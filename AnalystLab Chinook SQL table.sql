-- Understanding tables: View top 5 for quick data preview
SELECT TOP 5 * FROM dbo.Album;

-- Understanding tables: View top 5 for quick data preview
SELECT TOP 5 * FROM dbo.Artist;

-- Understanding tables: View top 5 for quick data preview
SELECT TOP 5 * FROM dbo.Customer;

-- Understanding tables: View top 5 for quick data preview
SELECT TOP 5 * FROM dbo.Invoice;

-- Understanding tables: View top 5 for quick data preview
SELECT TOP 5 * FROM dbo.InvoiceLine;

-- Understanding tables: View top 5 for quick data preview
SELECT TOP 5 * FROM dbo.Track;

-- Understanding tables: View top 5 for quick data preview
SELECT TOP 5 * FROM dbo.Genre;

-- Understanding tables: View top 5 for quick data preview
SELECT TOP 5 * FROM dbo.Employee;

-- Join Album and Artist (Common: ArtistId)
SELECT TOP 5 A.Title, Ar.Name 
FROM dbo.Album AS A INNER JOIN dbo.Artist AS Ar ON A.ArtistId = Ar.ArtistId;
SELECT TOP 5 A.Title, Ar.Name 
FROM dbo.Album AS A LEFT JOIN dbo.Artist AS Ar ON A.ArtistId = Ar.ArtistId;
SELECT TOP 5 A.Title, Ar.Name 
FROM dbo.Album AS A RIGHT JOIN dbo.Artist AS Ar ON A.ArtistId = Ar.ArtistId;

-- Join Album and Track (Common: AlbumId)
SELECT TOP 5 A.Title, T.Name 
FROM dbo.Album AS A INNER JOIN dbo.Track AS T ON A.AlbumId = T.AlbumId;
SELECT TOP 5 A.Title, T.Name 
FROM dbo.Album AS A LEFT JOIN dbo.Track AS T ON A.AlbumId = T.AlbumId;
SELECT TOP 5 A.Title, T.Name 
FROM dbo.Album AS A RIGHT JOIN dbo.Track AS T ON A.AlbumId = T.AlbumId;

-- Join Track and Genre (Common: GenreId)
SELECT TOP 5 T.Name, G.Name 
FROM dbo.Track AS T INNER JOIN dbo.Genre AS G ON T.GenreId = G.GenreId;
SELECT TOP 5 T.Name, G.Name 
FROM dbo.Track AS T LEFT JOIN dbo.Genre AS G ON T.GenreId = G.GenreId;
SELECT TOP 5 T.Name, G.Name 
FROM dbo.Track AS T RIGHT JOIN dbo.Genre AS G ON T.GenreId = G.GenreId;

-- Join Invoice and InvoiceLine (Common: InvoiceId)
SELECT TOP 5 I.InvoiceId, IL.UnitPrice 
FROM dbo.Invoice AS I INNER JOIN dbo.InvoiceLine AS IL ON I.InvoiceId = IL.InvoiceId;
SELECT TOP 5 I.InvoiceId, IL.UnitPrice 
FROM dbo.Invoice AS I LEFT JOIN dbo.InvoiceLine AS IL ON I.InvoiceId = IL.InvoiceId;
SELECT TOP 5 I.InvoiceId, IL.UnitPrice 
FROM dbo.Invoice AS I RIGHT JOIN dbo.InvoiceLine AS IL ON I.InvoiceId = IL.InvoiceId;

-- Join InvoiceLine and Track (Common: TrackId)
SELECT TOP 5 IL.InvoiceLineId, T.Name 
FROM dbo.InvoiceLine AS IL INNER JOIN dbo.Track AS T ON IL.TrackId = T.TrackId;
SELECT TOP 5 IL.InvoiceLineId, T.Name 
FROM dbo.InvoiceLine AS IL LEFT JOIN dbo.Track AS T ON IL.TrackId = T.TrackId;
SELECT TOP 5 IL.InvoiceLineId, T.Name 
FROM dbo.InvoiceLine AS IL RIGHT JOIN dbo.Track AS T ON IL.TrackId = T.TrackId;

-- Join Playlist and PlaylistTrack (Common: PlaylistId)
SELECT TOP 5 P.Name, PT.TrackId 
FROM dbo.Playlist AS P INNER JOIN dbo.PlaylistTrack AS PT ON P.PlaylistId = PT.PlaylistId;
SELECT TOP 5 P.Name, PT.TrackId 
FROM dbo.Playlist AS P LEFT JOIN dbo.PlaylistTrack AS PT ON P.PlaylistId = PT.PlaylistId;
SELECT TOP 5 P.Name, PT.TrackId 
FROM dbo.Playlist AS P RIGHT JOIN dbo.PlaylistTrack AS PT ON P.PlaylistId = PT.PlaylistId;

-- Join PlaylistTrack and Track (Common: TrackId)
SELECT TOP 5 PT.PlaylistId, T.Name 
FROM dbo.PlaylistTrack AS PT INNER JOIN dbo.Track AS T ON PT.TrackId = T.TrackId;
SELECT TOP 5 PT.PlaylistId, T.Name 
FROM dbo.PlaylistTrack AS PT LEFT JOIN dbo.Track AS T ON PT.TrackId = T.TrackId;
SELECT TOP 5 PT.PlaylistId, T.Name 
FROM dbo.PlaylistTrack AS PT RIGHT JOIN dbo.Track AS T ON PT.TrackId = T.TrackId;

-- Join Customer and Employee (Common: SupportRepId)
SELECT TOP 5 C.FirstName, E.FirstName AS SupportRep 
FROM dbo.Customer AS C INNER JOIN dbo.Employee AS E ON C.SupportRepId = E.EmployeeId;
SELECT TOP 5 C.FirstName, E.FirstName AS SupportRep 
FROM dbo.Customer AS C LEFT JOIN dbo.Employee AS E ON C.SupportRepId = E.EmployeeId;
SELECT TOP 5 C.FirstName, E.FirstName AS SupportRep 
FROM dbo.Customer AS C RIGHT JOIN dbo.Employee AS E ON C.SupportRepId = E.EmployeeId;

-- Aggregate: SUM calculates the total sum of a numeric column
SELECT SUM(Total) AS TotalRevenue FROM dbo.Invoice;

-- Aggregate: COUNT calculates the total number of records
SELECT COUNT(InvoiceId) AS TotalInvoiceCount FROM dbo.Invoice;

-- Aggregate: AVG calculates the mathematical average of a column
SELECT AVG(Total) AS AverageInvoiceValue FROM dbo.Invoice;

-- Filter: WHERE restricts individual rows based on a specific condition
SELECT * FROM dbo.Invoice WHERE BillingCountry = 'USA';

-- Filter: GROUP BY organizes data into logical summary rows (buckets)
SELECT BillingCountry, SUM(Total) AS RevenuePerCountry
FROM dbo.Invoice
GROUP BY BillingCountry;

-- Filter: HAVING acts like a WHERE, but for groups after they are calculated
SELECT BillingCountry, SUM(Total) AS RevenuePerCountry
FROM dbo.Invoice
GROUP BY BillingCountry
HAVING SUM(Total) > 100;

-- Filter: ORDER BY sorts the final output in ascending or descending order
SELECT BillingCountry, SUM(Total) AS RevenuePerCountry
FROM dbo.Invoice
GROUP BY BillingCountry
ORDER BY RevenuePerCountry DESC;

-- RANK: Assigns a rank to invoices based on their total value within each country
SELECT 
    BillingCountry, 
    Total,
    RANK() OVER (PARTITION BY BillingCountry ORDER BY Total DESC) AS InvoiceRank
FROM dbo.Invoice;

-- PARTITION BY: Calculates the average invoice value per country without collapsing rows
SELECT 
    BillingCountry, 
    Total,
    AVG(Total) OVER (PARTITION BY BillingCountry) AS AvgInvoiceValuePerCountry
FROM dbo.Invoice;

-- ROW_NUMBER: Gives each row a unique sequential number within its country partition
SELECT 
    BillingCountry, 
    InvoiceDate,
    ROW_NUMBER() OVER (PARTITION BY BillingCountry ORDER BY InvoiceDate) AS InvoiceSequence
FROM dbo.Invoice;

--Top-Performing Customers
-- Join Customer and Invoice to calculate total spend per customer
SELECT TOP 10 C.FirstName, C.LastName, SUM(I.Total) AS TotalSpent
FROM dbo.Customer AS C
JOIN dbo.Invoice AS I ON C.CustomerId = I.CustomerId
GROUP BY C.FirstName, C.LastName
ORDER BY TotalSpent DESC;

--Top-Performing Products
-- Join Track and InvoiceLine to find the most popular tracks
SELECT TOP 10 T.Name AS TrackName, COUNT(IL.TrackId) AS TimesSold
FROM dbo.Track AS T
JOIN dbo.InvoiceLine AS IL ON T.TrackId = IL.TrackId
GROUP BY T.Name
ORDER BY TimesSold DESC;

-- Revenue Trends Over Time
-- Extract the year from InvoiceDate to see yearly revenue trends
SELECT YEAR(InvoiceDate) AS SaleYear, SUM(Total) AS YearlyRevenue
FROM dbo.Invoice
GROUP BY YEAR(InvoiceDate)
ORDER BY SaleYear;

-- Customer Purchasing Behavior
-- Count number of invoices per customer to gauge loyalty/activity
SELECT C.FirstName, C.LastName, COUNT(I.InvoiceId) AS TotalOrders
FROM dbo.Customer AS C
JOIN dbo.Invoice AS I ON C.CustomerId = I.CustomerId
GROUP BY C.FirstName, C.LastName
ORDER BY TotalOrders DESC;