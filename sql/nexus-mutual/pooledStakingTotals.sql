WITH staked AS (
    SELECT
        SUM(amount / 10 ^ 18) AS nxm_staked
    FROM
        nexusmutual."PooledStaking_evt_Staked"
    WHERE
        staker = '\x1337def1fc06783d4b03cb8c1bf3ebf7d0593fc4'
),
unstaked AS (
    SELECT
        SUM(amount / 10 ^ 18) AS nxm_unstaked
    FROM
        nexusmutual."PooledStaking_evt_Unstaked"
    WHERE
        staker = '\x1337def1fc06783d4b03cb8c1bf3ebf7d0593fc4'
),
deposited AS (
    SELECT
        SUM(amount / 10 ^ 18) AS nxm_deposited
    FROM
        nexusmutual."PooledStaking_evt_Deposited"
    WHERE
        staker = '\x1337def1fc06783d4b03cb8c1bf3ebf7d0593fc4'
),
withdrawn AS (
    SELECT
        SUM(amount / 10 ^ 18) AS nxm_withdrawn
    FROM
        nexusmutual."PooledStaking_evt_Withdrawn"
    WHERE
        staker = '\x1337def1fc06783d4b03cb8c1bf3ebf7d0593fc4'
),
burned AS (
    SELECT 30272.704 AS nxm_burned
)
SELECT
    --    date_trunc('week', evt_block_time) AS "Week",
    -- staking_contract,
    -- labels.get(staking_contract, 'project') AS "project",
    (nxm_deposited) AS "NXM Deposited",
    (nxm_withdrawn) AS "NXM Withdrawn",
    (nxm_burned) AS "NXM Burned",
    (nxm_deposited - nxm_withdrawn - nxm_burned) AS "NXM Stake Deposit",
    (nxm_staked) AS "NXM Staked",
    (nxm_unstaked) AS "NXM Unstaked"
FROM
    staked,
    unstaked,
    deposited,
    withdrawn,
    burned
    