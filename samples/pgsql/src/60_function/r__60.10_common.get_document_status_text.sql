CREATE OR REPLACE FUNCTION common.get_document_status_text (
    IN v_status SMALLINT
   )
RETURNS VARCHAR(16) AS
$$
DECLARE
    v_ret VARCHAR(16);
BEGIN
    v_ret := CASE v_status
        WHEN 1 THEN 'Pending approval'
        WHEN 2 THEN 'Approved'
        WHEN 3 THEN 'Obsolete'
        ELSE '** Invalid **'
    END;

    RETURN v_ret;
END;
$$ LANGUAGE plpgsql
    IMMUTABLE;

COMMENT ON FUNCTION common.get_document_status_text(SMALLINT) IS 'Scalar function returning the text representation of the status column in the document table.';
