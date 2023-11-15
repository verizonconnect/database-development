-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 


DECLARE @source TABLE(
        subject_data_type_id                SMALLINT      NOT NULL
       ,subject_data_type_desc              VARCHAR(100)  NOT NULL
       ,subject_data_type_translation_key   VARCHAR(100)  NOT NULL
);

INSERT INTO @source (
    [subject_data_type_id]
   ,[subject_data_type_desc]
   ,[subject_data_type_translation_key]) 
VALUES (1, 'GeoLocation zipcode/POSTCODE', 'S_PRIVACY_SUBJECT_DATATYPE_GEOLOCATION_ZIPCODE_POSTCODE')
      ,(2, 'GeoLocation Address', 'S_PRIVACY_SUBJECT_DATATYPE_GEOLOCATION_ADDRESS')
      ,(3, 'DOT Number', 'S_PRIVACY_SUBJECT_DATATYPE_DOT_NUMBER')
      ,(4, 'Carrier Name', 'S_PRIVACY_SUBJECT_DATATYPE_CARRIER_NAME')
      ,(5, 'Email Address', 'S_PRIVACY_SUBJECT_DATATYPE_EMAIL_ADDRESS')
      ,(6, 'IP Address', 'S_PRIVACY_SUBJECT_DATATYPE_IP_ADDRESS')
      ,(7, 'Phone Number', 'S_PRIVACY_SUBJECT_DATATYPE_PHONE_NUMBER')
      ,(8, 'Fax Number', 'S_PRIVACY_SUBJECT_DATATYPE_FAX_NUMBER')
      ,(9, 'Security Password', 'S_PRIVACY_SUBJECT_DATATYPE_SECURITY_PASSWORD')
      ,(10, 'Security Answer', 'S_PRIVACY_SUBJECT_DATATYPE_SECURITY_ANSWER')
      ,(11, 'Security Question', 'S_PRIVACY_SUBJECT_DATATYPE_SECURITY_QUESTION')
      ,(12, 'Security PIN', 'S_PRIVACY_SUBJECT_DATATYPE_SECURITY_PIN')
      ,(13, 'GeoLocation GPS', 'S_PRIVACY_SUBJECT_DATATYPE_GEOLOCATION_GPS')
      ,(14, 'GeoLocation Direction', 'S_PRIVACY_SUBJECT_DATATYPE_GEOLOCATION_DIRECTION')
      ,(15, 'Name', 'S_PRIVACY_SUBJECT_DATATYPE_NAME')
      ,(16, 'Name - Initial', 'S_PRIVACY_SUBJECT_DATATYPE_NAME_INITIAL')
      ,(17, 'Driver License Number', 'S_PRIVACY_SUBJECT_DATATYPE_LICENSE_NUMBER')
      ,(18, 'Driver Tachograph Card', 'S_PRIVACY_SUBJECT_DATATYPE_DRIVER_TACHOGRAPH_CARD')
      ,(19, 'Social Security Number', 'S_PRIVACY_SUBJECT_DATATYPE_DRIVER_SOCIAL_SECURITY_NUMBER')
      ,(20, 'Signature', 'S_PRIVACY_SUBJECT_DATATYPE_SIGNATURE')
      ,(21, 'Vehicle Serial Number', 'S_PRIVACY_SUBJECT_VEHICLE_SERIAL_NUMBER')
      ,(22, 'Vehicle VIN', 'S_PRIVACY_SUBJECT_VEHICLE_VIN')
      ,(23, 'Vehicle Registration Number', 'S_PRIVACY_SUBJECT_VEHICLE_REGISTRATION_NUMBER')
      ,(24, 'Asset Serial Number', 'S_PRIVACY_SUBJECT_ASSET_SERIAL_NUMBER')
      ,(25, 'Asset Registration Number', 'S_PRIVACY_SUBJECT_ASSET_REGISTRATION_NUMBER')
      ,(26, 'Place Name', 'S_PLACES_TABLE_HEADER_PLACE_NAME')
      ,(27, 'First Name', 'S_PRIVACY_SUBJECT_DATATYPE_NAME_FIRST')
      ,(28, 'Last Name', 'S_PRIVACY_SUBJECT_DATATYPE_NAME_LAST');

MERGE INTO [privacy_framework].[subject_data_type] AS tgt
USING @source AS s ON s.[subject_data_type_id] = tgt.[subject_data_type_id]
WHEN MATCHED THEN UPDATE SET tgt.[subject_data_type_desc] = s.[subject_data_type_desc],
                             tgt.[subject_data_type_translation_key] = s.[subject_data_type_translation_key]
WHEN NOT MATCHED THEN INSERT ([subject_data_type_id]
                             ,[subject_data_type_desc]
                             ,[subject_data_type_translation_key])
                      VALUES (s.[subject_data_type_id]
                             ,s.[subject_data_type_desc]
                             ,s.[subject_data_type_translation_key])
WHEN NOT MATCHED BY SOURCE THEN DELETE;
