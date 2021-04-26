-- data from 2021-01-30 to 2021-03-04 for armor_fi."StakeManager_call_stakeNft"
-- data from 2021-01-30 to 2021-02-27 for armor_fi."StakeManager_call_batchStakeNft"
-- data from 2021-02-02 to 2021-03-03 for armor_fi."StakeManager_call_withdrawNft"
--
-- the following NFTs have been staked twice: 2820, 3015, 3148, 2768, 3172
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
    SELECT
        DISTINCT("_nftId") AS nft_id
    FROM
        armor_fi."StakeManager_call_stakeNft"
    WHERE
        call_success
    UNION
    SELECT
        UNNEST(entries)
    FROM
        (
            SELECT
                "_nftIds" AS entries
            FROM
                armor_fi."StakeManager_call_batchStakeNft"
            WHERE
                call_success
        ) g
),
withdrawn_before_2021_03_03 AS (
    SELECT
        DISTINCT("_nftId") AS nft_id
    FROM
        armor_fi."StakeManager_call_withdrawNft"
    WHERE
        call_success
),
staked_cover_usd AS (
    SELECT
        "coverId" AS cover_id,
        buyer,
        "coveredContract" AS covered_contract,
        c.currency,
        "coverAmount" AS cover_amount,
        "coverAmount" * p.price AS cover_amount_usd,
        "coverPrice" / 10 ^ c.decimals AS premium_paid,
        "coverPrice" / 10 ^ c.decimals * p.price AS premium_paid_usd,
        date_trunc('day', evt_block_time) AS date_bought,
        date_trunc(
            'day',
            (
                SELECT
                    TIMESTAMP WITH TIME ZONE 'epoch' + "startTime" * INTERVAL '1 second'
            )
        ) AS start_date,
        date_trunc(
            'day',
            (
                SELECT
                    TIMESTAMP WITH TIME ZONE 'epoch' + "startTime" * INTERVAL '1 second' + "coverPeriod" * INTERVAL '1 day'
            )
        ) AS end_date,
        s.nft_id AS staked_id,
        w.nft_id AS nft_unstaked_id,
        "coverPeriod" AS cover_period
    FROM
        armor_fi."arNFT_evt_BuyCover" buy
        LEFT JOIN currencies c ON c.identifier = buy.currency
        LEFT JOIN prices.usd p ON c.token = p.symbol
        LEFT JOIN staked_before_2021_03_04 s ON "coverId" = s.nft_id
        LEFT JOIN withdrawn_before_2021_03_03 w ON "coverId" = w.nft_id
    WHERE
        p.minute = date_trunc(
            'day',
            (
                SELECT
                    NOW()
            )
        )
),
enhanced_cover_usd AS (
    SELECT
        cover_id,
        covered_contract,
        currency,
        cover_amount,
        cover_amount_usd,
        premium_paid,
        premium_paid_usd,
        start_date,
        end_date,
        cover_period,
        CASE
            WHEN staked_id IS NULL THEN FALSE
            ELSE TRUE
        END AS nft_staked,
        CASE
            WHEN nft_unstaked_id IS NULL THEN FALSE
            ELSE TRUE
        END AS nft_unstaked,
        CASE
            WHEN (
                SELECT
                    NOW() > end_date
            ) THEN TRUE
            ELSE FALSE
        END AS is_nft_expired,
        buyer,
        date_bought
    FROM
        staked_cover_usd
)
SELECT
    COUNT(DISTINCT cover_id) AS "No. of Cover Purchases",
    COUNT(DISTINCT buyer) AS "No. of Buyers",
    SUM(cover_amount_usd) AS "Total Cover Purchased in USD",
    SUM(premium_paid_usd) "Total Premiums in USD",
    SUM(cover_amount_usd) / COUNT(DISTINCT cover_id) AS "Avg. Cover Amount per Purchase",
    SUM(cover_amount_usd) / COUNT(DISTINCT buyer) AS "Avg. Cover Amount per Buyer",
    SUM(premium_paid_usd) / COUNT(DISTINCT cover_id) AS "Avg. Premium per Purchase",
    SUM(premium_paid_usd) / COUNT(DISTINCT buyer) AS "Avg. Premium per Buyer"
FROM
    enhanced_cover_usd