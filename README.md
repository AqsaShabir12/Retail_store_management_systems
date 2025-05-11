# Retail_store_management_systems

This repository contains multiple relational database schemas used for exercises in invoicing, HR, inventory, and retail store management systems.

---

## Files Overview

| File Name              | Description                                                                 |
|------------------------|-----------------------------------------------------------------------------|
| `create-db-store.sql`  | Creates the schema for a general-purpose retail store database              |
| `create-db-invoicing.sql` | Defines tables and relationships for managing invoices and transactions      |
| `create-db-hr.sql`     | Contains a schema for a human resources (HR) database, including employees  |
| `create-db-inventory.sql` | Creates inventory-related tables to manage product stock and movement       |
| `create-databases.sql` | Master script to create all core databases (modular execution supported)    |
| `sqlstore2.sql`        | Sample SQL file containing queries or supplemental data for practice        |

---

##  Skills Covered

- SQL `CREATE TABLE` syntax
- Primary/foreign key constraints
- Data types, indexing, and normalization
- Schema design for different domains: retail, HR, inventory, invoicing
- Executing SQL scripts in MySQL, PostgreSQL, or SQLite environments

---

##  How to Use

1. Open any SQL environment (MySQL Workbench, pgAdmin, SQLite CLI, or DB Browser).
2. Run each `.sql` file as needed to create the desired schema:
   ```sql
   -- Example: Executing the store schema
   SOURCE create-db-store.sql;
