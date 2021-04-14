-- :todo: before going to production
-- 1 - Armor data not yet available in Dune, hard-coded 1 USD for now. Pull request initiated to integrate ARMOR
--
-- verified manually using info.uniswap.org
-- OK ARMOR:WETH
-- OK ARMOR:DAI
-- :todo: add correct decimals for ARMOR:WBTC
WITH pools AS (
    SELECT
        *
    FROM
        (
            VALUES
                (
                    'ARMOR:WETH',
                    'Uniswap',
                    '\x648450d9c30b73e2229303026107a1f7eb639f6c' :: bytea,
                    '\xf991f1e1B8Acd657661c89b5CD452d86De76a8C1' :: bytea
                ),
                (
                    'ARMOR:WBTC',
                    'Uniswap',
                    '\x888759cb22cedadf2cfb0049b03309d45aa380d9' :: bytea,
                    '\x01Acad2228F18598CD2b8611aCD37992BF27313C' :: bytea
                ),
                (
                    'ARMOR:DAI',
                    'Uniswap',
                    '\xfc0dd985f6de9c2322ebd97c3422b0857c4d78c7' :: bytea,
                    '\xa659e66E116D354e779D8dbb35319AF67171ffb4' :: bytea
                )
        ) AS t (pair, dex, liquidity_address, stakepool_address)
),
prices_short AS (
    SELECT
        *
    FROM
        prices.usd
    WHERE
        MINUTE > '2021-01-15'
        AND symbol IN ('ARMOR', 'WETH', 'WBTC', 'DAI')
) -- ARMOR:ETH Uni
SELECT
    pair,
    dex,
    split_part(pools.pair, ':', 1) AS first_token,
    "amount0" / 10 ^ 18 AS armor_amount,
    -- Armor data not yet available in Dune, hard-coded 1 USD for now
    "amount0" / 10 ^ 18 * 1 AS armor_price,
    split_part(pools.pair, ':', 2) AS second_token,
    "amount1" / 10 ^ 18 AS token_amount,
    "amount1" / 10 ^ 18 * p.price AS token_price,
    evt_block_time
FROM
    uniswap_v2."Pair_evt_Mint" uni
    LEFT JOIN pools ON pools.liquidity_address = uni.contract_address
    LEFT JOIN prices_short p ON p.minute = date_trunc('minute', evt_block_time)
    AND split_part(pools.pair, ':', 2) = p.symbol
WHERE
    evt_block_time > '2021-01-01'
    AND uni.contract_address IN (
        SELECT
            liquidity_address
        FROM
            pools
    )
ORDER BY
    evt_block_time DESC