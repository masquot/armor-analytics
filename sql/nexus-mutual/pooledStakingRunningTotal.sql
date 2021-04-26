WITH staked_and_unstaked AS (
    SELECT
        evt_block_time,
        amount / 10 ^ 18 AS nxm_staked,
        0 AS nxm_unstaked,
        0 AS nxm_burned,
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
        0 AS nxm_burned,
        "contractAddress" AS staking_contract
    FROM
        nexusmutual."PooledStaking_evt_Unstaked"
    WHERE
        staker = '\x1337def1fc06783d4b03cb8c1bf3ebf7d0593fc4'
    UNION
    ALL -- manually added burned due to accepted yearn claim
    SELECT
        '2021-02-08',
        0 AS nxm_staked,
        0 AS nxm_unstaked,
        30272.704 AS nxm_burned,
        "contractAddress" AS staking_contract
    FROM
        nexusmutual."PooledStaking_evt_Staked"
    WHERE
        staker = '\x1337def1fc06783d4b03cb8c1bf3ebf7d0593fc4'
        AND evt_block_time < '2021-01-24'
),
weekly_net_changes AS (
    SELECT
        date_trunc('week', evt_block_time) AS week,
        -- COALESCE((labels.get(staking_contract, 'project'))[1], encode(staking_contract, 'hex')) AS "project",
        (
            SUM(nxm_staked) - SUM(nxm_unstaked) - SUM(nxm_burned)
        ) AS net_change
    FROM
        staked_and_unstaked
    GROUP BY
        1
)
SELECT
    week AS "Week",
    SUM(net_change) OVER (
        ORDER BY
            week
    ) AS "Total Staked"
FROM
    weekly_net_changes