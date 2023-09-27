#!/bin/bash

snarkos developer deploy leo_nft.aleo --private-key "$PRIVATE_KEY" --query "http://localhost:3030" --path "./build/" --broadcast "http://localhost:3030/testnet3/transaction/broadcast" --fee 1 \
--record "{  owner: aleo1gm6kgmutfffgdasf2x9773ggp8ftem0tzcmc4syfzneeplwrsuzqqq82aa.private,  microcredits: 5000000000000u64.private,  _nonce: 7864545281177985087511987926262003544794618256200999342908794271199701092589group.public}"