-- verified manually using info.uniswap.org
-- OK ARMOR:WETH
-- OK ARMOR:DAI
-- OK ARMOR:WBTC
WITH tokens AS (
    SELECT
        *
    FROM
        (
            VALUES
                ('WETH', 18),
                ('ARMOR', 18),
                ('ARNXM', 18),
                ('WBTC', 8),
                ('DAI', 18)
        ) AS t (symbol, decimals)
),
pools AS (
    SELECT
        *
    FROM
        (
            VALUES
                (
                    'ARMOR:WETH',
                    0.5,
                    'Uniswap',
                    '\x648450d9c30b73e2229303026107a1f7eb639f6c' :: bytea,
                    '\xf991f1e1B8Acd657661c89b5CD452d86De76a8C1' :: bytea
                ),
                (
                    'ARMOR:WBTC',
                    0.5,
                    'Uniswap',
                    '\x888759cb22cedadf2cfb0049b03309d45aa380d9' :: bytea,
                    '\x01Acad2228F18598CD2b8611aCD37992BF27313C' :: bytea
                ),
                (
                    'ARMOR:DAI',
                    0.5,
                    'Uniswap',
                    '\xfc0dd985f6de9c2322ebd97c3422b0857c4d78c7' :: bytea,
                    '\xa659e66E116D354e779D8dbb35319AF67171ffb4' :: bytea
                )
        ) AS t (
            pair,
            composition,
            dex,
            liquidity_address,
            stakepool_address
        )
),
fourteen_days_ago AS (
    SELECT
        date_trunc(
            'day',
            (
                SELECT
                    NOW()
            ) - INTERVAL '13 days'
        ) AS start_date
),
prices_short AS (
    SELECT
        *
    FROM
        prices.usd
    WHERE
        MINUTE > (
            SELECT
                start_date
            FROM
                fourteen_days_ago
        )
        AND symbol IN ('WETH', 'WBTC', 'DAI')
),
swaps AS (
    SELECT
        pair,
        dex,
        "amount0In" / 10 ^ 18 AS armor_amount_in,
        - "amount0Out" / 10 ^ 18 AS armor_amount_out,
        "amount1In" / 10 ^ t.decimals AS token_amount_in,
        - "amount1Out" / 10 ^ t.decimals AS token_amount_out,
        ("amount1In" + "amount1Out") / 10 ^ t.decimals * p.price AS swap_usd_value,
        evt_block_time
    FROM
        uniswap_v2."Pair_evt_Swap" uni
        LEFT JOIN pools ON pools.liquidity_address = uni.contract_address --    LEFT JOIN prices_short p ON p.minute = date_trunc('minute', evt_block_time)
        LEFT JOIN prices_short p ON p.minute = date_trunc('minute', evt_block_time)
        AND split_part(pools.pair, ':', 2) = p.symbol --    AND split_part(pools.pair, ':', 2) = p.symbol
        LEFT JOIN tokens t ON split_part(pools.pair, ':', 2) = t.symbol
    WHERE
        evt_block_time > (
            SELECT
                start_date
            FROM
                fourteen_days_ago
        )
        AND uni.contract_address IN (
            SELECT
                liquidity_address
            FROM
                pools
        )
)
SELECT
    date_trunc('day', evt_block_time),
    pair,
    SUM(swap_usd_value) AS "Daily USD Swap Volume"
FROM
    swaps
GROUP BY
    date_trunc('day', evt_block_time),
    pair