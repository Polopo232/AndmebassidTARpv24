-- Сотрудники
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Position VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE
);

-- Меню
CREATE TABLE MenuItem (
    ItemID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(6,2),
    Available BOOLEAN
);

-- Заказы
CREATE TABLE `Order` (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    OrderTime DATETIME,
    TableNumber INT,
    EmployeeID INT,
    Total DECIMAL(10,2),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- Позиции в заказе
CREATE TABLE OrderItem (
    OrderID INT,
    ItemID INT,
    Quantity INT,
    Price DECIMAL(6,2),
    PRIMARY KEY (OrderID, ItemID),
    FOREIGN KEY (OrderID) REFERENCES `Order`(OrderID),
    FOREIGN KEY (ItemID) REFERENCES MenuItem(ItemID)
);

-- Оплаты
CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    Amount DECIMAL(10,2),
    Method VARCHAR(50),
    PaidAt DATETIME,
    FOREIGN KEY (OrderID) REFERENCES `Order`(OrderID)
);

-- Клиенты
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    PhoneNumber VARCHAR(15),
    Email VARCHAR(100)
);

-- Инвентарь
CREATE TABLE Inventory (
    ItemID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Quantity INT,
    PurchasePrice DECIMAL(6,2),
    Supplier VARCHAR(100)
);

-- Скидки
CREATE TABLE Discount (
    DiscountID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(50),
    Percentage DECIMAL(5,2),
    StartDate DATETIME,
    EndDate DATETIME
);

-- Бронирования
CREATE TABLE Reservation (
    ReservationID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    TableNumber INT,
    ReservationTime DATETIME,
    Status VARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);
