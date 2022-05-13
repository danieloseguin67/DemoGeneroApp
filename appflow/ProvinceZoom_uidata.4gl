{<CODEFILE Path="ProvinceZoom.code" Hash="1B2M2Y8AsgTpgAmY7PhCfg==" />}
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
IMPORT FGL ProvinceZoom_common
IMPORT FGL ProvinceZoom
IMPORT FGL ProvinceZoom_events
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
#+ @returnType INTEGER, record1_br_type, provinces.*
#+ @return Error number, 0-success, other-error
#+ @return p_arr_br_fields, p_arr_db_fields
PUBLIC FUNCTION ProvinceZoom_uidata_record1_getDataArray(p_arr_br_fields, p_arr_db_fields, p_where, p_detailList)
    --Declaration of parameters
    DEFINE p_arr_br_fields DYNAMIC ARRAY OF record1_br_type
    DEFINE p_arr_db_fields DYNAMIC ARRAY OF RECORD LIKE provinces.*
    DEFINE p_where STRING
    DEFINE p_detailList STRING
    --Declaration of local types, variables, constants
    DEFINE l_sqlQuery STRING --The SELECT SQL statement to retrieve keys of records
    DEFINE l_from STRING
    DEFINE l_distinct STRING
    DEFINE l_detailListTok base.StringTokenizer
    DEFINE l_tokValue STRING
    DEFINE i INTEGER
    {<POINT Name="fct.record1_getDataArray.define">} {</POINT>}
    CALL p_arr_br_fields.clear()
    CALL p_arr_db_fields.clear()
    LET l_from = ' FROM
    provinces
    '
    LET l_distinct = ''
    LET l_detailListTok = base.StringTokenizer.create(p_detailList, '|')
    WHILE l_detailListTok.hasMoreTokens()
        LET l_tokValue = l_detailListTok.nextToken()
    END WHILE
    LET l_sqlQuery = 'SELECT ', l_distinct
        , ' provinces.countryid, '
        , ' provinces.provinceid, '
        , ' provinces.provincename, '
        , ' provinces.* '
        , l_from
        , p_where
        , ''
        , ' ORDER BY provinces.countryid ASC, '
        , '   provinces.provinceid ASC '
    {<POINT Name="fct.record1_getDataArray.init">} {</POINT>}
    IF ProvinceZoom_events.m_DataEvent_record1_OnSelectRows IS NOT NULL THEN
        CALL ProvinceZoom_events.m_DataEvent_record1_OnSelectRows(l_sqlQuery)
            RETURNING l_sqlQuery
    END IF

    LET i = 1

    WHENEVER ERROR CONTINUE
        DECLARE getDataArray_cursqlsid_ProvinceZoom_record1 CURSOR FROM l_sqlQuery
    WHENEVER ERROR STOP
    IF SQLCA.SQLCODE != 0 THEN
        RETURN SQLCA.SQLCODE
    END IF
    WHENEVER ERROR CONTINUE
        FOREACH getDataArray_cursqlsid_ProvinceZoom_record1 INTO
                p_arr_br_fields[i].provinces_countryid,
                p_arr_br_fields[i].provinces_provinceid,
                p_arr_br_fields[i].provinces_provincename,
                p_arr_db_fields[i].*

            IF ProvinceZoom_events.m_DataEvent_record1_OnComputedFields IS NOT NULL THEN
                CALL ProvinceZoom_events.m_DataEvent_record1_OnComputedFields(p_arr_br_fields[i])
            END IF
            {<POINT Name="fct.record1_getDataArray.computeFieldsAddOn">} {</POINT>}
            LET i = i + 1

        END FOREACH
        CALL p_arr_br_fields.deleteElement(p_arr_br_fields.getLength())
        CALL p_arr_db_fields.deleteElement(p_arr_db_fields.getLength())
        FREE getDataArray_cursqlsid_ProvinceZoom_record1
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
#+ @returnType INTEGER, record1_br_type, provinces.*
#+ @return Error number, 0-success, other-error
#+ @return Data for the given Business Record (BR) Unique Key (UK)
PUBLIC FUNCTION ProvinceZoom_uidata_record1_getDataByKey(p_rec_br_uk)
    --Declaration of parameters
    DEFINE p_rec_br_uk record1_br_uk_type
    --Declaration of local types, variables, constants
    DEFINE l_rec_BRdata record1_br_type
    DEFINE l_rec_DBdata RECORD LIKE provinces.*
    {<POINT Name="fct.record1_getDataByKey.define">} {</POINT>}

    {<POINT Name="fct.record1_getDataByKey.init">} {</POINT>}
    WHENEVER ERROR CONTINUE
        SELECT @provinces.countryid,
            @provinces.provinceid,
            @provinces.provincename,
            provinces.*
        INTO l_rec_BRdata.provinces_countryid,
            l_rec_BRdata.provinces_provinceid,
            l_rec_BRdata.provinces_provincename,
            l_rec_DBdata.*
        FROM provinces
        WHERE @provinces.provinceid = p_rec_br_uk.provinces_provinceid
        IF SQLCA.SQLCODE != 0 THEN
            INITIALIZE l_rec_BRdata.* TO NULL
            INITIALIZE l_rec_DBdata.* TO NULL
        END IF

        IF ProvinceZoom_events.m_DataEvent_record1_OnComputedFields IS NOT NULL THEN
            CALL ProvinceZoom_events.m_DataEvent_record1_OnComputedFields(l_rec_BRdata)
        END IF
        {<POINT Name="fct.record1_getDataByKey.computeFieldsAddOn">} {</POINT>}
    WHENEVER ERROR STOP
    {<POINT Name="fct.record1_getDataByKey.user">} {</POINT>}
    RETURN SQLCA.SQLCODE, l_rec_BRdata.*, l_rec_DBdata.*
END FUNCTION
{</BLOCK>} --fct.record1_getDataByKey

--------------------------------------------------------------------------------
--Add user functions
{<POINT Name="user.functions">} {</POINT>}
