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
    cover_usd