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
prices_short AS (
    SELECT
        *
    FROM
        prices.usd
    WHERE
        minute > '2020-11-01'
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
        LEFT JOIN prices_short p ON p.minute = date_trunc('minute', evt_block_time)
        AND c.token = p.symbol
)
SELECT
    cover_period,
    date_bought,
    SUM(cover_amount_usd),
    SUM(premium_paid_usd)
FROM
    cover_usd
GROUP BY
    cover_period,
    date_bought