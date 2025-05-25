-- library managment sysetem
create table branch(
branch_id varchar(10) primary key,
manager_id varchar(10),
branch_address varchar(50),
contact_no varchar(10)
);
alter table branch
alter column contact_no type varchar(20);

create table employees(
emp_id varchar(10) primary key,
emp_name varchar(20),
position varchar(20),
salary int,
branch_id varchar(10), --FK

-- Foreign Key Constraints
    CONSTRAINT fk_branch FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
);

create table books(
isbn varchar(20) primary key,
book_title varchar(75),
category varchar(20),
rental_price float,
status varchar(15),
author varchar(30),
publisher varchar(30)
)

create table members(
member_id varchar(10) primary key,
member_name varchar(20),
member_address varchar(20),
reg_date date
)

create table issued_status(
issued_id varchar(10) primary key,
issued_member_id varchar(10), --FK
issued_book_name varchar(75),
issued_date date,
issued_book_isbn varchar(25), --Fk
issued_emp_id varchar(10), --Fk

-- Foreign Key Constraints
    CONSTRAINT fk_members FOREIGN KEY (issued_member_id) REFERENCES members(member_id),
    CONSTRAINT fk_books FOREIGN KEY (issued_book_isbn) REFERENCES books(isbn),
    CONSTRAINT fk_employees FOREIGN KEY (issued_emp_id) REFERENCES employees(emp_id)
)

create table return_status(
return_id varchar(10) primary key,
issued_id varchar(10),
return_book_name varchar(75),
return_date	date,
return_book_isbn varchar(20),

-- Foreign Key Constraints
    CONSTRAINT fk_issued_status FOREIGN KEY (issued_id) REFERENCES issued_status(issued_id)
)

select * from books;