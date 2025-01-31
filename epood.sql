CREATE DATABASE epoodNikiforov

use epoodNikiforov;

Create table Category 
(idCategory int primary key identity(1,1),
CategoryName varchar(25) UNIQUE)

select * from Category

Insert into Category
Values('jook'), ('sook')

--tabeli struukturi muutumine --> uue veergi lisamine
alter table Category ADD test int;

--tabeli struukturi muutumine --> uue kustutamine
alter table Category DROP COLUMN test;

CREATE TABLE Product
(idProduct int primary key identity(1,1),
ProductName varchar(25) not null,
idCategory int,
FOREIGN KEY(idCategory) references Category(idCategory),
Price decimal(5,2) not null
)


INSERT INTO Product (ProductName, idCategory, Price)
VALUES
('piim', 1, 2.00),
('kohupiim', 2, 1.50),
('sealiha', 2, 2.00),
('limonaad', 1, 1.60), 
('õlut', 1, 2.00)

Create table customer (
IdCustomer int primary key identity(1,1),
Name varchar(25),
Contact text)

INSERT INTO customer (Name, Contact)
VALUES
('Donald', '111 111 111'),
('Bill', '222 222 222'),
('Ronald', '333 333 333'),
('Peter', '444 444 444'),
('Trufield', '555 555 555')

create table Sale
(idSale int primary key identity(1,1),
idProduct int,
FOREIGN KEY(idProduct) references Product(idProduct),
idCustomer int, 
Count int,
DateOfSale date)

INSERT INTO Sale (idProduct, idCustomer, Count, DateOfSale)
VALUES
(1,1,4,'2025-01-31'),
(2,2,2,'2025-01-28'),
(3,3,1,'2025-01-25'),
(4,4,2,'2025-01-13'),
(5,5,10,'2025-01-01')

--kusutab kõik kirjed
DELETE FROM Sale

alter table sale ADD foreign key (idCustomer)
references Customer(idCustomer)

select * from Product
select * from customer
select * from Category
select * from Sale
