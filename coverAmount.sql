WITH currencies AS (
    SELECT
        *
    FROM (
        VALUES ('ETH', '\x45544800'::bytea, 18, 'WETH'),
            ('DAI', '\x44414900'::bytea, 18, 'DAI')) AS t (currency, identifier, decimals, token)
),
cover_usd AS (
    SELECT
        "coverId" AS cover_id, buyer, "coveredContract" AS covered_contract, c.currency, "coverAmount" AS cover_amount, "coverAmount" * p.price AS cover_amount_usd, "coverPrice" / 10 ^ c.decimals AS premium_paid, "coverPrice" / 10 ^ c.decimals * p.price AS premium_paid_usd, "startTime" AS start_time, "coverPeriod" AS cover_period, evt_block_time
    FROM
        armor_fi."arNFT_evt_BuyCover" buy
        LEFT JOIN currencies c ON c.identifier = buy.currency
        LEFT JOIN prices.usd p ON p.minute = date_trunc('minute', evt_block_time)
            AND c.token = p.symbol
)
SELECT
    cover_id,
    buyer,
    cover_amount_usd,
    SUM(cover_amount_usd) OVER (PARTITION BY buyer ORDER BY cover_id, buyer) AS total_per_buyer,
    SUM(cover_amount_usd) OVER (ORDER BY cover_id) AS total_overall
FROM
    cover_usd
ORDER BY
    cover_id,
    buyer
