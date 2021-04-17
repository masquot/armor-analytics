Findings:
- no data at all available in Dune for the events (events listed below)
- call data from 2021-01-30 until 2021-03-04 for:
	-  stakeNft
	-  batchStakeNft
	-  withdrawNft

Partial call data linked to arNFT buyCover event

== 
github link:
https://github.com/ArmorFi/arCore/blob/master/contracts/core/StakeManager.sol 
Latest commit [06e71f6](https://github.com/ArmorFi/arCore/commit/06e71f6b0f4a9ae4196cfaa695fe51598dca68dd) 28 days ago

// Event launched when an NFT is staked.
event StakedNFT(address indexed user, address indexed protocol, uint256 nftId, uint256 sumAssured, uint256 secondPrice, uint16 coverPeriod, uint256 timestamp);

// Event launched when an NFT expires.
event RemovedNFT(address indexed user, address indexed protocol, uint256 nftId, uint256 sumAssured, uint256 secondPrice, uint16 coverPeriod, uint256 timestamp);

// Event launched when an NFT expires.
event ExpiredNFT(address indexed user, uint256 nftId, uint256 timestamp);

event WithdrawRequest(address indexed user, uint256 nftId, uint256 timestamp, uint256 withdrawTimestamp);