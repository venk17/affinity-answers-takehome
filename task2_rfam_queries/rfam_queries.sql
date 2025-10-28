
---

## 🧩 `task2_rfam_queries/rfam_queries.sql`
```sql
-- Task 2: Rfam SQL Queries

-- Q1: How many types of tigers in taxonomy table?
SELECT COUNT(*) AS tiger_count
FROM taxonomy
WHERE LOWER(scientific_name) LIKE '%tigris%';

-- Q1b: NCBI ID of Sumatran Tiger (Panthera tigris sumatrae)
SELECT scientific_name, ncbi_id
FROM taxonomy
WHERE LOWER(scientific_name) LIKE '%sumatrae%';

-- Q2: Columns used to connect tables (foreign keys)
SELECT
  tc.table_name,
  kcu.column_name,
  ccu.table_name AS foreign_table,
  ccu.column_name AS foreign_column
FROM information_schema.table_constraints AS tc
JOIN information_schema.key_column_usage AS kcu
  ON tc.constraint_name = kcu.constraint_name
JOIN information_schema.constraint_column_usage AS ccu
  ON ccu.constraint_name = tc.constraint_name
WHERE constraint_type = 'FOREIGN KEY';

-- Q3: Rice species with longest DNA sequence
SELECT t.scientific_name, MAX(r.seq_len) AS longest_sequence
FROM rfamseq r
JOIN taxonomy t
  ON r.ncbi_taxid = t.ncbi_id
WHERE LOWER(t.scientific_name) LIKE '%oryza%'
GROUP BY t.scientific_name
ORDER BY longest_sequence DESC
LIMIT 1;

-- Q4: Pagination query (families with seq_len > 1,000,000)
-- 9th page, 15 results per page => OFFSET = 120
SELECT
  f.rfam_acc AS family_accession,
  f.rfam_id AS family_name,
  MAX(r.seq_len) AS max_length
FROM family f
JOIN rfamseq r
  ON f.rfam_acc = r.rfam_acc
GROUP BY f.rfam_acc, f.rfam_id
HAVING MAX(r.seq_len) > 1000000
ORDER BY max_length DESC
LIMIT 15 OFFSET 120;
