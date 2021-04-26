-- query adapted from Dune dcoumentation
-- arNXM
WITH arnxm_token_supply AS (
        SELECT
            'arNXM' AS token,
            SUM(transfer) AS total_supply
        FROM
            (
                SELECT
                    (value / 1e18) AS transfer --Divide by relevant decimal number
                FROM
                    erc20."ERC20_evt_Transfer"
                WHERE
                    contract_address = '\x1337DEF18C680aF1f9f45cBcab6309562975b1dD' -- token contract address
                    AND "from" = '\x0000000000000000000000000000000000000000'
                UNION
                ALL
                SELECT
                    (- value / 1e18) AS transfer --Divide by relevant decimal number
                FROM
                    erc20."ERC20_evt_Transfer"
                WHERE
                    contract_address = '\x1337DEF18C680aF1f9f45cBcab6309562975b1dD' -- token contract address
                    AND "to" = '\x0000000000000000000000000000000000000000'
            ) i
    ),
    nxm_token_supply AS (
        SELECT
            'NXM' AS token,
            SUM(transfer) AS total_supply
        FROM
            (
                SELECT
                    (value / 1e18) AS transfer --Divide by relevant decimal number
                FROM
                    erc20."ERC20_evt_Transfer"
                WHERE
                    contract_address = '\xd7c49cee7e9188cca6ad8ff264c1da2e69d4cf3b' -- token contract address
                    AND "from" = '\x0000000000000000000000000000000000000000'
                UNION
                ALL
                SELECT
                    (- value / 1e18) AS transfer --Divide by relevant decimal number
                FROM
                    erc20."ERC20_evt_Transfer"
                WHERE
                    contract_address = '\xd7c49cee7e9188cca6ad8ff264c1da2e69d4cf3b' -- token contract address
                    AND "to" = '\x0000000000000000000000000000000000000000'
            ) j
    ),wnxm_token_supply AS (
        SELECT
            'wNXM' AS token,
            SUM(transfer) AS total_supply
        FROM
            (
                SELECT
                    (value / 1e18) AS transfer --Divide by relevant decimal number
                FROM
                    erc20."ERC20_evt_Transfer"
                WHERE
                    contract_address = '\x0d438f3b5175bebc262bf23753c1e53d03432bde' -- token contract address
                    AND "from" = '\x0000000000000000000000000000000000000000'
                UNION
                ALL
                SELECT
                    (- value / 1e18) AS transfer --Divide by relevant decimal number
                FROM
                    erc20."ERC20_evt_Transfer"
                WHERE
                    contract_address = '\x0d438f3b5175bebc262bf23753c1e53d03432bde' -- token contract address
                    AND "to" = '\x0000000000000000000000000000000000000000'
            ) k
    )

SELECT
    (SELECT total_supply FROM arnxm_token_supply) / (SELECT total_supply FROM nxm_token_supply) AS "arNXM Supply / NXM Supply"