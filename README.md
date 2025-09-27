# Simple Library Management System Database

## 📚 Project Overview

This project implements a **simple Library Management System** using MySQL as part of the PLP Database Final Project. The system focuses on core library operations: managing books, members, and borrowing transactions with a clean, straightforward design.

## 🎯 Project Objectives

**Question 1: Complete Database Management System**

- ✅ **Real-world Use Case**: Library Management System
- ✅ **Well-structured Tables**: 5 essential tables with proper relationships
- ✅ **Proper Constraints**: PRIMARY KEY, FOREIGN KEY, NOT NULL, UNIQUE constraints
- ✅ **Relationships**: One-to-Many and Many-to-Many relationships

## 🗄️ Database Schema Design

### Simple Entity Relationship Overview

```
AUTHORS (1) ←→ (Many) BOOKS (Many) ←→ (Many) BORROWINGS (Many) ←→ (1) MEMBERS
CATEGORIES (1) ←→ (Many) BOOKS
```

### 📋 Database Tables (5 Core Tables)

#### 1. **AUTHORS**

Stores basic book author information

- **Primary Key**: `author_id`
- **Key Fields**: `first_name`, `last_name`, `email`
- **Constraints**: NOT NULL on names, UNIQUE email

#### 2. **CATEGORIES**

Manages book categories/genres

- **Primary Key**: `category_id`
- **Key Fields**: `category_name`
- **Constraints**: UNIQUE category names

#### 3. **BOOKS**

Central table for book inventory

- **Primary Key**: `book_id`
- **Key Fields**: `title`, `isbn`, `publication_year`, `total_copies`, `available_copies`
- **Foreign Keys**:
  - `author_id` → AUTHORS
  - `category_id` → CATEGORIES
- **Constraints**: UNIQUE ISBN, NOT NULL title

#### 4. **MEMBERS**

Library member registration

- **Primary Key**: `member_id`
- **Key Fields**: `first_name`, `last_name`, `email`, `phone`, `membership_date`
- **Constraints**: UNIQUE email, NOT NULL names

#### 5. **BORROWINGS**

Transaction records for book lending (Many-to-Many resolver)

- **Primary Key**: `borrowing_id`
- **Foreign Keys**:
  - `book_id` → BOOKS
  - `member_id` → MEMBERS
- **Key Fields**: `borrow_date`, `due_date`, `return_date`
- **Simple Design**: Basic borrowing tracking without complex status management

## 🔗 Relationship Types Implemented

### **One-to-Many Relationships**

- **AUTHORS** → **BOOKS** (One author can write many books)
- **CATEGORIES** → **BOOKS** (One category contains many books)
- **MEMBERS** → **BORROWINGS** (One member can have many borrowings)
- **BOOKS** → **BORROWINGS** (One book can be borrowed many times)

### **Many-to-Many Relationship**

- **BOOKS** ↔ **MEMBERS** (through BORROWINGS table)
  - Books can be borrowed by many members over time
  - Members can borrow many books

## 💾 Sample Data Included

The database comes pre-populated with:

- **3 Authors**: George Orwell, Jane Austen, Harper Lee
- **4 Categories**: Fiction, Mystery, Romance, Science Fiction
- **4 Books**: Classic literature titles (1984, Animal Farm, Pride and Prejudice, To Kill a Mockingbird)
- **3 Members**: Different member profiles
- **2 Sample Borrowing Transactions**: Active and returned books

## 🚀 How to Use This Database

### **Prerequisites**

- MySQL Server (5.7 or higher)
- MySQL Workbench (recommended) or any MySQL client

### **Installation Steps**

1. **Clone or Download** this repository

   ```bash
   git clone <repository-url>
   cd PLP-Database-Final_project
   ```

2. **Open MySQL Client**

   - MySQL Workbench
   - phpMyAdmin
   - Command line MySQL client

3. **Execute the SQL File**

   ```sql
   SOURCE library_management_system.sql;
   ```

   Or copy and paste the contents into your MySQL client and execute.

4. **Verify Installation**
   ```sql
   USE library_management_system;
   SHOW TABLES;
   SELECT COUNT(*) FROM books;
   ```

### **Common Queries to Test**

```sql
-- View all books with author and category information
SELECT
    b.title,
    CONCAT(a.first_name, ' ', a.last_name) AS author,
    c.category_name,
    b.available_copies,
    b.total_copies
FROM books b
JOIN authors a ON b.author_id = a.author_id
JOIN categories c ON b.category_id = c.category_id;

-- View current borrowings
SELECT
    CONCAT(m.first_name, ' ', m.last_name) AS member_name,
    b.title AS book_title,
    br.borrow_date,
    br.due_date,
    br.return_date
FROM borrowings br
JOIN books b ON br.book_id = b.book_id
JOIN members m ON br.member_id = m.member_id;

-- Find books by a specific author
SELECT b.title, b.isbn, b.publication_year
FROM books b
JOIN authors a ON b.author_id = a.author_id
WHERE a.last_name = 'Orwell';

-- Check available books
SELECT title, available_copies, total_copies
FROM books
WHERE available_copies > 0;
```

## 🔧 Basic Database Operations

### **Adding New Books**

```sql
INSERT INTO books (title, isbn, publication_year, total_copies, available_copies, author_id, category_id)
VALUES ('New Book Title', '978-1234567890', 2025, 3, 3, 1, 1);
```

### **Adding New Members**

```sql
INSERT INTO members (first_name, last_name, email, phone)
VALUES ('Jane', 'Doe', 'jane.doe@email.com', '+1-555-0199');
```

### **Recording a Book Borrowing**

```sql
INSERT INTO borrowings (book_id, member_id, borrow_date, due_date)
VALUES (1, 1, CURRENT_DATE, DATE_ADD(CURRENT_DATE, INTERVAL 14 DAY));

-- Update available copies
UPDATE books SET available_copies = available_copies - 1 WHERE book_id = 1;
```

### **Recording a Book Return**

```sql
UPDATE borrowings
SET return_date = CURRENT_DATE
WHERE borrowing_id = 1 AND return_date IS NULL;

-- Update available copies
UPDATE books SET available_copies = available_copies + 1 WHERE book_id = 1;
```

## 📊 Database Statistics

| Table      | Records | Purpose              |
| ---------- | ------- | -------------------- |
| Authors    | 3       | Author management    |
| Categories | 4       | Genre classification |
| Books      | 4       | Book inventory       |
| Members    | 3       | Member management    |
| Borrowings | 2       | Transaction history  |

## 🎓 Learning Outcomes

This simplified project demonstrates:

- **Clean Database Design**: Essential tables with clear relationships
- **SQL Fundamentals**: DDL, DML, and basic constraints
- **Real-world Application**: Practical library management scenarios
- **Data Integrity**: Foreign key relationships and constraints
- **Join Operations**: Connecting related data across tables

## ✨ Why This Simple Approach Works

- **Easy to Understand**: Clear table structure and relationships
- **Quick to Implement**: Minimal complexity, maximum functionality
- **Perfect for Learning**: Focuses on core database concepts
- **Extensible**: Can be expanded with additional features later
- **Practical**: Covers real library operations

## 🔍 Future Enhancements (Optional)

If you want to expand this system later, you could add:

- **Staff Management**: Track who processed each borrowing
- **Fines System**: Calculate overdue fees
- **Book Reservations**: Hold books for members
- **Publishers**: Track publishing information
- **Advanced Status**: More detailed borrowing states

## 📄 Technical Details

- **Database Engine**: MySQL 8.0+ compatible
- **Character Set**: UTF-8 for international support
- **Normalization**: 3rd Normal Form (3NF)
- **Referential Integrity**: Foreign key constraints
- **Simple Design**: No complex triggers or stored procedures

---

**Created by**: Bochaberii  
**Date**: September 27, 2025  
**Course**: PLP Database Management  
**Project**: Simple Library Management Database System
