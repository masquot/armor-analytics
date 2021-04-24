with open('arcore-input.txt') as f:
    lines = f.readlines()

start = """
WITH arcore_input AS (
    SELECT
        *
    FROM
        (
            VALUES
"""

end = """
        ) AS t (
            project,
            staked,
            purchased,
            remaining
        )
)
SELECT
    'arNFT Staked' AS "Type",
    project AS "Project",
    staked AS "Staked",
    purchased AS "Purchased",
    remaining AS "Remaining",
    purchased / staked * 100 AS "% Sold",
    remaining / staked * 100 AS "% Remaining"
FROM
    arcore_input
WHERE
    staked > 0
ORDER BY
    staked DESC
"""

with open('arcore-sql-output.txt', 'w') as w:
    w.write(start)
    for count, line in enumerate(lines):
        words = line.split()
        if count % 3 == 0:
            w.write('(')
            w.write("'" + words[0] + "'" + ',')
            w.write(words[2])
            w.write(',')
        if count % 3 == 1:
            w.write(words[2])
            w.write(',')
        if count % 3 == 2:
            w.write(words[2])
            w.write(')')
            if count != len(lines) - 1:
                w.write(',')
            w.write("\n")
    w.write(end)
   
