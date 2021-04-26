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
armor_lifetime_range AS (
    SELECT
        *
    FROM
        generate_series('2021-01-11', current_date, '1 day') AS gen_date
),
days_since_start AS (
    SELECT
        *
    FROM
        armor_lifetime_range
        CROSS JOIN UNNEST ('{"ETH","DAI"}' :: text []) gen_currency
),
cover_usd AS (
    SELECT
        "coverId" AS cover_id,
        buyer,
        "coveredContract" AS covered_contract,
        c.currency,
        "coverAmount" AS cover_amount,
        "coverPrice" / 10 ^ c.decimals AS premium_paid,
        "startTime" AS start_time,
        "coverPeriod" AS cover_period,
        date_trunc('day', evt_block_time) AS date_bought
    FROM
        armor_fi."arNFT_evt_BuyCover" buy
        LEFT JOIN currencies c ON c.identifier = buy.currency
),
cover_usd_grouped AS (
    SELECT
        gen_date AS gen_date,
        gen_currency AS currency,
        SUM(cover_amount) AS daily_cover_amount,
        SUM(premium_paid) AS daily_premium_paid
    FROM
        days_since_start
        LEFT JOIN cover_usd ON gen_date = date_bought
        AND gen_currency = currency -- WHERE date_bought > '2021-01-10'
    GROUP BY
        1,
        2
),
running_total AS (
    SELECT
        gen_date,
        currency,
        --    daily_cover_amount,
        --    daily_premium_paid,
        SUM(daily_cover_amount) OVER (
            PARTITION BY currency
            ORDER BY
                gen_date,
                currency
        ) AS cover_amount,
        SUM(daily_premium_paid) OVER (
            PARTITION BY currency
            ORDER BY
                gen_date,
                currency
        ) AS premium_paid
    FROM
        cover_usd_grouped
    ORDER BY
        gen_date,
        currency
)
SELECT
    gen_date,
    r.currency,
    p.price,
    cover_amount,
    premium_paid,
    cover_amount * p.price AS cover_amount_usd,
    premium_paid * p.price AS premium_usd
FROM
    running_total r
    LEFT JOIN currencies c ON c.currency = r.currency
    LEFT JOIN prices.usd p ON c.token = p.symbol
    AND r.gen_date = p.minute