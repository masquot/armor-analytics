-- works but data stops at 2021-02-12
-- using call data does work, both list the same `contract_address` field
WITH arNXMVault_evts AS (
    SELECT
        evt_block_time,
        "wAmount" / 1e18 AS amount
    FROM
        armor_fi."arNXMVault_evt_Deposit"
    UNION ALL
    SELECT
        evt_block_time,
        - "wAmount" / 1e18
    FROM
        armor_fi."arNXMVault_evt_Withdrawal"
),
arNXMVault_calls AS (
    SELECT
        call_block_time,
        "_wAmount" / 1e18 AS amount
    FROM
        armor_fi."arNXMVault_call_deposit"
    WHERE
        call_success = TRUE
    UNION ALL
    SELECT
        call_block_time,
        - "_arAmount" / 1e18
    FROM
        armor_fi."arNXMVault_call_withdraw"
    WHERE
        call_success = TRUE
)
SELECT
    date_trunc('day', call_block_time),
    SUM(amount) AS "Amount"
FROM
    arNXMVault_calls
GROUP BY
    1
