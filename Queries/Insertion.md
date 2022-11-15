For populating the star schema, I used cursor and select insert query.

1) Cursor for populating Sample dimension:

'''sql
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
'''sql
