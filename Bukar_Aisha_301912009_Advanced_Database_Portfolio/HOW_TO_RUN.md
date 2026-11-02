# How to Run the ShopEase Portfolio (Step-by-Step)
**Student:** Aisha Ali Bukar | ID: 301912009

This guide shows you the easiest ways to run the SQL parts so you can take real screenshots.

---

## Option 1 – Easiest (Recommended): Free Cloud PostgreSQL (Neon or Supabase)

### Using Neon.tech (very simple)
1. Go to https://neon.tech and sign up with your email / Google.
2. Create a new project (choose any name, e.g. “shopease”).
3. After creation you will see a connection string that looks like:
   ```
   postgresql://username:password@ep-xxx.us-east-2.aws.neon.tech/neondb?sslmode=require
   ```
4. Open the **SQL Editor** inside the Neon dashboard.
5. Copy the entire content of `portfolio-1-database-design/schema.sql` and paste → Run.
6. Then copy the entire content of `portfolio-1-database-design/sample_data.sql` and paste → Run.
7. Now you can run the queries from Portfolio 2 and the transactions from Portfolio 3.

### Using Supabase (also free and easy)
1. Go to https://supabase.com → Start your project.
2. Go to SQL Editor.
3. Paste and run `schema.sql`, then `sample_data.sql`.

---

## Option 2 – Local PostgreSQL (if you prefer)

### Windows
1. Download PostgreSQL from https://www.postgresql.org/download/windows/
2. Install (remember the password you set for the `postgres` user).
3. Open **pgAdmin** or **psql**.
4. Create a database called `shopease`.
5. Run the two SQL files in order.

### macOS
```bash
brew install postgresql@16
brew services start postgresql@16
createdb shopease
psql shopease
```
Then paste the SQL.

### Ubuntu / Linux
```bash
sudo apt update
sudo apt install postgresql postgresql-contrib
sudo -u postgres createdb shopease
sudo -u postgres psql shopease
```

---

## Running the Queries (Portfolio 2)

After the schema and data are loaded:

1. Open the SQL editor.
2. Copy one query from `portfolio-2-query-optimisation/queries.sql`.
3. Add `EXPLAIN ANALYZE` in front of it (already present in the file).
4. Run it and take a screenshot of the plan + the result.
5. Create the recommended indexes (also in the file).
6. Run the same query again and take another screenshot showing the improved plan.

---

## Running the Transactions (Portfolio 3)

You need **two browser tabs** or two SQL editor windows connected to the same database.

- Follow the comments inside `transactions.sql` exactly.
- Session A and Session B must be different connections.
- Take screenshots when you see COMMIT, ROLLBACK, or any lock/deadlock message.

---

## MongoDB part (Portfolio 4) – Optional but recommended

1. Go to https://www.mongodb.com/cloud/atlas → Sign up (free).
2. Create a free cluster.
3. Create a database called `shopease`.
4. Use the MongoDB shell or Compass and paste the examples from `mongodb_examples.js`.

---

## Final Checklist Before Submission

- [ ] Schema + sample data loaded successfully
- [ ] At least 2–3 queries run with EXPLAIN ANALYZE screenshots
- [ ] At least one successful transaction + one ROLLBACK screenshot
- [ ] ER diagram image generated from the Mermaid code
- [ ] Personal reflection written (use the template below)
- [ ] Files uploaded to a private GitHub repository
- [ ] GitHub link accessible to the lecturer
- [ ] AI Use Declaration included
- [ ] Folder and files named correctly: `Bukar_Aisha_301912009_...`

You do **not** need to be an expert. Just follow the steps above one by one and take screenshots as you go.
