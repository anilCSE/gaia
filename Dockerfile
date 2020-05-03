# Simple usage with a mounted data directory:
# > docker build -t aneka .
# > docker run -it -p 46657:46657 -p 46656:46656 -v ~/.anekad:/root/.anekad -v ~/.anekacli:/root/.anekacli aneka anekad init
# > docker run -it -p 46657:46657 -p 46656:46656 -v ~/.anekad:/root/.anekad -v ~/.anekacli:/root/.anekacli aneka anekad start
FROM golang:alpine AS build-env

# Set up dependencies
ENV PACKAGES curl make git libc-dev bash gcc linux-headers eudev-dev python

# Set working directory for the build
WORKDIR /go/src/github.com/vitwit/aneka

# Add source files
COPY . .

# Install minimum necessary dependencies, build Cosmos SDK, remove packages
RUN apk add --no-cache $PACKAGES && \
    make tools && \
    make install

# Final image
FROM alpine:edge

# Install ca-certificates
RUN apk add --update ca-certificates
WORKDIR /root

# Copy over binaries from the build-env
COPY --from=build-env /go/bin/anekad /usr/bin/anekad
COPY --from=build-env /go/bin/anekacli /usr/bin/anekacli

# Run anekad by default, omit entrypoint to ease using container with anekacli
CMD ["anekad"]
