{<CODEFILE Path="ProvinceZoom.code" Hash="7JQCYIx7vAgxlR4grvtljQ==" />}
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

IMPORT FGL ProvinceZoom_common
IMPORT FGL ProvinceZoom_events
IMPORT FGL ProvinceZoom_uidata
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
PUBLIC FUNCTION ProvinceZoom_uidialogdata_record1_clear()
    {<POINT Name="fct.record1_clear.define">} {</POINT>}
    CALL m_record1_arrRecDB.clear()
    CALL m_record1_arrRecList.clear()
    {<POINT Name="fct.record1_clear.init">} {</POINT>}
END FUNCTION
{</BLOCK>} --fct.record1_clear

{<BLOCK Name="fct.record1_fetchAll" Status="MODIFIED">}
#+ Fetch the data set for 'record1'
#+
#+ @param p_where        The WHERE part to apply
#+ @param p_detailList   List of details on whom a CONSTRUCT was done
PUBLIC FUNCTION (p_where, p_detailList)
    DEFINE p_where STRING
    DEFINE p_detailList STRING
    DEFINE errNo INTEGER
    {<POINT Name="fct.record1_fetchAll.define">} {</POINT>}
    {<POINT Name="fct.record1_fetchAll.init">} {</POINT>}
    CALL ProvinceZoom_uidialogdata_record1_clear()
    CALL ProvinceZoom_uidata.ProvinceZoom_uidata_record1_getDataArray(m_record1_arrRecList, m_record1_arrRecDB, p_where, p_detailList) RETURNING errNo
    IF errNo < ERROR_SQL_SUCCESS THEN
        LET m_record1_keyIndex = 0
        CALL libdbapp_utilMsgStatusBar(errNo, libdbapp_formatSqlErrorMsg(errNo))
    END IF
    LET m_record1_keyIndex = libdbapp_setRowIndex(m_record1_keyIndex, m_record1_arrRecList.getLength())
    CALL ProvinceZoom_uidialogdata_record1_fetchDetails()
END FUNCTION
{</BLOCK>} --fct.record1_fetchAll

{<BLOCK Name="fct.record1_fetchRowAndDetails">}
#+ Fetch row and details data for 'record1'
#+
FUNCTION ProvinceZoom_uidialogdata_record1_fetchRowAndDetails()
    DEFINE errNo INTEGER
    {<POINT Name="fct.record1_fetchRowAndDetails.define">} {</POINT>}
    {<POINT Name="fct.record1_fetchRowAndDetails.init">} {</POINT>}
    CALL ProvinceZoom_uidialogdata_record1_fetchRow() RETURNING errNo
    CALL ProvinceZoom_uidialogdata_record1_fetchDetails()
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.record1_fetchRowAndDetails

{<BLOCK Name="fct.record1_fetchRow">}
#+ Fetch row data for 'record1'
#+
FUNCTION ProvinceZoom_uidialogdata_record1_fetchRow()
    DEFINE errNo INTEGER
    {<POINT Name="fct.record1_fetchRow.define">} {</POINT>}
    {<POINT Name="fct.record1_fetchRow.init">} {</POINT>}
    IF m_record1_keyIndex > 0 THEN
        CALL ProvinceZoom_uidata.ProvinceZoom_uidata_record1_getDataByKey(m_record1_arrRecList[m_record1_keyIndex].provinces_provinceid) RETURNING errNo, m_record1_arrRecList[m_record1_keyIndex].*, m_record1_arrRecDB[m_record1_keyIndex].*
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
FUNCTION ProvinceZoom_uidialogdata_record1_fetchDetails()
    DEFINE errNo INTEGER
    {<POINT Name="fct.record1_fetchDetails.define">} {</POINT>}
    {<POINT Name="fct.record1_fetchDetails.init">} {</POINT>}
END FUNCTION
{</BLOCK>} --fct.record1_fetchDetails

{<BLOCK Name="fct.record1_seek">}
#+ Gets the index of an item matching the given criterias
#+
#+ @param p_record1_br_uk The seek criterias
#+
#+ @returnType INTEGER
#+ @return 0-nothing found, other-index of the matching item
PUBLIC FUNCTION ProvinceZoom_uidialogdata_record1_seek(p_record1_br_uk)
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
    IF p_record1_br_uk.provinces_provinceid IS NULL THEN
        LET idxReturn = 0
    END IF

    --If the seeking values match the current row, then no need to seek and return the current index
    IF m_record1_keyIndex > 0 THEN
        IF p_record1_br_uk.provinces_provinceid == m_record1_arrRecList[m_record1_keyIndex].provinces_provinceid THEN
            LET idxReturn = m_record1_keyIndex
        END IF
    END IF

    --Process the seeking
    LET s = m_record1_arrRecList.getLength()
    FOR i = 1 TO s
        IF p_record1_br_uk.provinces_provinceid == m_record1_arrRecList[i].provinces_provinceid THEN
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
