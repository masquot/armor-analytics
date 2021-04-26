WITH weeks AS (
    SELECT
        *
    FROM
        generate_series(
            date_trunc(
                'week',
                (
                    SELECT
                        NOW()
                )
            ),
            '2021-01-11',
            '-1 weeks'
        ) AS week_gen
),
staked AS (
    SELECT
        date_trunc('week', evt_block_time) AS week,
        SUM(amount / 10 ^ 18) AS total_amount --        "contractAddress" AS staking_contract
    FROM
        nexusmutual."PooledStaking_evt_Staked"
    WHERE
        staker = '\x1337def1fc06783d4b03cb8c1bf3ebf7d0593fc4'
    GROUP BY
        1
),
unstaked AS (
    SELECT
        date_trunc('week', evt_block_time) AS week,
        SUM(amount / 10 ^ 18) AS total_amount
    FROM
        nexusmutual."PooledStaking_evt_Unstaked"
    WHERE
        staker = '\x1337def1fc06783d4b03cb8c1bf3ebf7d0593fc4'
    GROUP BY
        1
),
stake_burned AS (
    SELECT
        timestamp '2021-02-08' AS week,
        30272.704 * 10 AS total_amount
),
nxm_burned AS (
    SELECT
        timestamp '2021-02-08' AS week,
        30272.704 AS total_amount
),
deposited AS (
    SELECT
        date_trunc('week', evt_block_time) AS week,
        SUM(amount / 10 ^ 18) AS total_amount
    FROM
        nexusmutual."PooledStaking_evt_Deposited"
    WHERE
        staker = '\x1337def1fc06783d4b03cb8c1bf3ebf7d0593fc4'
    GROUP BY
        1
),
withdrawn AS (
    SELECT
        date_trunc('week', evt_block_time) AS week,
        SUM(amount / 10 ^ 18) AS total_amount
    FROM
        nexusmutual."PooledStaking_evt_Withdrawn"
    WHERE
        staker = '\x1337def1fc06783d4b03cb8c1bf3ebf7d0593fc4'
    GROUP BY
        1
),
unstakeRequested AS (
    SELECT
        date_trunc('week', evt_block_time) AS week,
        SUM(amount / 10 ^ 18) AS total_amount
    FROM
        nexusmutual."PooledStaking_evt_UnstakeRequested"
    WHERE
        staker = '\x1337def1fc06783d4b03cb8c1bf3ebf7d0593fc4'
    GROUP BY
        1
)
SELECT
    weeks.week_gen,
    d.total_amount AS "NXM Deposited",
    w.total_amount AS "NXM Withdrawn",
    b.total_amount AS "NXM Burned",
    s.total_amount AS "NXM Staked",
    sb.total_amount AS "NXM Stake Burned",
    u.total_amount AS "NXM Unstaked",
    r.total_amount AS "NXM Unstake Requested"
FROM
    weeks
    LEFT JOIN staked s ON s.week = weeks.week_gen
    LEFT JOIN unstaked u ON u.week = weeks.week_gen
    LEFT JOIN nxm_burned b ON b.week = weeks.week_gen
    LEFT JOIN stake_burned sb ON sb.week = weeks.week_gen
    LEFT JOIN deposited d ON d.week = weeks.week_gen
    LEFT JOIN withdrawn w ON w.week = weeks.week_gen
    LEFT JOIN unstakeRequested r ON r.week = weeks.week_gen
ORDER BY
    1