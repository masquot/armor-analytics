-- query adapted from Dune dcoumentation
-- arNXM
WITH token_supply AS (
    (
        SELECT
            'arNXM' AS "Token",
            DAY,
            SUM(transfer) over (
                ORDER BY
                    DAY
            ) AS "Token Supply"
        FROM
            (
                SELECT
                    date_trunc('day', evt_block_time) AS DAY,
                    sum(value / 1e18) AS transfer --Divide by relevant decimal number
                FROM
                    erc20."ERC20_evt_Transfer"
                WHERE
                    contract_address = '\x1337DEF18C680aF1f9f45cBcab6309562975b1dD' -- token contract address
                    AND "from" = '\x0000000000000000000000000000000000000000'
                GROUP BY
                    1
                UNION
                SELECT
                    date_trunc('day', evt_block_time) AS DAY,
                    sum(- value / 1e18) AS transfer --Divide by relevant decimal number
                FROM
                    erc20."ERC20_evt_Transfer"
                WHERE
                    contract_address = '\x1337DEF18C680aF1f9f45cBcab6309562975b1dD' -- token contract address
                    AND "to" = '\x0000000000000000000000000000000000000000'
                GROUP BY
                    1
            )
    )
    UNION
    ALL (
        SELECT
            'wNXM',
            DAY,
            SUM(transfer) over (
                ORDER BY
                    DAY
            )
        FROM
            (
                SELECT
                    date_trunc('day', evt_block_time) AS DAY,
                    sum(value / 1e18) AS transfer --Divide by relevant decimal number
                FROM
                    erc20."ERC20_evt_Transfer"
                WHERE
                    contract_address = '\x0d438f3b5175bebc262bf23753c1e53d03432bde' -- token contract address
                    AND "from" = '\x0000000000000000000000000000000000000000'
                GROUP BY
                    1
                UNION
                SELECT
                    date_trunc('day', evt_block_time) AS DAY,
                    sum(- value / 1e18) AS transfer --Divide by relevant decimal number
                FROM
                    erc20."ERC20_evt_Transfer"
                WHERE
                    contract_address = '\x0d438f3b5175bebc262bf23753c1e53d03432bde' -- token contract address
                    AND "to" = '\x0000000000000000000000000000000000000000'
                GROUP BY
                    1
            )
    )
)
SELECT * FROM token_supply