import os
from web3 import Web3

start = """
WITH arcore_input AS (
    SELECT
        *
    FROM
        (
            VALUES
"""

end = """
        ) AS t (
            project,
            staked,
            purchased,
            remaining
        )
)
SELECT
    'arNFT Staked' AS "Type",
    project AS "Project",
    staked AS "Staked",
    purchased AS "Purchased",
    remaining AS "Remaining",
    purchased / staked * 100 AS "% Sold",
    remaining / staked * 100 AS "% Remaining"
FROM
    arcore_input
WHERE
    staked > 0
ORDER BY
    purchased DESC
"""

w3 = Web3(Web3.HTTPProvider(os.environ.get("INFURA_PROVIDER_MAIN")))

stakeAddress = Web3.toChecksumAddress("0x1337DEF1373bB63196F3D1443cE11D8d962543bB")
stakeAbi = '[{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"user","type":"address"},{"indexed":false,"internalType":"address[]","name":"protocols","type":"address[]"},{"indexed":false,"internalType":"uint256[]","name":"amounts","type":"uint256[]"},{"indexed":false,"internalType":"uint256","name":"endTime","type":"uint256"}],"name":"PlanUpdate","type":"event"},{"inputs":[{"internalType":"uint256","name":"_newMarkup","type":"uint256"}],"name":"adjustMarkup","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"_newCorePercent","type":"uint256"},{"internalType":"uint256","name":"_newArShieldPercent","type":"uint256"},{"internalType":"uint256","name":"_newArShieldPlusPercent","type":"uint256"}],"name":"adjustPercents","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address[]","name":"_shieldAddress","type":"address[]"},{"internalType":"uint256[]","name":"_shieldType","type":"uint256[]"}],"name":"adjustShields","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"arShieldCover","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"arShieldPercent","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"arShieldPlusCover","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"arShieldPlusPercent","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"arShields","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"_newMaster","type":"address"}],"name":"changeMaster","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"_protocol","type":"address"},{"internalType":"uint256","name":"_newPrice","type":"uint256"}],"name":"changePrice","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"_user","type":"address"},{"internalType":"address","name":"_protocol","type":"address"},{"internalType":"uint256","name":"_hackTime","type":"uint256"},{"internalType":"uint256","name":"_amount","type":"uint256"}],"name":"checkCoverage","outputs":[{"internalType":"uint256","name":"index","type":"uint256"},{"internalType":"bool","name":"check","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"coreCover","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"corePercent","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"_protocol","type":"address"}],"name":"coverageLeft","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"_user","type":"address"}],"name":"getCurrentPlan","outputs":[{"internalType":"uint256","name":"idx","type":"uint256"},{"internalType":"uint128","name":"start","type":"uint128"},{"internalType":"uint128","name":"end","type":"uint128"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"_user","type":"address"},{"internalType":"uint256","name":"_idx","type":"uint256"},{"internalType":"address","name":"_protocol","type":"address"}],"name":"getProtocolPlan","outputs":[{"internalType":"uint256","name":"idx","type":"uint256"},{"internalType":"uint64","name":"protocolId","type":"uint64"},{"internalType":"uint192","name":"amount","type":"uint192"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"_armorMaster","type":"address"}],"name":"initialize","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"markup","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"nftCoverPrice","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"_user","type":"address"},{"internalType":"uint256","name":"_planIndex","type":"uint256"},{"internalType":"address","name":"_protocol","type":"address"}],"name":"planRedeemed","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"","type":"address"},{"internalType":"uint256","name":"","type":"uint256"}],"name":"plans","outputs":[{"internalType":"uint64","name":"startTime","type":"uint64"},{"internalType":"uint64","name":"endTime","type":"uint64"},{"internalType":"uint128","name":"length","type":"uint128"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"bytes32","name":"","type":"bytes32"}],"name":"protocolPlan","outputs":[{"internalType":"uint64","name":"protocolId","type":"uint64"},{"internalType":"uint192","name":"amount","type":"uint192"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"totalUsedCover","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"_user","type":"address"},{"internalType":"uint256","name":"_expiry","type":"uint256"}],"name":"updateExpireTime","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address[]","name":"_protocols","type":"address[]"},{"internalType":"uint256[]","name":"_coverAmounts","type":"uint256[]"}],"name":"updatePlan","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"_user","type":"address"},{"internalType":"address","name":"_protocol","type":"address"}],"name":"userCoverageLimit","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"}]'
planMan = w3.eth.contract(address=stakeAddress, abi=stakeAbi)

stakeAddress = Web3.toChecksumAddress("0x1337DEF1670C54B2a70E590B5654c2B7cE1141a2")
stakeAbi = '[{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"user","type":"address"},{"indexed":false,"internalType":"uint256","name":"nftId","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"timestamp","type":"uint256"}],"name":"ExpiredNFT","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"user","type":"address"},{"indexed":true,"internalType":"address","name":"protocol","type":"address"},{"indexed":false,"internalType":"uint256","name":"nftId","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"sumAssured","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"secondPrice","type":"uint256"},{"indexed":false,"internalType":"uint16","name":"coverPeriod","type":"uint16"},{"indexed":false,"internalType":"uint256","name":"timestamp","type":"uint256"}],"name":"RemovedNFT","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"user","type":"address"},{"indexed":true,"internalType":"address","name":"protocol","type":"address"},{"indexed":false,"internalType":"uint256","name":"nftId","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"sumAssured","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"secondPrice","type":"uint256"},{"indexed":false,"internalType":"uint16","name":"coverPeriod","type":"uint16"},{"indexed":false,"internalType":"uint256","name":"timestamp","type":"uint256"}],"name":"StakedNFT","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"user","type":"address"},{"indexed":false,"internalType":"uint256","name":"nftId","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"timestamp","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"withdrawTimestamp","type":"uint256"}],"name":"WithdrawRequest","type":"event"},{"inputs":[],"name":"BUCKET_STEP","outputs":[{"internalType":"uint64","name":"","type":"uint64"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"ETH_SIG","outputs":[{"internalType":"bytes4","name":"","type":"bytes4"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"_protocol","type":"address"},{"internalType":"bool","name":"_allow","type":"bool"}],"name":"allowProtocol","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"_protocol","type":"address"},{"internalType":"uint256","name":"_totalBorrowedAmount","type":"uint256"}],"name":"allowedCover","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"allowedProtocol","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256[]","name":"_nftIds","type":"uint256[]"}],"name":"batchStakeNft","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"_newMaster","type":"address"}],"name":"changeMaster","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"_withdrawalDelay","type":"uint256"}],"name":"changeWithdrawalDelay","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint64","name":"","type":"uint64"}],"name":"checkPoints","outputs":[{"internalType":"uint96","name":"head","type":"uint96"},{"internalType":"uint96","name":"tail","type":"uint96"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address[]","name":"_users","type":"address[]"},{"internalType":"uint256[]","name":"_nftIds","type":"uint256[]"}],"name":"forceRemoveNft","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256[]","name":"_nftIds","type":"uint256[]"}],"name":"forceResetExpires","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"head","outputs":[{"internalType":"uint96","name":"","type":"uint96"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint96","name":"","type":"uint96"}],"name":"infos","outputs":[{"internalType":"uint96","name":"next","type":"uint96"},{"internalType":"uint96","name":"prev","type":"uint96"},{"internalType":"uint64","name":"expiresAt","type":"uint64"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"_armorMaster","type":"address"}],"name":"initialize","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"keep","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"","type":"uint256"}],"name":"nftOwners","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"","type":"uint256"}],"name":"pendingWithdrawals","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint64","name":"","type":"uint64"}],"name":"protocolAddress","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"protocolId","outputs":[{"internalType":"uint64","name":"","type":"uint64"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint64[]","name":"_buckets","type":"uint64[]"},{"internalType":"uint96[]","name":"_heads","type":"uint96[]"},{"internalType":"uint96[]","name":"_tails","type":"uint96[]"}],"name":"resetBuckets","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"_nftId","type":"uint256"}],"name":"stakeNft","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"","type":"uint256"}],"name":"submitted","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"_nftId","type":"uint256"},{"internalType":"address","name":"_protocol","type":"address"},{"internalType":"uint256","name":"_subtractAmount","type":"uint256"}],"name":"subtractTotal","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"tail","outputs":[{"internalType":"uint96","name":"","type":"uint96"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"toggleUF","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"totalStakedAmount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"_nftId","type":"uint256"}],"name":"withdrawNft","outputs":[],"stateMutability":"nonpayable","type":"function"}]'
stakeMan = w3.eth.contract(address=stakeAddress, abi=stakeAbi)

DENOMINATOR = 1000000000000000000
contracts = {
    "0xF5DCe57282A584D2746FaF1593d3121Fcac444dC": "CompoundSai",
    "0x8B3d70d628Ebd30D4A2ea82DB95bA2e906c71633": "bZxV1",
    "0x5504a1d88005236147EC86C62cfb53043bD1276a": "Unknown",
    "0x4Ddc2D193948926D02f9B1fE9e1daa0718270ED5": "CompoundETH",
    "0x080bf510FCbF18b91105470639e9561022937712": "0xV2.1",
    "0x16de59092dAE5CcF4A1E6439D611fd0653f0Bd01": "iearnyDAIV1",
    "0xAF350211414C5DC176421Ea05423F0cC494261fB": "SaturnDAOToken",
    "0x5d3a536E4D6DbD6114cc1Ead35777bAB948E3643": "CompoundDAI",
    "0x2157A7894439191e520825fe9399aB8655E0f708": "UniswapExchangeTemplate",
    "0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2": "MakerToken",
    "0x6e95C8E8557AbC08b46F3c347bA06F8dC012763f": "LegacyGnosisMultiSig",
    "0xb1CD6e4153B2a390Cf00A6556b0fC1458C4A5533": "BancorETHBNTToken",
    "0x29fe7D60DdF151E5b52e5FAB4f1325da6b2bD958": "PoolTogetherDAI",
    "0x4a57E687b9126435a9B19E4A802113e266AdeBde": "FlexacoinToken",
    "0x519b70055af55A007110B4Ff99b0eA33071c720a": "dxDAO",
    "0x802275979B020F0ec871c5eC1db6e412b72fF20b": "Nuo",
    "0xb7896fce748396EcFC240F5a0d3Cc92ca42D7d84": "PoolTogetherSAI",
    "0x932773aE4B661029704e731722CF8129e1B32494": "PoolTogetherV2",
    "0xB1dD690Cc9AF7BB1a906A9B5A94F94191cc553Ce": "Argent",
    "0x2b591e99afE9f32eAA6214f7B7629768c40Eeb39": "HexToken",
    "0x2C4Bd064b998838076fa341A83d007FC2FA50957": "UniswapV1MKRPool",
    "0x364508A5cA0538d8119D3BF40A284635686C98c4": "dydxPerpetual",
    "0x6B175474E89094C44Da98b954EedeAC495271d0F": "DAIToken",
    "0xD5D2b9e9bcd172D5fC8521AFd2C98Dd239F5b607": "Unknown",
    "0x241e82C79452F51fbfc89Fac6d912e021dB1a3B7": "DDEX",
    "0x12D66f87A04A9E220743712cE6d9bB1B5616B8Fc": "TornadoCash",
    "0x5d22045DAcEAB03B158031eCB7D9d06Fad24609b": "Deversifi",
    "0x498b3BfaBE9F73db90D252bCD4Fa9548Cd0Fd981": "InstadappRegistry",
    "0x448a5065aeBB8E423F0896E6c5D525C040f59af3": "MakerSCD",
    "0xe80d347DF1209a76DD9d2319d62912ba98C54DDD": "RenVM",
    "0xB27F1DB0a7e473304A5a06E54bdf035F671400C0": "0xV3",
    "0x1E0447b19BB6EcFdAe1e4AE1694b0C3659614e4e": "dydx",
    "0x3d9819210A31b4961b30EF54bE2aeD79B9c9Cd3B": "CompoundV2",
    "0x34CfAC646f301356fAa8B21e94227e3583Fe3F5F": "GnosisSafe",
    "0xc0a47dFe034B400B47bDaD5FecDa2621de6c4d95": "UniswapV1",
    "0x35D1b3F3D7966A1DFe207aa4514C12a259A0492B": "MakerDAOMCD",
    "0x72338b82800400F5488eCa2B5A37270ba3B7A111": "Paraswap-OLD",
    "0xc1D2819CE78f3E15Ee69c6738eB1B400A26e632A": "AaveV1",
    "0x10eC0D497824e342bCB0EDcE00959142aAa766dD": "IdleFinance-OLD",
    "0x3dfd23A6c5E8BbcFc9581d2E864a68feb6a076d3": "AaveLendingCore",
    "0x45F783CCE6B7FF23B2ab2D70e416cdb7D6055f51": "Curvefi-OLD",
    "0x11111254369792b2Ca5d084aB5eEA397cA8fa48B": "1Inch(DEX&LiquidityPools)",
    "0xF92C1ad75005E6436B4EE84e88cB23Ed8A290988": "ParaswapOLD",
    "0xb529964F86fbf99a6aA67f72a27e59fA3fa4FEaC": "Opyn",
    "0x9D25057e62939D3408406975aD75Ffe834DA4cDd": "YearnFinance(allvaults)",
    "0x77208a6000691E440026bEd1b178EF4661D37426": "Totle",
    "0x12f208476F64De6e6f933E55069Ba9596D818e08": "FlexaStaking",
    "0x78751B12Da02728F467A44eAc40F5cbc16Bd7934": "IdleV3",
    "0x7fC77b5c7614E1533320Ea6DDc2Eb61fa00A9714": "CurveBTCPools",
    "0x79a8C46DeA5aDa233ABaFFD40F3A0A2B1e5A4F27": "CurveAllPools(inclstaking)",
    "0x5B67871C3a857dE81A1ca0f9F7945e5670D986Dc": "SetProtocol",
    "0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f": "UniswapV2",
    "0x9424B1412450D0f8Fc2255FAf6046b98213B76Bd": "BalancerV1",
    "0xD36132E0c1141B26E62733e018f12Eb38A7b7678": "AmpleforthTokengeyser",
    "0x86969d29F5fd327E1009bA66072BE22DB6017cC6": "ParaswapV1",
    "0x5f9AE054C7F0489888B1ea46824b4B9618f8A711": "MelonV1",
    "0x1fd169A4f5c59ACf79d0Fd5d91D1201EF1Bce9f1": "MolochDAO",
    "0xAFcE80b19A8cE13DEc0739a1aaB7A028d6845Eb3": "mStable",
    "0xC011a73ee8576Fb46F5E1c5751cA3B9Fe0af2a6F": "Synthetix",
    "0x2a0c0DBEcC7E4D658f48E01e3fA353F44050c208": "IDEXV1",
    "0x9AAb3f75489902f3a48495025729a0AF77d4b11e": "Kyber(Katalyst)",
    "0x1F573D6Fb3F13d689FF844B4cE37794d79a7FF1C": "Bancor",
    "0x3e532e6222afe9Bcf02DCB87216802c75D5113aE": "UMA",
    "0x02285AcaafEB533e03A7306C55EC031297df9224": "dForceYieldMarket",
    "0x0e2298E3B3390e3b945a5456fBf59eCc3f55DA16": "YamFinanceV1",
    "0x3fE7940616e5Bc47b0775a0dccf6237893353bB4": "IdleV4",
    "0x71CD6666064C3A1354a3B4dca5fA1E2D3ee7D303": "Mooniswap",
    "0xe20A5C79b39bC8C363f0f49ADcFa82C2a01ab64a": "tBTCContractsV1",
    "0xe9778E69a961e64d3cdBB34CF6778281d34667c2": "NuCypherWorklock",
    "0x4C39b37f5F20a0695BFDC59cf10bd85a6c4B7c30": "AkropolisDelphi",
    "0x3A97247DF274a17C59A3bd12735ea3FcDFb49950": "DODOExchange",
    "0x26aaD4D82f6c9FA6E34D8c1067429C986A055872": "CoFix",
    "0xCB876f60399897db24058b2d58D0B9f713175eeF": "PoolTogetherV3",
    "0xa4c8d221d8BB851f83aadd0223a8900A6921A349": "SetProtocolV2",
    "0xB94199866Fe06B535d019C11247D3f921460b91A": "YieldProtocol",
    "0x00000000219ab540356cBB839Cbe05303d7705Fa": "Eth2.0",
    "0x878F15ffC8b894A1BA7647c7176E4C01f74e140b": "Hegic",
    "0xfA5047c9c78B8877af97BDcb85Db743fD7313d4a": "KeeperDAO",
    "0x3d5BC3c8d13dcB8bF317092d84783c2697AE9258": "C.R.E.A.M.V1",
    "0x7a9701453249e84fd0D5AfE5951e9cBe9ed2E90f": "TrueFi",
    "0x67B66C99D3Eb37Fa76Aa3Ed1ff33E8e39F0b9c7A": "AlphaHomoraV1",
    "0x7d2768dE32b0b80b7a3454c06BdAc94A69DDc7A9": "AaveV2",
    "0xc2EdaD668740f1aA35E4D8f227fB8E17dcA888Cd": "SushiSwapV1",
    "0xedfC81Bf63527337cD2193925f9C0cF2D537AccA": "CoverProtocolV1",
    "0xA51156F3F1e39d1036Ca4ba4974107A1C1815d1e": "PerpetualProtocol",
    "0x6354E79F21B56C11f48bcD7c451BE456D7102A36": "BadgerDAO",
    "0x9abd0b8868546105F6F48298eaDC1D9c82f7f683": "NotionalFinance",
    "0xE75D77B1865Ae93c7eaa3040B038D7aA7BC02F70": "OriginDollar",
    "0x7C06792Af1632E77cb27a558Dc0885338F4Bdf8E": "OpynV2",
    "0xCC88a9d330da1133Df3A7bD823B95e52511A6962": "Reflexer",
    "0xa4F1671d3Aee73C05b552d57f2d16d3cfcBd0217": "Vesper",
    "0x5D9972dD3Ba5602574ABeA6bF9E1713568D49903": "BenchmarkProtocol",
    "0xB17640796e4c27a39AF51887aff3F8DC0daF9567": "StakeDAO",
    "0xA39739EF8b0231DbFA0DcdA07d7e29faAbCf4bb2": "Liquity",
    "0x284D7200a0Dabb05ee6De698da10d00df164f61d": "HarvestFinance",
    "0xc57D000000000000000000000000000000000001": "Celsius",
    "0xC57D000000000000000000000000000000000002": "BlockFi",
    "0xC57d000000000000000000000000000000000003": "Nexo",
    "0xc57d000000000000000000000000000000000004": "inLock",
    "0xC57D000000000000000000000000000000000005": "Ledn",
    "0xC57d000000000000000000000000000000000006": "Hodlnaut",
    "0xC57d000000000000000000000000000000000007": "Binance",
    "0xc57D000000000000000000000000000000000008": "Coinbase",
    "0xc57d000000000000000000000000000000000009": "Kraken",
    "0xc57d000000000000000000000000000000000010": "Gemini",
}


def main():
    first_run = True

    with open("arcore-sql-test-output.txt", "w") as w:
        w.write(start)
        for contract in contracts:
            totalStaked = stakeMan.functions.totalStakedAmount(
                Web3.toChecksumAddress(contract)
            ).call()
            totalUsed = planMan.functions.totalUsedCover(
                Web3.toChecksumAddress(contract)
            ).call()
            extra = totalStaked - totalUsed
            if totalStaked > 0 or totalUsed > 0:
                if not first_run:
                    w.write(",\n")

                w.write("('" + contracts[contract] + "',")
                w.write(str(totalStaked / DENOMINATOR) + ",")
                w.write(str(totalUsed / DENOMINATOR) + ",")
                w.write(str(extra / DENOMINATOR) + ")")
                first_run = False

        w.write(end)


main()
