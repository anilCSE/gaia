package common

import (
	sdk "github.com/cosmos/cosmos-sdk/types"
)

const (
	bech32PrefixAccAddr = "vitwit:"
	bech32PrefixAccPub  = "vitwit:pub"

	bech32PrefixValAddr = "vitwit:valoper"
	bech32PrefixValPub  = "vitwit:valoperpub"

	bech32PrefixConsAddr = "vitwit:valcons"
	bech32PrefixConsPub  = "vitwit:valconspub"
)

// SetSDKAccountPrefixes configures address prefixes for validator, accounts and consensus nodes
func SetSDKAccountPrefixes() {
	config := sdk.GetConfig()
	config.SetBech32PrefixForAccount(bech32PrefixAccAddr, bech32PrefixAccPub)
	config.SetBech32PrefixForValidator(bech32PrefixValAddr, bech32PrefixValPub)
	config.SetBech32PrefixForConsensusNode(bech32PrefixConsAddr, bech32PrefixConsPub)

	config.Seal()
}