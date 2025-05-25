select * from books;
select * from branch;
select * from members;
select * from employees;
select * from issued_status;
select * from return_status;

--Project Task
-- Task 1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"
INSERT INTO books(isbn, book_title, category, rental_price, status, author, publisher)
VALUES
('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')

-- Task 2: Update an Existing Member's Address
UPDATE members
SET member_address = '125 Main St'
WHERE member_id = 'C101';

-- Task 3: Delete a Record from the Issued Status Table 
-- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.
SELECT * FROM issued_status
WHERE issued_id = 'IS121';

DELETE FROM issued_status
WHERE issued_id = 'IS121';

-- Task 4: Retrieve All Books Issued by a Specific Employee 
-- Objective: Select all books issued by the employee with emp_id = 'E101'.
SELECT * FROM issued_status
WHERE issued_emp_id = 'E101'; 

-- Task 5: List Members Who Have Issued More Than One Book 
-- Objective: Use GROUP BY to find members who have issued more than one book.
SELECT issued_emp_id, COUNT(*) AS books_issued
FROM issued_status
GROUP BY issued_emp_id
HAVING COUNT(issued_id) > 1;

-- CTAS
-- Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt**
CREATE TABLE book_issue_summary AS
SELECT 
    issued_book_name,
    COUNT(*) AS book_issued_cnt
FROM issued_status
GROUP BY issued_book_name;

select * from book_issue_summary;

-- Task 7. Retrieve All Books in a Specific Category:
SELECT * FROM books
WHERE category = 'Classic';

-- Task 8: Find Total Rental Income by Category:
SELECT 
    b.category,
    SUM(rental_price) AS total_rental_income
FROM issued_status AS ist
JOIN books AS b ON b.isbn = ist.issued_book_isbn
GROUP BY b.category;

--Task 9: List Members Who Registered in the Last 180 Days:
SELECT * FROM members
WHERE reg_date >= CURRENT_DATE - INTERVAL '180 days';

-- task 10 List Employees with Their Branch Manager's Name and their branch details:
SELECT 
    e.emp_id,
    e.emp_name AS employee_name,
	e.position,
	e.salary,
    b.branch_id,
	b.manager_id,
    m.emp_name AS manager
FROM employees e
JOIN branch b ON e.branch_id = b.branch_id
LEFT JOIN employees m ON b.manager_id = m.emp_id;

-- Task 11. Create a Table of Books with Rental Price Above a Certain Threshold 7USD:
CREATE TABLE premium_books AS
SELECT *
FROM books
WHERE rental_price > 7;

SELECT * FROM premium_books;

-- Task 12: Retrieve the List of Books Not Yet Returned:
SELECT 
   DISTINCT ist.issued_book_name
FROM issued_status AS ist
LEFT JOIN return_status AS rst
    ON ist.issued_id = rst.issued_id
WHERE rst.issued_id IS NULL;