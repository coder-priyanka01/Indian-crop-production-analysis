Create database crop_analytics;
Use crop_analytics;

-- top 5 crops
SELECT 'Rice' AS crop, SUM(`RICE PRODUCTION (1000 tons)`) AS total_prod FROM cropdata
UNION
SELECT 'Wheat', SUM(`WHEAT PRODUCTION (1000 tons)`) FROM cropdata
UNION
SELECT 'Maize', SUM(`MAIZE PRODUCTION (1000 tons)`) FROM cropdata
ORDER BY total_prod DESC
LIMIT 5;

-- state wise rice production 
SELECT `year`, SUM(`RICE PRODUCTION (1000 tons)`) AS rice_prod
FROM cropdata
GROUP BY `year`
ORDER BY  `year`;

SELECT * FROM cropdata;
DESCRIBE cropdata;

-- check null values
SELECT 
    SUM(CASE WHEN `RICE PRODUCTION (1000 tons)` IS NULL THEN 1 ELSE 0 END) AS rice_nulls,
    SUM(CASE WHEN `WHEAT PRODUCTION (1000 tons)` IS NULL THEN 1 ELSE 0 END) AS wheat_nulls
FROM cropdata;


-- year and state wise wheat production
SELECT 'state name', 'year', 
       SUM(`WHEAT PRODUCTION (1000 tons)`) AS wheat_total
FROM cropdata
GROUP BY 'state name',' year'
ORDER BY 'year', wheat_total DESC;

-- top 5 maize product
SELECT 'state name', 
       SUM(`MAIZE PRODUCTION (1000 tons)`) AS maize_total
FROM cropdata
GROUP BY 'state name'
ORDER BY maize_total DESC
LIMIT 5;

-- crop area vs prod
SELECT 'state name', 'year',
       SUM(`RICE AREA (1000 ha)`) AS rice_area,
       SUM(`RICE PRODUCTION (1000 tons)`) AS rice_prod,
       (SUM(`RICE PRODUCTION (1000 tons)`) / SUM(`RICE AREA (1000 ha)`)) AS yield
FROM cropdata
GROUP BY 'state name', 'year'
ORDER BY 'year';

-- highest yield state per year
SELECT 'year', 'state name',
       (SUM(`WHEAT PRODUCTION (1000 tons)`) / SUM(`WHEAT AREA (1000 ha)`)) AS yield
FROM cropdata
GROUP BY 'year', 'state name'
ORDER BY' year', yield DESC;

-- reuse
CREATE VIEW state_crop_summary AS
SELECT 'state name', 'year',
       SUM(`RICE PRODUCTION (1000 tons)`) AS rice,
       SUM(`WHEAT PRODUCTION (1000 tons)`) AS wheat,
       SUM(`MAIZE PRODUCTION (1000 tons)`) AS maize
FROM cropdata
GROUP BY 'state name', 'year';

SELECT * FROM state_crop_summary WHERE year = 2010;

-- year of crop data
SELECT DISTINCT `Year`
FROM cropdata
ORDER BY `Year`;



