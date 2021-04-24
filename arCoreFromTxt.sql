WITH arcore_input AS (
    SELECT
        *
    FROM
        (
            VALUES
                ('CompoundSai', 0.0, 0.0, 0.0),
                ('bZxV1', 0.0, 0.0, 0.0),
                ('Unknown', 0.0, 0.0, 0.0),
                ('CompoundETH', 0.0, 0.0, 0.0),
                ('0xV2.1', 0.0, 0.0, 0.0),
                ('iearnyDAIV1', 0.0, 0.0, 0.0),
                ('SaturnDAOToken', 0.0, 0.0, 0.0),
                ('CompoundDAI', 0.0, 0.0, 0.0),
                ('UniswapExchangeTemplate', 0.0, 0.0, 0.0),
                ('MakerToken', 0.0, 0.0, 0.0),
                ('LegacyGnosisMultiSig', 6245.0, 0.0, 6245.0),
                ('BancorETHBNTToken', 0.0, 0.0, 0.0),
                ('PoolTogetherDAI', 0.0, 0.0, 0.0),
                ('FlexacoinToken', 0.0, 0.0, 0.0),
                ('dxDAO', 0.0, 0.0, 0.0),
                ('Nuo', 0.0, 0.0, 0.0),
                ('PoolTogetherSAI', 0.0, 0.0, 0.0),
                ('PoolTogetherV2', 0.0, 0.0, 0.0),
                ('Argent', 7041.0, 0.0, 7041.0),
                ('HexToken', 0.0, 0.0, 0.0),
                ('UniswapV1MKRPool', 0.0, 0.0, 0.0),
                ('dydxPerpetual', 1059.0, 0.0, 1059.0),
                ('DAIToken', 0.0, 0.0, 0.0),
                ('Unknown', 0.0, 0.0, 0.0),
                ('DDEX', 0.0, 0.0, 0.0),
                (
                    'TornadoCash',
                    470.0,
                    206.0030197805105,
                    263.9969802194895
                ),
                ('Deversifi', 0.0, 0.0, 0.0),
                ('InstadappRegistry', 0.0, 0.0, 0.0),
                ('MakerSCD', 0.0, 0.0, 0.0),
                ('RenVM', 15890.0, 2.0, 15888.0),
                ('0xV3', 8180.0, 0.0, 8180.0),
                (
                    'dydx',
                    6985.0,
                    1.2413636265250645,
                    6983.758636373475
                ),
                (
                    'CompoundV2',
                    15370.0,
                    3187.8916100113356,
                    12182.108389988663
                ),
                ('GnosisSafe', 2046.0, 0.0, 2046.0),
                ('UniswapV1', 0.0, 0.0, 0.0),
                ('MakerDAOMCD', 11188.0, 1159.0, 10029.0),
                ('Paraswap-OLD', 0.0, 0.0, 0.0),
                ('AaveV1', 733.0, 0.0, 733.0),
                ('IdleFinance-OLD', 0.0, 0.0, 0.0),
                ('AaveLendingCore', 0.0, 0.0, 0.0),
                ('Curvefi-OLD', 0.0, 0.0, 0.0),
                (
                    '1Inch(DEX&LiquidityPools)',
                    3004.0,
                    1471.5022331378789,
                    1532.4977668621211
                ),
                ('ParaswapOLD', 0.0, 0.0, 0.0),
                ('Opyn', 1040.0, 0.0, 1040.0),
                (
                    'YearnFinance(allvaults)',
                    4707.0,
                    3440.5631544969547,
                    1266.4368455030453
                ),
                ('Totle', 4768.0, 0.0, 4768.0),
                ('FlexaStaking', 7492.0, 0.0, 7492.0),
                ('IdleV3', 0.0, 0.0, 0.0),
                ('CurveBTCPools', 0.0, 0.0, 0.0),
                (
                    'CurveAllPools(inclstaking)',
                    11871.0,
                    7072.453617296054,
                    4798.546382703946
                ),
                ('SetProtocol', 5000.0, 0.0, 5000.0),
                (
                    'UniswapV2',
                    24537.0,
                    1966.6593007193549,
                    22570.340699280645
                ),
                (
                    'BalancerV1',
                    4067.0,
                    964.3336618267393,
                    3102.6663381732606
                ),
                ('AmpleforthTokengeyser', 0.0, 0.0, 0.0),
                ('ParaswapV1', 0.0, 0.0, 0.0),
                ('MelonV1', 0.0, 0.0, 0.0),
                ('MolochDAO', 0.0, 0.0, 0.0),
                (
                    'mStable',
                    3479.0,
                    28.723304748472163,
                    3450.276695251528
                ),
                (
                    'Synthetix',
                    2787.0,
                    335.3673372765571,
                    2451.632662723443
                ),
                ('IDEXV1', 0.0, 0.0, 0.0),
                ('Kyber(Katalyst)', 2723.0, 0.0, 2723.0),
                (
                    'Bancor',
                    2933.0,
                    2645.063765506669,
                    287.936234493331
                ),
                ('UMA', 9600.0, 0.0, 9600.0),
                ('dForceYieldMarket', 0.0, 0.0, 0.0),
                ('YamFinanceV1', 0.0, 0.0, 0.0),
                ('IdleV4', 0.0, 0.0, 0.0),
                ('Mooniswap', 1620.0, 0.0, 1620.0),
                ('tBTCContractsV1', 0.0, 0.0, 0.0),
                ('NuCypherWorklock', 0.0, 0.0, 0.0),
                ('AkropolisDelphi', 0.0, 0.0, 0.0),
                ('DODOExchange', 0.0, 0.0, 0.0),
                ('CoFix', 0.0, 0.0, 0.0),
                (
                    'PoolTogetherV3',
                    3090.0,
                    69.06023782218816,
                    3020.9397621778116
                ),
                ('SetProtocolV2', 1019.0, 0.0, 1019.0),
                ('YieldProtocol', 0.0, 0.0, 0.0),
                ('Eth2.0', 0.0, 0.0, 0.0),
                (
                    'Hegic',
                    1273.0,
                    28.93589750235578,
                    1244.0641024976442
                ),
                (
                    'KeeperDAO',
                    3286.0,
                    1054.7927724417589,
                    2231.2072275582414
                ),
                (
                    'C.R.E.A.M.V1',
                    3217.0,
                    1013.9843998011503,
                    2203.01560019885
                ),
                ('TrueFi', 60.0, 24.0, 36.0),
                (
                    'AlphaHomoraV1',
                    548.0,
                    547.4763314311314,
                    0.52366856886863
                ),
                (
                    'AaveV2',
                    10543.0,
                    7926.424165090074,
                    2616.5758349099265
                ),
                (
                    'SushiSwapV1',
                    5115.0,
                    1335.4307376323093,
                    3779.569262367691
                ),
                ('CoverProtocolV1', 0.0, 0.0, 0.0),
                (
                    'PerpetualProtocol',
                    50.0,
                    10.493487622160853,
                    39.506512377839144
                ),
                (
                    'BadgerDAO',
                    1622.0,
                    1586.7285917509168,
                    35.271408249083095
                ),
                ('NotionalFinance', 0.0, 0.0, 0.0),
                ('OriginDollar', 0.0, 0.0, 0.0),
                ('OpynV2', 0.0, 0.0, 0.0),
                ('Reflexer', 0.0, 0.0, 0.0),
                ('Vesper', 0.0, 0.0, 0.0),
                ('BenchmarkProtocol', 0.0, 0.0, 0.0),
                ('StakeDAO', 0.0, 0.0, 0.0),
                ('Liquity', 0.0, 0.0, 0.0),
                ('HarvestFinance', 0.0, 0.0, 0.0),
                ('Celsius', 0.0, 0.0, 0.0),
                ('BlockFi', 0.0, 0.0, 0.0),
                ('Nexo', 0.0, 0.0, 0.0),
                ('inLock', 0.0, 0.0, 0.0),
                ('Ledn', 0.0, 0.0, 0.0),
                ('Hodlnaut', 0.0, 0.0, 0.0),
                ('Binance', 0.0, 0.0, 0.0),
                ('Coinbase', 0.0, 0.0, 0.0),
                ('Kraken', 0.0, 0.0, 0.0),
                ('Gemini', 0.0, 0.0, 0.0)
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
    staked DESC