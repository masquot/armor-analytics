WITH staked_and_unstaked AS (
    SELECT
        evt_block_time,
        amount / 10 ^ 18 AS nxm_staked,
        0 AS nxm_unstaked,
        "contractAddress" AS staking_contract
    FROM
        nexusmutual."PooledStaking_evt_Staked"
    WHERE
        staker = '\x1337def1fc06783d4b03cb8c1bf3ebf7d0593fc4'
    UNION
    ALL
    SELECT
        evt_block_time,
        0 AS nxm_staked,
        amount / 10 ^ 18 AS nxm_unstaked,
        "contractAddress" AS staking_contract
    FROM
        nexusmutual."PooledStaking_evt_Unstaked"
    WHERE
        staker = '\x1337def1fc06783d4b03cb8c1bf3ebf7d0593fc4'
)
SELECT
--    date_trunc('week', evt_block_time) AS "Week",
    staking_contract,
    labels.get(staking_contract, 'project') AS "project",
    SUM(nxm_staked) - SUM(nxm_unstaked) AS "NXM Staked"
FROM
    staked_and_unstaked
GROUP BY
    1,
    2