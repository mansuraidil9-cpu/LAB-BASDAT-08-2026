SET search_path TO classicmodels, public;
-- Soal 1
SELECT customerNumber AS "identifikasi pelanggan",
	SUM(amount) AS "total akumulasi",
	COUNT(checkNumber) AS "frekuensi transaksi",
	MAX(amount) AS "storan tunai terbesar"
	FROM payments
	GROUP BY customerNumber
	HAVING COUNT (checkNumber) > 4 AND AVG (amount) > 20000;

-- Soal 2
SELECT  customerNumber,
	SUM(amount) AS "total dana"
	FROM payments
	GROUP BY customerNumber
	HAVING SUM (amount) > 80000 
	ORDER BY "total dana" DESC;

-- Soal 3
SELECT productLine,
	COUNT(productCode) AS "jumlah ragam produk",
	ROUND(AVG(MSRP),2) AS "harga jual ritel",
	STRING_AGG (productName, ', ' ORDER BY productName) AS "daftar nama produk"
	FROM products
	GROUP BY productLine
	HAVING COUNT (productCode) > 10;

--Soal 4
SELECT DISTINCT reportsTo AS "no identifikasi"
FROM employees 
WHERE reportsto IS NOT NULL
	EXCEPT
SELECT employeenumber
FROM employees 
WHERE jobtitle ILIKE '%vp%' OR jobtitle ILIKE '%president%';


--Soal 5
SELECT productcode,
	SUM (quantityordered) AS "unit terjual",
	ROUND(AVG(priceeach), 2) AS "rata-rata harga"
	FROM orderdetails
WHERE (priceeach) > 100
GROUP BY productcode
HAVING SUM (quantityordered) > 50
ORDER BY "unit terjual" DESC;

--Soal 6
SELECT productCode AS "kode identifikasi barang",
	SUM (quantityordered) AS "total unit terjual",
	SUM (quantityordered * priceeach) AS "estimasi pendapatan kantor",
	ROUND(AVG(priceeach), 2) AS "rata-rata harga rill",
	(MAX(priceeach) - MIN(priceeach)) AS "rentang volatilitas harga jual"
	FROM orderdetails
	WHERE quantityordered > 20
GROUP BY productCode 
HAVING SUM(quantityordered * priceeach) > 50000
ORDER BY "estimasi pendapatan kantor" DESC;

--Soal 7
SELECT customerNumber
FROM customers
WHERE creditLimit > 80000
	INTERSECT
SELECT customerNumber
FROM orders
WHERE status IN ('Cancelled', 'On Hold')
	EXCEPT
SELECT customerNumber
	FROM payments
GROUP BY customerNumber
HAVING SUM (amount) > 100000;
	

	
	