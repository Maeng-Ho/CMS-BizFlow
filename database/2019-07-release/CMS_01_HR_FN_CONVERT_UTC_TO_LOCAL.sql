create or replace FUNCTION FN_CONVERT_UTC_TO_LOCAL(
    I_DATE      IN  DATE,
    I_TIMEZONE  IN  VARCHAR2 DEFAULT 'America/New_York'
)
RETURN DATE
IS  
    V_DT            DATE;
    V_TZ_OFFSET     FLOAT(4);
BEGIN
    IF I_DATE IS NULL THEN
        RETURN NULL;
    END IF;

    V_TZ_OFFSET := FN_GET_TIMEZONE_OFFSET(I_TIMEZONE);
    RETURN I_DATE + V_TZ_OFFSET/24;

EXCEPTION WHEN OTHERS THEN
    RETURN NULL;
END;
/
GRANT EXECUTE ON HHS_CMS_HR.FN_CONVERT_UTC_TO_LOCAL TO BIZFLOW;
/

