{<CODEFILE Path="consultcompanion.code" Hash="BNJhix8qwiJQ/kCh6/Y4Zw==" />}
#+ DB schema - Constraints Management (consultcompanion)

--------------------------------------------------------------------------------
--This code is generated with the template dbapp5.0
--Warning: Enter your changes within a <BLOCK> or <POINT> section, otherwise they will be lost.
{<POINT Name="user.comments">} {</POINT>}

--------------------------------------------------------------------------------
--Importing modules
IMPORT FGL libdbappCore

IMPORT FGL consultcompanion
IMPORT FGL consultcompanion_events
{<POINT Name="import" Status="MODIFIED">}
IMPORT FGL fgldialog
{</POINT>}

--------------------------------------------------------------------------------
--Database schema
SCHEMA consultcompanion

--------------------------------------------------------------------------------
--Functions

{<BLOCK Name="fct.seqreg_checkTableConstraints">}
#+ Check constraints on the "seqreg" table
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_data - a row data LIKE seqreg.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_seqreg_checkTableConstraints(p_forUpdate, p_data)
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_data RECORD LIKE seqreg.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE l_errNo INTEGER
    DEFINE l_errMsg STRING
    {<POINT Name="fct.seqreg_checkTableConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.seqreg_checkTableConstraints.init">} {</POINT>}

    CALL consultcompanion_dbxconstraints_seqreg_sr_name_checkColumnConstraints(p_data.sr_name) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL consultcompanion_dbxconstraints_seqreg_sr_last_checkColumnConstraints(p_data.sr_last) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    CALL consultcompanion_dbxconstraints_seqreg_pk_seqreg_checkUniqueConstraint(p_forUpdate, p_data.sr_name) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    IF consultcompanion_events.m_DbxDataEvent_seqreg_CheckTableConstraints IS NOT NULL THEN
        CALL consultcompanion_events.m_DbxDataEvent_seqreg_CheckTableConstraints(p_forUpdate, p_data.*)
            RETURNING l_errNo, l_errMsg
    END IF
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    {<POINT Name="fct.seqreg_checkTableConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.seqreg_checkTableConstraints

{<BLOCK Name="fct.seqreg_pk_seqreg_checkUniqueConstraint">}
#+ Check the primary key uniqueness constraint on the "seqreg"
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER, STRING, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_seqreg_pk_seqreg_checkUniqueConstraint(p_forUpdate, p_key)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_key
        RECORD
            seqreg_sr_name LIKE seqreg.sr_name
        END RECORD
    DEFINE l_key
        RECORD
            seqreg_sr_name LIKE seqreg.sr_name
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.seqreg_pk_seqreg_checkUniqueConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    LET l_where = "WHERE seqreg.sr_name = ? "
    LET l_sqlQuery = "SELECT COUNT(*), sr_name FROM seqreg ", l_where, " GROUP BY sr_name"
    {<POINT Name="fct.seqreg_pk_seqreg_checkUniqueConstraint.init">} {</POINT>}
    TRY
        PREPARE cur_seqreg_pk_seqreg_checkUniqueConstraint FROM l_sqlQuery
        EXECUTE cur_seqreg_pk_seqreg_checkUniqueConstraint USING p_key.* INTO l_count, l_key.*
        FREE cur_seqreg_pk_seqreg_checkUniqueConstraint
        IF (NOT p_forUpdate AND l_count > 0) OR (p_forUpdate AND l_count > 0 AND p_key.* != l_key.*) THEN
            CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- sr_name: " || ERROR_BAM_00002) RETURNING errNo, errMsg
        END IF
    CATCH
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.seqreg_pk_seqreg_checkUniqueConstraint.user">} {</POINT>}

    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.seqreg_pk_seqreg_checkUniqueConstraint

{<BLOCK Name="fct.seqreg_sr_name_checkColumnConstraints">}
#+ Check constraints on the "seqreg.sr_name" column
#+
#+ @param p_sr_name - VARCHAR(30) - sr_name
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_seqreg_sr_name_checkColumnConstraints(p_sr_name)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_sr_name LIKE seqreg.sr_name
    {<POINT Name="fct.seqreg_sr_name_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.seqreg_sr_name_checkColumnConstraints.init">} {</POINT>}
    IF p_sr_name IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- sr_name: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.seqreg_sr_name_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.seqreg_sr_name_checkColumnConstraints

{<BLOCK Name="fct.seqreg_sr_last_checkColumnConstraints">}
#+ Check constraints on the "seqreg.sr_last" column
#+
#+ @param p_sr_last - INTEGER - sr_last
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_seqreg_sr_last_checkColumnConstraints(p_sr_last)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_sr_last LIKE seqreg.sr_last
    {<POINT Name="fct.seqreg_sr_last_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.seqreg_sr_last_checkColumnConstraints.init">} {</POINT>}
    IF p_sr_last IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- sr_last: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.seqreg_sr_last_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.seqreg_sr_last_checkColumnConstraints

{<BLOCK Name="fct.seqreg_pk_seqreg_checkFKConstraint">}
#+ Check the Foreign Key existence constraint on the "seqreg"
#+
#+ @param p_data - Primary Key
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_seqreg_pk_seqreg_checkFKConstraint(p_data)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_data
        RECORD
            seqreg_sr_name LIKE seqreg.sr_name
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.seqreg_pk_seqreg_checkFKConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    IF NOT (p_data.seqreg_sr_name IS NULL) THEN
        LET l_where = "WHERE seqreg.sr_name = ? "
        LET l_sqlQuery = "SELECT COUNT(*) FROM seqreg ", l_where
        {<POINT Name="fct.seqreg_pk_seqreg_checkFKConstraint.init">} {</POINT>}
        TRY
            PREPARE cur_seqreg_pk_seqreg_checkFKConstraint FROM l_sqlQuery
            EXECUTE cur_seqreg_pk_seqreg_checkFKConstraint USING p_data.* INTO l_count
            FREE cur_seqreg_pk_seqreg_checkFKConstraint
            IF (l_count == 0) THEN
                CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- sr_name: " || ERROR_BAM_00004) RETURNING errNo, errMsg
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
    END IF
    {<POINT Name="fct.seqreg_pk_seqreg_checkFKConstraint.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.seqreg_pk_seqreg_checkFKConstraint

{<BLOCK Name="fct.rfs_checkTableConstraints">}
#+ Check constraints on the "rfs" table
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_data - a row data LIKE rfs.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_rfs_checkTableConstraints(p_forUpdate, p_data)
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_data RECORD LIKE rfs.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE l_errNo INTEGER
    DEFINE l_errMsg STRING
    {<POINT Name="fct.rfs_checkTableConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.rfs_checkTableConstraints.init">} {</POINT>}

    CALL consultcompanion_dbxconstraints_rfs_rfsId_checkColumnConstraints(p_data.rfsId) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL consultcompanion_dbxconstraints_rfs_clientid_checkColumnConstraints(p_data.clientid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL consultcompanion_dbxconstraints_rfs_stakeholderId_checkColumnConstraints(p_data.stakeholderId) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL consultcompanion_dbxconstraints_rfs_offertitle_checkColumnConstraints(p_data.offertitle) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL consultcompanion_dbxconstraints_rfs_offerdate_checkColumnConstraints(p_data.offerdate) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL consultcompanion_dbxconstraints_rfs_offerstatusid_checkColumnConstraints(p_data.offerstatusid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    CALL consultcompanion_dbxconstraints_rfs_PK_RFS_1_checkUniqueConstraint(p_forUpdate, p_data.rfsId) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    CALL consultcompanion_dbxconstraints_clientstakeholders_PK_clientStakeholders_1_checkFKConstraint(p_data.stakeholderId) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL consultcompanion_dbxconstraints_clients_PK_clients_1_checkFKConstraint(p_data.clientid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL consultcompanion_dbxconstraints_offerstatuses_PK_offerStatuses_1_checkFKConstraint(p_data.offerstatusid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    IF consultcompanion_events.m_DbxDataEvent_rfs_CheckTableConstraints IS NOT NULL THEN
        CALL consultcompanion_events.m_DbxDataEvent_rfs_CheckTableConstraints(p_forUpdate, p_data.*)
            RETURNING l_errNo, l_errMsg
    END IF
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    {<POINT Name="fct.rfs_checkTableConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.rfs_checkTableConstraints

{<BLOCK Name="fct.rfs_PK_RFS_1_checkUniqueConstraint">}
#+ Check the primary key uniqueness constraint on the "rfs"
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER, STRING, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_rfs_PK_RFS_1_checkUniqueConstraint(p_forUpdate, p_key)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_key
        RECORD
            rfs_rfsId LIKE rfs.rfsId
        END RECORD
    DEFINE l_key
        RECORD
            rfs_rfsId LIKE rfs.rfsId
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.rfs_PK_RFS_1_checkUniqueConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    LET l_where = "WHERE rfs.rfsId = ? "
    LET l_sqlQuery = "SELECT COUNT(*), rfsId FROM rfs ", l_where, " GROUP BY rfsId"
    {<POINT Name="fct.rfs_PK_RFS_1_checkUniqueConstraint.init">} {</POINT>}
    TRY
        PREPARE cur_rfs_PK_RFS_1_checkUniqueConstraint FROM l_sqlQuery
        EXECUTE cur_rfs_PK_RFS_1_checkUniqueConstraint USING p_key.* INTO l_count, l_key.*
        FREE cur_rfs_PK_RFS_1_checkUniqueConstraint
        IF (NOT p_forUpdate AND l_count > 0) OR (p_forUpdate AND l_count > 0 AND p_key.* != l_key.*) THEN
            CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- rfsId: " || ERROR_BAM_00002) RETURNING errNo, errMsg
        END IF
    CATCH
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.rfs_PK_RFS_1_checkUniqueConstraint.user">} {</POINT>}

    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.rfs_PK_RFS_1_checkUniqueConstraint

{<BLOCK Name="fct.rfs_rfsId_checkColumnConstraints">}
#+ Check constraints on the "rfs.rfsId" column
#+
#+ @param p_rfsId - SERIAL - rfsId
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_rfs_rfsId_checkColumnConstraints(p_rfsId)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_rfsId LIKE rfs.rfsId
    {<POINT Name="fct.rfs_rfsId_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.rfs_rfsId_checkColumnConstraints.init">} {</POINT>}
    IF p_rfsId IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- rfsId: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.rfs_rfsId_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.rfs_rfsId_checkColumnConstraints

{<BLOCK Name="fct.rfs_clientid_checkColumnConstraints">}
#+ Check constraints on the "rfs.clientid" column
#+
#+ @param p_clientid - INTEGER - clientid
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_rfs_clientid_checkColumnConstraints(p_clientid)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_clientid LIKE rfs.clientid
    {<POINT Name="fct.rfs_clientid_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.rfs_clientid_checkColumnConstraints.init">} {</POINT>}
    IF p_clientid IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- clientid: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.rfs_clientid_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.rfs_clientid_checkColumnConstraints

{<BLOCK Name="fct.rfs_stakeholderId_checkColumnConstraints">}
#+ Check constraints on the "rfs.stakeholderId" column
#+
#+ @param p_stakeholderId - INTEGER - stakeholderId
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_rfs_stakeholderId_checkColumnConstraints(p_stakeholderId)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_stakeholderId LIKE rfs.stakeholderId
    {<POINT Name="fct.rfs_stakeholderId_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.rfs_stakeholderId_checkColumnConstraints.init">} {</POINT>}
    IF p_stakeholderId IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- stakeholderId: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.rfs_stakeholderId_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.rfs_stakeholderId_checkColumnConstraints

{<BLOCK Name="fct.rfs_offertitle_checkColumnConstraints">}
#+ Check constraints on the "rfs.offertitle" column
#+
#+ @param p_offertitle - CHAR(60) - offertitle
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_rfs_offertitle_checkColumnConstraints(p_offertitle)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_offertitle LIKE rfs.offertitle
    {<POINT Name="fct.rfs_offertitle_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.rfs_offertitle_checkColumnConstraints.init">} {</POINT>}
    IF p_offertitle IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- offertitle: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.rfs_offertitle_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.rfs_offertitle_checkColumnConstraints

{<BLOCK Name="fct.rfs_offerdate_checkColumnConstraints">}
#+ Check constraints on the "rfs.offerdate" column
#+
#+ @param p_offerdate - DATE - offerdate
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_rfs_offerdate_checkColumnConstraints(p_offerdate)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_offerdate LIKE rfs.offerdate
    {<POINT Name="fct.rfs_offerdate_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.rfs_offerdate_checkColumnConstraints.init">} {</POINT>}
    IF p_offerdate IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- offerdate: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.rfs_offerdate_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.rfs_offerdate_checkColumnConstraints

{<BLOCK Name="fct.rfs_offerstatusid_checkColumnConstraints">}
#+ Check constraints on the "rfs.offerstatusid" column
#+
#+ @param p_offerstatusid - INTEGER - offerstatusid
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_rfs_offerstatusid_checkColumnConstraints(p_offerstatusid)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_offerstatusid LIKE rfs.offerstatusid
    {<POINT Name="fct.rfs_offerstatusid_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.rfs_offerstatusid_checkColumnConstraints.init">} {</POINT>}
    IF p_offerstatusid IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- offerstatusid: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.rfs_offerstatusid_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.rfs_offerstatusid_checkColumnConstraints

{<BLOCK Name="fct.rfs_PK_RFS_1_checkFKConstraint">}
#+ Check the Foreign Key existence constraint on the "rfs"
#+
#+ @param p_data - Primary Key
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_rfs_PK_RFS_1_checkFKConstraint(p_data)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_data
        RECORD
            rfs_rfsId LIKE rfs.rfsId
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.rfs_PK_RFS_1_checkFKConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    IF NOT (p_data.rfs_rfsId IS NULL) THEN
        LET l_where = "WHERE rfs.rfsId = ? "
        LET l_sqlQuery = "SELECT COUNT(*) FROM rfs ", l_where
        {<POINT Name="fct.rfs_PK_RFS_1_checkFKConstraint.init">} {</POINT>}
        TRY
            PREPARE cur_rfs_PK_RFS_1_checkFKConstraint FROM l_sqlQuery
            EXECUTE cur_rfs_PK_RFS_1_checkFKConstraint USING p_data.* INTO l_count
            FREE cur_rfs_PK_RFS_1_checkFKConstraint
            IF (l_count == 0) THEN
                CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- rfsId: " || ERROR_BAM_00004) RETURNING errNo, errMsg
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
    END IF
    {<POINT Name="fct.rfs_PK_RFS_1_checkFKConstraint.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.rfs_PK_RFS_1_checkFKConstraint

{<BLOCK Name="fct.provinces_checkTableConstraints">}
#+ Check constraints on the "provinces" table
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_data - a row data LIKE provinces.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_provinces_checkTableConstraints(p_forUpdate, p_data)
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_data RECORD LIKE provinces.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE l_errNo INTEGER
    DEFINE l_errMsg STRING
    {<POINT Name="fct.provinces_checkTableConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.provinces_checkTableConstraints.init">} {</POINT>}

    CALL consultcompanion_dbxconstraints_provinces_provinceid_checkColumnConstraints(p_data.provinceid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL consultcompanion_dbxconstraints_provinces_provincename_checkColumnConstraints(p_data.provincename) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL consultcompanion_dbxconstraints_provinces_countryid_checkColumnConstraints(p_data.countryid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    CALL consultcompanion_dbxconstraints_provinces_PK_provinces_1_checkUniqueConstraint(p_forUpdate, p_data.provinceid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    CALL consultcompanion_dbxconstraints_country_PK_country_1_checkFKConstraint(p_data.countryid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    IF consultcompanion_events.m_DbxDataEvent_provinces_CheckTableConstraints IS NOT NULL THEN
        CALL consultcompanion_events.m_DbxDataEvent_provinces_CheckTableConstraints(p_forUpdate, p_data.*)
            RETURNING l_errNo, l_errMsg
    END IF
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    {<POINT Name="fct.provinces_checkTableConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.provinces_checkTableConstraints

{<BLOCK Name="fct.provinces_PK_provinces_1_checkUniqueConstraint">}
#+ Check the primary key uniqueness constraint on the "provinces"
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER, STRING, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_provinces_PK_provinces_1_checkUniqueConstraint(p_forUpdate, p_key)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_key
        RECORD
            provinces_provinceid LIKE provinces.provinceid
        END RECORD
    DEFINE l_key
        RECORD
            provinces_provinceid LIKE provinces.provinceid
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.provinces_PK_provinces_1_checkUniqueConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    LET l_where = "WHERE provinces.provinceid = ? "
    LET l_sqlQuery = "SELECT COUNT(*), provinceid FROM provinces ", l_where, " GROUP BY provinceid"
    {<POINT Name="fct.provinces_PK_provinces_1_checkUniqueConstraint.init">} {</POINT>}
    TRY
        PREPARE cur_provinces_PK_provinces_1_checkUniqueConstraint FROM l_sqlQuery
        EXECUTE cur_provinces_PK_provinces_1_checkUniqueConstraint USING p_key.* INTO l_count, l_key.*
        FREE cur_provinces_PK_provinces_1_checkUniqueConstraint
        IF (NOT p_forUpdate AND l_count > 0) OR (p_forUpdate AND l_count > 0 AND p_key.* != l_key.*) THEN
            CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- provinceid: " || ERROR_BAM_00002) RETURNING errNo, errMsg
        END IF
    CATCH
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.provinces_PK_provinces_1_checkUniqueConstraint.user">} {</POINT>}

    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.provinces_PK_provinces_1_checkUniqueConstraint

{<BLOCK Name="fct.provinces_provinceid_checkColumnConstraints">}
#+ Check constraints on the "provinces.provinceid" column
#+
#+ @param p_provinceid - SERIAL - provinceid
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_provinces_provinceid_checkColumnConstraints(p_provinceid)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_provinceid LIKE provinces.provinceid
    {<POINT Name="fct.provinces_provinceid_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.provinces_provinceid_checkColumnConstraints.init">} {</POINT>}
    IF p_provinceid IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- provinceid: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.provinces_provinceid_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.provinces_provinceid_checkColumnConstraints

{<BLOCK Name="fct.provinces_provincename_checkColumnConstraints">}
#+ Check constraints on the "provinces.provincename" column
#+
#+ @param p_provincename - CHAR(30) - provincename
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_provinces_provincename_checkColumnConstraints(p_provincename)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_provincename LIKE provinces.provincename
    {<POINT Name="fct.provinces_provincename_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.provinces_provincename_checkColumnConstraints.init">} {</POINT>}
    IF p_provincename IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- provincename: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.provinces_provincename_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.provinces_provincename_checkColumnConstraints

{<BLOCK Name="fct.provinces_countryid_checkColumnConstraints" Status="MODIFIED">}
#+ Check constraints on the "provinces.countryid" column
#+
#+ @param p_countryid - INTEGER - countryid
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_provinces_countryid_checkColumnConstraints(p_countryid)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_countryid LIKE provinces.countryid
    {<POINT Name="fct.provinces_countryid_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.provinces_countryid_checkColumnConstraints.init">} {</POINT>}
    IF p_countryid IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- countryid: " || p_countryid || " - "  || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.provinces_countryid_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.provinces_countryid_checkColumnConstraints

{<BLOCK Name="fct.provinces_PK_provinces_1_checkFKConstraint">}
#+ Check the Foreign Key existence constraint on the "provinces"
#+
#+ @param p_data - Primary Key
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_provinces_PK_provinces_1_checkFKConstraint(p_data)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_data
        RECORD
            provinces_provinceid LIKE provinces.provinceid
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.provinces_PK_provinces_1_checkFKConstraint.define" Status="MODIFIED">} 
    {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    IF NOT (p_data.provinces_provinceid IS NULL) THEN
        LET l_where = "WHERE provinces.provinceid = ? "
        LET l_sqlQuery = "SELECT COUNT(*) FROM provinces ", l_where
        {<POINT Name="fct.provinces_PK_provinces_1_checkFKConstraint.init">} {</POINT>}
        TRY
            PREPARE cur_provinces_PK_provinces_1_checkFKConstraint FROM l_sqlQuery
            EXECUTE cur_provinces_PK_provinces_1_checkFKConstraint USING p_data.* INTO l_count
            FREE cur_provinces_PK_provinces_1_checkFKConstraint
            IF (l_count == 0) THEN
                CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- provinceid: " || ERROR_BAM_00004) RETURNING errNo, errMsg
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
    END IF
    {<POINT Name="fct.provinces_PK_provinces_1_checkFKConstraint.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.provinces_PK_provinces_1_checkFKConstraint

{<BLOCK Name="fct.projects_checkTableConstraints">}
#+ Check constraints on the "projects" table
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_data - a row data LIKE projects.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_projects_checkTableConstraints(p_forUpdate, p_data)
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_data RECORD LIKE projects.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE l_errNo INTEGER
    DEFINE l_errMsg STRING
    {<POINT Name="fct.projects_checkTableConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.projects_checkTableConstraints.init">} {</POINT>}

    CALL consultcompanion_dbxconstraints_projects_projectId_checkColumnConstraints(p_data.projectId) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL consultcompanion_dbxconstraints_projects_projectName_checkColumnConstraints(p_data.projectName) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    CALL consultcompanion_dbxconstraints_projects_PK_projects_1_checkUniqueConstraint(p_forUpdate, p_data.projectId) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    IF consultcompanion_events.m_DbxDataEvent_projects_CheckTableConstraints IS NOT NULL THEN
        CALL consultcompanion_events.m_DbxDataEvent_projects_CheckTableConstraints(p_forUpdate, p_data.*)
            RETURNING l_errNo, l_errMsg
    END IF
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    {<POINT Name="fct.projects_checkTableConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.projects_checkTableConstraints

{<BLOCK Name="fct.projects_PK_projects_1_checkUniqueConstraint">}
#+ Check the primary key uniqueness constraint on the "projects"
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER, STRING, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_projects_PK_projects_1_checkUniqueConstraint(p_forUpdate, p_key)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_key
        RECORD
            projects_projectId LIKE projects.projectId
        END RECORD
    DEFINE l_key
        RECORD
            projects_projectId LIKE projects.projectId
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.projects_PK_projects_1_checkUniqueConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    LET l_where = "WHERE projects.projectId = ? "
    LET l_sqlQuery = "SELECT COUNT(*), projectId FROM projects ", l_where, " GROUP BY projectId"
    {<POINT Name="fct.projects_PK_projects_1_checkUniqueConstraint.init">} {</POINT>}
    TRY
        PREPARE cur_projects_PK_projects_1_checkUniqueConstraint FROM l_sqlQuery
        EXECUTE cur_projects_PK_projects_1_checkUniqueConstraint USING p_key.* INTO l_count, l_key.*
        FREE cur_projects_PK_projects_1_checkUniqueConstraint
        IF (NOT p_forUpdate AND l_count > 0) OR (p_forUpdate AND l_count > 0 AND p_key.* != l_key.*) THEN
            CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- projectId: " || ERROR_BAM_00002) RETURNING errNo, errMsg
        END IF
    CATCH
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.projects_PK_projects_1_checkUniqueConstraint.user">} {</POINT>}

    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.projects_PK_projects_1_checkUniqueConstraint

{<BLOCK Name="fct.projects_projectId_checkColumnConstraints">}
#+ Check constraints on the "projects.projectId" column
#+
#+ @param p_projectId - SERIAL - projectId
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_projects_projectId_checkColumnConstraints(p_projectId)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_projectId LIKE projects.projectId
    {<POINT Name="fct.projects_projectId_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.projects_projectId_checkColumnConstraints.init">} {</POINT>}
    IF p_projectId IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- projectId: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.projects_projectId_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.projects_projectId_checkColumnConstraints

{<BLOCK Name="fct.projects_projectName_checkColumnConstraints">}
#+ Check constraints on the "projects.projectName" column
#+
#+ @param p_projectName - CHAR(30) - projectName
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_projects_projectName_checkColumnConstraints(p_projectName)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_projectName LIKE projects.projectName
    {<POINT Name="fct.projects_projectName_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.projects_projectName_checkColumnConstraints.init">} {</POINT>}
    IF p_projectName IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- projectName: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.projects_projectName_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.projects_projectName_checkColumnConstraints

{<BLOCK Name="fct.projects_PK_projects_1_checkFKConstraint">}
#+ Check the Foreign Key existence constraint on the "projects"
#+
#+ @param p_data - Primary Key
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_projects_PK_projects_1_checkFKConstraint(p_data)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_data
        RECORD
            projects_projectId LIKE projects.projectId
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.projects_PK_projects_1_checkFKConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    IF NOT (p_data.projects_projectId IS NULL) THEN
        LET l_where = "WHERE projects.projectId = ? "
        LET l_sqlQuery = "SELECT COUNT(*) FROM projects ", l_where
        {<POINT Name="fct.projects_PK_projects_1_checkFKConstraint.init">} {</POINT>}
        TRY
            PREPARE cur_projects_PK_projects_1_checkFKConstraint FROM l_sqlQuery
            EXECUTE cur_projects_PK_projects_1_checkFKConstraint USING p_data.* INTO l_count
            FREE cur_projects_PK_projects_1_checkFKConstraint
            IF (l_count == 0) THEN
                CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- projectId: " || ERROR_BAM_00004) RETURNING errNo, errMsg
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
    END IF
    {<POINT Name="fct.projects_PK_projects_1_checkFKConstraint.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.projects_PK_projects_1_checkFKConstraint

{<BLOCK Name="fct.preferences_checkTableConstraints">}
#+ Check constraints on the "preferences" table
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_data - a row data LIKE preferences.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_preferences_checkTableConstraints(p_forUpdate, p_data)
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_data RECORD LIKE preferences.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE l_errNo INTEGER
    DEFINE l_errMsg STRING
    {<POINT Name="fct.preferences_checkTableConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.preferences_checkTableConstraints.init">} {</POINT>}

    CALL consultcompanion_dbxconstraints_preferences_seqid_checkColumnConstraints(p_data.seqid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    CALL consultcompanion_dbxconstraints_preferences_PK_preferences_1_checkUniqueConstraint(p_forUpdate, p_data.seqid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    IF consultcompanion_events.m_DbxDataEvent_preferences_CheckTableConstraints IS NOT NULL THEN
        CALL consultcompanion_events.m_DbxDataEvent_preferences_CheckTableConstraints(p_forUpdate, p_data.*)
            RETURNING l_errNo, l_errMsg
    END IF
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    {<POINT Name="fct.preferences_checkTableConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.preferences_checkTableConstraints

{<BLOCK Name="fct.preferences_PK_preferences_1_checkUniqueConstraint">}
#+ Check the primary key uniqueness constraint on the "preferences"
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER, STRING, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_preferences_PK_preferences_1_checkUniqueConstraint(p_forUpdate, p_key)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_key
        RECORD
            preferences_seqid LIKE preferences.seqid
        END RECORD
    DEFINE l_key
        RECORD
            preferences_seqid LIKE preferences.seqid
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.preferences_PK_preferences_1_checkUniqueConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    LET l_where = "WHERE preferences.seqid = ? "
    LET l_sqlQuery = "SELECT COUNT(*), seqid FROM preferences ", l_where, " GROUP BY seqid"
    {<POINT Name="fct.preferences_PK_preferences_1_checkUniqueConstraint.init">} {</POINT>}
    TRY
        PREPARE cur_preferences_PK_preferences_1_checkUniqueConstraint FROM l_sqlQuery
        EXECUTE cur_preferences_PK_preferences_1_checkUniqueConstraint USING p_key.* INTO l_count, l_key.*
        FREE cur_preferences_PK_preferences_1_checkUniqueConstraint
        IF (NOT p_forUpdate AND l_count > 0) OR (p_forUpdate AND l_count > 0 AND p_key.* != l_key.*) THEN
            CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- seqid: " || ERROR_BAM_00002) RETURNING errNo, errMsg
        END IF
    CATCH
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.preferences_PK_preferences_1_checkUniqueConstraint.user">} {</POINT>}

    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.preferences_PK_preferences_1_checkUniqueConstraint

{<BLOCK Name="fct.preferences_seqid_checkColumnConstraints">}
#+ Check constraints on the "preferences.seqid" column
#+
#+ @param p_seqid - SERIAL - seqid
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_preferences_seqid_checkColumnConstraints(p_seqid)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_seqid LIKE preferences.seqid
    {<POINT Name="fct.preferences_seqid_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.preferences_seqid_checkColumnConstraints.init">} {</POINT>}
    IF p_seqid IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- seqid: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.preferences_seqid_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.preferences_seqid_checkColumnConstraints

{<BLOCK Name="fct.preferences_PK_preferences_1_checkFKConstraint">}
#+ Check the Foreign Key existence constraint on the "preferences"
#+
#+ @param p_data - Primary Key
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_preferences_PK_preferences_1_checkFKConstraint(p_data)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_data
        RECORD
            preferences_seqid LIKE preferences.seqid
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.preferences_PK_preferences_1_checkFKConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    IF NOT (p_data.preferences_seqid IS NULL) THEN
        LET l_where = "WHERE preferences.seqid = ? "
        LET l_sqlQuery = "SELECT COUNT(*) FROM preferences ", l_where
        {<POINT Name="fct.preferences_PK_preferences_1_checkFKConstraint.init">} {</POINT>}
        TRY
            PREPARE cur_preferences_PK_preferences_1_checkFKConstraint FROM l_sqlQuery
            EXECUTE cur_preferences_PK_preferences_1_checkFKConstraint USING p_data.* INTO l_count
            FREE cur_preferences_PK_preferences_1_checkFKConstraint
            IF (l_count == 0) THEN
                CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- seqid: " || ERROR_BAM_00004) RETURNING errNo, errMsg
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
    END IF
    {<POINT Name="fct.preferences_PK_preferences_1_checkFKConstraint.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.preferences_PK_preferences_1_checkFKConstraint

{<BLOCK Name="fct.paymentterms_checkTableConstraints">}
#+ Check constraints on the "paymentterms" table
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_data - a row data LIKE paymentterms.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_paymentterms_checkTableConstraints(p_forUpdate, p_data)
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_data RECORD LIKE paymentterms.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE l_errNo INTEGER
    DEFINE l_errMsg STRING
    {<POINT Name="fct.paymentterms_checkTableConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.paymentterms_checkTableConstraints.init">} {</POINT>}

    CALL consultcompanion_dbxconstraints_paymentterms_paytermid_checkColumnConstraints(p_data.paytermid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL consultcompanion_dbxconstraints_paymentterms_paytermname_checkColumnConstraints(p_data.paytermname) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL consultcompanion_dbxconstraints_paymentterms_paytermdays_checkColumnConstraints(p_data.paytermdays) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    CALL consultcompanion_dbxconstraints_paymentterms_PK_paymentTerms_1_checkUniqueConstraint(p_forUpdate, p_data.paytermid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    IF consultcompanion_events.m_DbxDataEvent_paymentterms_CheckTableConstraints IS NOT NULL THEN
        CALL consultcompanion_events.m_DbxDataEvent_paymentterms_CheckTableConstraints(p_forUpdate, p_data.*)
            RETURNING l_errNo, l_errMsg
    END IF
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    {<POINT Name="fct.paymentterms_checkTableConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.paymentterms_checkTableConstraints

{<BLOCK Name="fct.paymentterms_PK_paymentTerms_1_checkUniqueConstraint">}
#+ Check the primary key uniqueness constraint on the "paymentterms"
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER, STRING, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_paymentterms_PK_paymentTerms_1_checkUniqueConstraint(p_forUpdate, p_key)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_key
        RECORD
            paymentterms_paytermid LIKE paymentterms.paytermid
        END RECORD
    DEFINE l_key
        RECORD
            paymentterms_paytermid LIKE paymentterms.paytermid
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.paymentterms_PK_paymentTerms_1_checkUniqueConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    LET l_where = "WHERE paymentterms.paytermid = ? "
    LET l_sqlQuery = "SELECT COUNT(*), paytermid FROM paymentterms ", l_where, " GROUP BY paytermid"
    {<POINT Name="fct.paymentterms_PK_paymentTerms_1_checkUniqueConstraint.init">} {</POINT>}
    TRY
        PREPARE cur_paymentterms_PK_paymentTerms_1_checkUniqueConstraint FROM l_sqlQuery
        EXECUTE cur_paymentterms_PK_paymentTerms_1_checkUniqueConstraint USING p_key.* INTO l_count, l_key.*
        FREE cur_paymentterms_PK_paymentTerms_1_checkUniqueConstraint
        IF (NOT p_forUpdate AND l_count > 0) OR (p_forUpdate AND l_count > 0 AND p_key.* != l_key.*) THEN
            CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- paytermid: " || ERROR_BAM_00002) RETURNING errNo, errMsg
        END IF
    CATCH
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.paymentterms_PK_paymentTerms_1_checkUniqueConstraint.user">} {</POINT>}

    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.paymentterms_PK_paymentTerms_1_checkUniqueConstraint

{<BLOCK Name="fct.paymentterms_paytermid_checkColumnConstraints">}
#+ Check constraints on the "paymentterms.paytermid" column
#+
#+ @param p_paytermid - SERIAL - paytermid
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_paymentterms_paytermid_checkColumnConstraints(p_paytermid)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_paytermid LIKE paymentterms.paytermid
    {<POINT Name="fct.paymentterms_paytermid_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.paymentterms_paytermid_checkColumnConstraints.init">} {</POINT>}
    IF p_paytermid IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- paytermid: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.paymentterms_paytermid_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.paymentterms_paytermid_checkColumnConstraints

{<BLOCK Name="fct.paymentterms_paytermname_checkColumnConstraints">}
#+ Check constraints on the "paymentterms.paytermname" column
#+
#+ @param p_paytermname - CHAR(30) - paytermname
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_paymentterms_paytermname_checkColumnConstraints(p_paytermname)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_paytermname LIKE paymentterms.paytermname
    {<POINT Name="fct.paymentterms_paytermname_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.paymentterms_paytermname_checkColumnConstraints.init">} {</POINT>}
    IF p_paytermname IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- paytermname: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.paymentterms_paytermname_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.paymentterms_paytermname_checkColumnConstraints

{<BLOCK Name="fct.paymentterms_paytermdays_checkColumnConstraints">}
#+ Check constraints on the "paymentterms.paytermdays" column
#+
#+ @param p_paytermdays - INTEGER - paytermdays
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_paymentterms_paytermdays_checkColumnConstraints(p_paytermdays)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_paytermdays LIKE paymentterms.paytermdays
    {<POINT Name="fct.paymentterms_paytermdays_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.paymentterms_paytermdays_checkColumnConstraints.init">} {</POINT>}
    IF p_paytermdays IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- paytermdays: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.paymentterms_paytermdays_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.paymentterms_paytermdays_checkColumnConstraints

{<BLOCK Name="fct.paymentterms_PK_paymentTerms_1_checkFKConstraint">}
#+ Check the Foreign Key existence constraint on the "paymentterms"
#+
#+ @param p_data - Primary Key
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_paymentterms_PK_paymentTerms_1_checkFKConstraint(p_data)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_data
        RECORD
            paymentterms_paytermid LIKE paymentterms.paytermid
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.paymentterms_PK_paymentTerms_1_checkFKConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    IF NOT (p_data.paymentterms_paytermid IS NULL) THEN
        LET l_where = "WHERE paymentterms.paytermid = ? "
        LET l_sqlQuery = "SELECT COUNT(*) FROM paymentterms ", l_where
        {<POINT Name="fct.paymentterms_PK_paymentTerms_1_checkFKConstraint.init">} {</POINT>}
        TRY
            PREPARE cur_paymentterms_PK_paymentTerms_1_checkFKConstraint FROM l_sqlQuery
            EXECUTE cur_paymentterms_PK_paymentTerms_1_checkFKConstraint USING p_data.* INTO l_count
            FREE cur_paymentterms_PK_paymentTerms_1_checkFKConstraint
            IF (l_count == 0) THEN
                CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- paytermid: " || ERROR_BAM_00004) RETURNING errNo, errMsg
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
    END IF
    {<POINT Name="fct.paymentterms_PK_paymentTerms_1_checkFKConstraint.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.paymentterms_PK_paymentTerms_1_checkFKConstraint

{<BLOCK Name="fct.offerstatuses_checkTableConstraints">}
#+ Check constraints on the "offerstatuses" table
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_data - a row data LIKE offerstatuses.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_offerstatuses_checkTableConstraints(p_forUpdate, p_data)
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_data RECORD LIKE offerstatuses.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE l_errNo INTEGER
    DEFINE l_errMsg STRING
    {<POINT Name="fct.offerstatuses_checkTableConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.offerstatuses_checkTableConstraints.init">} {</POINT>}

    CALL consultcompanion_dbxconstraints_offerstatuses_offerstatusid_checkColumnConstraints(p_data.offerstatusid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL consultcompanion_dbxconstraints_offerstatuses_offerstatusname_checkColumnConstraints(p_data.offerstatusname) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    CALL consultcompanion_dbxconstraints_offerstatuses_PK_offerStatuses_1_checkUniqueConstraint(p_forUpdate, p_data.offerstatusid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    IF consultcompanion_events.m_DbxDataEvent_offerstatuses_CheckTableConstraints IS NOT NULL THEN
        CALL consultcompanion_events.m_DbxDataEvent_offerstatuses_CheckTableConstraints(p_forUpdate, p_data.*)
            RETURNING l_errNo, l_errMsg
    END IF
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    {<POINT Name="fct.offerstatuses_checkTableConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.offerstatuses_checkTableConstraints

{<BLOCK Name="fct.offerstatuses_PK_offerStatuses_1_checkUniqueConstraint">}
#+ Check the primary key uniqueness constraint on the "offerstatuses"
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER, STRING, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_offerstatuses_PK_offerStatuses_1_checkUniqueConstraint(p_forUpdate, p_key)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_key
        RECORD
            offerstatuses_offerstatusid LIKE offerstatuses.offerstatusid
        END RECORD
    DEFINE l_key
        RECORD
            offerstatuses_offerstatusid LIKE offerstatuses.offerstatusid
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.offerstatuses_PK_offerStatuses_1_checkUniqueConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    LET l_where = "WHERE offerstatuses.offerstatusid = ? "
    LET l_sqlQuery = "SELECT COUNT(*), offerstatusid FROM offerstatuses ", l_where, " GROUP BY offerstatusid"
    {<POINT Name="fct.offerstatuses_PK_offerStatuses_1_checkUniqueConstraint.init">} {</POINT>}
    TRY
        PREPARE cur_offerstatuses_PK_offerStatuses_1_checkUniqueConstraint FROM l_sqlQuery
        EXECUTE cur_offerstatuses_PK_offerStatuses_1_checkUniqueConstraint USING p_key.* INTO l_count, l_key.*
        FREE cur_offerstatuses_PK_offerStatuses_1_checkUniqueConstraint
        IF (NOT p_forUpdate AND l_count > 0) OR (p_forUpdate AND l_count > 0 AND p_key.* != l_key.*) THEN
            CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- offerstatusid: " || ERROR_BAM_00002) RETURNING errNo, errMsg
        END IF
    CATCH
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.offerstatuses_PK_offerStatuses_1_checkUniqueConstraint.user">} {</POINT>}

    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.offerstatuses_PK_offerStatuses_1_checkUniqueConstraint

{<BLOCK Name="fct.offerstatuses_offerstatusid_checkColumnConstraints">}
#+ Check constraints on the "offerstatuses.offerstatusid" column
#+
#+ @param p_offerstatusid - SERIAL - offerstatusid
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_offerstatuses_offerstatusid_checkColumnConstraints(p_offerstatusid)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_offerstatusid LIKE offerstatuses.offerstatusid
    {<POINT Name="fct.offerstatuses_offerstatusid_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.offerstatuses_offerstatusid_checkColumnConstraints.init">} {</POINT>}
    IF p_offerstatusid IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- offerstatusid: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.offerstatuses_offerstatusid_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.offerstatuses_offerstatusid_checkColumnConstraints

{<BLOCK Name="fct.offerstatuses_offerstatusname_checkColumnConstraints">}
#+ Check constraints on the "offerstatuses.offerstatusname" column
#+
#+ @param p_offerstatusname - CHAR(30) - offerstatusname
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_offerstatuses_offerstatusname_checkColumnConstraints(p_offerstatusname)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_offerstatusname LIKE offerstatuses.offerstatusname
    {<POINT Name="fct.offerstatuses_offerstatusname_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.offerstatuses_offerstatusname_checkColumnConstraints.init">} {</POINT>}
    IF p_offerstatusname IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- offerstatusname: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.offerstatuses_offerstatusname_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.offerstatuses_offerstatusname_checkColumnConstraints

{<BLOCK Name="fct.offerstatuses_PK_offerStatuses_1_checkFKConstraint">}
#+ Check the Foreign Key existence constraint on the "offerstatuses"
#+
#+ @param p_data - Primary Key
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_offerstatuses_PK_offerStatuses_1_checkFKConstraint(p_data)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_data
        RECORD
            offerstatuses_offerstatusid LIKE offerstatuses.offerstatusid
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.offerstatuses_PK_offerStatuses_1_checkFKConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    IF NOT (p_data.offerstatuses_offerstatusid IS NULL) THEN
        LET l_where = "WHERE offerstatuses.offerstatusid = ? "
        LET l_sqlQuery = "SELECT COUNT(*) FROM offerstatuses ", l_where
        {<POINT Name="fct.offerstatuses_PK_offerStatuses_1_checkFKConstraint.init">} {</POINT>}
        TRY
            PREPARE cur_offerstatuses_PK_offerStatuses_1_checkFKConstraint FROM l_sqlQuery
            EXECUTE cur_offerstatuses_PK_offerStatuses_1_checkFKConstraint USING p_data.* INTO l_count
            FREE cur_offerstatuses_PK_offerStatuses_1_checkFKConstraint
            IF (l_count == 0) THEN
                CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- offerstatusid: " || ERROR_BAM_00004) RETURNING errNo, errMsg
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
    END IF
    {<POINT Name="fct.offerstatuses_PK_offerStatuses_1_checkFKConstraint.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.offerstatuses_PK_offerStatuses_1_checkFKConstraint

{<BLOCK Name="fct.employeetypes_checkTableConstraints">}
#+ Check constraints on the "employeetypes" table
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_data - a row data LIKE employeetypes.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_employeetypes_checkTableConstraints(p_forUpdate, p_data)
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_data RECORD LIKE employeetypes.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE l_errNo INTEGER
    DEFINE l_errMsg STRING
    {<POINT Name="fct.employeetypes_checkTableConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.employeetypes_checkTableConstraints.init">} {</POINT>}

    CALL consultcompanion_dbxconstraints_employeetypes_emptypeid_checkColumnConstraints(p_data.emptypeid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL consultcompanion_dbxconstraints_employeetypes_emptypename_checkColumnConstraints(p_data.emptypename) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    CALL consultcompanion_dbxconstraints_employeetypes_PK_employeeTypes_1_checkUniqueConstraint(p_forUpdate, p_data.emptypeid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    IF consultcompanion_events.m_DbxDataEvent_employeetypes_CheckTableConstraints IS NOT NULL THEN
        CALL consultcompanion_events.m_DbxDataEvent_employeetypes_CheckTableConstraints(p_forUpdate, p_data.*)
            RETURNING l_errNo, l_errMsg
    END IF
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    {<POINT Name="fct.employeetypes_checkTableConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.employeetypes_checkTableConstraints

{<BLOCK Name="fct.employeetypes_PK_employeeTypes_1_checkUniqueConstraint">}
#+ Check the primary key uniqueness constraint on the "employeetypes"
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER, STRING, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_employeetypes_PK_employeeTypes_1_checkUniqueConstraint(p_forUpdate, p_key)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_key
        RECORD
            employeetypes_emptypeid LIKE employeetypes.emptypeid
        END RECORD
    DEFINE l_key
        RECORD
            employeetypes_emptypeid LIKE employeetypes.emptypeid
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.employeetypes_PK_employeeTypes_1_checkUniqueConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    LET l_where = "WHERE employeetypes.emptypeid = ? "
    LET l_sqlQuery = "SELECT COUNT(*), emptypeid FROM employeetypes ", l_where, " GROUP BY emptypeid"
    {<POINT Name="fct.employeetypes_PK_employeeTypes_1_checkUniqueConstraint.init">} {</POINT>}
    TRY
        PREPARE cur_employeetypes_PK_employeeTypes_1_checkUniqueConstraint FROM l_sqlQuery
        EXECUTE cur_employeetypes_PK_employeeTypes_1_checkUniqueConstraint USING p_key.* INTO l_count, l_key.*
        FREE cur_employeetypes_PK_employeeTypes_1_checkUniqueConstraint
        IF (NOT p_forUpdate AND l_count > 0) OR (p_forUpdate AND l_count > 0 AND p_key.* != l_key.*) THEN
            CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- emptypeid: " || ERROR_BAM_00002) RETURNING errNo, errMsg
        END IF
    CATCH
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.employeetypes_PK_employeeTypes_1_checkUniqueConstraint.user">} {</POINT>}

    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.employeetypes_PK_employeeTypes_1_checkUniqueConstraint

{<BLOCK Name="fct.employeetypes_emptypeid_checkColumnConstraints">}
#+ Check constraints on the "employeetypes.emptypeid" column
#+
#+ @param p_emptypeid - SERIAL - emptypeid
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_employeetypes_emptypeid_checkColumnConstraints(p_emptypeid)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_emptypeid LIKE employeetypes.emptypeid
    {<POINT Name="fct.employeetypes_emptypeid_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.employeetypes_emptypeid_checkColumnConstraints.init">} {</POINT>}
    IF p_emptypeid IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- emptypeid: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.employeetypes_emptypeid_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.employeetypes_emptypeid_checkColumnConstraints

{<BLOCK Name="fct.employeetypes_emptypename_checkColumnConstraints">}
#+ Check constraints on the "employeetypes.emptypename" column
#+
#+ @param p_emptypename - CHAR(30) - emptypename
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_employeetypes_emptypename_checkColumnConstraints(p_emptypename)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_emptypename LIKE employeetypes.emptypename
    {<POINT Name="fct.employeetypes_emptypename_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.employeetypes_emptypename_checkColumnConstraints.init">} {</POINT>}
    IF p_emptypename IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- emptypename: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.employeetypes_emptypename_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.employeetypes_emptypename_checkColumnConstraints

{<BLOCK Name="fct.employeetypes_PK_employeeTypes_1_checkFKConstraint">}
#+ Check the Foreign Key existence constraint on the "employeetypes"
#+
#+ @param p_data - Primary Key
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_employeetypes_PK_employeeTypes_1_checkFKConstraint(p_data)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_data
        RECORD
            employeetypes_emptypeid LIKE employeetypes.emptypeid
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.employeetypes_PK_employeeTypes_1_checkFKConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    IF NOT (p_data.employeetypes_emptypeid IS NULL) THEN
        LET l_where = "WHERE employeetypes.emptypeid = ? "
        LET l_sqlQuery = "SELECT COUNT(*) FROM employeetypes ", l_where
        {<POINT Name="fct.employeetypes_PK_employeeTypes_1_checkFKConstraint.init">} {</POINT>}
        TRY
            PREPARE cur_employeetypes_PK_employeeTypes_1_checkFKConstraint FROM l_sqlQuery
            EXECUTE cur_employeetypes_PK_employeeTypes_1_checkFKConstraint USING p_data.* INTO l_count
            FREE cur_employeetypes_PK_employeeTypes_1_checkFKConstraint
            IF (l_count == 0) THEN
                CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- emptypeid: " || ERROR_BAM_00004) RETURNING errNo, errMsg
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
    END IF
    {<POINT Name="fct.employeetypes_PK_employeeTypes_1_checkFKConstraint.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.employeetypes_PK_employeeTypes_1_checkFKConstraint

{<BLOCK Name="fct.employees_checkTableConstraints">}
#+ Check constraints on the "employees" table
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_data - a row data LIKE employees.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_employees_checkTableConstraints(p_forUpdate, p_data)
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_data RECORD LIKE employees.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE l_errNo INTEGER
    DEFINE l_errMsg STRING
    {<POINT Name="fct.employees_checkTableConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.employees_checkTableConstraints.init">} {</POINT>}

    CALL consultcompanion_dbxconstraints_employees_employeeid_checkColumnConstraints(p_data.employeeid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL consultcompanion_dbxconstraints_employees_empname_checkColumnConstraints(p_data.empname) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL consultcompanion_dbxconstraints_employees_emptype_checkColumnConstraints(p_data.emptype) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL consultcompanion_dbxconstraints_employees_address1_checkColumnConstraints(p_data.address1) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL consultcompanion_dbxconstraints_employees_city_checkColumnConstraints(p_data.city) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL consultcompanion_dbxconstraints_employees_provinceId_checkColumnConstraints(p_data.provinceId) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL consultcompanion_dbxconstraints_employees_postalzip_checkColumnConstraints(p_data.postalzip) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL consultcompanion_dbxconstraints_employees_primaryphone_checkColumnConstraints(p_data.primaryphone) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL consultcompanion_dbxconstraints_employees_dayRate_checkColumnConstraints(p_data.dayRate) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL consultcompanion_dbxconstraints_employees_countryid_checkColumnConstraints(p_data.countryid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    CALL consultcompanion_dbxconstraints_employees_PK_employees_1_checkUniqueConstraint(p_forUpdate, p_data.employeeid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    CALL consultcompanion_dbxconstraints_country_PK_country_1_checkFKConstraint(p_data.countryid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL consultcompanion_dbxconstraints_employeetypes_PK_employeeTypes_1_checkFKConstraint(p_data.emptype) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL consultcompanion_dbxconstraints_provinces_PK_provinces_1_checkFKConstraint(p_data.provinceId) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    IF consultcompanion_events.m_DbxDataEvent_employees_CheckTableConstraints IS NOT NULL THEN
        CALL consultcompanion_events.m_DbxDataEvent_employees_CheckTableConstraints(p_forUpdate, p_data.*)
            RETURNING l_errNo, l_errMsg
    END IF
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    {<POINT Name="fct.employees_checkTableConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.employees_checkTableConstraints

{<BLOCK Name="fct.employees_PK_employees_1_checkUniqueConstraint">}
#+ Check the primary key uniqueness constraint on the "employees"
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER, STRING, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_employees_PK_employees_1_checkUniqueConstraint(p_forUpdate, p_key)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_key
        RECORD
            employees_employeeid LIKE employees.employeeid
        END RECORD
    DEFINE l_key
        RECORD
            employees_employeeid LIKE employees.employeeid
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.employees_PK_employees_1_checkUniqueConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    LET l_where = "WHERE employees.employeeid = ? "
    LET l_sqlQuery = "SELECT COUNT(*), employeeid FROM employees ", l_where, " GROUP BY employeeid"
    {<POINT Name="fct.employees_PK_employees_1_checkUniqueConstraint.init">} {</POINT>}
    TRY
        PREPARE cur_employees_PK_employees_1_checkUniqueConstraint FROM l_sqlQuery
        EXECUTE cur_employees_PK_employees_1_checkUniqueConstraint USING p_key.* INTO l_count, l_key.*
        FREE cur_employees_PK_employees_1_checkUniqueConstraint
        IF (NOT p_forUpdate AND l_count > 0) OR (p_forUpdate AND l_count > 0 AND p_key.* != l_key.*) THEN
            CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- employeeid: " || ERROR_BAM_00002) RETURNING errNo, errMsg
        END IF
    CATCH
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.employees_PK_employees_1_checkUniqueConstraint.user">} {</POINT>}

    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.employees_PK_employees_1_checkUniqueConstraint

{<BLOCK Name="fct.employees_employeeid_checkColumnConstraints">}
#+ Check constraints on the "employees.employeeid" column
#+
#+ @param p_employeeid - SERIAL - employeeid
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_employees_employeeid_checkColumnConstraints(p_employeeid)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_employeeid LIKE employees.employeeid
    {<POINT Name="fct.employees_employeeid_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.employees_employeeid_checkColumnConstraints.init">} {</POINT>}
    IF p_employeeid IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- employeeid: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.employees_employeeid_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.employees_employeeid_checkColumnConstraints

{<BLOCK Name="fct.employees_empname_checkColumnConstraints">}
#+ Check constraints on the "employees.empname" column
#+
#+ @param p_empname - CHAR(30) - empname
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_employees_empname_checkColumnConstraints(p_empname)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_empname LIKE employees.empname
    {<POINT Name="fct.employees_empname_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.employees_empname_checkColumnConstraints.init">} {</POINT>}
    IF p_empname IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- empname: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.employees_empname_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.employees_empname_checkColumnConstraints

{<BLOCK Name="fct.employees_emptype_checkColumnConstraints">}
#+ Check constraints on the "employees.emptype" column
#+
#+ @param p_emptype - INTEGER - emptype
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_employees_emptype_checkColumnConstraints(p_emptype)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_emptype LIKE employees.emptype
    {<POINT Name="fct.employees_emptype_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.employees_emptype_checkColumnConstraints.init">} {</POINT>}
    IF p_emptype IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- emptype: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.employees_emptype_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.employees_emptype_checkColumnConstraints

{<BLOCK Name="fct.employees_address1_checkColumnConstraints">}
#+ Check constraints on the "employees.address1" column
#+
#+ @param p_address1 - CHAR(60) - address1
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_employees_address1_checkColumnConstraints(p_address1)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_address1 LIKE employees.address1
    {<POINT Name="fct.employees_address1_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.employees_address1_checkColumnConstraints.init">} {</POINT>}
    IF p_address1 IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- address1: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.employees_address1_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.employees_address1_checkColumnConstraints

{<BLOCK Name="fct.employees_city_checkColumnConstraints">}
#+ Check constraints on the "employees.city" column
#+
#+ @param p_city - CHAR(30) - city
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_employees_city_checkColumnConstraints(p_city)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_city LIKE employees.city
    {<POINT Name="fct.employees_city_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.employees_city_checkColumnConstraints.init">} {</POINT>}
    IF p_city IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- city: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.employees_city_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.employees_city_checkColumnConstraints

{<BLOCK Name="fct.employees_provinceId_checkColumnConstraints">}
#+ Check constraints on the "employees.provinceId" column
#+
#+ @param p_provinceId - INTEGER - provinceId
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_employees_provinceId_checkColumnConstraints(p_provinceId)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_provinceId LIKE employees.provinceId
    {<POINT Name="fct.employees_provinceId_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.employees_provinceId_checkColumnConstraints.init">} {</POINT>}
    IF p_provinceId IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- provinceId: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.employees_provinceId_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.employees_provinceId_checkColumnConstraints

{<BLOCK Name="fct.employees_postalzip_checkColumnConstraints">}
#+ Check constraints on the "employees.postalzip" column
#+
#+ @param p_postalzip - CHAR(10) - postalzip
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_employees_postalzip_checkColumnConstraints(p_postalzip)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_postalzip LIKE employees.postalzip
    {<POINT Name="fct.employees_postalzip_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.employees_postalzip_checkColumnConstraints.init">} {</POINT>}
    IF p_postalzip IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- postalzip: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.employees_postalzip_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.employees_postalzip_checkColumnConstraints

{<BLOCK Name="fct.employees_primaryphone_checkColumnConstraints">}
#+ Check constraints on the "employees.primaryphone" column
#+
#+ @param p_primaryphone - CHAR(1) - primaryphone
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_employees_primaryphone_checkColumnConstraints(p_primaryphone)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_primaryphone LIKE employees.primaryphone
    {<POINT Name="fct.employees_primaryphone_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.employees_primaryphone_checkColumnConstraints.init">} {</POINT>}
    IF p_primaryphone IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- primaryphone: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.employees_primaryphone_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.employees_primaryphone_checkColumnConstraints

{<BLOCK Name="fct.employees_dayRate_checkColumnConstraints">}
#+ Check constraints on the "employees.dayRate" column
#+
#+ @param p_dayRate - DECIMAL(5,2) - dayRate
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_employees_dayRate_checkColumnConstraints(p_dayRate)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_dayRate LIKE employees.dayRate
    {<POINT Name="fct.employees_dayRate_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.employees_dayRate_checkColumnConstraints.init">} {</POINT>}
    IF p_dayRate IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- dayRate: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.employees_dayRate_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.employees_dayRate_checkColumnConstraints

{<BLOCK Name="fct.employees_countryid_checkColumnConstraints">}
#+ Check constraints on the "employees.countryid" column
#+
#+ @param p_countryid - INTEGER - countryid
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_employees_countryid_checkColumnConstraints(p_countryid)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_countryid LIKE employees.countryid
    {<POINT Name="fct.employees_countryid_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.employees_countryid_checkColumnConstraints.init">} {</POINT>}
    IF p_countryid IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- countryid: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.employees_countryid_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.employees_countryid_checkColumnConstraints

{<BLOCK Name="fct.employees_PK_employees_1_checkFKConstraint">}
#+ Check the Foreign Key existence constraint on the "employees"
#+
#+ @param p_data - Primary Key
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_employees_PK_employees_1_checkFKConstraint(p_data)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_data
        RECORD
            employees_employeeid LIKE employees.employeeid
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.employees_PK_employees_1_checkFKConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    IF NOT (p_data.employees_employeeid IS NULL) THEN
        LET l_where = "WHERE employees.employeeid = ? "
        LET l_sqlQuery = "SELECT COUNT(*) FROM employees ", l_where
        {<POINT Name="fct.employees_PK_employees_1_checkFKConstraint.init">} {</POINT>}
        TRY
            PREPARE cur_employees_PK_employees_1_checkFKConstraint FROM l_sqlQuery
            EXECUTE cur_employees_PK_employees_1_checkFKConstraint USING p_data.* INTO l_count
            FREE cur_employees_PK_employees_1_checkFKConstraint
            IF (l_count == 0) THEN
                CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- employeeid: " || ERROR_BAM_00004) RETURNING errNo, errMsg
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
    END IF
    {<POINT Name="fct.employees_PK_employees_1_checkFKConstraint.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.employees_PK_employees_1_checkFKConstraint

{<BLOCK Name="fct.country_checkTableConstraints">}
#+ Check constraints on the "country" table
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_data - a row data LIKE country.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_country_checkTableConstraints(p_forUpdate, p_data)
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_data RECORD LIKE country.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE l_errNo INTEGER
    DEFINE l_errMsg STRING
    {<POINT Name="fct.country_checkTableConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.country_checkTableConstraints.init">} {</POINT>}

    CALL consultcompanion_dbxconstraints_country_countryid_checkColumnConstraints(p_data.countryid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL consultcompanion_dbxconstraints_country_countryname_checkColumnConstraints(p_data.countryname) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    CALL consultcompanion_dbxconstraints_country_PK_country_1_checkUniqueConstraint(p_forUpdate, p_data.countryid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    IF consultcompanion_events.m_DbxDataEvent_country_CheckTableConstraints IS NOT NULL THEN
        CALL consultcompanion_events.m_DbxDataEvent_country_CheckTableConstraints(p_forUpdate, p_data.*)
            RETURNING l_errNo, l_errMsg
    END IF
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    {<POINT Name="fct.country_checkTableConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.country_checkTableConstraints

{<BLOCK Name="fct.country_PK_country_1_checkUniqueConstraint">}
#+ Check the primary key uniqueness constraint on the "country"
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER, STRING, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_country_PK_country_1_checkUniqueConstraint(p_forUpdate, p_key)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_key
        RECORD
            country_countryid LIKE country.countryid
        END RECORD
    DEFINE l_key
        RECORD
            country_countryid LIKE country.countryid
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.country_PK_country_1_checkUniqueConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    LET l_where = "WHERE country.countryid = ? "
    LET l_sqlQuery = "SELECT COUNT(*), countryid FROM country ", l_where, " GROUP BY countryid"
    {<POINT Name="fct.country_PK_country_1_checkUniqueConstraint.init">} {</POINT>}
    TRY
        PREPARE cur_country_PK_country_1_checkUniqueConstraint FROM l_sqlQuery
        EXECUTE cur_country_PK_country_1_checkUniqueConstraint USING p_key.* INTO l_count, l_key.*
        FREE cur_country_PK_country_1_checkUniqueConstraint
        IF (NOT p_forUpdate AND l_count > 0) OR (p_forUpdate AND l_count > 0 AND p_key.* != l_key.*) THEN
            CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- countryid: " || ERROR_BAM_00002) RETURNING errNo, errMsg
        END IF
    CATCH
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.country_PK_country_1_checkUniqueConstraint.user">} {</POINT>}

    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.country_PK_country_1_checkUniqueConstraint

{<BLOCK Name="fct.country_countryid_checkColumnConstraints">}
#+ Check constraints on the "country.countryid" column
#+
#+ @param p_countryid - SERIAL - countryid
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_country_countryid_checkColumnConstraints(p_countryid)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_countryid LIKE country.countryid
    {<POINT Name="fct.country_countryid_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.country_countryid_checkColumnConstraints.init">} {</POINT>}
    IF p_countryid IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- countryid: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.country_countryid_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.country_countryid_checkColumnConstraints

{<BLOCK Name="fct.country_countryname_checkColumnConstraints">}
#+ Check constraints on the "country.countryname" column
#+
#+ @param p_countryname - CHAR(30) - countryname
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_country_countryname_checkColumnConstraints(p_countryname)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_countryname LIKE country.countryname
    {<POINT Name="fct.country_countryname_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.country_countryname_checkColumnConstraints.init">} {</POINT>}
    IF p_countryname IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- countryname: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.country_countryname_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.country_countryname_checkColumnConstraints

{<BLOCK Name="fct.country_PK_country_1_checkFKConstraint">}
#+ Check the Foreign Key existence constraint on the "country"
#+
#+ @param p_data - Primary Key
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_country_PK_country_1_checkFKConstraint(p_data)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_data
        RECORD
            country_countryid LIKE country.countryid
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.country_PK_country_1_checkFKConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    IF NOT (p_data.country_countryid IS NULL) THEN
        LET l_where = "WHERE country.countryid = ? "
        LET l_sqlQuery = "SELECT COUNT(*) FROM country ", l_where
        {<POINT Name="fct.country_PK_country_1_checkFKConstraint.init">} {</POINT>}
        TRY
            PREPARE cur_country_PK_country_1_checkFKConstraint FROM l_sqlQuery
            EXECUTE cur_country_PK_country_1_checkFKConstraint USING p_data.* INTO l_count
            FREE cur_country_PK_country_1_checkFKConstraint
            IF (l_count == 0) THEN
                CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- countryid: " || ERROR_BAM_00004) RETURNING errNo, errMsg
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
    END IF
    {<POINT Name="fct.country_PK_country_1_checkFKConstraint.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.country_PK_country_1_checkFKConstraint

{<BLOCK Name="fct.clienttypes_checkTableConstraints">}
#+ Check constraints on the "clienttypes" table
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_data - a row data LIKE clienttypes.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_clienttypes_checkTableConstraints(p_forUpdate, p_data)
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_data RECORD LIKE clienttypes.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE l_errNo INTEGER
    DEFINE l_errMsg STRING
    {<POINT Name="fct.clienttypes_checkTableConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.clienttypes_checkTableConstraints.init">} {</POINT>}

    CALL consultcompanion_dbxconstraints_clienttypes_clienttypeid_checkColumnConstraints(p_data.clienttypeid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL consultcompanion_dbxconstraints_clienttypes_clientypename_checkColumnConstraints(p_data.clientypename) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    CALL consultcompanion_dbxconstraints_clienttypes_PK_clientTypes_1_checkUniqueConstraint(p_forUpdate, p_data.clienttypeid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    IF consultcompanion_events.m_DbxDataEvent_clienttypes_CheckTableConstraints IS NOT NULL THEN
        CALL consultcompanion_events.m_DbxDataEvent_clienttypes_CheckTableConstraints(p_forUpdate, p_data.*)
            RETURNING l_errNo, l_errMsg
    END IF
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    {<POINT Name="fct.clienttypes_checkTableConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.clienttypes_checkTableConstraints

{<BLOCK Name="fct.clienttypes_PK_clientTypes_1_checkUniqueConstraint">}
#+ Check the primary key uniqueness constraint on the "clienttypes"
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER, STRING, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_clienttypes_PK_clientTypes_1_checkUniqueConstraint(p_forUpdate, p_key)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_key
        RECORD
            clienttypes_clienttypeid LIKE clienttypes.clienttypeid
        END RECORD
    DEFINE l_key
        RECORD
            clienttypes_clienttypeid LIKE clienttypes.clienttypeid
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.clienttypes_PK_clientTypes_1_checkUniqueConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    LET l_where = "WHERE clienttypes.clienttypeid = ? "
    LET l_sqlQuery = "SELECT COUNT(*), clienttypeid FROM clienttypes ", l_where, " GROUP BY clienttypeid"
    {<POINT Name="fct.clienttypes_PK_clientTypes_1_checkUniqueConstraint.init">} {</POINT>}
    TRY
        PREPARE cur_clienttypes_PK_clientTypes_1_checkUniqueConstraint FROM l_sqlQuery
        EXECUTE cur_clienttypes_PK_clientTypes_1_checkUniqueConstraint USING p_key.* INTO l_count, l_key.*
        FREE cur_clienttypes_PK_clientTypes_1_checkUniqueConstraint
        IF (NOT p_forUpdate AND l_count > 0) OR (p_forUpdate AND l_count > 0 AND p_key.* != l_key.*) THEN
            CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- clienttypeid: " || ERROR_BAM_00002) RETURNING errNo, errMsg
        END IF
    CATCH
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.clienttypes_PK_clientTypes_1_checkUniqueConstraint.user">} {</POINT>}

    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.clienttypes_PK_clientTypes_1_checkUniqueConstraint

{<BLOCK Name="fct.clienttypes_clienttypeid_checkColumnConstraints">}
#+ Check constraints on the "clienttypes.clienttypeid" column
#+
#+ @param p_clienttypeid - SERIAL - clienttypeid
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_clienttypes_clienttypeid_checkColumnConstraints(p_clienttypeid)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_clienttypeid LIKE clienttypes.clienttypeid
    {<POINT Name="fct.clienttypes_clienttypeid_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.clienttypes_clienttypeid_checkColumnConstraints.init">} {</POINT>}
    IF p_clienttypeid IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- clienttypeid: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.clienttypes_clienttypeid_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.clienttypes_clienttypeid_checkColumnConstraints

{<BLOCK Name="fct.clienttypes_clientypename_checkColumnConstraints">}
#+ Check constraints on the "clienttypes.clientypename" column
#+
#+ @param p_clientypename - CHAR(30) - clientypename
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_clienttypes_clientypename_checkColumnConstraints(p_clientypename)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_clientypename LIKE clienttypes.clientypename
    {<POINT Name="fct.clienttypes_clientypename_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.clienttypes_clientypename_checkColumnConstraints.init">} {</POINT>}
    IF p_clientypename IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- clientypename: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.clienttypes_clientypename_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.clienttypes_clientypename_checkColumnConstraints

{<BLOCK Name="fct.clienttypes_PK_clientTypes_1_checkFKConstraint">}
#+ Check the Foreign Key existence constraint on the "clienttypes"
#+
#+ @param p_data - Primary Key
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_clienttypes_PK_clientTypes_1_checkFKConstraint(p_data)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_data
        RECORD
            clienttypes_clienttypeid LIKE clienttypes.clienttypeid
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.clienttypes_PK_clientTypes_1_checkFKConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    IF NOT (p_data.clienttypes_clienttypeid IS NULL) THEN
        LET l_where = "WHERE clienttypes.clienttypeid = ? "
        LET l_sqlQuery = "SELECT COUNT(*) FROM clienttypes ", l_where
        {<POINT Name="fct.clienttypes_PK_clientTypes_1_checkFKConstraint.init">} {</POINT>}
        TRY
            PREPARE cur_clienttypes_PK_clientTypes_1_checkFKConstraint FROM l_sqlQuery
            EXECUTE cur_clienttypes_PK_clientTypes_1_checkFKConstraint USING p_data.* INTO l_count
            FREE cur_clienttypes_PK_clientTypes_1_checkFKConstraint
            IF (l_count == 0) THEN
                CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- clienttypeid: " || ERROR_BAM_00004) RETURNING errNo, errMsg
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
    END IF
    {<POINT Name="fct.clienttypes_PK_clientTypes_1_checkFKConstraint.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.clienttypes_PK_clientTypes_1_checkFKConstraint

{<BLOCK Name="fct.clientstakeholders_checkTableConstraints">}
#+ Check constraints on the "clientstakeholders" table
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_data - a row data LIKE clientstakeholders.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_clientstakeholders_checkTableConstraints(p_forUpdate, p_data)
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_data RECORD LIKE clientstakeholders.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE l_errNo INTEGER
    DEFINE l_errMsg STRING
    {<POINT Name="fct.clientstakeholders_checkTableConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.clientstakeholders_checkTableConstraints.init">} {</POINT>}

    CALL consultcompanion_dbxconstraints_clientstakeholders_clientId_checkColumnConstraints(p_data.clientId) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL consultcompanion_dbxconstraints_clientstakeholders_stakeholderId_checkColumnConstraints(p_data.stakeholderId) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL consultcompanion_dbxconstraints_clientstakeholders_stakeholdername_checkColumnConstraints(p_data.stakeholdername) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    CALL consultcompanion_dbxconstraints_clientstakeholders_PK_clientStakeholders_1_checkUniqueConstraint(p_forUpdate, p_data.stakeholderId) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    CALL consultcompanion_dbxconstraints_clients_PK_clients_1_checkFKConstraint(p_data.clientId) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    IF consultcompanion_events.m_DbxDataEvent_clientstakeholders_CheckTableConstraints IS NOT NULL THEN
        CALL consultcompanion_events.m_DbxDataEvent_clientstakeholders_CheckTableConstraints(p_forUpdate, p_data.*)
            RETURNING l_errNo, l_errMsg
    END IF
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    {<POINT Name="fct.clientstakeholders_checkTableConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.clientstakeholders_checkTableConstraints

{<BLOCK Name="fct.clientstakeholders_PK_clientStakeholders_1_checkUniqueConstraint">}
#+ Check the primary key uniqueness constraint on the "clientstakeholders"
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER, STRING, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_clientstakeholders_PK_clientStakeholders_1_checkUniqueConstraint(p_forUpdate, p_key)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_key
        RECORD
            clientstakeholders_stakeholderId LIKE clientstakeholders.stakeholderId
        END RECORD
    DEFINE l_key
        RECORD
            clientstakeholders_stakeholderId LIKE clientstakeholders.stakeholderId
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.clientstakeholders_PK_clientStakeholders_1_checkUniqueConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    LET l_where = "WHERE clientstakeholders.stakeholderId = ? "
    LET l_sqlQuery = "SELECT COUNT(*), stakeholderId FROM clientstakeholders ", l_where, " GROUP BY stakeholderId"
    {<POINT Name="fct.clientstakeholders_PK_clientStakeholders_1_checkUniqueConstraint.init">} {</POINT>}
    TRY
        PREPARE cur_clientstakeholders_PK_clientStakeholders_1_checkUniqueConstraint FROM l_sqlQuery
        EXECUTE cur_clientstakeholders_PK_clientStakeholders_1_checkUniqueConstraint USING p_key.* INTO l_count, l_key.*
        FREE cur_clientstakeholders_PK_clientStakeholders_1_checkUniqueConstraint
        IF (NOT p_forUpdate AND l_count > 0) OR (p_forUpdate AND l_count > 0 AND p_key.* != l_key.*) THEN
            CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- stakeholderId: " || ERROR_BAM_00002) RETURNING errNo, errMsg
        END IF
    CATCH
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.clientstakeholders_PK_clientStakeholders_1_checkUniqueConstraint.user">} {</POINT>}

    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.clientstakeholders_PK_clientStakeholders_1_checkUniqueConstraint

{<BLOCK Name="fct.clientstakeholders_clientId_checkColumnConstraints">}
#+ Check constraints on the "clientstakeholders.clientId" column
#+
#+ @param p_clientId - INTEGER - clientId
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_clientstakeholders_clientId_checkColumnConstraints(p_clientId)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_clientId LIKE clientstakeholders.clientId
    {<POINT Name="fct.clientstakeholders_clientId_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.clientstakeholders_clientId_checkColumnConstraints.init">} {</POINT>}
    IF p_clientId IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- clientId: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.clientstakeholders_clientId_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.clientstakeholders_clientId_checkColumnConstraints

{<BLOCK Name="fct.clientstakeholders_stakeholderId_checkColumnConstraints">}
#+ Check constraints on the "clientstakeholders.stakeholderId" column
#+
#+ @param p_stakeholderId - SERIAL - stakeholderId
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_clientstakeholders_stakeholderId_checkColumnConstraints(p_stakeholderId)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_stakeholderId LIKE clientstakeholders.stakeholderId
    {<POINT Name="fct.clientstakeholders_stakeholderId_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.clientstakeholders_stakeholderId_checkColumnConstraints.init">} {</POINT>}
    IF p_stakeholderId IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- stakeholderId: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.clientstakeholders_stakeholderId_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.clientstakeholders_stakeholderId_checkColumnConstraints

{<BLOCK Name="fct.clientstakeholders_stakeholdername_checkColumnConstraints">}
#+ Check constraints on the "clientstakeholders.stakeholdername" column
#+
#+ @param p_stakeholdername - CHAR(30) - stakeholdername
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_clientstakeholders_stakeholdername_checkColumnConstraints(p_stakeholdername)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_stakeholdername LIKE clientstakeholders.stakeholdername
    {<POINT Name="fct.clientstakeholders_stakeholdername_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.clientstakeholders_stakeholdername_checkColumnConstraints.init">} {</POINT>}
    IF p_stakeholdername IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- stakeholdername: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.clientstakeholders_stakeholdername_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.clientstakeholders_stakeholdername_checkColumnConstraints

{<BLOCK Name="fct.clientstakeholders_PK_clientStakeholders_1_checkFKConstraint">}
#+ Check the Foreign Key existence constraint on the "clientstakeholders"
#+
#+ @param p_data - Primary Key
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_clientstakeholders_PK_clientStakeholders_1_checkFKConstraint(p_data)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_data
        RECORD
            clientstakeholders_stakeholderId LIKE clientstakeholders.stakeholderId
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.clientstakeholders_PK_clientStakeholders_1_checkFKConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    IF NOT (p_data.clientstakeholders_stakeholderId IS NULL) THEN
        LET l_where = "WHERE clientstakeholders.stakeholderId = ? "
        LET l_sqlQuery = "SELECT COUNT(*) FROM clientstakeholders ", l_where
        {<POINT Name="fct.clientstakeholders_PK_clientStakeholders_1_checkFKConstraint.init">} {</POINT>}
        TRY
            PREPARE cur_clientstakeholders_PK_clientStakeholders_1_checkFKConstraint FROM l_sqlQuery
            EXECUTE cur_clientstakeholders_PK_clientStakeholders_1_checkFKConstraint USING p_data.* INTO l_count
            FREE cur_clientstakeholders_PK_clientStakeholders_1_checkFKConstraint
            IF (l_count == 0) THEN
                CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- stakeholderId: " || ERROR_BAM_00004) RETURNING errNo, errMsg
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
    END IF
    {<POINT Name="fct.clientstakeholders_PK_clientStakeholders_1_checkFKConstraint.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.clientstakeholders_PK_clientStakeholders_1_checkFKConstraint

{<BLOCK Name="fct.clients_checkTableConstraints" Status="MODIFIED">}
#+ Check constraints on the "clients" table
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_data - a row data LIKE clients.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_clients_checkTableConstraints(p_forUpdate, p_data)
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_data RECORD LIKE clients.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE l_errNo INTEGER
    DEFINE l_errMsg STRING
    {<POINT Name="fct.clients_checkTableConstraints.define" Status="MODIFIED">} 
    DEFINE l_scratch string
    {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.clients_checkTableConstraints.init">} {</POINT>}

    CALL consultcompanion_dbxconstraints_clients_clientid_checkColumnConstraints(p_data.clientid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL consultcompanion_dbxconstraints_clients_clientname_checkColumnConstraints(p_data.clientname) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL consultcompanion_dbxconstraints_clients_address1_checkColumnConstraints(p_data.address1) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL consultcompanion_dbxconstraints_clients_city_checkColumnConstraints(p_data.city) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL consultcompanion_dbxconstraints_clients_provinceid_checkColumnConstraints(p_data.provinceid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL consultcompanion_dbxconstraints_clients_postalzip_checkColumnConstraints(p_data.postalzip) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL consultcompanion_dbxconstraints_clients_primarycontact_checkColumnConstraints(p_data.primarycontact) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL consultcompanion_dbxconstraints_clients_primaryemail_checkColumnConstraints(p_data.primaryemail) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL consultcompanion_dbxconstraints_clients_clienttypeid_checkColumnConstraints(p_data.clienttypeid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL consultcompanion_dbxconstraints_clients_preferred_checkColumnConstraints(p_data.preferred) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL consultcompanion_dbxconstraints_clients_paytermid_checkColumnConstraints(p_data.paytermid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL consultcompanion_dbxconstraints_clients_primaryphone_checkColumnConstraints(p_data.primaryphone) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL consultcompanion_dbxconstraints_clients_countryid_checkColumnConstraints(p_data.countryid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    CALL consultcompanion_dbxconstraints_clients_PK_clients_1_checkUniqueConstraint(p_forUpdate, p_data.clientid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    CALL consultcompanion_dbxconstraints_clienttypes_PK_clientTypes_1_checkFKConstraint(p_data.clienttypeid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL consultcompanion_dbxconstraints_country_PK_country_1_checkFKConstraint(p_data.countryid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL consultcompanion_dbxconstraints_paymentterms_PK_paymentTerms_1_checkFKConstraint(p_data.paytermid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg
    CALL consultcompanion_dbxconstraints_provinces_PK_provinces_1_checkFKConstraint(p_data.provinceid) RETURNING l_errNo, l_errMsg
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    IF consultcompanion_events.m_DbxDataEvent_clients_CheckTableConstraints IS NOT NULL THEN
        CALL consultcompanion_events.m_DbxDataEvent_clients_CheckTableConstraints(p_forUpdate, p_data.*)
            RETURNING l_errNo, l_errMsg
    END IF
    CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, l_errNo, l_errMsg) RETURNING errNo, errMsg

    {<POINT Name="fct.clients_checkTableConstraints.user" Status="MODIFIED">}
    {</POINT>}
    
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.clients_checkTableConstraints

{<BLOCK Name="fct.clients_PK_clients_1_checkUniqueConstraint">}
#+ Check the primary key uniqueness constraint on the "clients"
#+
#+ @param p_forUpdate TRUE: for 'update' SQL operation, FALSE for 'insert' SQL operation
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER, STRING, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_clients_PK_clients_1_checkUniqueConstraint(p_forUpdate, p_key)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_forUpdate BOOLEAN
    DEFINE p_key
        RECORD
            clients_clientid LIKE clients.clientid
        END RECORD
    DEFINE l_key
        RECORD
            clients_clientid LIKE clients.clientid
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.clients_PK_clients_1_checkUniqueConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    LET l_where = "WHERE clients.clientid = ? "
    LET l_sqlQuery = "SELECT COUNT(*), clientid FROM clients ", l_where, " GROUP BY clientid"
    {<POINT Name="fct.clients_PK_clients_1_checkUniqueConstraint.init">} {</POINT>}
    TRY
        PREPARE cur_clients_PK_clients_1_checkUniqueConstraint FROM l_sqlQuery
        EXECUTE cur_clients_PK_clients_1_checkUniqueConstraint USING p_key.* INTO l_count, l_key.*
        FREE cur_clients_PK_clients_1_checkUniqueConstraint
        IF (NOT p_forUpdate AND l_count > 0) OR (p_forUpdate AND l_count > 0 AND p_key.* != l_key.*) THEN
            CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- clientid: " || ERROR_BAM_00002) RETURNING errNo, errMsg
        END IF
    CATCH
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.clients_PK_clients_1_checkUniqueConstraint.user">} {</POINT>}

    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.clients_PK_clients_1_checkUniqueConstraint

{<BLOCK Name="fct.clients_clientid_checkColumnConstraints">}
#+ Check constraints on the "clients.clientid" column
#+
#+ @param p_clientid - SERIAL - clientid
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_clients_clientid_checkColumnConstraints(p_clientid)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_clientid LIKE clients.clientid
    {<POINT Name="fct.clients_clientid_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.clients_clientid_checkColumnConstraints.init">} {</POINT>}
    IF p_clientid IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- clientid: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.clients_clientid_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.clients_clientid_checkColumnConstraints

{<BLOCK Name="fct.clients_clientname_checkColumnConstraints">}
#+ Check constraints on the "clients.clientname" column
#+
#+ @param p_clientname - CHAR(30) - clientname
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_clients_clientname_checkColumnConstraints(p_clientname)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_clientname LIKE clients.clientname
    {<POINT Name="fct.clients_clientname_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.clients_clientname_checkColumnConstraints.init">} {</POINT>}
    IF p_clientname IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- clientname: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.clients_clientname_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.clients_clientname_checkColumnConstraints

{<BLOCK Name="fct.clients_address1_checkColumnConstraints">}
#+ Check constraints on the "clients.address1" column
#+
#+ @param p_address1 - CHAR(60) - address1
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_clients_address1_checkColumnConstraints(p_address1)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_address1 LIKE clients.address1
    {<POINT Name="fct.clients_address1_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.clients_address1_checkColumnConstraints.init">} {</POINT>}
    IF p_address1 IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- address1: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.clients_address1_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.clients_address1_checkColumnConstraints

{<BLOCK Name="fct.clients_city_checkColumnConstraints">}
#+ Check constraints on the "clients.city" column
#+
#+ @param p_city - CHAR(30) - city
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_clients_city_checkColumnConstraints(p_city)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_city LIKE clients.city
    {<POINT Name="fct.clients_city_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.clients_city_checkColumnConstraints.init">} {</POINT>}
    IF p_city IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- city: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.clients_city_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.clients_city_checkColumnConstraints

{<BLOCK Name="fct.clients_provinceid_checkColumnConstraints">}
#+ Check constraints on the "clients.provinceid" column
#+
#+ @param p_provinceid - INTEGER - provinceid
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_clients_provinceid_checkColumnConstraints(p_provinceid)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_provinceid LIKE clients.provinceid
    {<POINT Name="fct.clients_provinceid_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.clients_provinceid_checkColumnConstraints.init">} {</POINT>}
    IF p_provinceid IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- provinceid: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.clients_provinceid_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.clients_provinceid_checkColumnConstraints

{<BLOCK Name="fct.clients_postalzip_checkColumnConstraints">}
#+ Check constraints on the "clients.postalzip" column
#+
#+ @param p_postalzip - CHAR(10) - postalzip
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_clients_postalzip_checkColumnConstraints(p_postalzip)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_postalzip LIKE clients.postalzip
    {<POINT Name="fct.clients_postalzip_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.clients_postalzip_checkColumnConstraints.init">} {</POINT>}
    IF p_postalzip IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- postalzip: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.clients_postalzip_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.clients_postalzip_checkColumnConstraints

{<BLOCK Name="fct.clients_primarycontact_checkColumnConstraints">}
#+ Check constraints on the "clients.primarycontact" column
#+
#+ @param p_primarycontact - CHAR(30) - primarycontact
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_clients_primarycontact_checkColumnConstraints(p_primarycontact)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_primarycontact LIKE clients.primarycontact
    {<POINT Name="fct.clients_primarycontact_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.clients_primarycontact_checkColumnConstraints.init">} {</POINT>}
    IF p_primarycontact IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- primarycontact: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.clients_primarycontact_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.clients_primarycontact_checkColumnConstraints

{<BLOCK Name="fct.clients_primaryemail_checkColumnConstraints">}
#+ Check constraints on the "clients.primaryemail" column
#+
#+ @param p_primaryemail - CHAR(80) - primaryemail
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_clients_primaryemail_checkColumnConstraints(p_primaryemail)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_primaryemail LIKE clients.primaryemail
    {<POINT Name="fct.clients_primaryemail_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.clients_primaryemail_checkColumnConstraints.init">} {</POINT>}
    IF p_primaryemail IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- primaryemail: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.clients_primaryemail_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.clients_primaryemail_checkColumnConstraints

{<BLOCK Name="fct.clients_clienttypeid_checkColumnConstraints">}
#+ Check constraints on the "clients.clienttypeid" column
#+
#+ @param p_clienttypeid - INTEGER - clienttypeid
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_clients_clienttypeid_checkColumnConstraints(p_clienttypeid)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_clienttypeid LIKE clients.clienttypeid
    {<POINT Name="fct.clients_clienttypeid_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.clients_clienttypeid_checkColumnConstraints.init">} {</POINT>}
    IF p_clienttypeid IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- clienttypeid: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.clients_clienttypeid_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.clients_clienttypeid_checkColumnConstraints

{<BLOCK Name="fct.clients_preferred_checkColumnConstraints">}
#+ Check constraints on the "clients.preferred" column
#+
#+ @param p_preferred - BOOLEAN - preferred
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_clients_preferred_checkColumnConstraints(p_preferred)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_preferred LIKE clients.preferred
    {<POINT Name="fct.clients_preferred_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.clients_preferred_checkColumnConstraints.init">} {</POINT>}
    IF p_preferred IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- preferred: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.clients_preferred_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.clients_preferred_checkColumnConstraints

{<BLOCK Name="fct.clients_paytermid_checkColumnConstraints">}
#+ Check constraints on the "clients.paytermid" column
#+
#+ @param p_paytermid - INTEGER - paytermid
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_clients_paytermid_checkColumnConstraints(p_paytermid)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_paytermid LIKE clients.paytermid
    {<POINT Name="fct.clients_paytermid_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.clients_paytermid_checkColumnConstraints.init">} {</POINT>}
    IF p_paytermid IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- paytermid: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.clients_paytermid_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.clients_paytermid_checkColumnConstraints

{<BLOCK Name="fct.clients_primaryphone_checkColumnConstraints">}
#+ Check constraints on the "clients.primaryphone" column
#+
#+ @param p_primaryphone - CHAR(1) - primaryphone
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_clients_primaryphone_checkColumnConstraints(p_primaryphone)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_primaryphone LIKE clients.primaryphone
    {<POINT Name="fct.clients_primaryphone_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.clients_primaryphone_checkColumnConstraints.init">} {</POINT>}
    IF p_primaryphone IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- primaryphone: " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.clients_primaryphone_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.clients_primaryphone_checkColumnConstraints

{<BLOCK Name="fct.clients_countryid_checkColumnConstraints" Status="MODIFIED">}
#+ Check constraints on the "clients.countryid" column
#+
#+ @param p_countryid - INTEGER - countryid
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_clients_countryid_checkColumnConstraints(p_countryid)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_countryid LIKE clients.countryid
    {<POINT Name="fct.clients_countryid_checkColumnConstraints.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    {<POINT Name="fct.clients_countryid_checkColumnConstraints.init">} {</POINT>}
    IF p_countryid IS NULL THEN
        CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- countryid: " || p_countryid || " - " || ERROR_BAM_00001) RETURNING errNo, errMsg
    END IF
    {<POINT Name="fct.clients_countryid_checkColumnConstraints.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.clients_countryid_checkColumnConstraints

{<BLOCK Name="fct.clients_PK_clients_1_checkFKConstraint">}
#+ Check the Foreign Key existence constraint on the "clients"
#+
#+ @param p_data - Primary Key
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxconstraints_clients_PK_clients_1_checkFKConstraint(p_data)
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE p_data
        RECORD
            clients_clientid LIKE clients.clientid
        END RECORD
    DEFINE l_where STRING
    DEFINE l_sqlQuery STRING
    DEFINE l_count INTEGER
    {<POINT Name="fct.clients_PK_clients_1_checkFKConstraint.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    INITIALIZE errMsg TO NULL
    IF NOT (p_data.clients_clientid IS NULL) THEN
        LET l_where = "WHERE clients.clientid = ? "
        LET l_sqlQuery = "SELECT COUNT(*) FROM clients ", l_where
        {<POINT Name="fct.clients_PK_clients_1_checkFKConstraint.init">} {</POINT>}
        TRY
            PREPARE cur_clients_PK_clients_1_checkFKConstraint FROM l_sqlQuery
            EXECUTE cur_clients_PK_clients_1_checkFKConstraint USING p_data.* INTO l_count
            FREE cur_clients_PK_clients_1_checkFKConstraint
            IF (l_count == 0) THEN
                CALL libdbapp_utilBuildErrorNoAndErrorMsg(errNo, errMsg, ERROR_FAILURE, "\n- clientid: " || ERROR_BAM_00004) RETURNING errNo, errMsg
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
    END IF
    {<POINT Name="fct.clients_PK_clients_1_checkFKConstraint.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.clients_PK_clients_1_checkFKConstraint

--------------------------------------------------------------------------------
--Add user functions
{<POINT Name="user.functions">} {</POINT>}
