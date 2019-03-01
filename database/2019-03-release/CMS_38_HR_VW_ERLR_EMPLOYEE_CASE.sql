CREATE OR REPLACE VIEW VW_ERLR_EMPLOYEE_CASE
AS SELECT G.ERLR_CASE_NUMBER AS CASE_NUMBER, 
    G.GEN_EMPLOYEE_ID AS HHSID, 
    'F' AS DELETABLE, 
    G.ERLR_CASE_NUMBER ||'-'|| D.TBL_LABEL||'-'||L.LAST_NAME AS DISPLAY
FROM ERLR_GEN G 
     JOIN HHS_HR.EMPLOYEE_LOOKUP L ON L.HHSID = G.GEN_EMPLOYEE_ID
     JOIN TBL_LOOKUP D ON D.TBL_ID = G.GEN_CASE_TYPE
WHERE G.GEN_CASE_STATUS IS NULL OR G.GEN_CASE_STATUS <> 'Completed';

-- Update Form Data and Process Variable
UPDATE HHS_CMS_HR.TBL_FORM_DTL
   SET FIELD_DATA = UPDATEXML(FIELD_DATA,'/formData/items/item[id="GEN_CASE_STATUS"]/value/text()', 'Completed')
 WHERE FORM_TYPE = 'CMSERLR'
   AND PROCID IN (SELECT PROCID FROM BIZFLOW.RLVNTDATA WHERE RLVNTDATANAME ='caseStatus' AND VALUE = 'closeNow');
   
UPDATE BIZFLOW.RLVNTDATA
   SET VALUE = 'Completed'
 WHERE RLVNTDATANAME ='caseStatus'
   AND VALUE = 'closeNow';

UPDATE HHS_CMS_HR.ERLR_GEN
   SET GEN_CASE_STATUS = 'Completed'
 WHERE GEN_CASE_STATUS = 'closeNow';

COMMIT;
