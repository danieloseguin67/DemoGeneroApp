{<CODEFILE Path="ClientManagerform.code" Hash="1B2M2Y8AsgTpgAmY7PhCfg==" />}
#+ User Interface - Dialog Data management

--------------------------------------------------------------------------------
--This code is generated with the template dbapp5.0
--Warning: Enter your changes within a <BLOCK> or <POINT> section, otherwise they will be lost.
{<POINT Name="user.comments">} {</POINT>}

--------------------------------------------------------------------------------
--Importing modules
IMPORT FGL libdbappCore
IMPORT FGL libdbappSql
IMPORT FGL libdbappUI
IMPORT FGL libdbappFormUI

IMPORT FGL ClientManagerform_common
IMPORT FGL ClientManagerform_events
IMPORT FGL ClientManagerform_uidata
{<POINT Name="import">} {</POINT>}

--------------------------------------------------------------------------------
--Database schema
SCHEMA consultcompanion

--------------------------------------------------------------------------------
--Definition of constants, user-types, variables
{<POINT Name="define">} {</POINT>}

--------------------------------------------------------------------------------
--Functions

{<BLOCK Name="fct.record1_clear">}
#+ Clear data for 'record1'
#+
PUBLIC FUNCTION ClientManagerform_uidialogdata_record1_clear()
    {<POINT Name="fct.record1_clear.define">} {</POINT>}
    CALL m_record1_arrRecDB.clear()
    CALL m_record1_arrRecList.clear()
    {<POINT Name="fct.record1_clear.init">} {</POINT>}
END FUNCTION
{</BLOCK>} --fct.record1_clear

{<BLOCK Name="fct.record1_fetchAll">}
#+ Fetch the data set for 'record1'
#+
#+ @param p_where        The WHERE part to apply
#+ @param p_detailList   List of details on whom a CONSTRUCT was done
PUBLIC FUNCTION ClientManagerform_uidialogdata_record1_fetchAll(p_where, p_detailList)
    DEFINE p_where STRING
    DEFINE p_detailList STRING
    DEFINE errNo INTEGER
    {<POINT Name="fct.record1_fetchAll.define">} {</POINT>}
    {<POINT Name="fct.record1_fetchAll.init">} {</POINT>}
    CALL ClientManagerform_uidialogdata_record1_clear()
    CALL ClientManagerform_uidata.ClientManagerform_uidata_record1_getDataArray(m_record1_arrRecList, m_record1_arrRecDB, p_where, p_detailList) RETURNING errNo
    IF errNo < ERROR_SQL_SUCCESS THEN
        LET m_record1_keyIndex = 0
        CALL libdbapp_utilMsgStatusBar(errNo, libdbapp_formatSqlErrorMsg(errNo))
    END IF
    LET m_record1_keyIndex = libdbapp_setRowIndex(m_record1_keyIndex, m_record1_arrRecList.getLength())
    CALL ClientManagerform_uidialogdata_record1_fetchDetails()
END FUNCTION
{</BLOCK>} --fct.record1_fetchAll

{<BLOCK Name="fct.record1_fetchRowAndDetails">}
#+ Fetch row and details data for 'record1'
#+
FUNCTION ClientManagerform_uidialogdata_record1_fetchRowAndDetails()
    DEFINE errNo INTEGER
    {<POINT Name="fct.record1_fetchRowAndDetails.define">} {</POINT>}
    {<POINT Name="fct.record1_fetchRowAndDetails.init">} {</POINT>}
    CALL ClientManagerform_uidialogdata_record1_fetchRow() RETURNING errNo
    CALL ClientManagerform_uidialogdata_record1_fetchDetails()
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.record1_fetchRowAndDetails

{<BLOCK Name="fct.record1_fetchRow">}
#+ Fetch row data for 'record1'
#+
FUNCTION ClientManagerform_uidialogdata_record1_fetchRow()
    DEFINE errNo INTEGER
    {<POINT Name="fct.record1_fetchRow.define">} {</POINT>}
    {<POINT Name="fct.record1_fetchRow.init">} {</POINT>}
    IF m_record1_keyIndex > 0 THEN
        CALL ClientManagerform_uidata.ClientManagerform_uidata_record1_getDataByKey(m_record1_arrRecList[m_record1_keyIndex].clients_clientid) RETURNING errNo, m_record1_arrRecList[m_record1_keyIndex].*, m_record1_arrRecDB[m_record1_keyIndex].*
        IF errNo < ERROR_SQL_SUCCESS THEN
            CALL libdbapp_utilMsgStatusBar(errNo, libdbapp_formatSqlErrorMsg(errNo))
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.record1_fetchRow

{<BLOCK Name="fct.record1_fetchDetails">}
#+ Fetch details data for 'record1'
#+
FUNCTION ClientManagerform_uidialogdata_record1_fetchDetails()
    DEFINE errNo INTEGER
    {<POINT Name="fct.record1_fetchDetails.define">} {</POINT>}
    {<POINT Name="fct.record1_fetchDetails.init">} {</POINT>}
END FUNCTION
{</BLOCK>} --fct.record1_fetchDetails

{<BLOCK Name="fct.record1_setDefaultValues">}
#+ Initialize 'record1' with default values
#+
#+ @param p_dialog     The current DIALOG
PUBLIC FUNCTION ClientManagerform_uidialogdata_record1_setDefaultValues(p_dialog)
    DEFINE p_dialog ui.Dialog
    DEFINE errNo INTEGER
    {<POINT Name="fct.record1_setDefaultValues.define">} {</POINT>}

    LET m_record1_arrRecList[m_record1_keyIndex].clients_preferred = "0"

    {<POINT Name="fct.record1_setDefaultValues.init">} {</POINT>}
    IF ClientManagerform_events.m_DataEvent_record1_OnDefaultValues IS NOT NULL THEN
        CALL ClientManagerform_events.m_DataEvent_record1_OnDefaultValues(m_record1_arrRecList[m_record1_keyIndex].*)
            RETURNING m_record1_arrRecList[m_record1_keyIndex].*
    END IF
END FUNCTION
{</BLOCK>} --fct.record1_setDefaultValues

{<BLOCK Name="fct.record1_seek">}
#+ Gets the index of an item matching the given criterias
#+
#+ @param p_record1_br_uk The seek criterias
#+
#+ @returnType INTEGER
#+ @return 0-nothing found, other-index of the matching item
PUBLIC FUNCTION ClientManagerform_uidialogdata_record1_seek(p_record1_br_uk)
    DEFINE p_record1_br_uk record1_br_uk_type
    DEFINE i, s INTEGER
    DEFINE idxFirstMatch INTEGER
    DEFINE idxExactMatch INTEGER
    DEFINE idxReturn INTEGER
    {<POINT Name="fct.record1_seek.define">} {</POINT>}

    LET idxFirstMatch = 0
    LET idxExactMatch = 0
    LET m_record1_keyIndex = libdbapp_setRowIndex(m_record1_keyIndex, m_record1_arrRecList.getLength())
    {<POINT Name="fct.record1_seek.init">} {</POINT>}

    --If the unique key (in whole for composite key) is NULL, then no need to seek and return 0
    IF p_record1_br_uk.clients_clientid IS NULL THEN
        LET idxReturn = 0
    END IF

    --If the seeking values match the current row, then no need to seek and return the current index
    IF m_record1_keyIndex > 0 THEN
        IF p_record1_br_uk.clients_clientid == m_record1_arrRecList[m_record1_keyIndex].clients_clientid THEN
            LET idxReturn = m_record1_keyIndex
        END IF
    END IF

    --Process the seeking
    LET s = m_record1_arrRecList.getLength()
    FOR i = 1 TO s
        IF p_record1_br_uk.clients_clientid == m_record1_arrRecList[i].clients_clientid THEN
            LET idxExactMatch = i
            EXIT FOR
        END IF
    END FOR
    LET idxReturn = IIF(idxExactMatch == 0, idxFirstMatch, idxExactMatch)

    RETURN libdbapp_setRowIndex(idxReturn, m_record1_arrRecList.getLength())
END FUNCTION
{</BLOCK>} --fct.record1_seek

--------------------------------------------------------------------------------
--Add user functions
{<POINT Name="user.functions">} {</POINT>}
