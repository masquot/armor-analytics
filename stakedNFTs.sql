-- data from 2021-01-30 to 2021-03-04 for armor_fi."StakeManager_call_stakeNft"
-- data from 2021-01-30 to 2021-02-27 for armor_fi."StakeManager_call_batchStakeNft"
-- SELECT _nftId FROM armor_fi."StakeManager_call_stakeNft" ORDER BY "call_block_time" DESC
-- _nftId
WITH currencies AS (
    SELECT
        *
    FROM
        (
            VALUES
                ('ETH', '\x45544800' :: bytea, 18, 'WETH'),
                ('DAI', '\x44414900' :: bytea, 18, 'DAI')
        ) AS t (currency, identifier, decimals, token)
),
staked_before_2021_03_04 AS (
SELECT "_nftId" AS nft_id FROM armor_fi."StakeManager_call_stakeNft" WHERE call_success
UNION
SELECT UNNEST(entries) FROM (SELECT "_nftIds" AS entries FROM armor_fi."StakeManager_call_batchStakeNft"  WHERE call_success) g
),
cover_usd AS (
    SELECT
        "coverId" AS cover_id,
        buyer,
        "coveredContract" AS covered_contract,
        c.currency,
        "coverAmount" AS cover_amount,
        "coverAmount" * p.price AS cover_amount_usd,
        "coverPrice" / 10 ^ c.decimals AS premium_paid,
        "coverPrice" / 10 ^ c.decimals * p.price AS premium_paid_usd,
        "startTime" AS start_time,
        "coverPeriod" AS cover_period,
        date_trunc('day', evt_block_time) AS date_bought
    FROM
        armor_fi."arNFT_evt_BuyCover" buy
        LEFT JOIN currencies c ON c.identifier = buy.currency
        LEFT JOIN prices.usd p ON c.token = p.symbol
    WHERE
        p.minute = date_trunc(
            'day',
            (
                SELECT
                    NOW()
            )
        )
)
SELECT nft_id, * FROM cover_usd
LEFT JOIN staked_before_2021_03_04 ON cover_id = nft_id
ORDER BY date_bought 