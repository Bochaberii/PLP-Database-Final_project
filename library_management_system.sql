

-- Create the database

CREATE DATABASE library_management_system;
USE library_management_system;



-- 1. AUTHORS Table
CREATE TABLE authors (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE
);

-- 2. CATEGORIES Table
CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) NOT NULL UNIQUE
);

-- 3. BOOKS Table
CREATE TABLE books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    publication_year YEAR,
    total_copies INT NOT NULL DEFAULT 1,
    available_copies INT NOT NULL DEFAULT 1,
    author_id INT NOT NULL,
    category_id INT NOT NULL,
    
    -- Foreign Key Constraints
    CONSTRAINT fk_books_author FOREIGN KEY (author_id) REFERENCES authors(author_id),
    CONSTRAINT fk_books_category FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- 4. MEMBERS Table
CREATE TABLE members (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    membership_date DATE NOT NULL DEFAULT (CURRENT_DATE)
);

-- 5. BORROWINGS Table (Many-to-Many relationship between Books and Members)
CREATE TABLE borrowings (
    borrowing_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    borrow_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    due_date DATE NOT NULL,
    return_date DATE NULL,
    
    -- Foreign Key Constraints
    CONSTRAINT fk_borrowings_book FOREIGN KEY (book_id) REFERENCES books(book_id),
    CONSTRAINT fk_borrowings_member FOREIGN KEY (member_id) REFERENCES members(member_id)
);



-- Insert Authors
INSERT INTO authors (first_name, last_name, email) VALUES
('George', 'Orwell', 'george.orwell@email.com'),
('Jane', 'Austen', 'jane.austen@email.com'),
('Harper', 'Lee', 'harper.lee@email.com');

-- Insert Categories
INSERT INTO categories (category_name) VALUES
('Fiction'),
('Mystery'),
('Romance'),
('Science Fiction');

-- Insert Books
INSERT INTO books (title, isbn, publication_year, total_copies, available_copies, author_id, category_id) VALUES
('1984', '978-0-452-28423-4', 1949, 3, 2, 1, 1),
('Animal Farm', '978-0-452-28424-1', 1945, 2, 2, 1, 1),
('Pride and Prejudice', '978-0-14-143951-8', 1813, 3, 3, 2, 3),
('To Kill a Mockingbird', '978-0-06-112008-4', 1960, 4, 3, 3, 1);

-- Insert Members
INSERT INTO members (first_name, last_name, email, phone) VALUES
('John', 'Smith', 'john.smith@email.com', '+1-555-0101'),
('Emily', 'Johnson', 'emily.johnson@email.com', '+1-555-0102'),
('Michael', 'Brown', 'michael.brown@email.com', '+1-555-0103');

-- Insert Sample Borrowings
INSERT INTO borrowings (book_id, member_id, borrow_date, due_date) VALUES
(1, 1, '2025-09-15', '2025-09-29'),
(4, 2, '2025-09-20', '2025-10-04');

-- Update return_date for one returned book
UPDATE borrowings SET return_date = '2025-09-28' WHERE borrowing_id = 1;



-- View all books with author and category
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

-- ========================================
-- SUCCESS MESSAGE
-- ========================================
SELECT 'Simple Library Management System created successfully!' AS Status;
