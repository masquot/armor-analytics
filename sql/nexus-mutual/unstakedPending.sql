WITH unstake_requested AS (
    SELECT
        evt_block_time,
        amount / 10 ^ 18 AS nxm_unstake_requested,
        "unstakeAt" AS unstake_time,
        "contractAddress" AS staking_contract
    FROM
        nexusmutual."PooledStaking_evt_UnstakeRequested"
    WHERE
        staker = '\x1337def1fc06783d4b03cb8c1bf3ebf7d0593fc4'
)
SELECT
    labels.get(staking_contract, 'project') AS "Project",
    (
        SELECT
            TIMESTAMP WITH TIME ZONE 'epoch' + unstake_time * INTERVAL '1 second'
    ) AS "Lock Up End Time",
    nxm_unstake_requested AS "Amount",
    evt_block_time AS "Lock Up Start Time",
    staking_contract AS "Staking Contract"
FROM
    unstake_requested
ORDER BY
    evt_block_time DESC