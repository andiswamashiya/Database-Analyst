--  QUESTION 1

CREATE TABLE CUSTOMER(
Customer_ID VARCHAR2(5) NOT NULL,
First_Name VARCHAR2(50) NOT NULL,
Surname VARCHAR2(100) NOT NULL,
Address VARCHAR2(100) NOT NULL,
Contact_Num VARCHAR2(20) NOT NULL,
Email VARCHAR2(100) NOT NULL,
CONSTRAINT PK_CUSTOMER PRIMARY KEY(Customer_id)
);   

CREATE TABLE EMPLOYEE(
Employee_id VARCHAR2(6) NOT NULL,
First_Name VARCHAR2(50) NOT NULL,
Surname VARCHAR2(100) NOT NULL,
Contact_Num VARCHAR2(20) NOT NULL,
Address VARCHAR2(100) NOT NULL,
Email VARCHAR2(100) NOT NULL,
CONSTRAINT PK_EMPLOYEE PRIMARY KEY(Employee_id)
);

CREATE TABLE DONATOR(
Donator_id NUMBER(5) NOT NULL,
First_Name VARCHAR2(20) NOT NULL,
Surname VARCHAR2(50) NOT NULL,
Contact_Num VARCHAR2(20) NOT NULL,
Email VARCHAR2(100) NOT NULL,
CONSTRAINT PK_DONATOR PRIMARY KEY(Donator_ID)
);

CREATE TABLE DONATION(
Donation_ID NUMBER(4) NOT NULL,
Donator_id NUMBER(5) NOT NULL,
Donation VARCHAR2(50) NOT NULL,
Price INT NOT NULL,
Donation_Date DATE NOT NULL,
CONSTRAINT PK_DONATION PRIMARY KEY(Donation_ID),
CONSTRAINT FK_DONATOR_DONATION FOREIGN KEY(Donator_id) REFERENCES DONATOR(Donator_id)
);

CREATE TABLE DELIVERY(
Delivery_id INT NOT NULL,
Delivery_notes VARCHAR2(100) NOT NULL,
Dispatch_Date DATE NOT NULL,
Delivery_Date DATE NOT NULL,
CONSTRAINT PK_DELIVERY PRIMARY KEY(Delivery_id)
);

CREATE TABLE RETURNS(
Return_id VARCHAR2(6) NOT NULL,
Return_Date DATE NOT NULL,
Reason VARCHAR2(200) NOT NULL,
Customer_ID VARCHAR2(5) NOT NULL,
Donation_ID NUMBER(4) NOT NULL,
Employee_id VARCHAR2(6) NOT NULL,
CONSTRAINT PK_RETURNS PRIMARY KEY(Return_id),
CONSTRAINT FK_CUSTOMER_RETURNS FOREIGN KEY(Customer_id) REFERENCES CUSTOMER(Customer_id),
CONSTRAINT FK_DONATION_RETURNS FOREIGN KEY(Donation_id) REFERENCES DONATION(Donation_id),
CONSTRAINT FK_EMPLOYEE_RETURNS FOREIGN KEY(Employee_id) REFERENCES EMPLOYEE(Employee_id)
);

CREATE TABLE INVOICE (
    Invoice_num NUMBER(4) NOT NULL,
    Customer_ID VARCHAR2(5) NOT NULL,
    Invoice_Date DATE NOT NULL,
    Employee_id VARCHAR2(6) NOT NULL,
    Donation_ID NUMBER(4) NOT NULL,
    Delivery_id INT NOT NULL,
    CONSTRAINT PK_INVOICE PRIMARY KEY (Invoice_num), 
    CONSTRAINT FK_CUSTOMER_INVOICE FOREIGN KEY (Customer_ID) REFERENCES CUSTOMER(Customer_ID),
    CONSTRAINT FK_DONATION_INVOICE FOREIGN KEY (Donation_ID) REFERENCES DONATION(Donation_ID),
    CONSTRAINT FK_EMPLOYEE_INVOICE FOREIGN KEY (Employee_id) REFERENCES EMPLOYEE(Employee_id),
    CONSTRAINT FK_DELIVERY_INVOICE FOREIGN KEY (Delivery_id) REFERENCES DELIVERY(Delivery_id)
);

--INSERTS
--Customer
INSERT ALL 
          INTO CUSTOMER VALUES('11011','Jack','Smith','18 Water Rd','0877277521','jsmith@isat.com')
          INTO CUSTOMER VALUES('11012','Pat','Hendricks','22 Water Rd','0863257857','ph@mcom.co.za')
          INTO CUSTOMER VALUES('11013','Andre','Clark','101 Summer Lane','0834567891','aclark@mcom.co.za')
          INTO CUSTOMER VALUES('11014','Kevin','Jones','55 Mountain Way','0612547895','kj@isat.co.za')
          INTO CUSTOMER VALUES('11015','Lucy','Williams','5 Main Rd','0827238521','lw@mcal.co.za')       
SELECT*FROM DUAL;

--Employee
INSERT ALL 
    INTO EMPLOYEE VALUES('emp101','Jeff','Davis','0877277521','10 Main Road','jand@isat.com')
    INTO EMPLOYEE VALUES('emp102','Kevin','Marks','0837377522','18 Water Road','km@isat.com')
    INTO EMPLOYEE VALUES('emp103','Adanya','Andrews','0817117523','21 Circle Lane','aa@isat.com')
    INTO EMPLOYEE VALUES('emp104','Adebayo','Dryer','0797215244','1 Sea Road','aryer@isat.com')
    INTO EMPLOYEE VALUES('emp105','Xolani','Samson','0827122255','12 Main Road','xosam@isat.com')
SELECT * FROM DUAL;

--DONATOR
INSERT ALL 
          INTO DONATOR VALUES('20111','Jeff','Watson','0827172250','jwatson@ymail.com')
          INTO DONATOR VALUES('20112','Stephen','Jones','0837865670','jones@ymail.com')
          INTO DONATOR VALUES('20113','James','Joe','0878978650','jj@isat.com')
          INTO DONATOR VALUES('20114','Kelly','Ross','0826575650','kroos@gsat.com')
          INTO DONATOR VALUES('20115','Abraham','Clark','0797656430','aclark@gmail.com')
SELECT*FROM DUAL;

-- delivery 
INSERT ALL 
         INTO DELIVERY VALUES('511','Double packaging requested','10 May 2024','15 May 2024')
         INTO DELIVERY VALUES('512','Delivery to work address','12 May 2024','15 May 2024')
         INTO DELIVERY VALUES('513','Signature requested','12 May 2024','17 May 2024')
         INTO DELIVERY VALUES('514','No notes','12 May 2024','15 May 2024')
         INTO DELIVERY VALUES('515','Birthday Present wrapping required','18 May 2024','19 May 2024')
         INTO DELIVERY VALUES('516','Delivery to work address ','20 May 2024','25 May 2024')
SELECT*FROM DUAL;

--Donation 
INSERT ALL
           INTO DONATION VALUES('7111','20111','KIC Fridge','599','1 May 2024')
           INTO DONATION VALUES('7112','20112','Samsung 42inch LCD','1299','3 May 2024')
           INTO DONATION VALUES('7113','20113','Sharp microwave','1599','3 May 2024')
           INTO DONATION VALUES('7114','20115','6 Seat dining table','799','5 May 2024')
           INTO DONATION VALUES('7115','20113','Lazyboy sofa','1199','7 May 2024')
           INTO DONATION VALUES('7116','20113','JVC surround sound system','179','9 May 2024')
SELECT*FROM DUAL;

--Return
INSERT ALL 
         INTO RETURNS VALUES('ret001','25 May 2024','Customer not satisfied with product','11011','7116','emp101')
         INTO RETURNS VALUES('ret002','25 May 2024','Product had broken section','11013','7114','emp103')
SELECT*FROM DUAL;

--INVOICE
INSERT ALL 
          INTO INVOICE VALUES('8111','11011','15 May 2024','emp103','7111','511')
          INTO INVOICE VALUES('8112','11013','15 May 2024','emp101','7112','512')
          INTO INVOICE VALUES('8113','11012','17 May 2024','emp101','7113','513')
          INTO INVOICE VALUES('8114','11015','17 May 2024','emp102','7114','514')
          INTO INVOICE VALUES('8115','11011','17 May 2024','emp102','7115','515')
          INTO INVOICE VALUES('8116','11015','18 May 2024','emp103','7116','516')
SELECT* FROM DUAL;

--Question 2
SELECT 
    c.First_Name || ' ' || c.Surname AS customer_name,
    i.Employee_id,
    d.Delivery_notes,
    dn.Donation,
    i.Invoice_num
FROM CUSTOMER c
JOIN INVOICE i ON c.Customer_ID = i.Customer_ID
JOIN DELIVERY d ON i.Delivery_id = d.Delivery_id
JOIN DONATION dn ON i.Donation_ID = dn.Donation_ID
WHERE i.Invoice_Date < '18-MAY-2024';

--Question 3
CREATE SEQUENCE funding_id_seq START WITH 1 INCREMENT BY 1;


CREATE TABLE Funding (
    funding_id NUMBER,
    funder VARCHAR2(255),
    funding_amount NUMBER
);

--trigger to  generate new id.
CREATE OR REPLACE TRIGGER trg_generate_funding_id
BEFORE INSERT ON Funding
FOR EACH ROW
BEGIN
    SELECT funding_id_seq.NEXTVAL INTO :NEW.funding_id FROM dual;
END;
/


INSERT INTO Funding (funder, funding_amount) VALUES ('Example Funder', 1000);
INSERT INTO Funding (funder, funding_amount) VALUES ('Buhle Funder', 2000);
INSERT INTO Funding (funder, funding_amount) VALUES ('Rosebank college Funder', 3000);
SELECT * FROM Funding;

--Question 4
SET SERVEROUTPUT ON;

DECLARE
    v_Customer_Name CUSTOMER.First_Name%TYPE;
    v_Donation_Purchased DONATION.Donation%TYPE;
    v_Donation_Price DONATION.Price%TYPE;
    v_Return_Reason RETURNS.Reason%TYPE;
BEGIN
    FOR rec IN (SELECT c.First_Name || ' ' || c.Surname AS customer_name,
                       dn.Donation,
                       dn.Price,
                       r.Reason
                  FROM RETURNS r
                       JOIN CUSTOMER c ON r.Customer_ID = c.Customer_ID
                       JOIN DONATION dn ON r.Donation_ID = dn.Donation_ID)
    LOOP
        v_Customer_Name := rec.customer_name;
        v_Donation_Purchased := rec.Donation;
        v_Donation_Price := rec.Price;
        v_Return_Reason := rec.Reason;

        DBMS_OUTPUT.PUT_LINE('Customer Name: ' || v_Customer_Name);
        DBMS_OUTPUT.PUT_LINE('Donation Purchased: ' || v_Donation_Purchased);
        DBMS_OUTPUT.PUT_LINE('Donation Price: ' || v_Donation_Price);
        DBMS_OUTPUT.PUT_LINE('Return Reason: ' || v_Return_Reason);
        DBMS_OUTPUT.PUT_LINE('----------------------------------------');
    END LOOP;
END;


--Question 5
SET SERVEROUTPUT ON;
DECLARE
    v_Customer_Name CUSTOMER.First_Name%TYPE;
    v_Employee_Name EMPLOYEE.First_Name%TYPE;
    v_Donation DONATION.Donation%TYPE;
    v_Dispatch_Date DELIVERY.Dispatch_Date%TYPE;
    v_Delivery_Date DELIVERY.Delivery_Date%TYPE;
    v_Days_Between NUMBER;
BEGIN
    SELECT 
        c.First_Name || ' ' || c.Surname,
        e.First_Name || ' ' || e.Surname,
        dn.Donation,
        dv.Dispatch_Date,
        dv.Delivery_Date
    INTO 
        v_Customer_Name, v_Employee_Name, v_Donation, v_Dispatch_Date, v_Delivery_Date
    FROM 
        INVOICE i
    INNER JOIN 
        CUSTOMER c ON i.Customer_ID = c.Customer_ID
    INNER JOIN 
        EMPLOYEE e ON i.Employee_id = e.Employee_id
    INNER JOIN 
        DONATION dn ON i.Donation_ID = dn.Donation_ID
    INNER JOIN 
        DELIVERY dv ON i.Delivery_id = dv.Delivery_id
    WHERE 
        c.Customer_ID = '11013';

    v_Days_Between := NVL(TO_NUMBER(v_Delivery_Date - v_Dispatch_Date), 0);

    DBMS_OUTPUT.PUT_LINE('Customer Name: ' || v_Customer_Name);
    DBMS_OUTPUT.PUT_LINE('Employee Name: ' || v_Employee_Name);
    DBMS_OUTPUT.PUT_LINE('Donation: ' || v_Donation);
    DBMS_OUTPUT.PUT_LINE('Dispatch Date: ' || v_Dispatch_Date);
    DBMS_OUTPUT.PUT_LINE('Delivery Date: ' || v_Delivery_Date);
    DBMS_OUTPUT.PUT_LINE('Days Between Dispatch and Delivery: ' || v_Days_Between);
END;
/

--Question 6
SET SERVEROUTPUT ON;

SELECT 
    c.First_Name || ' ' || c.Surname AS customer_name,
    SUM(dn.Price) AS total_amount_spent,
    CASE 
        WHEN SUM(dn.Price) >= 1500 THEN 'Star'
        ELSE 'No Star'
    END AS customer_rating
FROM DONATION dn
SSS
JOIN CUSTOMER c ON i.Customer_ID = c.Customer_ID
GROUP BY c.First_Name, c.Surname;



