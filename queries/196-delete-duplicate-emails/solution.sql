-- Postgres: USING is the multi-table delete syntax; equivalent to MySQL's DELETE p1 FROM ... JOIN
DELETE FROM Person p1
USING Person p2
WHERE p1.email = p2.email
  AND p1.id > p2.id;
