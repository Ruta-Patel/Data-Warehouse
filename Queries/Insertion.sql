---For populating the star schema,cursor and select insert query is used.

---1) Cursor for populating Sample dimension:


declare
CURSOR s_sample is
SELECT
"@id","samplesamplingPoint","samplesamplingPointnotation","samplesamplingPointlabel","
samplesampledMaterialTypelabel",SAMPLE_COMPLIANCE,"samplepurposelabel","sample
samplingPointeasting","samplesamplingPointnorthing"
from water_quality;
begin
for s_sam in s_sample loop
insert into 
SAMPLE(SAMPLE_ID,SAMPLE_SAMPLING_POINT,SAMPLE_SAMPLING_POINT_N
OTATION,SAMPLING_POINT_LABEL,SAMPLE_MATERIAL_TYPE_LABEL,SAMPLE
_COMPLIANCE,SAMPLE_PURPOSE_LABEL,SAMPLING_POINT_EASTING,SAMPLI
NG_POINT_NORTHING)
VALUES 
(s_sam."@id",s_sam."samplesamplingPoint",s_sam."samplesamplingPointnotation",s_sam."s
amplesamplingPointlabel",s_sam."samplesampledMaterialTypelabel",s_sam.SAMPLE_COM
PLIANCE,s_sam."samplepurposelabel",s_sam."samplesamplingPointeasting",s_sam."sample
samplingPointnorthing");
end loop;
end;
SELECT * from SAMPLE;

---2) Cursor for populating fact table:

declare
CURSOR F_sample is
SELECT "@id", ID, SAMPLE_ID,TIME_ID, 
DETERMINAND_NOTATION,DETERMINAND_ID, 
"samplesampledMaterialTypelabel",RESULT,"samplepurposelabel"
from water_quality W, SAMPLE S,TIME_DIM T,DETERMINAND D
WHERE W."@id" = S.SAMPLE_ID AND W."ID" = T.TIME_ID AND 
W.DETERMINAND_NOTATION = D.DETERMINAND_ID;
begin
for F_sam in F_sample loop
insert into 
FACT_MEASUREMENT(SAMPLE_ID,TIME_ID,DETERMINAND_ID,SAMPLE_MATE
RIAL_TYPE,RESULT,SAMPLE_PURPOSE)
VALUES 
(F_sam."@id",F_sam.TIME_ID,F_sam.DETERMINAND_NOTATION,F_sam."samplesamp
ledMaterialTypelabel",F_sam.RESULT,F_sam."samplepurposelabel");
end loop;
end;

---3) Cursor for populating time dimension:

declare
CURSOR T_sample is
SELECT
SAMPLE_DATE,SAMPLE_TIME,SAMPLE_WEEK
from water_quality;
begin
for T_sam in T_sample loop
insert into TIME_DIM(SAMPLE_DATE,SAMPLE_TIME,SAMPLE_WEEK)
VALUES (T_sam.SAMPLE_DATE,T_sam.SAMPLE_TIME,T_sam.SAMPLE_WEEK);
end loop;
end;


---4) Insert-Select query for populating determinand dimension:

INSERT INTO DETERMINAND 
(DETERMINAND_ID,DETERMINAND_LABEL,DETERMINAND_DEFINITION,DETER
MINAND_UNIT_LABEL) 
SELECT DISTINCT 
DETERMINAND_NOTATION,"determinandlabel","determinanddefinition","determinandun
itlabel" FROM WATER_QUALITY;



