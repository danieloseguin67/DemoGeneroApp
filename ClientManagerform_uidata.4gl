{<CODEFILE Path="ClientManagerform.code" Hash="BWOLY2WEhEuyDLGUELPTTA==" />}
#+ User Interface - Data Management

--------------------------------------------------------------------------------
--This code is generated with the template dbapp5.0
--Warning: Enter your changes within a <BLOCK> or <POINT> section, otherwise they will be lost.
{<POINT Name="user.comments">} {</POINT>}

--------------------------------------------------------------------------------
--Importing modules
IMPORT FGL libdbappCore
IMPORT FGL libdbappSql
IMPORT FGL libdbappEvents

IMPORT FGL consultcompanion_dbxdata
IMPORT FGL ClientManagerform_common
IMPORT FGL ClientManagerform
IMPORT FGL ClientManagerform_events
{<POINT Name="import">} {</POINT>}

--------------------------------------------------------------------------------
--Database schema
SCHEMA consultcompanion

--------------------------------------------------------------------------------
--Definition of constants, user-types, variables

{<POINT Name="define">} {</POINT>}

--------------------------------------------------------------------------------
--Functions
{<BLOCK Name="fct.record1_getDataArray">}
#+ Create and fill a dynamic array of Business Record(BR) fields for record1
#+
#+ @param p_arr_br_fields The array of Business Record(BR) fields
#+ @param p_arr_db_fields The array of  Database(DB) fields
#+ @param p_where The where clause of the query
#+ @param p_detailList List of details on whom a CONSTRUCT was done
#+ @returnType INTEGER, record1_br_type, clients.*
#+ @return Error number, 0-success, other-error
#+ @return p_arr_br_fields, p_arr_db_fields
PUBLIC FUNCTION ClientManagerform_uidata_record1_getDataArray(p_arr_br_fields, p_arr_db_fields, p_where, p_detailList)
    --Declaration of parameters
    DEFINE p_arr_br_fields DYNAMIC ARRAY OF record1_br_type
    DEFINE p_arr_db_fields DYNAMIC ARRAY OF RECORD LIKE clients.*
    DEFINE p_where STRING
    DEFINE p_detailList STRING
    --Declaration of local types, variables, constants
    DEFINE l_sqlQuery STRING --The SELECT SQL statement to retrieve keys of records
    DEFINE l_from STRING
    DEFINE l_distinct STRING
    DEFINE l_detailListTok base.StringTokenizer
    DEFINE l_tokValue STRING
    DEFINE i INTEGER
    {<POINT Name="fct.record1_getDataArray.define" Status="MODIFIED">}  {</POINT>}
    CALL p_arr_br_fields.clear()
    CALL p_arr_db_fields.clear()
    LET l_from = ' FROM
    clients
    '
    LET l_distinct = ''
    LET l_detailListTok = base.StringTokenizer.create(p_detailList, '|')
    WHILE l_detailListTok.hasMoreTokens()
        LET l_tokValue = l_detailListTok.nextToken()
    END WHILE
    LET l_sqlQuery = 'SELECT ', l_distinct
        , ' clients.clientid, '
        , ' clients.clientname, '
        , ' clients.address1, '
        , ' clients.address2, '
        , ' clients.city, '
        , ' clients.countryid, '
        , ' clients.provinceid, '
        , ' clients.postalzip, '
        , ' clients.primarycontact, '
        , ' clients.primaryemail, '
        , ' clients.clienttypeid, '
        , ' clients.preferred, '
        , ' clients.paytermid, '
        , ' clients.primaryphone, '
        , ' clients.homephone, '
        , ' clients.workphone, '
        , ' clients.workextension, '
        , ' clients.mobilephone, '
        , ' clients.* '
        , l_from
        , p_where
        , ''
        , ' ORDER BY clients.clientid ASC '
    {<POINT Name="fct.record1_getDataArray.init">} {</POINT>}
    IF ClientManagerform_events.m_DataEvent_record1_OnSelectRows IS NOT NULL THEN
        CALL ClientManagerform_events.m_DataEvent_record1_OnSelectRows(l_sqlQuery)
            RETURNING l_sqlQuery
    END IF

    LET i = 1

    WHENEVER ERROR CONTINUE
        DECLARE getDataArray_cursqlsid_ClientManagerform_record1 CURSOR FROM l_sqlQuery
    WHENEVER ERROR STOP
    IF SQLCA.SQLCODE != 0 THEN
        RETURN SQLCA.SQLCODE
    END IF
    WHENEVER ERROR CONTINUE
        FOREACH getDataArray_cursqlsid_ClientManagerform_record1 INTO
                p_arr_br_fields[i].clients_clientid,
                p_arr_br_fields[i].clients_clientname,
                p_arr_br_fields[i].clients_address1,
                p_arr_br_fields[i].clients_address2,
                p_arr_br_fields[i].clients_city,
                p_arr_br_fields[i].clients_countryid,
                p_arr_br_fields[i].clients_provinceid,
                p_arr_br_fields[i].clients_postalzip,
                p_arr_br_fields[i].clients_primarycontact,
                p_arr_br_fields[i].clients_primaryemail,
                p_arr_br_fields[i].clients_clienttypeid,
                p_arr_br_fields[i].clients_preferred,
                p_arr_br_fields[i].clients_paytermid,
                p_arr_br_fields[i].clients_primaryphone,
                p_arr_br_fields[i].clients_homephone,
                p_arr_br_fields[i].clients_workphone,
                p_arr_br_fields[i].clients_workextension,
                p_arr_br_fields[i].clients_mobilephone,
                p_arr_db_fields[i].*

            IF ClientManagerform_events.m_DataEvent_record1_OnComputedFields IS NOT NULL THEN
                CALL ClientManagerform_events.m_DataEvent_record1_OnComputedFields(p_arr_br_fields[i])
            END IF
            {<POINT Name="fct.record1_getDataArray.computeFieldsAddOn">} {</POINT>}
            LET i = i + 1

        END FOREACH
        CALL p_arr_br_fields.deleteElement(p_arr_br_fields.getLength())
        CALL p_arr_db_fields.deleteElement(p_arr_db_fields.getLength())
        FREE getDataArray_cursqlsid_ClientManagerform_record1
    WHENEVER ERROR STOP
    IF SQLCA.SQLCODE != 0 THEN
        CALL p_arr_br_fields.clear()
        CALL p_arr_db_fields.clear()
    END IF
    {<POINT Name="fct.record1_getDataArray.user">} {</POINT>}
    RETURN SQLCA.SQLCODE
END FUNCTION
{</BLOCK>} --fct.record1_getDataArray

{<BLOCK Name="fct.record1_getDataByKey">}
#+ Get data from a given Business Record (BR) Unique Key (UK) (may be a composite key)
#+
#+ @param p_rec_br_uk The Business Record (BR) Unique Key (UK) for which to get data
#+
#+ @returnType INTEGER, record1_br_type, clients.*
#+ @return Error number, 0-success, other-error
#+ @return Data for the given Business Record (BR) Unique Key (UK)
PUBLIC FUNCTION ClientManagerform_uidata_record1_getDataByKey(p_rec_br_uk)
    --Declaration of parameters
    DEFINE p_rec_br_uk record1_br_uk_type
    --Declaration of local types, variables, constants
    DEFINE l_rec_BRdata record1_br_type
    DEFINE l_rec_DBdata RECORD LIKE clients.*
    {<POINT Name="fct.record1_getDataByKey.define">} {</POINT>}

    {<POINT Name="fct.record1_getDataByKey.init">} {</POINT>}
    WHENEVER ERROR CONTINUE
        SELECT @clients.clientid,
            @clients.clientname,
            @clients.address1,
            @clients.address2,
            @clients.city,
            @clients.countryid,
            @clients.provinceid,
            @clients.postalzip,
            @clients.primarycontact,
            @clients.primaryemail,
            @clients.clienttypeid,
            @clients.preferred,
            @clients.paytermid,
            @clients.primaryphone,
            @clients.homephone,
            @clients.workphone,
            @clients.workextension,
            @clients.mobilephone,
            clients.*
        INTO l_rec_BRdata.clients_clientid,
            l_rec_BRdata.clients_clientname,
            l_rec_BRdata.clients_address1,
            l_rec_BRdata.clients_address2,
            l_rec_BRdata.clients_city,
            l_rec_BRdata.clients_countryid,
            l_rec_BRdata.clients_provinceid,
            l_rec_BRdata.clients_postalzip,
            l_rec_BRdata.clients_primarycontact,
            l_rec_BRdata.clients_primaryemail,
            l_rec_BRdata.clients_clienttypeid,
            l_rec_BRdata.clients_preferred,
            l_rec_BRdata.clients_paytermid,
            l_rec_BRdata.clients_primaryphone,
            l_rec_BRdata.clients_homephone,
            l_rec_BRdata.clients_workphone,
            l_rec_BRdata.clients_workextension,
            l_rec_BRdata.clients_mobilephone,
            l_rec_DBdata.*
        FROM clients
        WHERE @clients.clientid = p_rec_br_uk.clients_clientid
        IF SQLCA.SQLCODE != 0 THEN
            INITIALIZE l_rec_BRdata.* TO NULL
            INITIALIZE l_rec_DBdata.* TO NULL
        END IF

        IF ClientManagerform_events.m_DataEvent_record1_OnComputedFields IS NOT NULL THEN
            CALL ClientManagerform_events.m_DataEvent_record1_OnComputedFields(l_rec_BRdata)
        END IF
        {<POINT Name="fct.record1_getDataByKey.computeFieldsAddOn">} {</POINT>}
    WHENEVER ERROR STOP
    {<POINT Name="fct.record1_getDataByKey.user">} {</POINT>}
    RETURN SQLCA.SQLCODE, l_rec_BRdata.*, l_rec_DBdata.*
END FUNCTION
{</BLOCK>} --fct.record1_getDataByKey

{<BLOCK Name="fct.record1_insertRow" Status="MODIFIED">}
#+ Insert a row in the database
#+
#+ @param p_rec_br Business record values to insert/
#+
#+ @returnType INTEGER, STRING, RECORD
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, Business Record unique keys
PUBLIC FUNCTION ClientManagerform_uidata_record1_insertRow(p_rec_br)
    DEFINE p_rec_br record1_br_type
    DEFINE dataInsert RECORD LIKE clients.*
    DEFINE ret record1_br_uk_type
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.record1_insertRow.define">} {</POINT>}

    --Init local data with default values from the DB schema
    CALL consultcompanion_dbxdata.consultcompanion_dbxdata_clients_setDefaultValuesFromDBSchema() RETURNING dataInsert.*
    --Set local data with form field values
    LET dataInsert.clientid = p_rec_br.clients_clientid
    LET dataInsert.clientname = p_rec_br.clients_clientname
    LET dataInsert.address1 = p_rec_br.clients_address1
    LET dataInsert.address2 = p_rec_br.clients_address2
    LET dataInsert.city = p_rec_br.clients_city
    LET dataInsert.provinceid = p_rec_br.clients_provinceid
    LET dataInsert.postalzip = p_rec_br.clients_postalzip
    LET dataInsert.primarycontact = p_rec_br.clients_primarycontact
    LET dataInsert.primaryemail = p_rec_br.clients_primaryemail
    LET dataInsert.clienttypeid = p_rec_br.clients_clienttypeid
    LET dataInsert.preferred = p_rec_br.clients_preferred
    LET dataInsert.paytermid = p_rec_br.clients_paytermid
    LET dataInsert.primaryphone = p_rec_br.clients_primaryphone
    LET dataInsert.homephone = p_rec_br.clients_homephone
    LET dataInsert.workphone = p_rec_br.clients_workphone
    LET dataInsert.mobilephone = p_rec_br.clients_mobilephone
    let dataInsert.workextension = p_rec_br.clients_workextension
    LET dataInsert.countryid = p_rec_br.clients_countryid
    {<POINT Name="fct.record1_insertRow.init" Status="MODIFIED">} 
    {</POINT>}

    IF ClientManagerform_events.m_DataEvent_record1_BeforeInsertRow IS NOT NULL THEN
        CALL ClientManagerform_events.m_DataEvent_record1_BeforeInsertRow(dataInsert.*)
            RETURNING errNo, errMsg, dataInsert.*
    END IF
    IF errNo == ERROR_SUCCESS THEN
        --Call the database insert row
        CALL consultcompanion_dbxdata.consultcompanion_dbxdata_clients_PK_clients_1_insertRowByKey(dataInsert.*) RETURNING errNo, errMsg, ret.clients_clientid
        IF errNo == ERROR_SUCCESS THEN
            IF ClientManagerform_events.m_DataEvent_record1_AfterInsertRow IS NOT NULL THEN
                CALL ClientManagerform_events.m_DataEvent_record1_AfterInsertRow(errNo, errMsg, ret.*)
                    RETURNING errNo, errMsg
            END IF
        END IF
    END IF

    LET errMsg = IIF(errNo = ERROR_SUCCESS, C_TXT_INSERT_SUCCESS_MSG, C_TXT_INSERT_FAIL_MSG), errMsg

    {<POINT Name="fct.record1_insertRow.user">} {</POINT>}
    RETURN errNo, errMsg, ret.*
END FUNCTION
{</BLOCK>} --fct.record1_insertRow

{<BLOCK Name="fct.record1_updateRow">}
#+ Update a row in the database
#+
#+ @param p_rec_br Business record values to update
#+ @param p_dataT0 - a row data LIKE clients.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE, error message
PUBLIC FUNCTION ClientManagerform_uidata_record1_updateRow(p_rec_br, p_dataT0)
    DEFINE p_rec_br record1_br_type
    DEFINE p_dataT0 RECORD LIKE clients.*
    DEFINE l_dataT1 RECORD LIKE clients.*
    DEFINE l_rec_br_uk record1_br_uk_type
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.record1_updateRow.define">} {</POINT>}
    --Init local data with values from the DB array
    LET l_dataT1.* = p_dataT0.*
    --Set local data with form field values
    LET l_dataT1.clientid = p_rec_br.clients_clientid
    LET l_dataT1.clientname = p_rec_br.clients_clientname
    LET l_dataT1.address1 = p_rec_br.clients_address1
    LET l_dataT1.address2 = p_rec_br.clients_address2
    LET l_dataT1.city = p_rec_br.clients_city
    LET l_dataT1.countryid = p_rec_br.clients_countryid
    LET l_dataT1.provinceid = p_rec_br.clients_provinceid
    LET l_dataT1.postalzip = p_rec_br.clients_postalzip
    LET l_dataT1.primarycontact = p_rec_br.clients_primarycontact
    LET l_dataT1.primaryemail = p_rec_br.clients_primaryemail
    LET l_dataT1.clienttypeid = p_rec_br.clients_clienttypeid
    LET l_dataT1.preferred = p_rec_br.clients_preferred
    LET l_dataT1.paytermid = p_rec_br.clients_paytermid
    LET l_dataT1.primaryphone = p_rec_br.clients_primaryphone
    LET l_dataT1.homephone = p_rec_br.clients_homephone
    LET l_dataT1.workphone = p_rec_br.clients_workphone
    LET l_dataT1.workextension = p_rec_br.clients_workextension
    LET l_dataT1.mobilephone = p_rec_br.clients_mobilephone
    --Set local Business Record Key data
    LET l_rec_br_uk.clients_clientid = p_dataT0.clientid
    {<POINT Name="fct.record1_updateRow.init">} {</POINT>}

    IF ClientManagerform_events.m_DataEvent_record1_BeforeUpdateRow IS NOT NULL THEN
        CALL ClientManagerform_events.m_DataEvent_record1_BeforeUpdateRow(p_dataT0.*, l_dataT1.*)
            RETURNING errNo, errMsg, p_dataT0.*, l_dataT1.*
    END IF
    IF errNo == ERROR_SUCCESS THEN
        --Call the database update row
        CALL consultcompanion_dbxdata.consultcompanion_dbxdata_clients_PK_clients_1_updateRowByKey(p_dataT0.*, l_dataT1.*) RETURNING errNo, errMsg
        IF errNo == ERROR_SUCCESS THEN
            IF ClientManagerform_events.m_DataEvent_record1_AfterUpdateRow IS NOT NULL THEN
                CALL ClientManagerform_events.m_DataEvent_record1_AfterUpdateRow(errNo, errMsg, l_rec_br_uk.*)
                    RETURNING errNo, errMsg
            END IF
        END IF
    END IF

    CASE errNo
        WHEN ERROR_SUCCESS
            LET errMsg = C_TXT_UPDATE_SUCCESS_MSG
        WHEN ERROR_CONCURRENT_ACCESS_FAILURE
            LET errMsg = C_TXT_UPDATE_OVERWRITE
        WHEN ERROR_CONCURRENT_ACCESS_NOTFOUND
            LET errMsg = C_TXT_UPDATE_DATA_MISSING
        OTHERWISE
            LET errMsg = C_TXT_UPDATE_FAIL_MSG, errMsg
    END CASE

    {<POINT Name="fct.record1_updateRow.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.record1_updateRow

{<BLOCK Name="fct.record1_deleteRowWithConcurrentAccess">}
#+ Delete a row in the database
#+
#+ @param p_dataT0 - a row data LIKE clients.*
#+
#+ @returnType       INTEGER, STRING
#+ @return           0-success|Other-Error, error message
PUBLIC FUNCTION ClientManagerform_uidata_record1_deleteRowWithConcurrentAccess(p_dataT0)
    DEFINE p_dataT0 RECORD LIKE clients.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.record1_deleteRowWithConcurrentAccess.define">} {</POINT>}
    {<POINT Name="fct.record1_deleteRowWithConcurrentAccess.init">} {</POINT>}

    IF ClientManagerform_events.m_DataEvent_record1_BeforeDeleteRowWithConcurrentAccess IS NOT NULL THEN
        CALL ClientManagerform_events.m_DataEvent_record1_BeforeDeleteRowWithConcurrentAccess(p_dataT0.*)
            RETURNING errNo, errMsg, p_dataT0.*
    END IF
    IF errNo == ERROR_SUCCESS THEN
        --Call the database update row
        CALL consultcompanion_dbxdata.consultcompanion_dbxdata_clients_PK_clients_1_deleteRowByKeyWithConcurrentAccess(p_dataT0.*) RETURNING errNo
        IF errNo == ERROR_SUCCESS THEN
            IF ClientManagerform_events.m_DataEvent_record1_AfterDeleteRowWithConcurrentAccess IS NOT NULL THEN
                CALL ClientManagerform_events.m_DataEvent_record1_AfterDeleteRowWithConcurrentAccess(errNo, errMsg, p_dataT0.*)
                    RETURNING errNo, errMsg
            END IF
        END IF
    END IF

    CASE errNo
        WHEN ERROR_SUCCESS
            LET errMsg = C_TXT_DELETE_SUCCESS_MSG
        WHEN ERROR_CONCURRENT_ACCESS_FAILURE
            LET errMsg = C_TXT_DELETE_OVERWRITE
        WHEN ERROR_CONCURRENT_ACCESS_NOTFOUND
            LET errMsg = C_TXT_DELETE_DATA_MISSING
        WHEN ERROR_DELETE_CASCADE_ROW_USED
            LET errMsg = C_TXT_DELETE_FAIL_ROW_USED_MSG
        OTHERWISE
            LET errMsg = C_TXT_DELETE_FAIL_MSG
    END CASE

    {<POINT Name="fct.record1_deleteRowWithConcurrentAccess.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.record1_deleteRowWithConcurrentAccess

{<BLOCK Name="fct.record1_checkRowConcurrentAccess">}
#+ Check a row in the database
#+
#+ @param p_dataT0 - a row data LIKE clients.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE, error message
PUBLIC FUNCTION ClientManagerform_uidata_record1_checkRowConcurrentAccess(p_dataT0)
    DEFINE p_dataT0 RECORD LIKE clients.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.record1_checkRowConcurrentAccess.define">} {</POINT>}
    {<POINT Name="fct.record1_checkRowConcurrentAccess.init">} {</POINT>}

    CALL consultcompanion_dbxdata.consultcompanion_dbxdata_clients_PK_clients_1_checkRowByKeyWithConcurrentAccess(p_dataT0.*, FALSE) RETURNING errNo
    CASE errNo
        WHEN ERROR_SUCCESS
        WHEN ERROR_CONCURRENT_ACCESS_FAILURE
            LET errMsg = C_TXT_UPDATE_OVERWRITE
        WHEN ERROR_CONCURRENT_ACCESS_NOTFOUND
            LET errMsg = C_TXT_UPDATE_DATA_MISSING
        OTHERWISE
            LET errMsg = C_TXT_DELETE_FAIL_MSG, errMsg
    END CASE
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.record1_checkRowConcurrentAccess

--------------------------------------------------------------------------------
--Add user functions
{<POINT Name="user.functions">} {</POINT>}
