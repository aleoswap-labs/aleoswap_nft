program aleoswap_nft.aleo {
    struct TokenId {
        data1: u128
    }

    // padded with 0s at the end
    // parse: (data0.data1.data2.data3).toHex
    struct BaseURI {
        data0: u128,
        data1: u128,
        data2: u128,
        data3: u128
    }

    // as symbol in EIP-721
    struct SymbolBits{
        data: u128
    }

    record NFT {
        private owner: address,
        private data: TokenId,
        private edition: scalar,
    }

    // to prove ownership of the nft in the private way
    record prove_ownership {
        private owner: address,
        private nft_owner: address,
        private data: TokenId,
        private edition: scalar,
    }

    // 0 -> initialized
    // 1 -> symbol
    // 2-5 -> base url
    // 6 -> total minted
    mapping settings: u8 => u128;

    // 0 -> owner
    mapping addresses: u8 => address;

    // public ownerships of token id (hash)
    mapping nft_owners: field => address;

    transition initialize_public(
        public symbol: u128,
        public base_uri: BaseURI,
    ) {
        // only owner
        assert_eq(self.caller, aleo1gm6kgmutfffgdasf2x9773ggp8ftem0tzcmc4syfzneeplwrsuzqqq82aa);
        return then finalize(symbol, self.caller, base_uri);
    }

    finalize initialize_public(
        public symbol: u128,
        public owner: address,
        public base_uri: BaseURI,
    ) {
        // only initialize once
        let is_initialized: u128 = settings.get_or_use(0u8, 0u128);
        // to check never initialized
        assert_eq(is_initialized, 0u128);
        // set flag for initialization
        settings.set(0u8, 1u128);
        // set symbol
        settings.set(1u8, symbol);
        // set base url
        settings.set(2u8, base_uri.data0);
        settings.set(3u8, base_uri.data1);
        settings.set(4u8, base_uri.data2);
        settings.set(5u8, base_uri.data3);
        // set total minted
        settings.set(6u8, 0u128);

        // set owner
        addresses.set(0u8, owner);
    }

    // set symbol by owner
    transition set_symbol(public symbol: u128) {
        return then finalize(symbol, self.caller);
    }

    finalize set_symbol(public symbol: u128, public owner: address) {
        // only owner
        assert_eq(addresses.get(0u8), owner);
        settings.set(1u8, symbol);
    }

    // set base uri by owner
    transition set_base_uri(public base_uri: BaseURI) {
        return then finalize(base_uri, self.caller);
    }

    finalize set_base_uri(public base_uri: BaseURI, public owner: address) {
        // only owner
        assert_eq(addresses.get(0u8), owner);
        settings.set(2u8, base_uri.data0);
        settings.set(3u8, base_uri.data1);
        settings.set(4u8, base_uri.data2);
        settings.set(5u8, base_uri.data3);
    }

    // set new owner by owner
    transition set_owner(public new_owner: address) {
        return then finalize(self.caller, new_owner);
    }

    finalize set_owner(public caller: address, public new_owner: address) {
        // only owner
        assert_eq(addresses.get(0u8), caller);
        addresses.set(0u8, new_owner);
    }

    // mint by the owner of the program
    transition mint(
        public data: TokenId,
        public edition: scalar,
        public receiver: address,
        ) -> NFT {
        let token_hash: field = BHP256::hash_to_field(data);
        let token_edition_hash: field = BHP256::commit_to_field(token_hash, edition);
        return NFT {
            owner: receiver,
            data,
            edition
        } then finalize(self.caller, receiver, token_edition_hash);
    }

    finalize mint(public caller: address, public receiver: address, public token_edition_hash: field) {
        // only owner
        assert_eq(addresses.get(0u8), caller);
        // total minted + 1
        let total_minted: u128 = settings.get(6u8);
        settings.set(6u8, total_minted + 1u128);
    }

    // prove the ownership of target NFT
    transition prove(private nft: NFT, private judge: address) -> (NFT, prove_ownership) {
        return (
            NFT {
                owner: nft.owner,
                data: nft.data,
                edition: nft.edition,
            },
            prove_ownership {
                owner: judge,
                nft_owner: nft.owner,
                data: nft.data,
                edition: nft.edition,
            }
        );
    }

    // transfer in private way
    transition transfer_private(
        nft: NFT,
        private receiver: address
    ) -> NFT{
        return NFT {
            owner: receiver,
            data: nft.data,
            edition: nft.edition,
        };
    }

    // transfer in public way
    transition transfer_public(
        private receiver: address,
        private data: TokenId,
        private edition: scalar
    ){
        let token_hash: field = BHP256::hash_to_field(data);
        let token_edition_hash: field = BHP256::commit_to_field(token_hash, edition);
        return then finalize(self.caller, receiver, token_edition_hash);
    }

    finalize transfer_public(
        public owner: address,
        public receiver: address,
        public token_edition_hash: field,
    )
    {
        assert_eq(owner, nft_owners.get(token_edition_hash));
        nft_owners.set(token_edition_hash, receiver);
    }


    // turn private record to public
    transition convert_private_to_public(nft: NFT){
        let token_hash: field = BHP256::hash_to_field(nft.data);
        let token_edition_hash: field = BHP256::commit_to_field(token_hash, nft.edition);
        return then finalize(nft.owner, token_edition_hash);
    }

    finalize convert_private_to_public(
        public owner: address,
        public token_edition_hash: field
    ){
        nft_owners.set(token_edition_hash, owner);
    }

    // export private record from mapping
    transition convert_public_to_private(
        private data: TokenId,
        private edition: scalar,
    ) -> NFT{
        let token_hash: field = BHP256::hash_to_field(data);
        let token_edition_hash: field = BHP256::commit_to_field(token_hash, edition);
        let owner: address = self.caller;
        return NFT {
            owner,
            data,
            edition,
        } then finalize(owner, token_edition_hash);
    }

    finalize convert_public_to_private(
        public owner: address,
        public token_edition_hash: field
    ){
        assert_eq(owner, nft_owners.get(token_edition_hash));
        nft_owners.remove(token_edition_hash);
    }
}