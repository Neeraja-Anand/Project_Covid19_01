CREATE DATABASE library;
-- Use the 'library' database
USE library;
-- Create the 'Branch1' table
CREATE TABLE Branch1 (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(255),
    Contact_no VARCHAR(20));
    
    INSERT INTO Branch1 (Branch_no, Manager_Id, Branch_address, Contact_no)
VALUES
    (1, 101, 'kkm', '988888888888'),
    (2, 102, 'XYZ', '99988776655'),
    (3, 103, 'ABC', '9993349993');
    
    CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(255),
    Position VARCHAR(255),
    Salary DECIMAL(10, 2)
);
-- Inserting values into the Employee table
INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary)
VALUES
    (1, 'John Doe', 'Manager', 50000.00),
    (2, 'Jane Smith', 'Developer', 45000.00),
    (3, 'Bob Johnson', 'Analyst', 40000.00);


-- Create the "Customer" table
CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(255),
    Customer_address VARCHAR(255),
    Reg_date DATE
);

INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date)
VALUES
    (1, 'Anny', '123 Main St', '2023-01-15'),
    (2, 'Smith', '456 Oak Ave', '2023-02-20'),
    (3, 'Marly', '789 Elm Blvd', '2023-03-25');

-- Create the "Books" table
CREATE TABLE Books (
    ISBN VARCHAR(13) PRIMARY KEY,
    Book_title VARCHAR(255),
    Category VARCHAR(255),
    Rental_Price DECIMAL(10, 2),
    Status ENUM('yes', 'no'),
    Author VARCHAR(255),
    Publisher VARCHAR(255)
);
INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher)
VALUES
    ('9781234567890', 'Python', 'Reference', 15.99, 'yes', 'F. Scott Fitzgerald', 'Penguin Books'),
    ('9780987654321', 'Introduction to SQL', 'Non-fiction', 29.99, 'no', 'John Doe', 'Tech Publications'),
    ('9785555555555', 'PowerBI', 'Reference', 24.99, 'yes', 'Jane Smith', 'Science Press');

-- Create the "IssueStatus" table
CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(255),
    Issue_date DATE,
    Isbn_book VARCHAR(13),
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);
INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book)
VALUES
    (1, 1, 'Python', '2023-01-20', '9781234567890'),
    (2, 2, 'Introduction to SQL', '2023-02-15', '9780987654321'),
    (3, 3, 'PowerBi', '2023-03-10', '97855555555');

-- Create the "ReturnStatus" table
CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(255),
    Return_date DATE,
    Isbn_book2 VARCHAR(13),
    FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);
INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2)
VALUES
    (1, 1, 'Python', '2023-02-05', '9781234567890'),
    (2, 2, 'Introduction to SQL', '2023-03-02', '9780987654321'),
    (3, 3, 'PowerBi', '2023-04-15', '9785555555555');
SELECT Book_title, Category, Rental_Price
FROM Books
WHERE Status = 'yes';

SELECT Emp_name, Salary
FROM Employee
ORDER BY Salary DESC;

SELECT B.Book_title, C.Customer_name
FROM IssueStatus AS I
INNER JOIN Books AS B ON I.Isbn_book = B.ISBN
INNER JOIN Customer AS C ON I.Issued_cust = C.Customer_Id;

SELECT Category, COUNT(*) AS BookCount
FROM Books
GROUP BY Category;

SELECT Emp_name, Position
FROM Employee
WHERE Salary > 50000;

SELECT Customer_name
FROM Customer
WHERE Reg_date < '2022-01-01' AND Customer_Id NOT IN (SELECT DISTINCT Issued_cust FROM IssueStatus);

ALTER TABLE Employee
ADD Branch_ID INT,
ADD FOREIGN KEY (Branch_ID) REFERENCES Branch(Branch_no);

SELECT Branch_ID, COUNT(*) AS EmployeeCount
FROM Employee
GROUP BY Branch_ID;

SELECT DISTINCT C.Customer_name
FROM Customer AS C
INNER JOIN IssueStatus AS I ON C.Customer_Id = I.Issued_cust
WHERE YEAR(Issue_date) = 2023 AND MONTH(Issue_date) = 6;

SELECT Book_title
FROM Books
WHERE Category = 'history';

SELECT E.Branch_ID, COUNT(*) AS EmployeeCount
FROM Employee AS E
GROUP BY E.Branch_ID
HAVING EmployeeCount > 5;

    