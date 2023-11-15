$data_dir = (Resolve-Path $PSScriptRoot) -replace 'callback_scripts', '30_data'
$defaults_dir = (Resolve-Path $PSScriptRoot) -replace 'src\\callback_scripts', 'conf'
$cicd_dir = (Resolve-Path $PSScriptRoot) -replace 'src\\callback_scripts', ''
$data_dictionary = (Get-Content "$data_dir/data_dictionary.json") | ConvertFrom-Json
$defaults = (Get-Content "$defaults_dir/defaults.json") | ConvertFrom-Json
$cicd = (Get-Content "$cicd_dir/cicd.json") | ConvertFrom-Json

$ServerInstance = "localhost,$($defaults.$($cicd.Build.BuildType).DockerHostPort)"
$Database = $cicd.Build.MigrateDatabase.DatabaseName
$UserName = $defaults.$($cicd.Build.BuildType).DatabaseUser
$Password = $defaults.$($cicd.Build.BuildType).DatabasePassword

$yes_no_map = @{
    yes = 1
    no  = 0
}

$pii_type_map = @{
    'direct-pii'   = 1
    'indirect-pii' = 2
    'no-pii'       = 3
}

$business_justification_map = @{
    'product-other'     = 1
    'product-support'   = 2
    'product-important' = 3
    'product-critical'  = 4    
    'product-required'  = 5
}

$table_insert = @"
CREATE TABLE #table_configuration (
    sch_nm                      SYSNAME       NOT NULL
   ,tbl_nm                      SYSNAME       NOT NULL
   ,transactional_indicator     BIT           NOT NULL
   ,partitioned_indicator       BIT           NOT NULL
   ,drp_type_desc               VARCHAR(20)   NOT NULL
   ,business_justification_id   TINYINT       NOT NULL
   ,PRIMARY KEY (sch_nm, tbl_nm)
);

INSERT INTO #table_configuration(
    sch_nm
   ,tbl_nm
   ,transactional_indicator
   ,partitioned_indicator
   ,drp_type_desc 
   ,business_justification_id
) VALUES 
@table_insert_rows;

MERGE dof.table_configuration AS tgt
USING (SELECT   tc.sch_nm
               ,tc.tbl_nm
               ,tc.transactional_indicator
               ,tc.partitioned_indicator
               ,tc.drp_type_desc 
               ,tc.business_justification_id
       FROM     #table_configuration AS tc) AS src
ON  src.sch_nm = tgt.sch_nm
    AND src.tbl_nm = tgt.tbl_nm
WHEN NOT MATCHED THEN INSERT (
    sch_nm
   ,tbl_nm
   ,transactional_indicator
   ,partitioned_indicator
   ,drp_type_desc 
   ,business_justification_id
) VALUES (
    src.sch_nm
   ,src.tbl_nm
   ,src.transactional_indicator
   ,src.partitioned_indicator
   ,src.drp_type_desc 
   ,src.business_justification_id
) 
WHEN MATCHED AND    (tgt.transactional_indicator    <> src.transactional_indicator
                  OR tgt.partitioned_indicator      <> src.partitioned_indicator
                  OR tgt.drp_type_desc              <> src.drp_type_desc 
                  OR tgt.business_justification_id  <> src.business_justification_id)
THEN UPDATE SET      tgt.transactional_indicator    = src.transactional_indicator
                    ,tgt.partitioned_indicator      = src.partitioned_indicator
                    ,tgt.drp_type_desc              = src.drp_type_desc 
                    ,tgt.business_justification_id  = src.business_justification_id
                    ,tgt.modified_utc_when          = SYSUTCDATETIME()
WHEN NOT MATCHED BY SOURCE THEN DELETE;

GO

"@

$column_insert = @"
CREATE TABLE #column_configuration (
    sch_nm               SYSNAME NOT NULL
   ,tbl_nm               SYSNAME NOT NULL
   ,col_nm               SYSNAME NOT NULL
   ,pii_type_id          TINYINT NOT NULL
   ,PRIMARY KEY (sch_nm, tbl_nm, col_nm)
);
@column_insert_rows;
      
MERGE dof.column_configuration AS tgt
USING (SELECT   tc.sch_nm
               ,tc.tbl_nm
               ,tc.col_nm
               ,tc.pii_type_id
       FROM     #column_configuration AS tc) AS src
ON  src.sch_nm = tgt.sch_nm
    AND src.tbl_nm = tgt.tbl_nm
    AND src.col_nm = tgt.col_nm
WHEN NOT MATCHED THEN INSERT (
    sch_nm                        
   ,tbl_nm                        
   ,col_nm                        
   ,pii_type_id          
) VALUES (
    src.sch_nm                        
   ,src.tbl_nm                        
   ,src.col_nm                        
   ,src.pii_type_id          
) 
WHEN MATCHED AND    (tgt.pii_type_id        <> src.pii_type_id)
THEN UPDATE SET      tgt.pii_type_id        = src.pii_type_id
                    ,tgt.modified_utc_when  = SYSUTCDATETIME()
WHEN NOT MATCHED BY SOURCE THEN DELETE;

GO

"@

$table_insert_rows = ''
$column_insert_rows = ''
$table_row_index = 0
$column_row_index = 0
foreach ($obj in $data_dictionary.'db-objects') {   
    $sch_name = $obj.'object-name'.Substring(0,($obj.'object-name'.IndexOf('.')))
    $tbl_name = $obj.'object-name'.Substring(($obj.'object-name'.IndexOf('.') + 1), ($obj.'object-name'.Length - ($obj.'object-name'.IndexOf('.') + 1)))
    $drp_type_id = $obj.'drp-type-id'
    $transactional_indicator = $yes_no_map[$obj.transactional]
    $business_justification = $business_justification_map[$obj.'business-justification']
    $parititioned_indicator = $yes_no_map[$obj.partitioned]
    $table_comma = ','
    if (($table_row_index % 1000) -eq 0) {
        $table_comma = ''
        $table_insert_rows += "
INSERT INTO #table_configuration (
    sch_nm
   ,tbl_nm
   ,transactional_indicator
   ,partitioned_indicator
   ,drp_type_desc 
   ,business_justification_id
) VALUES"
    }
    
    $table_row_index += 1
    $table_insert_rows += "
$table_comma (
    '$sch_name'
   ,'$tbl_name'
   ,$transactional_indicator
   ,$parititioned_indicator
   ,'$drp_type_id'
   ,$business_justification
)"
    
    foreach ($col in $obj.properties) {
        $col_name = $col.'property-name'
        $pii_type = $pii_type_map[$col.'pii-type']
        $column_comma = ','
        if (($column_row_index % 1000) -eq 0) {
            $column_comma = ''
            $column_insert_rows += "
INSERT INTO #column_configuration (
    sch_nm                        
   ,tbl_nm                        
   ,col_nm                                     
   ,pii_type_id             
) VALUES"
        }
        
        $column_row_index += 1
        $column_insert_rows += "
$column_comma(
    '$sch_name'
   ,'$tbl_name'
   ,'$col_name'
   ,$pii_type
)"
    }
}

$table_insert = $table_insert -replace '@table_insert_rows', $table_insert_rows
$column_insert = $column_insert -replace '@column_insert_rows', $column_insert_rows

$Query = $table_insert + $column_insert

$Query

$invoke_sqlcmd_params = @{
    ServerInstance = $ServerInstance
    Database = $Database
    Username = $Username
    Password = $Password
    Query = $Query
}

#Invoke-Sqlcmd @invoke_sqlcmd_params

