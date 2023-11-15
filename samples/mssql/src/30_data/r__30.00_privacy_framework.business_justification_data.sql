-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE TABLE #business_justification (
        business_justification_id   TINYINT      NOT NULL 
       ,business_justification_desc VARCHAR(50)  NOT NULL
   ,PRIMARY KEY (business_justification_id)
);

INSERT INTO #business_justification (
    business_justification_id
   ,business_justification_desc
)
VALUES (1, 'Product Other')
      ,(2, 'Product Support')
      ,(3, 'Product Important')
      ,(4, 'Product Critical')
      ,(5, 'Product Not Required');

MERGE privacy_framework.business_justification AS tgt
USING (SELECT   tc.business_justification_id
               ,tc.business_justification_desc
       FROM     #business_justification AS tc) AS src
ON  src.business_justification_id = tgt.business_justification_id
WHEN NOT MATCHED THEN INSERT (
    business_justification_id
   ,business_justification_desc
) VALUES (
    src.business_justification_id
   ,src.business_justification_desc
) 
WHEN MATCHED AND tgt.business_justification_desc <> src.business_justification_desc
THEN UPDATE  SET tgt.business_justification_desc =  src.business_justification_desc
WHEN NOT MATCHED BY SOURCE THEN DELETE;

GO