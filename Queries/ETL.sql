<!--ETL Process:-->

To get the data together from all the dataset of years 2000 to 2016, the data is merged into single 
master dataset and named as water_quality. For merging the data select and union query is used.

INSERT INTO WATER_QUALITY
SELECT * FROM "2000"
UNION ALL
