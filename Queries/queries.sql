---1) The list of water sensors measured by type of it by month:

SELECT D.DETERMINAND_ID, D.DETERMINAND_LABEL, 
D.DETERMINAND_DEFINITION, D.DETERMINAND_UNIT_LABEL, 
F.SAMPLE_MATERIAL_TYPE, T.SAMPLE_MONTH, T.SAMPLE_DATE
FROM DETERMINAND D, FACT_MEASUREMENT F, TIME_DIM T
WHERE D.DETERMINAND_ID = F.DETERMINAND_ID AND F.TIME_ID =T.TIME_ID
ORDER BY SAMPLE_DATE;


---2)  The number of sensor measurements collected by type of sensor by week :

SELECT D.DETERMINAND_LABEL,COUNT(F.RESULT) AS "NUMBER OF 
MEASUREMENT", T.SAMPLE_WEEK, T.SAMPLE_YEAR
FROM FACT_MEASUREMENT F, DETERMINAND D, TIME_DIM T
WHERE D.DETERMINAND_ID = F.DETERMINAND_ID AND F.TIME_ID = 
T.TIME_ID
GROUP BY DETERMINAND_LABEL,SAMPLE_WEEK,SAMPLE_YEAR ;


---3) The number of measurements made by location by month

SELECT S.SAMPLING_POINT_LABEL,COUNT(F.RESULT) as "Number of 
Measurement" , T.SAMPLE_MONTH,T.SAMPLE_YEAR 
FROM FACT_MEASUREMENT F, SAMPLE S, TIME_DIM T 
WHERE S.SAMPLE_ID = F.SAMPLE_ID AND F.TIME_ID = T.TIME_ID 
GROUP BY T.SAMPLE_MONTH,T.SAMPLE_YEAR,S.SAMPLING_POINT_LABEL
ORDER BY T.SAMPLE_YEAR;


---4) The average value of Nitrate measurements by locations by year

SELECT cast(AVG(F.RESULT) as decimal(8,4)) AS "AVERAGE MEASUREMENT", 
D.DETERMINAND_LABEL,T.SAMPLE_YEAR
FROM DETERMINAND D, FACT_MEASUREMENT F, TIME_DIM T
WHERE D.DETERMINAND_ID = F.DETERMINAND_ID AND F.TIME_ID = 
T.TIME_ID and DETERMINAND_LABEL = 'Nitrate-N'
GROUP BY T.SAMPLE_YEAR, D.DETERMINAND_LABEL
ORDER BY T.SAMPLE_YEAR;

