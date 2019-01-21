CREATE TABLE Customers(
customer_id varchar2(15) PRIMARY KEY,
customer_name varchar2(15) NOT NULL,
contact_name varchar2(15) NOT NULL,
address varchar2(15) NOT NULL,
city varchar2(15) NOT NULL,
postal_code varchar2(15),
country varchar2(15) NOT NULL
);
CREATE TABLE Employees(
employee_id varchar2(15) PRIMARY KEY,
last_name varchar2(15) NOT NULL,
first_name varchar2(15) NOT NULL,
birth_date varchar2(15) NOT NULL,
photo varchar2(15) NOT NULL,
notes varchar2(15)
);

CREATE SEQUENCE order_id
START WITH 1000
INCREMENT BY 1;

CREATE TABLE Orders(
order_id varchar2(15) PRIMARY KEY,
customer_id varchar2(15) NOT NULL,
employee_id varchar2(15) NOT NULL,
order_date DATE DEFAULT SYSDATE,
shipper_id varchar2(15),
CONSTRAINT  Orders_fk_employee_id FOREIGN KEY(employee_id) REFERENCES  Employees(employee_id)
);