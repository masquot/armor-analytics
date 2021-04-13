Ran test queries in Dune Analytics to see what tables actually contain data

## ArmorMaster

SELECT * FROM armor_fi."ArmorMaster_call_getModule"
8771 rows

SELECT * FROM armor_fi."ArmorMaster_evt_OwnershipTransferred"
1 row

SELECT * FROM armor_fi."ArmorMaster_call_addJob"
 4 rows

## BalanceManager

creation:
Timestamp:
39 days 11 hrs ago (Mar-02-2021 08:27:25 PM +UTC)|  Confirmed within 27 secs
From:
[0x531ed64e65b1d2f569feabbad73bef04ac249378](https://etherscan.io/address/0x531ed64e65b1d2f569feabbad73bef04ac249378) (Armor.fi: Deployer 2) [](javascript:;)

SELECT * FROM armor_fi."BalanceManager_evt_Deposit"
no results

SELECT * FROM armor_fi."BalanceManager_call_deposit"
63 results

## RewardManager

Timestamp:
39 days 12 hrs ago (Mar-02-2021 08:28:37 PM +UTC)|  Confirmed within 30 secs
From:
[0x531ed64e65b1d2f569feabbad73bef04ac249378](https://etherscan.io/address/0x531ed64e65b1d2f569feabbad73bef04ac249378) (Armor.fi: Deployer 2) [](javascript:;)

SELECT * FROM armor_fi."RewardManager_call_stake"
31 rows

SELECT * FROM armor_fi."RewardManager_call_earned"
SELECT * FROM armor_fi."RewardManager_call_balanceOf"
no results

SELECT * FROM armor_fi."RewardManager_evt_BalanceAdded"
SELECT * FROM armor_fi."RewardManager_evt_RewardAdded"
SELECT * FROM armor_fi."RewardManager_evt_RewardPaid"
no results

## StakeManager
Is new and old

SELECT * FROM armor_fi."StakeManager_call_stakeNft"
344 rows

SELECT * FROM armor_fi."StakeManager_evt_StakedNFT"
no results

## PlanManager

SELECT * FROM armor_fi."PlanManager_call_coverageLeft"
SELECT * FROM armor_fi."PlanManager_call_coreCover"
SELECT * FROM armor_fi."PlanManager_call_plans"
no results

SELECT * FROM armor_fi."PlanManager_evt_PlanUpdate"
no results

## ClaimManager

SELECT * FROM armor_fi."ClaimManager_call_submitNft"
2 rows

SELECT * FROM armor_fi."ClaimManager_evt_ConfirmedHack"
1 row

SELECT * FROM armor_fi."ClaimManager_evt_ClaimPayout"
no results