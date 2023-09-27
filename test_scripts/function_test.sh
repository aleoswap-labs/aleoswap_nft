# EXTRA: check fund account's balance
snarkos developer scan -v AViewKey1mSnpFFC8Mj4fXbK5YiWgZ3mjiV8CxA79bYNa8ymUpTrw --last 200 --endpoint "http://localhost:3030"

# 1. initialize_public
snarkos developer execute "leo_nft.aleo" "initialize_public" "1024u128" "{
          data0: 1u128,
          data1: 2u128,
          data2: 3u128,
          data3: 4u128}" \
          --private-key "$PRIVATE_KEY" \
          --query "http://localhost:3030" \
          --broadcast "http://localhost:3030/testnet3/transaction/broadcast" \
          --fee 1000000 \
          --record "{  owner: aleo1gm6kgmutfffgdasf2x9773ggp8ftem0tzcmc4syfzneeplwrsuzqqq82aa.private,  microcredits: 4998989866999u64.private,  _nonce: 7075579529052031814852672050464276096268250498597767104560227601252460437199group.public}"

# 2. test set_symbol
snarkos developer execute "leo_nft.aleo" "set_symbol" "2048u128" \
          --private-key "$PRIVATE_KEY" \
          --query "http://localhost:3030" \
          --broadcast "http://localhost:3030/testnet3/transaction/broadcast" \
          --fee 1000000 \
          --record "{  owner: aleo1gm6kgmutfffgdasf2x9773ggp8ftem0tzcmc4syfzneeplwrsuzqqq82aa.private,  microcredits: 4998980363567u64.private,  _nonce: 8417490179315914379400825581491224790193647404646476790180017108030614109158group.public}"

# case 1: reject when not owner
snarkos developer execute "leo_nft.aleo" "set_symbol" "4096u128" \
          --private-key APrivateKey1zkp8CZNn3yeCseEtxuVPbDCwSyhGW6yZKUYKfgXmcpoGPWH \
          --query "http://localhost:3030" \
          --broadcast "http://localhost:3030/testnet3/transaction/broadcast" \
          --fee 1000000 \
          --record "{  owner: aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px.private,  microcredits: 93750000000000u64.private,  _nonce: 6526741553655730916585406598622172875143600009335802058713184455273822212848group.public}"

# 3. test set_base_uri
snarkos developer execute "leo_nft.aleo" "set_base_uri" \
          "{data0: 11u128,
            data1: 22u128,
            data2: 33u128,
            data3: 44u128}" \
          --private-key "$PRIVATE_KEY" \
          --query "http://localhost:3030" \
          --broadcast "http://localhost:3030/testnet3/transaction/broadcast" \
          --fee 1000000 \
          --record "{  owner: aleo1gm6kgmutfffgdasf2x9773ggp8ftem0tzcmc4syfzneeplwrsuzqqq82aa.private,  microcredits: 4998977860397u64.private,  _nonce: 3355477048607389251305213369472497022810448103940112509569825078944789493568group.public}"

# case 1: reject when not owner
snarkos developer execute "leo_nft.aleo" "set_base_uri" \
          "{data0: 111u128,
            data1: 222u128,
            data2: 333u128,
            data3: 444u128}" \
          --private-key APrivateKey1zkp8CZNn3yeCseEtxuVPbDCwSyhGW6yZKUYKfgXmcpoGPWH \
          --query "http://localhost:3030" \
          --broadcast "http://localhost:3030/testnet3/transaction/broadcast" \
          --fee 1000000 \
          --record "{  owner: aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px.private,  microcredits: 93749997496830u64.private,  _nonce: 3322940356254102200913028724296533973634432936893056434755088019496058597535group.public}"


# 4. test set_owner
snarkos developer execute "leo_nft.aleo" "set_owner" aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px \
          --private-key "$PRIVATE_KEY" \
          --query "http://localhost:3030" \
          --broadcast "http://localhost:3030/testnet3/transaction/broadcast" \
          --fee 1000000 \
          --record  "{  owner: aleo1gm6kgmutfffgdasf2x9773ggp8ftem0tzcmc4syfzneeplwrsuzqqq82aa.private,  microcredits: 4998972357043u64.private,  _nonce: 1910273516259833594555790520071087767940023911269831482125407628169731772894group.public}"

# case 1: reject when not owner
snarkos developer execute "leo_nft.aleo" "set_owner" aleo1gm6kgmutfffgdasf2x9773ggp8ftem0tzcmc4syfzneeplwrsuzqqq82aa \
          --private-key "$PRIVATE_KEY" \
          --query "http://localhost:3030" \
          --broadcast "http://localhost:3030/testnet3/transaction/broadcast" \
          --fee 1000000 \
          --record    "{  owner: aleo1gm6kgmutfffgdasf2x9773ggp8ftem0tzcmc4syfzneeplwrsuzqqq82aa.private,  microcredits: 4998969853842u64.private,  _nonce: 411477418780071296670140649849764406443185748658769764484770054816581027879group.public}"

# change owner back
snarkos developer execute "leo_nft.aleo" "set_owner" aleo1gm6kgmutfffgdasf2x9773ggp8ftem0tzcmc4syfzneeplwrsuzqqq82aa \
          --private-key APrivateKey1zkp8CZNn3yeCseEtxuVPbDCwSyhGW6yZKUYKfgXmcpoGPWH \
          --query "http://localhost:3030" \
          --broadcast "http://localhost:3030/testnet3/transaction/broadcast" \
          --fee 1000000 \
          --record    "{  owner: aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px.private,  microcredits: 93749991993476u64.private,  _nonce: 4221158589639098995733492654623549848613531186727752310031823536267781061709group.public}"

# 5. test mint
# mint to aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px
snarkos developer execute "leo_nft.aleo" "mint" \
        "{ data1: 11111111u128}" \
        0scalar \
        aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px \
        --private-key "$PRIVATE_KEY" \
        --query "http://localhost:3030" \
        --broadcast "http://localhost:3030/testnet3/transaction/broadcast" \
        --fee 1000000 \
        --record   "{  owner: aleo1gm6kgmutfffgdasf2x9773ggp8ftem0tzcmc4syfzneeplwrsuzqqq82aa.private,  microcredits: 4998967350641u64.private,  _nonce: 230056844394963617652502575013967303888088140737694666108445987172778329407group.public}"
# transcation id: at1hax0gln96a24xak57lqzwmlfm0tffs8r0k0vfvl9ms7l9qxupugqqjrg2t
# output
#{
#  owner: aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px.private,
#  data: {
#    data1: 11111111u128.private
#  },
#  edition: 0scalar.private,
#  _nonce: 1813728837688266199589785912870793255535361305525772214850705214780987523095group.public
#}

# case 1: reject when not owner
snarkos developer execute "leo_nft.aleo" "mint" \
        "{ data1: 11111111u128}" \
        1scalar \
        aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px \
        --private-key APrivateKey1zkp8CZNn3yeCseEtxuVPbDCwSyhGW6yZKUYKfgXmcpoGPWH \
        --query "http://localhost:3030" \
        --broadcast "http://localhost:3030/testnet3/transaction/broadcast" \
        --fee 1000000 \
        --record   "{  owner: aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px.private,  microcredits: 93749989490275u64.private,  _nonce: 7513790530958388032677182691305446181240473651151019864814306318615236007200group.public}"

# test prove
snarkos developer execute "leo_nft.aleo" "prove" \
        "{
           owner: aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px.private,
           data: {
             data1: 11111111u128.private
           },
           edition: 0scalar.private,
           _nonce: 1813728837688266199589785912870793255535361305525772214850705214780987523095group.public
         }" \
        aleo1gm6kgmutfffgdasf2x9773ggp8ftem0tzcmc4syfzneeplwrsuzqqq82aa \
        --private-key APrivateKey1zkp8CZNn3yeCseEtxuVPbDCwSyhGW6yZKUYKfgXmcpoGPWH \
        --query "http://localhost:3030" \
        --broadcast "http://localhost:3030/testnet3/transaction/broadcast" \
        --fee 1000000 \
        --record   "{  owner: aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px.private,  microcredits: 93749986484658u64.private,  _nonce: 5593656747087951149570613359723356320735338105580570590442128491901476436857group.public}"

# test transfer_private
snarkos developer execute "leo_nft.aleo" "transfer_private" \
        "{
           owner: aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px.private,
           data: {
             data1: 11111111u128.private
           },
           edition: 0scalar.private,
           _nonce: 3560956619168059397272983300185390645226496144286288826418926289592933573228group.public
         }" \
        aleo1gm6kgmutfffgdasf2x9773ggp8ftem0tzcmc4syfzneeplwrsuzqqq82aa \
        --private-key APrivateKey1zkp8CZNn3yeCseEtxuVPbDCwSyhGW6yZKUYKfgXmcpoGPWH \
        --query "http://localhost:3030" \
        --broadcast "http://localhost:3030/testnet3/transaction/broadcast" \
        --fee 1000000 \
        --record   "{  owner: aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px.private,  microcredits: 93749985482333u64.private,  _nonce: 3114058139505487816668129566718277934630656694552563947347485163236958764446group.public}"
# transaction id: at1wj9vf3c24293p29p5msrz23jfu695nzue0q5k3cmhr4mdlks4vgs3exnps
# output:
#{
#  owner: aleo1gm6kgmutfffgdasf2x9773ggp8ftem0tzcmc4syfzneeplwrsuzqqq82aa.private,
#  data: {
#    data1: 11111111u128.private
#  },
#  edition: 0scalar.private,
#  _nonce: 3185686750182480797023202518062544790455924116814299380723482251461253723701group.public
#}

# case 2. fail if transfer again with the same input record
snarkos developer execute "leo_nft.aleo" "transfer_private" \
        "{
           owner: aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px.private,
           data: {
             data1: 11111111u128.private
           },
           edition: 0scalar.private,
           _nonce: 3560956619168059397272983300185390645226496144286288826418926289592933573228group.public
         }" \
        aleo1gm6kgmutfffgdasf2x9773ggp8ftem0tzcmc4syfzneeplwrsuzqqq82aa \
        --private-key APrivateKey1zkp8CZNn3yeCseEtxuVPbDCwSyhGW6yZKUYKfgXmcpoGPWH \
        --query "http://localhost:3030" \
        --broadcast "http://localhost:3030/testnet3/transaction/broadcast" \
        --fee 1000000 \
        --record  "{  owner: aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px.private,  microcredits: 93749984480329u64.private,  _nonce: 969162647768514407135263128552160895414303929467246722496793660411325562320group.public}"

#✅ Created execution transaction for 'leo_nft.aleo/transfer_private'
#⚠️  ❌ Failed to broadcast execution 'leo_nft.aleo/transfer_private' to http://localhost:3030/testnet3/transaction/broadcast: (status code 500: "Something went wrong: Input ID '4675370658288359499970431802788311067389245755167171721753303668023553079214field' already exists in the ledger")

# test convert_private_to_public
snarkos developer execute "leo_nft.aleo" "convert_private_to_public" \
        "{  owner: aleo1gm6kgmutfffgdasf2x9773ggp8ftem0tzcmc4syfzneeplwrsuzqqq82aa.private,  data: {    data1: 11111111u128.private  },  edition: 0scalar.private,  _nonce: 3185686750182480797023202518062544790455924116814299380723482251461253723701group.public}" \
        --private-key "$PRIVATE_KEY" \
        --query "http://localhost:3030" \
        --broadcast "http://localhost:3030/testnet3/transaction/broadcast" \
        --fee 1000000 \
        --record   "{  owner: aleo1gm6kgmutfffgdasf2x9773ggp8ftem0tzcmc4syfzneeplwrsuzqqq82aa.private,  microcredits: 4998964345024u64.private,  _nonce: 5349939203443857330918853779621908294247079705306048100426492208928597896772group.public}"
# transaction id: at1c20l4axhyya8r32l6ux2dxvj5djkppcpptm4tcgu9dlu6w7tg5zqnycuk7

# test transfer_public
snarkos developer execute "leo_nft.aleo" "transfer_public" \
        aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px \
        "{data1: 11111111u128}" \
        0scalar \
        --private-key APrivateKey1zkp8CZNn3yeCseEtxuVPbDCwSyhGW6yZKUYKfgXmcpoGPWH \
        --query "http://localhost:3030" \
        --broadcast "http://localhost:3030/testnet3/transaction/broadcast" \
        --fee 1000000 \
        --record  "{  owner: aleo1gm6kgmutfffgdasf2x9773ggp8ftem0tzcmc4syfzneeplwrsuzqqq82aa.private,  microcredits: 4998962343291u64.private,  _nonce: 4858098732222331874023041618454828044973220369258106292221669173590261103200group.public}"
# transaction id: at1ryxh78438xd6rlgykmmewj6m2srqqqen9x2kp0m36c2dzzqtjqpqtvmgc8

# case 1: reject if try to transfer an NFT not belongs to the caller
snarkos developer execute "leo_nft.aleo" "transfer_public" \
        aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px \
        "{data1: 11111111u128}" \
        0scalar \
        --private-key "$PRIVATE_KEY" \
        --query "http://localhost:3030" \
        --broadcast "http://localhost:3030/testnet3/transaction/broadcast" \
        --fee 1000000 \
        --record  "{  owner: aleo1gm6kgmutfffgdasf2x9773ggp8ftem0tzcmc4syfzneeplwrsuzqqq82aa.private,  microcredits: 4998959839849u64.private,  _nonce: 6116099685607076154098143907880851454883557785889976359324357534070126524035group.public}"

# test convert_public_to_private
snarkos developer execute "leo_nft.aleo" "convert_public_to_private" \
        "{data1: 11111111u128}" \
        0scalar \
        --private-key APrivateKey1zkp8CZNn3yeCseEtxuVPbDCwSyhGW6yZKUYKfgXmcpoGPWH \
        --query "http://localhost:3030" \
        --broadcast "http://localhost:3030/testnet3/transaction/broadcast" \
        --fee 1000000 \
        --record  "{  owner: aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px.private,  microcredits: 93749984480329u64.private,  _nonce: 969162647768514407135263128552160895414303929467246722496793660411325562320group.public}"
# transaction id : at1wnvfeu2r2y0gznxke4kvsmsh9kfa6nvxw396sxkxprasjc5rgqxqdely6l