# Task 2 – SQL Queries (Rfam Database)

## 🎯 Objective
Answer database-related questions using the **Rfam public SQL schema**.

---

### Q1: Types of tigers in taxonomy table
```sql
SELECT COUNT(*) FROM taxonomy WHERE LOWER(scientific_name) LIKE '%tigris%';
