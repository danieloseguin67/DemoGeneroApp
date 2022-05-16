{<CODEFILE Path="consultcompanion.code" Hash="g/9CUDEUGZ5Ge8Z1ccBfIw==" />}
#+ DB schema - Data Management (consultcompanion)

--------------------------------------------------------------------------------
--This code is generated with the template dbapp5.0
--Warning: Enter your changes within a <BLOCK> or <POINT> section, otherwise they will be lost.
{<POINT Name="user.comments">} {</POINT>}

--------------------------------------------------------------------------------
--Importing modules
IMPORT FGL libdbappCore
IMPORT FGL libdbappSql

IMPORT FGL consultcompanion
IMPORT FGL consultcompanion_events
IMPORT FGL consultcompanion_dbxconstraints
{<POINT Name="import" Status="MODIFIED">} 
IMPORT FGL fgldialog
{</POINT>}

--------------------------------------------------------------------------------
--Database schema
SCHEMA consultcompanion

--------------------------------------------------------------------------------
--Functions

{<BLOCK Name="fct.seqreg_pk_seqreg_selectRowByKey">}
#+ Select a row identified by the primary key in the "seqreg" table
#+
#+ @param p_key - Primary Key
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER, LIKE seqreg.*
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_NOTFOUND, RECORD LIKE seqreg.*
PUBLIC FUNCTION consultcompanion_dbxdata_seqreg_pk_seqreg_selectRowByKey(p_key, p_lock)
    DEFINE p_key
        RECORD
            seqreg_sr_name LIKE seqreg.sr_name
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE l_data RECORD LIKE seqreg.*
    DEFINE l_supportLock BOOLEAN
    DEFINE errNo INTEGER
    {<POINT Name="fct.seqreg_pk_seqreg_selectRowByKey.define" Status="MODIFIED">} 
    DEFINE l_flag smallint
    {</POINT>}

    LET errNo = ERROR_SUCCESS
    -- SQLite does not support the FOR UPDATE close in SELECT syntax
    LET l_supportLock = (UPSHIFT(fgl_db_driver_type()) != "SQT")
    {<POINT Name="fct.seqreg_pk_seqreg_selectRowByKey.init" Status="MODIFIED">}
       # example to add code similar than fg .ext files 
       LET l_flag = 0       
    {</POINT>}
    TRY
        IF p_lock AND l_supportLock THEN
            SELECT * INTO l_data.* FROM seqreg
                WHERE @seqreg.sr_name = p_key.seqreg_sr_name
            FOR UPDATE
        ELSE
            SELECT * INTO l_data.* FROM seqreg
                WHERE @seqreg.sr_name = p_key.seqreg_sr_name
        END IF
        IF SQLCA.SQLCODE == NOTFOUND THEN
            LET errNo = ERROR_NOTFOUND
        END IF
    CATCH
        INITIALIZE l_data.* TO NULL
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.seqreg_pk_seqreg_selectRowByKey.afterSelect">} {</POINT>}
    RETURN errNo, l_data.*
END FUNCTION
{</BLOCK>} --fct.seqreg_pk_seqreg_selectRowByKey

{<BLOCK Name="fct.seqreg_insertRowByKey">}
#+ Insert a row in the "seqreg" table and return the primary key created
#+
#+ @param p_data - a row data LIKE seqreg.*
#+
#+ @returnType INTEGER, STRING, VARCHAR(30)
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, seqreg.sr_name
PRIVATE FUNCTION consultcompanion_dbxdata_seqreg_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE seqreg.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.seqreg_insertRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.seqreg_insertRowByKey.init">} {</POINT>}

        IF consultcompanion_events.m_DbxDataEvent_seqreg_BeforeInsertRowByKey IS NOT NULL THEN
            CALL consultcompanion_events.m_DbxDataEvent_seqreg_BeforeInsertRowByKey(p_data.*)
                RETURNING errNo, errMsg, p_data.*
        END IF
        IF errNo == ERROR_SUCCESS THEN
            CALL consultcompanion_dbxconstraints.consultcompanion_dbxconstraints_seqreg_checkTableConstraints(FALSE, p_data.*) RETURNING errNo, errMsg
        END IF
        {<POINT Name="fct.seqreg_insertRowByKey.beforeInsert">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            TRY
                INSERT INTO seqreg VALUES (p_data.*)
            CATCH
                LET errNo = ERROR_FAILURE
            END TRY
            IF consultcompanion_events.m_DbxDataEvent_seqreg_AfterInsertRowByKey IS NOT NULL THEN
                CALL consultcompanion_events.m_DbxDataEvent_seqreg_AfterInsertRowByKey(p_data.*)
                    RETURNING errNo, errMsg
            END IF
            {<POINT Name="fct.seqreg_insertRowByKey.afterInsert">} {</POINT>}
        END IF
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg, p_data.sr_name
END FUNCTION
{</BLOCK>} --fct.seqreg_insertRowByKey

{<BLOCK Name="fct.seqreg_pk_seqreg_insertRowByKey">}
#+ Insert a row in the "seqreg" table and return the table keys
#+
#+ @param p_data - a row data LIKE seqreg.*
#+
#+ @returnType INTEGER, STRING, VARCHAR(30)
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, seqreg.sr_name
PUBLIC FUNCTION consultcompanion_dbxdata_seqreg_pk_seqreg_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE seqreg.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.seqreg_pk_seqreg_insertRowByKey.define">} {</POINT>}
    {<POINT Name="fct.seqreg_pk_seqreg_insertRowByKey.init">} {</POINT>}

    CALL consultcompanion_dbxdata_seqreg_insertRowByKey(p_data.*) RETURNING errNo, errMsg, p_data.sr_name
    RETURN errNo, errMsg, p_data.sr_name
END FUNCTION
{</BLOCK>} --fct.seqreg_pk_seqreg_insertRowByKey

{<BLOCK Name="fct.seqreg_pk_seqreg_updateRowByKey">}
#+ Update a row identified by the primary key in the "seqreg" table
#+
#+ @param p_dataT0 - a row data LIKE seqreg.*
#+ @param p_dataT1 - a row data LIKE seqreg.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxdata_seqreg_pk_seqreg_updateRowByKey(p_dataT0, p_dataT1)
    DEFINE p_dataT0 RECORD LIKE seqreg.*
    DEFINE p_dataT1 RECORD LIKE seqreg.*
    DEFINE l_key
        RECORD
            seqreg_sr_name LIKE seqreg.sr_name
        END RECORD
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.seqreg_pk_seqreg_updateRowByKey.define">} {</POINT>}
    LET l_key.seqreg_sr_name = p_dataT0.sr_name
    INITIALIZE errMsg TO NULL
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.seqreg_pk_seqreg_updateRowByKey.init">} {</POINT>}
        TRY
            LET errNo = consultcompanion_dbxdata_seqreg_pk_seqreg_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
            {<POINT Name="fct.seqreg_pk_seqreg_updateRowByKey.afterSelect">} {</POINT>}
            IF errNo == ERROR_SUCCESS THEN
                CALL consultcompanion_dbxconstraints.consultcompanion_dbxconstraints_seqreg_checkTableConstraints(TRUE, p_dataT1.*) RETURNING errNo, errMsg
                {<POINT Name="fct.seqreg_pk_seqreg_updateRowByKey.beforeUpdate">} {</POINT>}
                IF errNo == ERROR_SUCCESS THEN
                 IF consultcompanion_events.m_DbxDataEvent_seqreg_BeforeUpdateRowByKey IS NOT NULL THEN
                    CALL consultcompanion_events.m_DbxDataEvent_seqreg_BeforeUpdateRowByKey(p_dataT1.*)
                        RETURNING errNo, errMsg
                END IF
                    UPDATE seqreg
                        SET seqreg.* = p_dataT1.*
                        WHERE @seqreg.sr_name = l_key.seqreg_sr_name
                END IF
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        IF consultcompanion_events.m_DbxDataEvent_seqreg_AfterUpdateRowByKey IS NOT NULL THEN
            CALL consultcompanion_events.m_DbxDataEvent_seqreg_AfterUpdateRowByKey(p_dataT1.*)
                RETURNING errNo, errMsg
        END IF
        {<POINT Name="fct.seqreg_pk_seqreg_updateRowByKey.afterUpdate">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.seqreg_pk_seqreg_updateRowByKey

{<BLOCK Name="fct.seqreg_pk_seqreg_deleteRowByKey">}
#+ Delete a row identified by the primary key in the "seqreg" table
#+
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION consultcompanion_dbxdata_seqreg_pk_seqreg_deleteRowByKey(p_key)
    DEFINE p_key
        RECORD
            seqreg_sr_name LIKE seqreg.sr_name
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.seqreg_pk_seqreg_deleteRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.seqreg_pk_seqreg_deleteRowByKey.init">} {</POINT>}
        IF consultcompanion_events.m_DbxDataEvent_seqreg_BeforeDeleteRowByKey IS NOT NULL THEN
            CALL consultcompanion_events.m_DbxDataEvent_seqreg_BeforeDeleteRowByKey(p_key.*)
                RETURNING errNo
        END IF
        TRY
            DELETE FROM seqreg
                WHERE @seqreg.sr_name = p_key.seqreg_sr_name
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        IF consultcompanion_events.m_DbxDataEvent_seqreg_AfterDeleteRowByKey IS NOT NULL THEN
            CALL consultcompanion_events.m_DbxDataEvent_seqreg_AfterDeleteRowByKey(p_key.*)
                RETURNING errNo
        END IF
        {<POINT Name="fct.seqreg_pk_seqreg_deleteRowByKey.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.seqreg_pk_seqreg_deleteRowByKey

{<BLOCK Name="fct.seqreg_pk_seqreg_deleteRowByKeyWithConcurrentAccess">}
#+ Delete a row identified by the primary key in the "seqreg" table if the concurrent access is success
#+
#+ @param p_dataT0 - a row data LIKE seqreg.*
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION consultcompanion_dbxdata_seqreg_pk_seqreg_deleteRowByKeyWithConcurrentAccess(p_dataT0)
    DEFINE p_dataT0 RECORD LIKE seqreg.*
    DEFINE l_key
        RECORD
            seqreg_sr_name LIKE seqreg.sr_name
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.seqreg_pk_seqreg_deleteRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.seqreg_sr_name = p_dataT0.sr_name
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.seqreg_pk_seqreg_deleteRowByKeyWithConcurrentAccess.init">} {</POINT>}
        LET errNo = consultcompanion_dbxdata_seqreg_pk_seqreg_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
        {<POINT Name="fct.seqreg_pk_seqreg_deleteRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = consultcompanion_dbxdata_seqreg_pk_seqreg_deleteRowByKey(l_key.*)
        END IF
        {<POINT Name="fct.seqreg_pk_seqreg_deleteRowByKeyWithConcurrentAccess.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.seqreg_pk_seqreg_deleteRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.seqreg_pk_seqreg_checkRowByKeyWithConcurrentAccess">}
#+ Check if a row identified by the primary key in the "seqreg" table has been modified or deleted
#+
#+ @param p_dataT0 - a row data LIKE seqreg.*
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE
PUBLIC FUNCTION consultcompanion_dbxdata_seqreg_pk_seqreg_checkRowByKeyWithConcurrentAccess(p_dataT0, p_lock)
    DEFINE p_dataT0 RECORD LIKE seqreg.*
    DEFINE l_dataT2 RECORD LIKE seqreg.*
    DEFINE l_key
        RECORD
            seqreg_sr_name LIKE seqreg.sr_name
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE errNo INTEGER
    DEFINE errDiff INTEGER
    {<POINT Name="fct.seqreg_pk_seqreg_checkRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.seqreg_sr_name = p_dataT0.sr_name
    INITIALIZE l_dataT2.* TO NULL
    LET errDiff = FALSE
    {<POINT Name="fct.seqreg_pk_seqreg_checkRowByKeyWithConcurrentAccess.init">} {</POINT>}
    CALL consultcompanion_dbxdata_seqreg_pk_seqreg_selectRowByKey(l_key.*, p_lock) RETURNING errNo, l_dataT2.*
    CASE errNo
        WHEN ERROR_SUCCESS
            LET errDiff = (p_dataT0.* != l_dataT2.*)
            {<POINT Name="fct.seqreg_pk_seqreg_checkRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
            IF NOT errDiff THEN
                LET errNo = ERROR_SUCCESS
            ELSE
                LET errNo = ERROR_CONCURRENT_ACCESS_FAILURE
            END IF
        WHEN ERROR_NOTFOUND
            LET errNo = ERROR_CONCURRENT_ACCESS_NOTFOUND
    END CASE
    {<POINT Name="fct.seqreg_pk_seqreg_checkRowByKeyWithConcurrentAccess.afterCheck">} {</POINT>}
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.seqreg_pk_seqreg_checkRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.seqreg_setDefaultValuesFromDBSchema">}
#+ Set data with the default values coming from the DB schema
#+
PUBLIC FUNCTION consultcompanion_dbxdata_seqreg_setDefaultValuesFromDBSchema()
    DEFINE l_data RECORD LIKE seqreg.*
    {<POINT Name="fct.seqreg_setDefaultValuesFromDBSchema.define">} {</POINT>}

    INITIALIZE l_data.* TO NULL
    {<POINT Name="fct.seqreg_setDefaultValuesFromDBSchema.init">} {</POINT>}
    IF consultcompanion_events.m_DbxDataEvent_seqreg_SetDefaultValues IS NOT NULL THEN
        CALL consultcompanion_events.m_DbxDataEvent_seqreg_SetDefaultValues(l_data.*)
            RETURNING l_data.*
    END IF
    RETURN l_data.*
END FUNCTION
{</BLOCK>} --fct.seqreg_setDefaultValuesFromDBSchema

{<BLOCK Name="fct.rfs_PK_RFS_1_selectRowByKey">}
#+ Select a row identified by the primary key in the "rfs" table
#+
#+ @param p_key - Primary Key
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER, LIKE rfs.*
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_NOTFOUND, RECORD LIKE rfs.*
PUBLIC FUNCTION consultcompanion_dbxdata_rfs_PK_RFS_1_selectRowByKey(p_key, p_lock)
    DEFINE p_key
        RECORD
            rfs_rfsId LIKE rfs.rfsId
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE l_data RECORD LIKE rfs.*
    DEFINE l_supportLock BOOLEAN
    DEFINE errNo INTEGER
    {<POINT Name="fct.rfs_PK_RFS_1_selectRowByKey.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    -- SQLite does not support the FOR UPDATE close in SELECT syntax
    LET l_supportLock = (UPSHIFT(fgl_db_driver_type()) != "SQT")
    LOCATE l_data.offerlink IN MEMORY
    LOCATE l_data.offernote IN MEMORY
    {<POINT Name="fct.rfs_PK_RFS_1_selectRowByKey.init">} {</POINT>}
    TRY
        IF p_lock AND l_supportLock THEN
            SELECT * INTO l_data.* FROM rfs
                WHERE @rfs.rfsId = p_key.rfs_rfsId
            FOR UPDATE
        ELSE
            SELECT * INTO l_data.* FROM rfs
                WHERE @rfs.rfsId = p_key.rfs_rfsId
        END IF
        IF SQLCA.SQLCODE == NOTFOUND THEN
            LET errNo = ERROR_NOTFOUND
        END IF
    CATCH
        INITIALIZE l_data.* TO NULL
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.rfs_PK_RFS_1_selectRowByKey.afterSelect">} {</POINT>}
    RETURN errNo, l_data.*
END FUNCTION
{</BLOCK>} --fct.rfs_PK_RFS_1_selectRowByKey

{<BLOCK Name="fct.rfs_insertRowByKey">}
#+ Insert a row in the "rfs" table and return the primary key created
#+
#+ @param p_data - a row data LIKE rfs.*
#+
#+ @returnType INTEGER, STRING, SERIAL
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, rfs.rfsId
PRIVATE FUNCTION consultcompanion_dbxdata_rfs_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE rfs.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.rfs_insertRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        CALL libdbapp_get_sequence("rfs") RETURNING errNo, p_data.rfsId
        {<POINT Name="fct.rfs_insertRowByKey.init">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            IF consultcompanion_events.m_DbxDataEvent_rfs_BeforeInsertRowByKey IS NOT NULL THEN
                CALL consultcompanion_events.m_DbxDataEvent_rfs_BeforeInsertRowByKey(p_data.*)
                    RETURNING errNo, errMsg, p_data.*
            END IF
            IF errNo == ERROR_SUCCESS THEN
                CALL consultcompanion_dbxconstraints.consultcompanion_dbxconstraints_rfs_checkTableConstraints(FALSE, p_data.*) RETURNING errNo, errMsg
            END IF
            {<POINT Name="fct.rfs_insertRowByKey.beforeInsert">} {</POINT>}
            IF errNo == ERROR_SUCCESS THEN
                TRY
                    INSERT INTO rfs VALUES (p_data.*)
                    CALL libdbapp_get_inserted_sequence(p_data.rfsId) RETURNING p_data.rfsId
                CATCH
                    LET errNo = ERROR_FAILURE
                END TRY
                IF consultcompanion_events.m_DbxDataEvent_rfs_AfterInsertRowByKey IS NOT NULL THEN
                    CALL consultcompanion_events.m_DbxDataEvent_rfs_AfterInsertRowByKey(p_data.*)
                        RETURNING errNo, errMsg
                END IF
                {<POINT Name="fct.rfs_insertRowByKey.afterInsert">} {</POINT>}
            END IF
        END IF
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg, p_data.rfsId
END FUNCTION
{</BLOCK>} --fct.rfs_insertRowByKey

{<BLOCK Name="fct.rfs_PK_RFS_1_insertRowByKey">}
#+ Insert a row in the "rfs" table and return the table keys
#+
#+ @param p_data - a row data LIKE rfs.*
#+
#+ @returnType INTEGER, STRING, SERIAL
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, rfs.rfsId
PUBLIC FUNCTION consultcompanion_dbxdata_rfs_PK_RFS_1_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE rfs.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.rfs_PK_RFS_1_insertRowByKey.define">} {</POINT>}
    {<POINT Name="fct.rfs_PK_RFS_1_insertRowByKey.init">} {</POINT>}

    CALL consultcompanion_dbxdata_rfs_insertRowByKey(p_data.*) RETURNING errNo, errMsg, p_data.rfsId
    RETURN errNo, errMsg, p_data.rfsId
END FUNCTION
{</BLOCK>} --fct.rfs_PK_RFS_1_insertRowByKey

{<BLOCK Name="fct.rfs_PK_RFS_1_updateRowByKey">}
#+ Update a row identified by the primary key in the "rfs" table
#+
#+ @param p_dataT0 - a row data LIKE rfs.*
#+ @param p_dataT1 - a row data LIKE rfs.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxdata_rfs_PK_RFS_1_updateRowByKey(p_dataT0, p_dataT1)
    DEFINE p_dataT0 RECORD LIKE rfs.*
    DEFINE p_dataT1 RECORD LIKE rfs.*
    DEFINE l_key
        RECORD
            rfs_rfsId LIKE rfs.rfsId
        END RECORD
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.rfs_PK_RFS_1_updateRowByKey.define">} {</POINT>}
    LET l_key.rfs_rfsId = p_dataT0.rfsId
    INITIALIZE errMsg TO NULL
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.rfs_PK_RFS_1_updateRowByKey.init">} {</POINT>}
        TRY
            LET errNo = consultcompanion_dbxdata_rfs_PK_RFS_1_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
            {<POINT Name="fct.rfs_PK_RFS_1_updateRowByKey.afterSelect">} {</POINT>}
            IF errNo == ERROR_SUCCESS THEN
                CALL consultcompanion_dbxconstraints.consultcompanion_dbxconstraints_rfs_checkTableConstraints(TRUE, p_dataT1.*) RETURNING errNo, errMsg
                {<POINT Name="fct.rfs_PK_RFS_1_updateRowByKey.beforeUpdate">} {</POINT>}
                IF errNo == ERROR_SUCCESS THEN
                 IF consultcompanion_events.m_DbxDataEvent_rfs_BeforeUpdateRowByKey IS NOT NULL THEN
                    CALL consultcompanion_events.m_DbxDataEvent_rfs_BeforeUpdateRowByKey(p_dataT1.*)
                        RETURNING errNo, errMsg
                END IF
                    UPDATE rfs
                        SET rfs.* = p_dataT1.*
                        WHERE @rfs.rfsId = l_key.rfs_rfsId
                END IF
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        IF consultcompanion_events.m_DbxDataEvent_rfs_AfterUpdateRowByKey IS NOT NULL THEN
            CALL consultcompanion_events.m_DbxDataEvent_rfs_AfterUpdateRowByKey(p_dataT1.*)
                RETURNING errNo, errMsg
        END IF
        {<POINT Name="fct.rfs_PK_RFS_1_updateRowByKey.afterUpdate">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.rfs_PK_RFS_1_updateRowByKey

{<BLOCK Name="fct.rfs_PK_RFS_1_deleteRowByKey">}
#+ Delete a row identified by the primary key in the "rfs" table
#+
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION consultcompanion_dbxdata_rfs_PK_RFS_1_deleteRowByKey(p_key)
    DEFINE p_key
        RECORD
            rfs_rfsId LIKE rfs.rfsId
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.rfs_PK_RFS_1_deleteRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.rfs_PK_RFS_1_deleteRowByKey.init">} {</POINT>}
        IF consultcompanion_events.m_DbxDataEvent_rfs_BeforeDeleteRowByKey IS NOT NULL THEN
            CALL consultcompanion_events.m_DbxDataEvent_rfs_BeforeDeleteRowByKey(p_key.*)
                RETURNING errNo
        END IF
        TRY
            DELETE FROM rfs
                WHERE @rfs.rfsId = p_key.rfs_rfsId
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        IF consultcompanion_events.m_DbxDataEvent_rfs_AfterDeleteRowByKey IS NOT NULL THEN
            CALL consultcompanion_events.m_DbxDataEvent_rfs_AfterDeleteRowByKey(p_key.*)
                RETURNING errNo
        END IF
        {<POINT Name="fct.rfs_PK_RFS_1_deleteRowByKey.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.rfs_PK_RFS_1_deleteRowByKey

{<BLOCK Name="fct.rfs_PK_RFS_1_deleteRowByKeyWithConcurrentAccess">}
#+ Delete a row identified by the primary key in the "rfs" table if the concurrent access is success
#+
#+ @param p_dataT0 - a row data LIKE rfs.*
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION consultcompanion_dbxdata_rfs_PK_RFS_1_deleteRowByKeyWithConcurrentAccess(p_dataT0)
    DEFINE p_dataT0 RECORD LIKE rfs.*
    DEFINE l_key
        RECORD
            rfs_rfsId LIKE rfs.rfsId
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.rfs_PK_RFS_1_deleteRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.rfs_rfsId = p_dataT0.rfsId
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.rfs_PK_RFS_1_deleteRowByKeyWithConcurrentAccess.init">} {</POINT>}
        LET errNo = consultcompanion_dbxdata_rfs_PK_RFS_1_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
        {<POINT Name="fct.rfs_PK_RFS_1_deleteRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = consultcompanion_dbxdata_rfs_PK_RFS_1_deleteRowByKey(l_key.*)
        END IF
        {<POINT Name="fct.rfs_PK_RFS_1_deleteRowByKeyWithConcurrentAccess.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.rfs_PK_RFS_1_deleteRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.rfs_PK_RFS_1_checkRowByKeyWithConcurrentAccess">}
#+ Check if a row identified by the primary key in the "rfs" table has been modified or deleted
#+
#+ @param p_dataT0 - a row data LIKE rfs.*
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE
PUBLIC FUNCTION consultcompanion_dbxdata_rfs_PK_RFS_1_checkRowByKeyWithConcurrentAccess(p_dataT0, p_lock)
    DEFINE p_dataT0 RECORD LIKE rfs.*
    DEFINE l_dataT2 RECORD LIKE rfs.*
    DEFINE l_key
        RECORD
            rfs_rfsId LIKE rfs.rfsId
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE errNo INTEGER
    DEFINE errDiff INTEGER
    {<POINT Name="fct.rfs_PK_RFS_1_checkRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.rfs_rfsId = p_dataT0.rfsId
    INITIALIZE l_dataT2.* TO NULL
    LET errDiff = FALSE
    {<POINT Name="fct.rfs_PK_RFS_1_checkRowByKeyWithConcurrentAccess.init">} {</POINT>}
    CALL consultcompanion_dbxdata_rfs_PK_RFS_1_selectRowByKey(l_key.*, p_lock) RETURNING errNo, l_dataT2.*
    CASE errNo
        WHEN ERROR_SUCCESS
            LET errDiff = NVL(p_dataT0.rfsId, 0) != NVL(l_dataT2.rfsId, 0) OR
                        NVL(p_dataT0.clientid, 0) != NVL(l_dataT2.clientid, 0) OR
                        NVL(p_dataT0.stakeholderId, 0) != NVL(l_dataT2.stakeholderId, 0) OR
                        NVL(p_dataT0.offernumber, 0) != NVL(l_dataT2.offernumber, 0) OR
                        NVL(p_dataT0.offertitle, 0) != NVL(l_dataT2.offertitle, 0) OR
                        NVL(p_dataT0.offerdate, 0) != NVL(l_dataT2.offerdate, 0) OR
                        NVL(p_dataT0.offersubmitted, 0) != NVL(l_dataT2.offersubmitted, 0) OR
                        NVL(p_dataT0.offerstatusid, 0) != NVL(l_dataT2.offerstatusid, 0) OR
                        NVL(p_dataT0.interviewdate, 0) != NVL(l_dataT2.interviewdate, 0) OR
                        NVL(p_dataT0.accepteddate, 0) != NVL(l_dataT2.accepteddate, 0) OR
                        LENGTH(p_dataT0.offerlink) != LENGTH(l_dataT2.offerlink) OR
                        LENGTH(p_dataT0.offernote) != LENGTH(l_dataT2.offernote)
            {<POINT Name="fct.rfs_PK_RFS_1_checkRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
            IF NOT errDiff THEN
                LET errNo = ERROR_SUCCESS
            ELSE
                LET errNo = ERROR_CONCURRENT_ACCESS_FAILURE
            END IF
        WHEN ERROR_NOTFOUND
            LET errNo = ERROR_CONCURRENT_ACCESS_NOTFOUND
    END CASE
    {<POINT Name="fct.rfs_PK_RFS_1_checkRowByKeyWithConcurrentAccess.afterCheck">} {</POINT>}
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.rfs_PK_RFS_1_checkRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.rfs_setDefaultValuesFromDBSchema">}
#+ Set data with the default values coming from the DB schema
#+
PUBLIC FUNCTION consultcompanion_dbxdata_rfs_setDefaultValuesFromDBSchema()
    DEFINE l_data RECORD LIKE rfs.*
    {<POINT Name="fct.rfs_setDefaultValuesFromDBSchema.define">} {</POINT>}

    INITIALIZE l_data.* TO NULL
    {<POINT Name="fct.rfs_setDefaultValuesFromDBSchema.init">} {</POINT>}
    IF consultcompanion_events.m_DbxDataEvent_rfs_SetDefaultValues IS NOT NULL THEN
        CALL consultcompanion_events.m_DbxDataEvent_rfs_SetDefaultValues(l_data.*)
            RETURNING l_data.*
    END IF
    RETURN l_data.*
END FUNCTION
{</BLOCK>} --fct.rfs_setDefaultValuesFromDBSchema

{<BLOCK Name="fct.provinces_PK_provinces_1_selectRowByKey">}
#+ Select a row identified by the primary key in the "provinces" table
#+
#+ @param p_key - Primary Key
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER, LIKE provinces.*
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_NOTFOUND, RECORD LIKE provinces.*
PUBLIC FUNCTION consultcompanion_dbxdata_provinces_PK_provinces_1_selectRowByKey(p_key, p_lock)
    DEFINE p_key
        RECORD
            provinces_provinceid LIKE provinces.provinceid
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE l_data RECORD LIKE provinces.*
    DEFINE l_supportLock BOOLEAN
    DEFINE errNo INTEGER
    {<POINT Name="fct.provinces_PK_provinces_1_selectRowByKey.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    -- SQLite does not support the FOR UPDATE close in SELECT syntax
    LET l_supportLock = (UPSHIFT(fgl_db_driver_type()) != "SQT")
    {<POINT Name="fct.provinces_PK_provinces_1_selectRowByKey.init">} {</POINT>}
    TRY
        IF p_lock AND l_supportLock THEN
            SELECT * INTO l_data.* FROM provinces
                WHERE @provinces.provinceid = p_key.provinces_provinceid
            FOR UPDATE
        ELSE
            SELECT * INTO l_data.* FROM provinces
                WHERE @provinces.provinceid = p_key.provinces_provinceid
        END IF
        IF SQLCA.SQLCODE == NOTFOUND THEN
            LET errNo = ERROR_NOTFOUND
        END IF
    CATCH
        INITIALIZE l_data.* TO NULL
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.provinces_PK_provinces_1_selectRowByKey.afterSelect">} {</POINT>}
    RETURN errNo, l_data.*
END FUNCTION
{</BLOCK>} --fct.provinces_PK_provinces_1_selectRowByKey

{<BLOCK Name="fct.provinces_insertRowByKey">}
#+ Insert a row in the "provinces" table and return the primary key created
#+
#+ @param p_data - a row data LIKE provinces.*
#+
#+ @returnType INTEGER, STRING, SERIAL
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, provinces.provinceid
PRIVATE FUNCTION consultcompanion_dbxdata_provinces_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE provinces.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.provinces_insertRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        CALL libdbapp_get_sequence("provinces") RETURNING errNo, p_data.provinceid
        {<POINT Name="fct.provinces_insertRowByKey.init">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            IF consultcompanion_events.m_DbxDataEvent_provinces_BeforeInsertRowByKey IS NOT NULL THEN
                CALL consultcompanion_events.m_DbxDataEvent_provinces_BeforeInsertRowByKey(p_data.*)
                    RETURNING errNo, errMsg, p_data.*
            END IF
            IF errNo == ERROR_SUCCESS THEN
                CALL consultcompanion_dbxconstraints.consultcompanion_dbxconstraints_provinces_checkTableConstraints(FALSE, p_data.*) RETURNING errNo, errMsg
            END IF
            {<POINT Name="fct.provinces_insertRowByKey.beforeInsert">} {</POINT>}
            IF errNo == ERROR_SUCCESS THEN
                TRY
                    INSERT INTO provinces VALUES (p_data.*)
                    CALL libdbapp_get_inserted_sequence(p_data.provinceid) RETURNING p_data.provinceid
                CATCH
                    LET errNo = ERROR_FAILURE
                END TRY
                IF consultcompanion_events.m_DbxDataEvent_provinces_AfterInsertRowByKey IS NOT NULL THEN
                    CALL consultcompanion_events.m_DbxDataEvent_provinces_AfterInsertRowByKey(p_data.*)
                        RETURNING errNo, errMsg
                END IF
                {<POINT Name="fct.provinces_insertRowByKey.afterInsert">} {</POINT>}
            END IF
        END IF
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg, p_data.provinceid
END FUNCTION
{</BLOCK>} --fct.provinces_insertRowByKey

{<BLOCK Name="fct.provinces_PK_provinces_1_insertRowByKey">}
#+ Insert a row in the "provinces" table and return the table keys
#+
#+ @param p_data - a row data LIKE provinces.*
#+
#+ @returnType INTEGER, STRING, SERIAL
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, provinces.provinceid
PUBLIC FUNCTION consultcompanion_dbxdata_provinces_PK_provinces_1_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE provinces.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.provinces_PK_provinces_1_insertRowByKey.define">} {</POINT>}
    {<POINT Name="fct.provinces_PK_provinces_1_insertRowByKey.init">} {</POINT>}

    CALL consultcompanion_dbxdata_provinces_insertRowByKey(p_data.*) RETURNING errNo, errMsg, p_data.provinceid
    RETURN errNo, errMsg, p_data.provinceid
END FUNCTION
{</BLOCK>} --fct.provinces_PK_provinces_1_insertRowByKey

{<BLOCK Name="fct.provinces_PK_provinces_1_updateRowByKey">}
#+ Update a row identified by the primary key in the "provinces" table
#+
#+ @param p_dataT0 - a row data LIKE provinces.*
#+ @param p_dataT1 - a row data LIKE provinces.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxdata_provinces_PK_provinces_1_updateRowByKey(p_dataT0, p_dataT1)
    DEFINE p_dataT0 RECORD LIKE provinces.*
    DEFINE p_dataT1 RECORD LIKE provinces.*
    DEFINE l_key
        RECORD
            provinces_provinceid LIKE provinces.provinceid
        END RECORD
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.provinces_PK_provinces_1_updateRowByKey.define">} {</POINT>}
    LET l_key.provinces_provinceid = p_dataT0.provinceid
    INITIALIZE errMsg TO NULL
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.provinces_PK_provinces_1_updateRowByKey.init">} {</POINT>}
        TRY
            LET errNo = consultcompanion_dbxdata_provinces_PK_provinces_1_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
            {<POINT Name="fct.provinces_PK_provinces_1_updateRowByKey.afterSelect">} {</POINT>}
            IF errNo == ERROR_SUCCESS THEN
                CALL consultcompanion_dbxconstraints.consultcompanion_dbxconstraints_provinces_checkTableConstraints(TRUE, p_dataT1.*) RETURNING errNo, errMsg
                {<POINT Name="fct.provinces_PK_provinces_1_updateRowByKey.beforeUpdate">} {</POINT>}
                IF errNo == ERROR_SUCCESS THEN
                 IF consultcompanion_events.m_DbxDataEvent_provinces_BeforeUpdateRowByKey IS NOT NULL THEN
                    CALL consultcompanion_events.m_DbxDataEvent_provinces_BeforeUpdateRowByKey(p_dataT1.*)
                        RETURNING errNo, errMsg
                END IF
                    UPDATE provinces
                        SET provinces.* = p_dataT1.*
                        WHERE @provinces.provinceid = l_key.provinces_provinceid
                END IF
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        IF consultcompanion_events.m_DbxDataEvent_provinces_AfterUpdateRowByKey IS NOT NULL THEN
            CALL consultcompanion_events.m_DbxDataEvent_provinces_AfterUpdateRowByKey(p_dataT1.*)
                RETURNING errNo, errMsg
        END IF
        {<POINT Name="fct.provinces_PK_provinces_1_updateRowByKey.afterUpdate">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.provinces_PK_provinces_1_updateRowByKey

{<BLOCK Name="fct.provinces_PK_provinces_1_deleteRowByKey">}
#+ Delete a row identified by the primary key in the "provinces" table
#+
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION consultcompanion_dbxdata_provinces_PK_provinces_1_deleteRowByKey(p_key)
    DEFINE p_key
        RECORD
            provinces_provinceid LIKE provinces.provinceid
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.provinces_PK_provinces_1_deleteRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.provinces_PK_provinces_1_deleteRowByKey.init">} {</POINT>}
        IF consultcompanion_events.m_DbxDataEvent_provinces_BeforeDeleteRowByKey IS NOT NULL THEN
            CALL consultcompanion_events.m_DbxDataEvent_provinces_BeforeDeleteRowByKey(p_key.*)
                RETURNING errNo
        END IF
        TRY
            CALL consultcompanion_dbxdata_provinces_PK_provinces_1_deleteReferencingRowsByKey(p_key.*) RETURNING errNo
            IF errNo == ERROR_SUCCESS THEN
                DELETE FROM provinces
                    WHERE @provinces.provinceid = p_key.provinces_provinceid
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        IF consultcompanion_events.m_DbxDataEvent_provinces_AfterDeleteRowByKey IS NOT NULL THEN
            CALL consultcompanion_events.m_DbxDataEvent_provinces_AfterDeleteRowByKey(p_key.*)
                RETURNING errNo
        END IF
        {<POINT Name="fct.provinces_PK_provinces_1_deleteRowByKey.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.provinces_PK_provinces_1_deleteRowByKey

{<BLOCK Name="fct.provinces_PK_provinces_1_deleteRowByKeyWithConcurrentAccess">}
#+ Delete a row identified by the primary key in the "provinces" table if the concurrent access is success
#+
#+ @param p_dataT0 - a row data LIKE provinces.*
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION consultcompanion_dbxdata_provinces_PK_provinces_1_deleteRowByKeyWithConcurrentAccess(p_dataT0)
    DEFINE p_dataT0 RECORD LIKE provinces.*
    DEFINE l_key
        RECORD
            provinces_provinceid LIKE provinces.provinceid
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.provinces_PK_provinces_1_deleteRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.provinces_provinceid = p_dataT0.provinceid
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.provinces_PK_provinces_1_deleteRowByKeyWithConcurrentAccess.init">} {</POINT>}
        LET errNo = consultcompanion_dbxdata_provinces_PK_provinces_1_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
        {<POINT Name="fct.provinces_PK_provinces_1_deleteRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = consultcompanion_dbxdata_provinces_PK_provinces_1_deleteRowByKey(l_key.*)
        END IF
        {<POINT Name="fct.provinces_PK_provinces_1_deleteRowByKeyWithConcurrentAccess.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.provinces_PK_provinces_1_deleteRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.provinces_PK_provinces_1_checkRowByKeyWithConcurrentAccess">}
#+ Check if a row identified by the primary key in the "provinces" table has been modified or deleted
#+
#+ @param p_dataT0 - a row data LIKE provinces.*
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE
PUBLIC FUNCTION consultcompanion_dbxdata_provinces_PK_provinces_1_checkRowByKeyWithConcurrentAccess(p_dataT0, p_lock)
    DEFINE p_dataT0 RECORD LIKE provinces.*
    DEFINE l_dataT2 RECORD LIKE provinces.*
    DEFINE l_key
        RECORD
            provinces_provinceid LIKE provinces.provinceid
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE errNo INTEGER
    DEFINE errDiff INTEGER
    {<POINT Name="fct.provinces_PK_provinces_1_checkRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.provinces_provinceid = p_dataT0.provinceid
    INITIALIZE l_dataT2.* TO NULL
    LET errDiff = FALSE
    {<POINT Name="fct.provinces_PK_provinces_1_checkRowByKeyWithConcurrentAccess.init">} {</POINT>}
    CALL consultcompanion_dbxdata_provinces_PK_provinces_1_selectRowByKey(l_key.*, p_lock) RETURNING errNo, l_dataT2.*
    CASE errNo
        WHEN ERROR_SUCCESS
            LET errDiff = (p_dataT0.* != l_dataT2.*)
            {<POINT Name="fct.provinces_PK_provinces_1_checkRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
            IF NOT errDiff THEN
                LET errNo = ERROR_SUCCESS
            ELSE
                LET errNo = ERROR_CONCURRENT_ACCESS_FAILURE
            END IF
        WHEN ERROR_NOTFOUND
            LET errNo = ERROR_CONCURRENT_ACCESS_NOTFOUND
    END CASE
    {<POINT Name="fct.provinces_PK_provinces_1_checkRowByKeyWithConcurrentAccess.afterCheck">} {</POINT>}
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.provinces_PK_provinces_1_checkRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.provinces_PK_provinces_1_deleteReferencingRowsByKey">}
#+ Delete rows referencing the primary key of the "provinces" table
#+
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION consultcompanion_dbxdata_provinces_PK_provinces_1_deleteReferencingRowsByKey(p_key)
    DEFINE p_key
        RECORD
            provinces_provinceid LIKE provinces.provinceid
        END RECORD
    DEFINE l_data RECORD LIKE provinces.*
    DEFINE l_key_FK_employees_provinces_1
        RECORD
            employees_employeeid LIKE employees.employeeid
        END RECORD
    DEFINE l_key_FK_clients_provinces_1
        RECORD
            clients_clientid LIKE clients.clientid
        END RECORD
    DEFINE errNo INTEGER
    DEFINE l_sqlQuery STRING
    {<POINT Name="fct.provinces_PK_provinces_1_deleteReferencingRowsByKey.define">} {</POINT>}

    INITIALIZE l_data.* TO NULL
    {<POINT Name="fct.provinces_PK_provinces_1_deleteReferencingRowsByKey.init">} {</POINT>}
    CALL consultcompanion_dbxdata_provinces_PK_provinces_1_selectRowByKey(p_key.*, FALSE)
        RETURNING errNo, l_data.*
    CASE errNo
        WHEN ERROR_SUCCESS
            --check Foreign Key FK_employees_provinces_1
            LET l_sqlQuery = "SELECT employeeid FROM employees WHERE employees.provinceId = ?"
            TRY
                DECLARE consultcompanion_dbxdata_provinces_PK_provinces_1_deleteReferencingRowsByKey_FK_employees_provinces_1 CURSOR FROM l_sqlQuery
                OPEN consultcompanion_dbxdata_provinces_PK_provinces_1_deleteReferencingRowsByKey_FK_employees_provinces_1
                    USING l_data.provinceid
                FETCH consultcompanion_dbxdata_provinces_PK_provinces_1_deleteReferencingRowsByKey_FK_employees_provinces_1
                    INTO l_key_FK_employees_provinces_1.*
                IF SQLCA.SQLCODE = 0 THEN
                    LET errNo = ERROR_DELETE_CASCADE_ROW_USED
                END IF
                CLOSE consultcompanion_dbxdata_provinces_PK_provinces_1_deleteReferencingRowsByKey_FK_employees_provinces_1
            CATCH
                LET errNo = ERROR_FAILURE
            END TRY

            IF errNo == ERROR_SUCCESS THEN
                --check Foreign Key FK_clients_provinces_1
                LET l_sqlQuery = "SELECT clientid FROM clients WHERE clients.provinceid = ?"
                TRY
                    DECLARE consultcompanion_dbxdata_provinces_PK_provinces_1_deleteReferencingRowsByKey_FK_clients_provinces_1 CURSOR FROM l_sqlQuery
                    OPEN consultcompanion_dbxdata_provinces_PK_provinces_1_deleteReferencingRowsByKey_FK_clients_provinces_1
                        USING l_data.provinceid
                    FETCH consultcompanion_dbxdata_provinces_PK_provinces_1_deleteReferencingRowsByKey_FK_clients_provinces_1
                        INTO l_key_FK_clients_provinces_1.*
                    IF SQLCA.SQLCODE = 0 THEN
                        LET errNo = ERROR_DELETE_CASCADE_ROW_USED
                    END IF
                    CLOSE consultcompanion_dbxdata_provinces_PK_provinces_1_deleteReferencingRowsByKey_FK_clients_provinces_1
                CATCH
                    LET errNo = ERROR_FAILURE
                END TRY

            END IF
        WHEN ERROR_NOTFOUND
            LET errNo = ERROR_SUCCESS
    END CASE
    {<POINT Name="fct.provinces_PK_provinces_1_deleteReferencingRowsByKey.afterDelete">} {</POINT>}
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.provinces_PK_provinces_1_deleteReferencingRowsByKey

{<BLOCK Name="fct.provinces_setDefaultValuesFromDBSchema">}
#+ Set data with the default values coming from the DB schema
#+
PUBLIC FUNCTION consultcompanion_dbxdata_provinces_setDefaultValuesFromDBSchema()
    DEFINE l_data RECORD LIKE provinces.*
    {<POINT Name="fct.provinces_setDefaultValuesFromDBSchema.define">} {</POINT>}

    INITIALIZE l_data.* TO NULL
    {<POINT Name="fct.provinces_setDefaultValuesFromDBSchema.init">} {</POINT>}
    IF consultcompanion_events.m_DbxDataEvent_provinces_SetDefaultValues IS NOT NULL THEN
        CALL consultcompanion_events.m_DbxDataEvent_provinces_SetDefaultValues(l_data.*)
            RETURNING l_data.*
    END IF
    RETURN l_data.*
END FUNCTION
{</BLOCK>} --fct.provinces_setDefaultValuesFromDBSchema

{<BLOCK Name="fct.projects_PK_projects_1_selectRowByKey">}
#+ Select a row identified by the primary key in the "projects" table
#+
#+ @param p_key - Primary Key
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER, LIKE projects.*
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_NOTFOUND, RECORD LIKE projects.*
PUBLIC FUNCTION consultcompanion_dbxdata_projects_PK_projects_1_selectRowByKey(p_key, p_lock)
    DEFINE p_key
        RECORD
            projects_projectId LIKE projects.projectId
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE l_data RECORD LIKE projects.*
    DEFINE l_supportLock BOOLEAN
    DEFINE errNo INTEGER
    {<POINT Name="fct.projects_PK_projects_1_selectRowByKey.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    -- SQLite does not support the FOR UPDATE close in SELECT syntax
    LET l_supportLock = (UPSHIFT(fgl_db_driver_type()) != "SQT")
    {<POINT Name="fct.projects_PK_projects_1_selectRowByKey.init">} {</POINT>}
    TRY
        IF p_lock AND l_supportLock THEN
            SELECT * INTO l_data.* FROM projects
                WHERE @projects.projectId = p_key.projects_projectId
            FOR UPDATE
        ELSE
            SELECT * INTO l_data.* FROM projects
                WHERE @projects.projectId = p_key.projects_projectId
        END IF
        IF SQLCA.SQLCODE == NOTFOUND THEN
            LET errNo = ERROR_NOTFOUND
        END IF
    CATCH
        INITIALIZE l_data.* TO NULL
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.projects_PK_projects_1_selectRowByKey.afterSelect">} {</POINT>}
    RETURN errNo, l_data.*
END FUNCTION
{</BLOCK>} --fct.projects_PK_projects_1_selectRowByKey

{<BLOCK Name="fct.projects_insertRowByKey">}
#+ Insert a row in the "projects" table and return the primary key created
#+
#+ @param p_data - a row data LIKE projects.*
#+
#+ @returnType INTEGER, STRING, SERIAL
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, projects.projectId
PRIVATE FUNCTION consultcompanion_dbxdata_projects_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE projects.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.projects_insertRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        CALL libdbapp_get_sequence("projects") RETURNING errNo, p_data.projectId
        {<POINT Name="fct.projects_insertRowByKey.init">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            IF consultcompanion_events.m_DbxDataEvent_projects_BeforeInsertRowByKey IS NOT NULL THEN
                CALL consultcompanion_events.m_DbxDataEvent_projects_BeforeInsertRowByKey(p_data.*)
                    RETURNING errNo, errMsg, p_data.*
            END IF
            IF errNo == ERROR_SUCCESS THEN
                CALL consultcompanion_dbxconstraints.consultcompanion_dbxconstraints_projects_checkTableConstraints(FALSE, p_data.*) RETURNING errNo, errMsg
            END IF
            {<POINT Name="fct.projects_insertRowByKey.beforeInsert">} {</POINT>}
            IF errNo == ERROR_SUCCESS THEN
                TRY
                    INSERT INTO projects VALUES (p_data.*)
                    CALL libdbapp_get_inserted_sequence(p_data.projectId) RETURNING p_data.projectId
                CATCH
                    LET errNo = ERROR_FAILURE
                END TRY
                IF consultcompanion_events.m_DbxDataEvent_projects_AfterInsertRowByKey IS NOT NULL THEN
                    CALL consultcompanion_events.m_DbxDataEvent_projects_AfterInsertRowByKey(p_data.*)
                        RETURNING errNo, errMsg
                END IF
                {<POINT Name="fct.projects_insertRowByKey.afterInsert">} {</POINT>}
            END IF
        END IF
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg, p_data.projectId
END FUNCTION
{</BLOCK>} --fct.projects_insertRowByKey

{<BLOCK Name="fct.projects_PK_projects_1_insertRowByKey">}
#+ Insert a row in the "projects" table and return the table keys
#+
#+ @param p_data - a row data LIKE projects.*
#+
#+ @returnType INTEGER, STRING, SERIAL
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, projects.projectId
PUBLIC FUNCTION consultcompanion_dbxdata_projects_PK_projects_1_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE projects.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.projects_PK_projects_1_insertRowByKey.define">} {</POINT>}
    {<POINT Name="fct.projects_PK_projects_1_insertRowByKey.init">} {</POINT>}

    CALL consultcompanion_dbxdata_projects_insertRowByKey(p_data.*) RETURNING errNo, errMsg, p_data.projectId
    RETURN errNo, errMsg, p_data.projectId
END FUNCTION
{</BLOCK>} --fct.projects_PK_projects_1_insertRowByKey

{<BLOCK Name="fct.projects_PK_projects_1_updateRowByKey">}
#+ Update a row identified by the primary key in the "projects" table
#+
#+ @param p_dataT0 - a row data LIKE projects.*
#+ @param p_dataT1 - a row data LIKE projects.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxdata_projects_PK_projects_1_updateRowByKey(p_dataT0, p_dataT1)
    DEFINE p_dataT0 RECORD LIKE projects.*
    DEFINE p_dataT1 RECORD LIKE projects.*
    DEFINE l_key
        RECORD
            projects_projectId LIKE projects.projectId
        END RECORD
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.projects_PK_projects_1_updateRowByKey.define">} {</POINT>}
    LET l_key.projects_projectId = p_dataT0.projectId
    INITIALIZE errMsg TO NULL
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.projects_PK_projects_1_updateRowByKey.init">} {</POINT>}
        TRY
            LET errNo = consultcompanion_dbxdata_projects_PK_projects_1_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
            {<POINT Name="fct.projects_PK_projects_1_updateRowByKey.afterSelect">} {</POINT>}
            IF errNo == ERROR_SUCCESS THEN
                CALL consultcompanion_dbxconstraints.consultcompanion_dbxconstraints_projects_checkTableConstraints(TRUE, p_dataT1.*) RETURNING errNo, errMsg
                {<POINT Name="fct.projects_PK_projects_1_updateRowByKey.beforeUpdate">} {</POINT>}
                IF errNo == ERROR_SUCCESS THEN
                 IF consultcompanion_events.m_DbxDataEvent_projects_BeforeUpdateRowByKey IS NOT NULL THEN
                    CALL consultcompanion_events.m_DbxDataEvent_projects_BeforeUpdateRowByKey(p_dataT1.*)
                        RETURNING errNo, errMsg
                END IF
                    UPDATE projects
                        SET projects.* = p_dataT1.*
                        WHERE @projects.projectId = l_key.projects_projectId
                END IF
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        IF consultcompanion_events.m_DbxDataEvent_projects_AfterUpdateRowByKey IS NOT NULL THEN
            CALL consultcompanion_events.m_DbxDataEvent_projects_AfterUpdateRowByKey(p_dataT1.*)
                RETURNING errNo, errMsg
        END IF
        {<POINT Name="fct.projects_PK_projects_1_updateRowByKey.afterUpdate">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.projects_PK_projects_1_updateRowByKey

{<BLOCK Name="fct.projects_PK_projects_1_deleteRowByKey">}
#+ Delete a row identified by the primary key in the "projects" table
#+
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION consultcompanion_dbxdata_projects_PK_projects_1_deleteRowByKey(p_key)
    DEFINE p_key
        RECORD
            projects_projectId LIKE projects.projectId
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.projects_PK_projects_1_deleteRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.projects_PK_projects_1_deleteRowByKey.init">} {</POINT>}
        IF consultcompanion_events.m_DbxDataEvent_projects_BeforeDeleteRowByKey IS NOT NULL THEN
            CALL consultcompanion_events.m_DbxDataEvent_projects_BeforeDeleteRowByKey(p_key.*)
                RETURNING errNo
        END IF
        TRY
            DELETE FROM projects
                WHERE @projects.projectId = p_key.projects_projectId
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        IF consultcompanion_events.m_DbxDataEvent_projects_AfterDeleteRowByKey IS NOT NULL THEN
            CALL consultcompanion_events.m_DbxDataEvent_projects_AfterDeleteRowByKey(p_key.*)
                RETURNING errNo
        END IF
        {<POINT Name="fct.projects_PK_projects_1_deleteRowByKey.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.projects_PK_projects_1_deleteRowByKey

{<BLOCK Name="fct.projects_PK_projects_1_deleteRowByKeyWithConcurrentAccess">}
#+ Delete a row identified by the primary key in the "projects" table if the concurrent access is success
#+
#+ @param p_dataT0 - a row data LIKE projects.*
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION consultcompanion_dbxdata_projects_PK_projects_1_deleteRowByKeyWithConcurrentAccess(p_dataT0)
    DEFINE p_dataT0 RECORD LIKE projects.*
    DEFINE l_key
        RECORD
            projects_projectId LIKE projects.projectId
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.projects_PK_projects_1_deleteRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.projects_projectId = p_dataT0.projectId
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.projects_PK_projects_1_deleteRowByKeyWithConcurrentAccess.init">} {</POINT>}
        LET errNo = consultcompanion_dbxdata_projects_PK_projects_1_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
        {<POINT Name="fct.projects_PK_projects_1_deleteRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = consultcompanion_dbxdata_projects_PK_projects_1_deleteRowByKey(l_key.*)
        END IF
        {<POINT Name="fct.projects_PK_projects_1_deleteRowByKeyWithConcurrentAccess.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.projects_PK_projects_1_deleteRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.projects_PK_projects_1_checkRowByKeyWithConcurrentAccess">}
#+ Check if a row identified by the primary key in the "projects" table has been modified or deleted
#+
#+ @param p_dataT0 - a row data LIKE projects.*
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE
PUBLIC FUNCTION consultcompanion_dbxdata_projects_PK_projects_1_checkRowByKeyWithConcurrentAccess(p_dataT0, p_lock)
    DEFINE p_dataT0 RECORD LIKE projects.*
    DEFINE l_dataT2 RECORD LIKE projects.*
    DEFINE l_key
        RECORD
            projects_projectId LIKE projects.projectId
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE errNo INTEGER
    DEFINE errDiff INTEGER
    {<POINT Name="fct.projects_PK_projects_1_checkRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.projects_projectId = p_dataT0.projectId
    INITIALIZE l_dataT2.* TO NULL
    LET errDiff = FALSE
    {<POINT Name="fct.projects_PK_projects_1_checkRowByKeyWithConcurrentAccess.init">} {</POINT>}
    CALL consultcompanion_dbxdata_projects_PK_projects_1_selectRowByKey(l_key.*, p_lock) RETURNING errNo, l_dataT2.*
    CASE errNo
        WHEN ERROR_SUCCESS
            LET errDiff = (p_dataT0.* != l_dataT2.*)
            {<POINT Name="fct.projects_PK_projects_1_checkRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
            IF NOT errDiff THEN
                LET errNo = ERROR_SUCCESS
            ELSE
                LET errNo = ERROR_CONCURRENT_ACCESS_FAILURE
            END IF
        WHEN ERROR_NOTFOUND
            LET errNo = ERROR_CONCURRENT_ACCESS_NOTFOUND
    END CASE
    {<POINT Name="fct.projects_PK_projects_1_checkRowByKeyWithConcurrentAccess.afterCheck">} {</POINT>}
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.projects_PK_projects_1_checkRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.projects_setDefaultValuesFromDBSchema">}
#+ Set data with the default values coming from the DB schema
#+
PUBLIC FUNCTION consultcompanion_dbxdata_projects_setDefaultValuesFromDBSchema()
    DEFINE l_data RECORD LIKE projects.*
    {<POINT Name="fct.projects_setDefaultValuesFromDBSchema.define">} {</POINT>}

    INITIALIZE l_data.* TO NULL
    {<POINT Name="fct.projects_setDefaultValuesFromDBSchema.init">} {</POINT>}
    IF consultcompanion_events.m_DbxDataEvent_projects_SetDefaultValues IS NOT NULL THEN
        CALL consultcompanion_events.m_DbxDataEvent_projects_SetDefaultValues(l_data.*)
            RETURNING l_data.*
    END IF
    RETURN l_data.*
END FUNCTION
{</BLOCK>} --fct.projects_setDefaultValuesFromDBSchema

{<BLOCK Name="fct.preferences_PK_preferences_1_selectRowByKey">}
#+ Select a row identified by the primary key in the "preferences" table
#+
#+ @param p_key - Primary Key
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER, LIKE preferences.*
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_NOTFOUND, RECORD LIKE preferences.*
PUBLIC FUNCTION consultcompanion_dbxdata_preferences_PK_preferences_1_selectRowByKey(p_key, p_lock)
    DEFINE p_key
        RECORD
            preferences_seqid LIKE preferences.seqid
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE l_data RECORD LIKE preferences.*
    DEFINE l_supportLock BOOLEAN
    DEFINE errNo INTEGER
    {<POINT Name="fct.preferences_PK_preferences_1_selectRowByKey.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    -- SQLite does not support the FOR UPDATE close in SELECT syntax
    LET l_supportLock = (UPSHIFT(fgl_db_driver_type()) != "SQT")
    {<POINT Name="fct.preferences_PK_preferences_1_selectRowByKey.init">} {</POINT>}
    TRY
        IF p_lock AND l_supportLock THEN
            SELECT * INTO l_data.* FROM preferences
                WHERE @preferences.seqid = p_key.preferences_seqid
            FOR UPDATE
        ELSE
            SELECT * INTO l_data.* FROM preferences
                WHERE @preferences.seqid = p_key.preferences_seqid
        END IF
        IF SQLCA.SQLCODE == NOTFOUND THEN
            LET errNo = ERROR_NOTFOUND
        END IF
    CATCH
        INITIALIZE l_data.* TO NULL
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.preferences_PK_preferences_1_selectRowByKey.afterSelect">} {</POINT>}
    RETURN errNo, l_data.*
END FUNCTION
{</BLOCK>} --fct.preferences_PK_preferences_1_selectRowByKey

{<BLOCK Name="fct.preferences_insertRowByKey">}
#+ Insert a row in the "preferences" table and return the primary key created
#+
#+ @param p_data - a row data LIKE preferences.*
#+
#+ @returnType INTEGER, STRING, SERIAL
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, preferences.seqid
PRIVATE FUNCTION consultcompanion_dbxdata_preferences_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE preferences.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.preferences_insertRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        CALL libdbapp_get_sequence("preferences") RETURNING errNo, p_data.seqid
        {<POINT Name="fct.preferences_insertRowByKey.init">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            IF consultcompanion_events.m_DbxDataEvent_preferences_BeforeInsertRowByKey IS NOT NULL THEN
                CALL consultcompanion_events.m_DbxDataEvent_preferences_BeforeInsertRowByKey(p_data.*)
                    RETURNING errNo, errMsg, p_data.*
            END IF
            IF errNo == ERROR_SUCCESS THEN
                CALL consultcompanion_dbxconstraints.consultcompanion_dbxconstraints_preferences_checkTableConstraints(FALSE, p_data.*) RETURNING errNo, errMsg
            END IF
            {<POINT Name="fct.preferences_insertRowByKey.beforeInsert">} {</POINT>}
            IF errNo == ERROR_SUCCESS THEN
                TRY
                    INSERT INTO preferences VALUES (p_data.*)
                    CALL libdbapp_get_inserted_sequence(p_data.seqid) RETURNING p_data.seqid
                CATCH
                    LET errNo = ERROR_FAILURE
                END TRY
                IF consultcompanion_events.m_DbxDataEvent_preferences_AfterInsertRowByKey IS NOT NULL THEN
                    CALL consultcompanion_events.m_DbxDataEvent_preferences_AfterInsertRowByKey(p_data.*)
                        RETURNING errNo, errMsg
                END IF
                {<POINT Name="fct.preferences_insertRowByKey.afterInsert">} {</POINT>}
            END IF
        END IF
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg, p_data.seqid
END FUNCTION
{</BLOCK>} --fct.preferences_insertRowByKey

{<BLOCK Name="fct.preferences_PK_preferences_1_insertRowByKey">}
#+ Insert a row in the "preferences" table and return the table keys
#+
#+ @param p_data - a row data LIKE preferences.*
#+
#+ @returnType INTEGER, STRING, SERIAL
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, preferences.seqid
PUBLIC FUNCTION consultcompanion_dbxdata_preferences_PK_preferences_1_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE preferences.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.preferences_PK_preferences_1_insertRowByKey.define">} {</POINT>}
    {<POINT Name="fct.preferences_PK_preferences_1_insertRowByKey.init">} {</POINT>}

    CALL consultcompanion_dbxdata_preferences_insertRowByKey(p_data.*) RETURNING errNo, errMsg, p_data.seqid
    RETURN errNo, errMsg, p_data.seqid
END FUNCTION
{</BLOCK>} --fct.preferences_PK_preferences_1_insertRowByKey

{<BLOCK Name="fct.preferences_PK_preferences_1_updateRowByKey">}
#+ Update a row identified by the primary key in the "preferences" table
#+
#+ @param p_dataT0 - a row data LIKE preferences.*
#+ @param p_dataT1 - a row data LIKE preferences.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxdata_preferences_PK_preferences_1_updateRowByKey(p_dataT0, p_dataT1)
    DEFINE p_dataT0 RECORD LIKE preferences.*
    DEFINE p_dataT1 RECORD LIKE preferences.*
    DEFINE l_key
        RECORD
            preferences_seqid LIKE preferences.seqid
        END RECORD
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.preferences_PK_preferences_1_updateRowByKey.define">} {</POINT>}
    LET l_key.preferences_seqid = p_dataT0.seqid
    INITIALIZE errMsg TO NULL
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.preferences_PK_preferences_1_updateRowByKey.init">} {</POINT>}
        TRY
            LET errNo = consultcompanion_dbxdata_preferences_PK_preferences_1_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
            {<POINT Name="fct.preferences_PK_preferences_1_updateRowByKey.afterSelect">} {</POINT>}
            IF errNo == ERROR_SUCCESS THEN
                CALL consultcompanion_dbxconstraints.consultcompanion_dbxconstraints_preferences_checkTableConstraints(TRUE, p_dataT1.*) RETURNING errNo, errMsg
                {<POINT Name="fct.preferences_PK_preferences_1_updateRowByKey.beforeUpdate">} {</POINT>}
                IF errNo == ERROR_SUCCESS THEN
                 IF consultcompanion_events.m_DbxDataEvent_preferences_BeforeUpdateRowByKey IS NOT NULL THEN
                    CALL consultcompanion_events.m_DbxDataEvent_preferences_BeforeUpdateRowByKey(p_dataT1.*)
                        RETURNING errNo, errMsg
                END IF
                    UPDATE preferences
                        SET preferences.* = p_dataT1.*
                        WHERE @preferences.seqid = l_key.preferences_seqid
                END IF
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        IF consultcompanion_events.m_DbxDataEvent_preferences_AfterUpdateRowByKey IS NOT NULL THEN
            CALL consultcompanion_events.m_DbxDataEvent_preferences_AfterUpdateRowByKey(p_dataT1.*)
                RETURNING errNo, errMsg
        END IF
        {<POINT Name="fct.preferences_PK_preferences_1_updateRowByKey.afterUpdate">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.preferences_PK_preferences_1_updateRowByKey

{<BLOCK Name="fct.preferences_PK_preferences_1_deleteRowByKey">}
#+ Delete a row identified by the primary key in the "preferences" table
#+
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION consultcompanion_dbxdata_preferences_PK_preferences_1_deleteRowByKey(p_key)
    DEFINE p_key
        RECORD
            preferences_seqid LIKE preferences.seqid
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.preferences_PK_preferences_1_deleteRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.preferences_PK_preferences_1_deleteRowByKey.init">} {</POINT>}
        IF consultcompanion_events.m_DbxDataEvent_preferences_BeforeDeleteRowByKey IS NOT NULL THEN
            CALL consultcompanion_events.m_DbxDataEvent_preferences_BeforeDeleteRowByKey(p_key.*)
                RETURNING errNo
        END IF
        TRY
            DELETE FROM preferences
                WHERE @preferences.seqid = p_key.preferences_seqid
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        IF consultcompanion_events.m_DbxDataEvent_preferences_AfterDeleteRowByKey IS NOT NULL THEN
            CALL consultcompanion_events.m_DbxDataEvent_preferences_AfterDeleteRowByKey(p_key.*)
                RETURNING errNo
        END IF
        {<POINT Name="fct.preferences_PK_preferences_1_deleteRowByKey.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.preferences_PK_preferences_1_deleteRowByKey

{<BLOCK Name="fct.preferences_PK_preferences_1_deleteRowByKeyWithConcurrentAccess">}
#+ Delete a row identified by the primary key in the "preferences" table if the concurrent access is success
#+
#+ @param p_dataT0 - a row data LIKE preferences.*
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION consultcompanion_dbxdata_preferences_PK_preferences_1_deleteRowByKeyWithConcurrentAccess(p_dataT0)
    DEFINE p_dataT0 RECORD LIKE preferences.*
    DEFINE l_key
        RECORD
            preferences_seqid LIKE preferences.seqid
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.preferences_PK_preferences_1_deleteRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.preferences_seqid = p_dataT0.seqid
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.preferences_PK_preferences_1_deleteRowByKeyWithConcurrentAccess.init">} {</POINT>}
        LET errNo = consultcompanion_dbxdata_preferences_PK_preferences_1_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
        {<POINT Name="fct.preferences_PK_preferences_1_deleteRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = consultcompanion_dbxdata_preferences_PK_preferences_1_deleteRowByKey(l_key.*)
        END IF
        {<POINT Name="fct.preferences_PK_preferences_1_deleteRowByKeyWithConcurrentAccess.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.preferences_PK_preferences_1_deleteRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.preferences_PK_preferences_1_checkRowByKeyWithConcurrentAccess">}
#+ Check if a row identified by the primary key in the "preferences" table has been modified or deleted
#+
#+ @param p_dataT0 - a row data LIKE preferences.*
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE
PUBLIC FUNCTION consultcompanion_dbxdata_preferences_PK_preferences_1_checkRowByKeyWithConcurrentAccess(p_dataT0, p_lock)
    DEFINE p_dataT0 RECORD LIKE preferences.*
    DEFINE l_dataT2 RECORD LIKE preferences.*
    DEFINE l_key
        RECORD
            preferences_seqid LIKE preferences.seqid
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE errNo INTEGER
    DEFINE errDiff INTEGER
    {<POINT Name="fct.preferences_PK_preferences_1_checkRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.preferences_seqid = p_dataT0.seqid
    INITIALIZE l_dataT2.* TO NULL
    LET errDiff = FALSE
    {<POINT Name="fct.preferences_PK_preferences_1_checkRowByKeyWithConcurrentAccess.init">} {</POINT>}
    CALL consultcompanion_dbxdata_preferences_PK_preferences_1_selectRowByKey(l_key.*, p_lock) RETURNING errNo, l_dataT2.*
    CASE errNo
        WHEN ERROR_SUCCESS
            LET errDiff = (p_dataT0.* != l_dataT2.*)
            {<POINT Name="fct.preferences_PK_preferences_1_checkRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
            IF NOT errDiff THEN
                LET errNo = ERROR_SUCCESS
            ELSE
                LET errNo = ERROR_CONCURRENT_ACCESS_FAILURE
            END IF
        WHEN ERROR_NOTFOUND
            LET errNo = ERROR_CONCURRENT_ACCESS_NOTFOUND
    END CASE
    {<POINT Name="fct.preferences_PK_preferences_1_checkRowByKeyWithConcurrentAccess.afterCheck">} {</POINT>}
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.preferences_PK_preferences_1_checkRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.preferences_setDefaultValuesFromDBSchema">}
#+ Set data with the default values coming from the DB schema
#+
PUBLIC FUNCTION consultcompanion_dbxdata_preferences_setDefaultValuesFromDBSchema()
    DEFINE l_data RECORD LIKE preferences.*
    {<POINT Name="fct.preferences_setDefaultValuesFromDBSchema.define">} {</POINT>}

    INITIALIZE l_data.* TO NULL
    {<POINT Name="fct.preferences_setDefaultValuesFromDBSchema.init">} {</POINT>}
    IF consultcompanion_events.m_DbxDataEvent_preferences_SetDefaultValues IS NOT NULL THEN
        CALL consultcompanion_events.m_DbxDataEvent_preferences_SetDefaultValues(l_data.*)
            RETURNING l_data.*
    END IF
    RETURN l_data.*
END FUNCTION
{</BLOCK>} --fct.preferences_setDefaultValuesFromDBSchema

{<BLOCK Name="fct.paymentterms_PK_paymentTerms_1_selectRowByKey">}
#+ Select a row identified by the primary key in the "paymentterms" table
#+
#+ @param p_key - Primary Key
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER, LIKE paymentterms.*
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_NOTFOUND, RECORD LIKE paymentterms.*
PUBLIC FUNCTION consultcompanion_dbxdata_paymentterms_PK_paymentTerms_1_selectRowByKey(p_key, p_lock)
    DEFINE p_key
        RECORD
            paymentterms_paytermid LIKE paymentterms.paytermid
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE l_data RECORD LIKE paymentterms.*
    DEFINE l_supportLock BOOLEAN
    DEFINE errNo INTEGER
    {<POINT Name="fct.paymentterms_PK_paymentTerms_1_selectRowByKey.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    -- SQLite does not support the FOR UPDATE close in SELECT syntax
    LET l_supportLock = (UPSHIFT(fgl_db_driver_type()) != "SQT")
    {<POINT Name="fct.paymentterms_PK_paymentTerms_1_selectRowByKey.init">} {</POINT>}
    TRY
        IF p_lock AND l_supportLock THEN
            SELECT * INTO l_data.* FROM paymentterms
                WHERE @paymentterms.paytermid = p_key.paymentterms_paytermid
            FOR UPDATE
        ELSE
            SELECT * INTO l_data.* FROM paymentterms
                WHERE @paymentterms.paytermid = p_key.paymentterms_paytermid
        END IF
        IF SQLCA.SQLCODE == NOTFOUND THEN
            LET errNo = ERROR_NOTFOUND
        END IF
    CATCH
        INITIALIZE l_data.* TO NULL
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.paymentterms_PK_paymentTerms_1_selectRowByKey.afterSelect">} {</POINT>}
    RETURN errNo, l_data.*
END FUNCTION
{</BLOCK>} --fct.paymentterms_PK_paymentTerms_1_selectRowByKey

{<BLOCK Name="fct.paymentterms_insertRowByKey">}
#+ Insert a row in the "paymentterms" table and return the primary key created
#+
#+ @param p_data - a row data LIKE paymentterms.*
#+
#+ @returnType INTEGER, STRING, SERIAL
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, paymentterms.paytermid
PRIVATE FUNCTION consultcompanion_dbxdata_paymentterms_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE paymentterms.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.paymentterms_insertRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        CALL libdbapp_get_sequence("paymentterms") RETURNING errNo, p_data.paytermid
        {<POINT Name="fct.paymentterms_insertRowByKey.init">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            IF consultcompanion_events.m_DbxDataEvent_paymentterms_BeforeInsertRowByKey IS NOT NULL THEN
                CALL consultcompanion_events.m_DbxDataEvent_paymentterms_BeforeInsertRowByKey(p_data.*)
                    RETURNING errNo, errMsg, p_data.*
            END IF
            IF errNo == ERROR_SUCCESS THEN
                CALL consultcompanion_dbxconstraints.consultcompanion_dbxconstraints_paymentterms_checkTableConstraints(FALSE, p_data.*) RETURNING errNo, errMsg
            END IF
            {<POINT Name="fct.paymentterms_insertRowByKey.beforeInsert">} {</POINT>}
            IF errNo == ERROR_SUCCESS THEN
                TRY
                    INSERT INTO paymentterms VALUES (p_data.*)
                    CALL libdbapp_get_inserted_sequence(p_data.paytermid) RETURNING p_data.paytermid
                CATCH
                    LET errNo = ERROR_FAILURE
                END TRY
                IF consultcompanion_events.m_DbxDataEvent_paymentterms_AfterInsertRowByKey IS NOT NULL THEN
                    CALL consultcompanion_events.m_DbxDataEvent_paymentterms_AfterInsertRowByKey(p_data.*)
                        RETURNING errNo, errMsg
                END IF
                {<POINT Name="fct.paymentterms_insertRowByKey.afterInsert">} {</POINT>}
            END IF
        END IF
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg, p_data.paytermid
END FUNCTION
{</BLOCK>} --fct.paymentterms_insertRowByKey

{<BLOCK Name="fct.paymentterms_PK_paymentTerms_1_insertRowByKey">}
#+ Insert a row in the "paymentterms" table and return the table keys
#+
#+ @param p_data - a row data LIKE paymentterms.*
#+
#+ @returnType INTEGER, STRING, SERIAL
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, paymentterms.paytermid
PUBLIC FUNCTION consultcompanion_dbxdata_paymentterms_PK_paymentTerms_1_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE paymentterms.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.paymentterms_PK_paymentTerms_1_insertRowByKey.define">} {</POINT>}
    {<POINT Name="fct.paymentterms_PK_paymentTerms_1_insertRowByKey.init">} {</POINT>}

    CALL consultcompanion_dbxdata_paymentterms_insertRowByKey(p_data.*) RETURNING errNo, errMsg, p_data.paytermid
    RETURN errNo, errMsg, p_data.paytermid
END FUNCTION
{</BLOCK>} --fct.paymentterms_PK_paymentTerms_1_insertRowByKey

{<BLOCK Name="fct.paymentterms_PK_paymentTerms_1_updateRowByKey">}
#+ Update a row identified by the primary key in the "paymentterms" table
#+
#+ @param p_dataT0 - a row data LIKE paymentterms.*
#+ @param p_dataT1 - a row data LIKE paymentterms.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxdata_paymentterms_PK_paymentTerms_1_updateRowByKey(p_dataT0, p_dataT1)
    DEFINE p_dataT0 RECORD LIKE paymentterms.*
    DEFINE p_dataT1 RECORD LIKE paymentterms.*
    DEFINE l_key
        RECORD
            paymentterms_paytermid LIKE paymentterms.paytermid
        END RECORD
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.paymentterms_PK_paymentTerms_1_updateRowByKey.define">} {</POINT>}
    LET l_key.paymentterms_paytermid = p_dataT0.paytermid
    INITIALIZE errMsg TO NULL
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.paymentterms_PK_paymentTerms_1_updateRowByKey.init">} {</POINT>}
        TRY
            LET errNo = consultcompanion_dbxdata_paymentterms_PK_paymentTerms_1_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
            {<POINT Name="fct.paymentterms_PK_paymentTerms_1_updateRowByKey.afterSelect">} {</POINT>}
            IF errNo == ERROR_SUCCESS THEN
                CALL consultcompanion_dbxconstraints.consultcompanion_dbxconstraints_paymentterms_checkTableConstraints(TRUE, p_dataT1.*) RETURNING errNo, errMsg
                {<POINT Name="fct.paymentterms_PK_paymentTerms_1_updateRowByKey.beforeUpdate">} {</POINT>}
                IF errNo == ERROR_SUCCESS THEN
                 IF consultcompanion_events.m_DbxDataEvent_paymentterms_BeforeUpdateRowByKey IS NOT NULL THEN
                    CALL consultcompanion_events.m_DbxDataEvent_paymentterms_BeforeUpdateRowByKey(p_dataT1.*)
                        RETURNING errNo, errMsg
                END IF
                    UPDATE paymentterms
                        SET paymentterms.* = p_dataT1.*
                        WHERE @paymentterms.paytermid = l_key.paymentterms_paytermid
                END IF
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        IF consultcompanion_events.m_DbxDataEvent_paymentterms_AfterUpdateRowByKey IS NOT NULL THEN
            CALL consultcompanion_events.m_DbxDataEvent_paymentterms_AfterUpdateRowByKey(p_dataT1.*)
                RETURNING errNo, errMsg
        END IF
        {<POINT Name="fct.paymentterms_PK_paymentTerms_1_updateRowByKey.afterUpdate">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.paymentterms_PK_paymentTerms_1_updateRowByKey

{<BLOCK Name="fct.paymentterms_PK_paymentTerms_1_deleteRowByKey">}
#+ Delete a row identified by the primary key in the "paymentterms" table
#+
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION consultcompanion_dbxdata_paymentterms_PK_paymentTerms_1_deleteRowByKey(p_key)
    DEFINE p_key
        RECORD
            paymentterms_paytermid LIKE paymentterms.paytermid
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.paymentterms_PK_paymentTerms_1_deleteRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.paymentterms_PK_paymentTerms_1_deleteRowByKey.init">} {</POINT>}
        IF consultcompanion_events.m_DbxDataEvent_paymentterms_BeforeDeleteRowByKey IS NOT NULL THEN
            CALL consultcompanion_events.m_DbxDataEvent_paymentterms_BeforeDeleteRowByKey(p_key.*)
                RETURNING errNo
        END IF
        TRY
            CALL consultcompanion_dbxdata_paymentterms_PK_paymentTerms_1_deleteReferencingRowsByKey(p_key.*) RETURNING errNo
            IF errNo == ERROR_SUCCESS THEN
                DELETE FROM paymentterms
                    WHERE @paymentterms.paytermid = p_key.paymentterms_paytermid
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        IF consultcompanion_events.m_DbxDataEvent_paymentterms_AfterDeleteRowByKey IS NOT NULL THEN
            CALL consultcompanion_events.m_DbxDataEvent_paymentterms_AfterDeleteRowByKey(p_key.*)
                RETURNING errNo
        END IF
        {<POINT Name="fct.paymentterms_PK_paymentTerms_1_deleteRowByKey.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.paymentterms_PK_paymentTerms_1_deleteRowByKey

{<BLOCK Name="fct.paymentterms_PK_paymentTerms_1_deleteRowByKeyWithConcurrentAccess">}
#+ Delete a row identified by the primary key in the "paymentterms" table if the concurrent access is success
#+
#+ @param p_dataT0 - a row data LIKE paymentterms.*
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION consultcompanion_dbxdata_paymentterms_PK_paymentTerms_1_deleteRowByKeyWithConcurrentAccess(p_dataT0)
    DEFINE p_dataT0 RECORD LIKE paymentterms.*
    DEFINE l_key
        RECORD
            paymentterms_paytermid LIKE paymentterms.paytermid
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.paymentterms_PK_paymentTerms_1_deleteRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.paymentterms_paytermid = p_dataT0.paytermid
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.paymentterms_PK_paymentTerms_1_deleteRowByKeyWithConcurrentAccess.init">} {</POINT>}
        LET errNo = consultcompanion_dbxdata_paymentterms_PK_paymentTerms_1_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
        {<POINT Name="fct.paymentterms_PK_paymentTerms_1_deleteRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = consultcompanion_dbxdata_paymentterms_PK_paymentTerms_1_deleteRowByKey(l_key.*)
        END IF
        {<POINT Name="fct.paymentterms_PK_paymentTerms_1_deleteRowByKeyWithConcurrentAccess.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.paymentterms_PK_paymentTerms_1_deleteRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.paymentterms_PK_paymentTerms_1_checkRowByKeyWithConcurrentAccess">}
#+ Check if a row identified by the primary key in the "paymentterms" table has been modified or deleted
#+
#+ @param p_dataT0 - a row data LIKE paymentterms.*
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE
PUBLIC FUNCTION consultcompanion_dbxdata_paymentterms_PK_paymentTerms_1_checkRowByKeyWithConcurrentAccess(p_dataT0, p_lock)
    DEFINE p_dataT0 RECORD LIKE paymentterms.*
    DEFINE l_dataT2 RECORD LIKE paymentterms.*
    DEFINE l_key
        RECORD
            paymentterms_paytermid LIKE paymentterms.paytermid
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE errNo INTEGER
    DEFINE errDiff INTEGER
    {<POINT Name="fct.paymentterms_PK_paymentTerms_1_checkRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.paymentterms_paytermid = p_dataT0.paytermid
    INITIALIZE l_dataT2.* TO NULL
    LET errDiff = FALSE
    {<POINT Name="fct.paymentterms_PK_paymentTerms_1_checkRowByKeyWithConcurrentAccess.init">} {</POINT>}
    CALL consultcompanion_dbxdata_paymentterms_PK_paymentTerms_1_selectRowByKey(l_key.*, p_lock) RETURNING errNo, l_dataT2.*
    CASE errNo
        WHEN ERROR_SUCCESS
            LET errDiff = (p_dataT0.* != l_dataT2.*)
            {<POINT Name="fct.paymentterms_PK_paymentTerms_1_checkRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
            IF NOT errDiff THEN
                LET errNo = ERROR_SUCCESS
            ELSE
                LET errNo = ERROR_CONCURRENT_ACCESS_FAILURE
            END IF
        WHEN ERROR_NOTFOUND
            LET errNo = ERROR_CONCURRENT_ACCESS_NOTFOUND
    END CASE
    {<POINT Name="fct.paymentterms_PK_paymentTerms_1_checkRowByKeyWithConcurrentAccess.afterCheck">} {</POINT>}
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.paymentterms_PK_paymentTerms_1_checkRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.paymentterms_PK_paymentTerms_1_deleteReferencingRowsByKey">}
#+ Delete rows referencing the primary key of the "paymentterms" table
#+
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION consultcompanion_dbxdata_paymentterms_PK_paymentTerms_1_deleteReferencingRowsByKey(p_key)
    DEFINE p_key
        RECORD
            paymentterms_paytermid LIKE paymentterms.paytermid
        END RECORD
    DEFINE l_data RECORD LIKE paymentterms.*
    DEFINE l_key_FK_clients_paymentTerms_1
        RECORD
            clients_clientid LIKE clients.clientid
        END RECORD
    DEFINE errNo INTEGER
    DEFINE l_sqlQuery STRING
    {<POINT Name="fct.paymentterms_PK_paymentTerms_1_deleteReferencingRowsByKey.define">} {</POINT>}

    INITIALIZE l_data.* TO NULL
    {<POINT Name="fct.paymentterms_PK_paymentTerms_1_deleteReferencingRowsByKey.init">} {</POINT>}
    CALL consultcompanion_dbxdata_paymentterms_PK_paymentTerms_1_selectRowByKey(p_key.*, FALSE)
        RETURNING errNo, l_data.*
    CASE errNo
        WHEN ERROR_SUCCESS
            --check Foreign Key FK_clients_paymentTerms_1
            LET l_sqlQuery = "SELECT clientid FROM clients WHERE clients.paytermid = ?"
            TRY
                DECLARE consultcompanion_dbxdata_paymentterms_PK_paymentTerms_1_deleteReferencingRowsByKey_FK_clients_paymentTerms_1 CURSOR FROM l_sqlQuery
                OPEN consultcompanion_dbxdata_paymentterms_PK_paymentTerms_1_deleteReferencingRowsByKey_FK_clients_paymentTerms_1
                    USING l_data.paytermid
                FETCH consultcompanion_dbxdata_paymentterms_PK_paymentTerms_1_deleteReferencingRowsByKey_FK_clients_paymentTerms_1
                    INTO l_key_FK_clients_paymentTerms_1.*
                IF SQLCA.SQLCODE = 0 THEN
                    LET errNo = ERROR_DELETE_CASCADE_ROW_USED
                END IF
                CLOSE consultcompanion_dbxdata_paymentterms_PK_paymentTerms_1_deleteReferencingRowsByKey_FK_clients_paymentTerms_1
            CATCH
                LET errNo = ERROR_FAILURE
            END TRY

        WHEN ERROR_NOTFOUND
            LET errNo = ERROR_SUCCESS
    END CASE
    {<POINT Name="fct.paymentterms_PK_paymentTerms_1_deleteReferencingRowsByKey.afterDelete">} {</POINT>}
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.paymentterms_PK_paymentTerms_1_deleteReferencingRowsByKey

{<BLOCK Name="fct.paymentterms_setDefaultValuesFromDBSchema">}
#+ Set data with the default values coming from the DB schema
#+
PUBLIC FUNCTION consultcompanion_dbxdata_paymentterms_setDefaultValuesFromDBSchema()
    DEFINE l_data RECORD LIKE paymentterms.*
    {<POINT Name="fct.paymentterms_setDefaultValuesFromDBSchema.define">} {</POINT>}

    INITIALIZE l_data.* TO NULL
    {<POINT Name="fct.paymentterms_setDefaultValuesFromDBSchema.init">} {</POINT>}
    IF consultcompanion_events.m_DbxDataEvent_paymentterms_SetDefaultValues IS NOT NULL THEN
        CALL consultcompanion_events.m_DbxDataEvent_paymentterms_SetDefaultValues(l_data.*)
            RETURNING l_data.*
    END IF
    RETURN l_data.*
END FUNCTION
{</BLOCK>} --fct.paymentterms_setDefaultValuesFromDBSchema

{<BLOCK Name="fct.offerstatuses_PK_offerStatuses_1_selectRowByKey">}
#+ Select a row identified by the primary key in the "offerstatuses" table
#+
#+ @param p_key - Primary Key
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER, LIKE offerstatuses.*
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_NOTFOUND, RECORD LIKE offerstatuses.*
PUBLIC FUNCTION consultcompanion_dbxdata_offerstatuses_PK_offerStatuses_1_selectRowByKey(p_key, p_lock)
    DEFINE p_key
        RECORD
            offerstatuses_offerstatusid LIKE offerstatuses.offerstatusid
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE l_data RECORD LIKE offerstatuses.*
    DEFINE l_supportLock BOOLEAN
    DEFINE errNo INTEGER
    {<POINT Name="fct.offerstatuses_PK_offerStatuses_1_selectRowByKey.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    -- SQLite does not support the FOR UPDATE close in SELECT syntax
    LET l_supportLock = (UPSHIFT(fgl_db_driver_type()) != "SQT")
    {<POINT Name="fct.offerstatuses_PK_offerStatuses_1_selectRowByKey.init">} {</POINT>}
    TRY
        IF p_lock AND l_supportLock THEN
            SELECT * INTO l_data.* FROM offerstatuses
                WHERE @offerstatuses.offerstatusid = p_key.offerstatuses_offerstatusid
            FOR UPDATE
        ELSE
            SELECT * INTO l_data.* FROM offerstatuses
                WHERE @offerstatuses.offerstatusid = p_key.offerstatuses_offerstatusid
        END IF
        IF SQLCA.SQLCODE == NOTFOUND THEN
            LET errNo = ERROR_NOTFOUND
        END IF
    CATCH
        INITIALIZE l_data.* TO NULL
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.offerstatuses_PK_offerStatuses_1_selectRowByKey.afterSelect">} {</POINT>}
    RETURN errNo, l_data.*
END FUNCTION
{</BLOCK>} --fct.offerstatuses_PK_offerStatuses_1_selectRowByKey

{<BLOCK Name="fct.offerstatuses_insertRowByKey">}
#+ Insert a row in the "offerstatuses" table and return the primary key created
#+
#+ @param p_data - a row data LIKE offerstatuses.*
#+
#+ @returnType INTEGER, STRING, SERIAL
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, offerstatuses.offerstatusid
PRIVATE FUNCTION consultcompanion_dbxdata_offerstatuses_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE offerstatuses.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.offerstatuses_insertRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        CALL libdbapp_get_sequence("offerstatuses") RETURNING errNo, p_data.offerstatusid
        {<POINT Name="fct.offerstatuses_insertRowByKey.init">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            IF consultcompanion_events.m_DbxDataEvent_offerstatuses_BeforeInsertRowByKey IS NOT NULL THEN
                CALL consultcompanion_events.m_DbxDataEvent_offerstatuses_BeforeInsertRowByKey(p_data.*)
                    RETURNING errNo, errMsg, p_data.*
            END IF
            IF errNo == ERROR_SUCCESS THEN
                CALL consultcompanion_dbxconstraints.consultcompanion_dbxconstraints_offerstatuses_checkTableConstraints(FALSE, p_data.*) RETURNING errNo, errMsg
            END IF
            {<POINT Name="fct.offerstatuses_insertRowByKey.beforeInsert">} {</POINT>}
            IF errNo == ERROR_SUCCESS THEN
                TRY
                    INSERT INTO offerstatuses VALUES (p_data.*)
                    CALL libdbapp_get_inserted_sequence(p_data.offerstatusid) RETURNING p_data.offerstatusid
                CATCH
                    LET errNo = ERROR_FAILURE
                END TRY
                IF consultcompanion_events.m_DbxDataEvent_offerstatuses_AfterInsertRowByKey IS NOT NULL THEN
                    CALL consultcompanion_events.m_DbxDataEvent_offerstatuses_AfterInsertRowByKey(p_data.*)
                        RETURNING errNo, errMsg
                END IF
                {<POINT Name="fct.offerstatuses_insertRowByKey.afterInsert">} {</POINT>}
            END IF
        END IF
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg, p_data.offerstatusid
END FUNCTION
{</BLOCK>} --fct.offerstatuses_insertRowByKey

{<BLOCK Name="fct.offerstatuses_PK_offerStatuses_1_insertRowByKey">}
#+ Insert a row in the "offerstatuses" table and return the table keys
#+
#+ @param p_data - a row data LIKE offerstatuses.*
#+
#+ @returnType INTEGER, STRING, SERIAL
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, offerstatuses.offerstatusid
PUBLIC FUNCTION consultcompanion_dbxdata_offerstatuses_PK_offerStatuses_1_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE offerstatuses.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.offerstatuses_PK_offerStatuses_1_insertRowByKey.define">} {</POINT>}
    {<POINT Name="fct.offerstatuses_PK_offerStatuses_1_insertRowByKey.init">} {</POINT>}

    CALL consultcompanion_dbxdata_offerstatuses_insertRowByKey(p_data.*) RETURNING errNo, errMsg, p_data.offerstatusid
    RETURN errNo, errMsg, p_data.offerstatusid
END FUNCTION
{</BLOCK>} --fct.offerstatuses_PK_offerStatuses_1_insertRowByKey

{<BLOCK Name="fct.offerstatuses_PK_offerStatuses_1_updateRowByKey">}
#+ Update a row identified by the primary key in the "offerstatuses" table
#+
#+ @param p_dataT0 - a row data LIKE offerstatuses.*
#+ @param p_dataT1 - a row data LIKE offerstatuses.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxdata_offerstatuses_PK_offerStatuses_1_updateRowByKey(p_dataT0, p_dataT1)
    DEFINE p_dataT0 RECORD LIKE offerstatuses.*
    DEFINE p_dataT1 RECORD LIKE offerstatuses.*
    DEFINE l_key
        RECORD
            offerstatuses_offerstatusid LIKE offerstatuses.offerstatusid
        END RECORD
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.offerstatuses_PK_offerStatuses_1_updateRowByKey.define">} {</POINT>}
    LET l_key.offerstatuses_offerstatusid = p_dataT0.offerstatusid
    INITIALIZE errMsg TO NULL
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.offerstatuses_PK_offerStatuses_1_updateRowByKey.init">} {</POINT>}
        TRY
            LET errNo = consultcompanion_dbxdata_offerstatuses_PK_offerStatuses_1_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
            {<POINT Name="fct.offerstatuses_PK_offerStatuses_1_updateRowByKey.afterSelect">} {</POINT>}
            IF errNo == ERROR_SUCCESS THEN
                CALL consultcompanion_dbxconstraints.consultcompanion_dbxconstraints_offerstatuses_checkTableConstraints(TRUE, p_dataT1.*) RETURNING errNo, errMsg
                {<POINT Name="fct.offerstatuses_PK_offerStatuses_1_updateRowByKey.beforeUpdate">} {</POINT>}
                IF errNo == ERROR_SUCCESS THEN
                 IF consultcompanion_events.m_DbxDataEvent_offerstatuses_BeforeUpdateRowByKey IS NOT NULL THEN
                    CALL consultcompanion_events.m_DbxDataEvent_offerstatuses_BeforeUpdateRowByKey(p_dataT1.*)
                        RETURNING errNo, errMsg
                END IF
                    UPDATE offerstatuses
                        SET offerstatuses.* = p_dataT1.*
                        WHERE @offerstatuses.offerstatusid = l_key.offerstatuses_offerstatusid
                END IF
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        IF consultcompanion_events.m_DbxDataEvent_offerstatuses_AfterUpdateRowByKey IS NOT NULL THEN
            CALL consultcompanion_events.m_DbxDataEvent_offerstatuses_AfterUpdateRowByKey(p_dataT1.*)
                RETURNING errNo, errMsg
        END IF
        {<POINT Name="fct.offerstatuses_PK_offerStatuses_1_updateRowByKey.afterUpdate">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.offerstatuses_PK_offerStatuses_1_updateRowByKey

{<BLOCK Name="fct.offerstatuses_PK_offerStatuses_1_deleteRowByKey">}
#+ Delete a row identified by the primary key in the "offerstatuses" table
#+
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION consultcompanion_dbxdata_offerstatuses_PK_offerStatuses_1_deleteRowByKey(p_key)
    DEFINE p_key
        RECORD
            offerstatuses_offerstatusid LIKE offerstatuses.offerstatusid
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.offerstatuses_PK_offerStatuses_1_deleteRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.offerstatuses_PK_offerStatuses_1_deleteRowByKey.init">} {</POINT>}
        IF consultcompanion_events.m_DbxDataEvent_offerstatuses_BeforeDeleteRowByKey IS NOT NULL THEN
            CALL consultcompanion_events.m_DbxDataEvent_offerstatuses_BeforeDeleteRowByKey(p_key.*)
                RETURNING errNo
        END IF
        TRY
            CALL consultcompanion_dbxdata_offerstatuses_PK_offerStatuses_1_deleteReferencingRowsByKey(p_key.*) RETURNING errNo
            IF errNo == ERROR_SUCCESS THEN
                DELETE FROM offerstatuses
                    WHERE @offerstatuses.offerstatusid = p_key.offerstatuses_offerstatusid
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        IF consultcompanion_events.m_DbxDataEvent_offerstatuses_AfterDeleteRowByKey IS NOT NULL THEN
            CALL consultcompanion_events.m_DbxDataEvent_offerstatuses_AfterDeleteRowByKey(p_key.*)
                RETURNING errNo
        END IF
        {<POINT Name="fct.offerstatuses_PK_offerStatuses_1_deleteRowByKey.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.offerstatuses_PK_offerStatuses_1_deleteRowByKey

{<BLOCK Name="fct.offerstatuses_PK_offerStatuses_1_deleteRowByKeyWithConcurrentAccess">}
#+ Delete a row identified by the primary key in the "offerstatuses" table if the concurrent access is success
#+
#+ @param p_dataT0 - a row data LIKE offerstatuses.*
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION consultcompanion_dbxdata_offerstatuses_PK_offerStatuses_1_deleteRowByKeyWithConcurrentAccess(p_dataT0)
    DEFINE p_dataT0 RECORD LIKE offerstatuses.*
    DEFINE l_key
        RECORD
            offerstatuses_offerstatusid LIKE offerstatuses.offerstatusid
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.offerstatuses_PK_offerStatuses_1_deleteRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.offerstatuses_offerstatusid = p_dataT0.offerstatusid
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.offerstatuses_PK_offerStatuses_1_deleteRowByKeyWithConcurrentAccess.init">} {</POINT>}
        LET errNo = consultcompanion_dbxdata_offerstatuses_PK_offerStatuses_1_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
        {<POINT Name="fct.offerstatuses_PK_offerStatuses_1_deleteRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = consultcompanion_dbxdata_offerstatuses_PK_offerStatuses_1_deleteRowByKey(l_key.*)
        END IF
        {<POINT Name="fct.offerstatuses_PK_offerStatuses_1_deleteRowByKeyWithConcurrentAccess.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.offerstatuses_PK_offerStatuses_1_deleteRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.offerstatuses_PK_offerStatuses_1_checkRowByKeyWithConcurrentAccess">}
#+ Check if a row identified by the primary key in the "offerstatuses" table has been modified or deleted
#+
#+ @param p_dataT0 - a row data LIKE offerstatuses.*
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE
PUBLIC FUNCTION consultcompanion_dbxdata_offerstatuses_PK_offerStatuses_1_checkRowByKeyWithConcurrentAccess(p_dataT0, p_lock)
    DEFINE p_dataT0 RECORD LIKE offerstatuses.*
    DEFINE l_dataT2 RECORD LIKE offerstatuses.*
    DEFINE l_key
        RECORD
            offerstatuses_offerstatusid LIKE offerstatuses.offerstatusid
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE errNo INTEGER
    DEFINE errDiff INTEGER
    {<POINT Name="fct.offerstatuses_PK_offerStatuses_1_checkRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.offerstatuses_offerstatusid = p_dataT0.offerstatusid
    INITIALIZE l_dataT2.* TO NULL
    LET errDiff = FALSE
    {<POINT Name="fct.offerstatuses_PK_offerStatuses_1_checkRowByKeyWithConcurrentAccess.init">} {</POINT>}
    CALL consultcompanion_dbxdata_offerstatuses_PK_offerStatuses_1_selectRowByKey(l_key.*, p_lock) RETURNING errNo, l_dataT2.*
    CASE errNo
        WHEN ERROR_SUCCESS
            LET errDiff = (p_dataT0.* != l_dataT2.*)
            {<POINT Name="fct.offerstatuses_PK_offerStatuses_1_checkRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
            IF NOT errDiff THEN
                LET errNo = ERROR_SUCCESS
            ELSE
                LET errNo = ERROR_CONCURRENT_ACCESS_FAILURE
            END IF
        WHEN ERROR_NOTFOUND
            LET errNo = ERROR_CONCURRENT_ACCESS_NOTFOUND
    END CASE
    {<POINT Name="fct.offerstatuses_PK_offerStatuses_1_checkRowByKeyWithConcurrentAccess.afterCheck">} {</POINT>}
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.offerstatuses_PK_offerStatuses_1_checkRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.offerstatuses_PK_offerStatuses_1_deleteReferencingRowsByKey">}
#+ Delete rows referencing the primary key of the "offerstatuses" table
#+
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION consultcompanion_dbxdata_offerstatuses_PK_offerStatuses_1_deleteReferencingRowsByKey(p_key)
    DEFINE p_key
        RECORD
            offerstatuses_offerstatusid LIKE offerstatuses.offerstatusid
        END RECORD
    DEFINE l_data RECORD LIKE offerstatuses.*
    DEFINE l_key_FK_RFS_offerStatuses_1
        RECORD
            rfs_rfsId LIKE rfs.rfsId
        END RECORD
    DEFINE errNo INTEGER
    DEFINE l_sqlQuery STRING
    {<POINT Name="fct.offerstatuses_PK_offerStatuses_1_deleteReferencingRowsByKey.define">} {</POINT>}

    INITIALIZE l_data.* TO NULL
    {<POINT Name="fct.offerstatuses_PK_offerStatuses_1_deleteReferencingRowsByKey.init">} {</POINT>}
    CALL consultcompanion_dbxdata_offerstatuses_PK_offerStatuses_1_selectRowByKey(p_key.*, FALSE)
        RETURNING errNo, l_data.*
    CASE errNo
        WHEN ERROR_SUCCESS
            --check Foreign Key FK_RFS_offerStatuses_1
            LET l_sqlQuery = "SELECT rfsId FROM rfs WHERE rfs.offerstatusid = ?"
            TRY
                DECLARE consultcompanion_dbxdata_offerstatuses_PK_offerStatuses_1_deleteReferencingRowsByKey_FK_RFS_offerStatuses_1 CURSOR FROM l_sqlQuery
                OPEN consultcompanion_dbxdata_offerstatuses_PK_offerStatuses_1_deleteReferencingRowsByKey_FK_RFS_offerStatuses_1
                    USING l_data.offerstatusid
                FETCH consultcompanion_dbxdata_offerstatuses_PK_offerStatuses_1_deleteReferencingRowsByKey_FK_RFS_offerStatuses_1
                    INTO l_key_FK_RFS_offerStatuses_1.*
                IF SQLCA.SQLCODE = 0 THEN
                    LET errNo = ERROR_DELETE_CASCADE_ROW_USED
                END IF
                CLOSE consultcompanion_dbxdata_offerstatuses_PK_offerStatuses_1_deleteReferencingRowsByKey_FK_RFS_offerStatuses_1
            CATCH
                LET errNo = ERROR_FAILURE
            END TRY

        WHEN ERROR_NOTFOUND
            LET errNo = ERROR_SUCCESS
    END CASE
    {<POINT Name="fct.offerstatuses_PK_offerStatuses_1_deleteReferencingRowsByKey.afterDelete">} {</POINT>}
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.offerstatuses_PK_offerStatuses_1_deleteReferencingRowsByKey

{<BLOCK Name="fct.offerstatuses_setDefaultValuesFromDBSchema">}
#+ Set data with the default values coming from the DB schema
#+
PUBLIC FUNCTION consultcompanion_dbxdata_offerstatuses_setDefaultValuesFromDBSchema()
    DEFINE l_data RECORD LIKE offerstatuses.*
    {<POINT Name="fct.offerstatuses_setDefaultValuesFromDBSchema.define">} {</POINT>}

    INITIALIZE l_data.* TO NULL
    {<POINT Name="fct.offerstatuses_setDefaultValuesFromDBSchema.init">} {</POINT>}
    IF consultcompanion_events.m_DbxDataEvent_offerstatuses_SetDefaultValues IS NOT NULL THEN
        CALL consultcompanion_events.m_DbxDataEvent_offerstatuses_SetDefaultValues(l_data.*)
            RETURNING l_data.*
    END IF
    RETURN l_data.*
END FUNCTION
{</BLOCK>} --fct.offerstatuses_setDefaultValuesFromDBSchema

{<BLOCK Name="fct.employeetypes_PK_employeeTypes_1_selectRowByKey">}
#+ Select a row identified by the primary key in the "employeetypes" table
#+
#+ @param p_key - Primary Key
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER, LIKE employeetypes.*
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_NOTFOUND, RECORD LIKE employeetypes.*
PUBLIC FUNCTION consultcompanion_dbxdata_employeetypes_PK_employeeTypes_1_selectRowByKey(p_key, p_lock)
    DEFINE p_key
        RECORD
            employeetypes_emptypeid LIKE employeetypes.emptypeid
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE l_data RECORD LIKE employeetypes.*
    DEFINE l_supportLock BOOLEAN
    DEFINE errNo INTEGER
    {<POINT Name="fct.employeetypes_PK_employeeTypes_1_selectRowByKey.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    -- SQLite does not support the FOR UPDATE close in SELECT syntax
    LET l_supportLock = (UPSHIFT(fgl_db_driver_type()) != "SQT")
    {<POINT Name="fct.employeetypes_PK_employeeTypes_1_selectRowByKey.init">} {</POINT>}
    TRY
        IF p_lock AND l_supportLock THEN
            SELECT * INTO l_data.* FROM employeetypes
                WHERE @employeetypes.emptypeid = p_key.employeetypes_emptypeid
            FOR UPDATE
        ELSE
            SELECT * INTO l_data.* FROM employeetypes
                WHERE @employeetypes.emptypeid = p_key.employeetypes_emptypeid
        END IF
        IF SQLCA.SQLCODE == NOTFOUND THEN
            LET errNo = ERROR_NOTFOUND
        END IF
    CATCH
        INITIALIZE l_data.* TO NULL
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.employeetypes_PK_employeeTypes_1_selectRowByKey.afterSelect">} {</POINT>}
    RETURN errNo, l_data.*
END FUNCTION
{</BLOCK>} --fct.employeetypes_PK_employeeTypes_1_selectRowByKey

{<BLOCK Name="fct.employeetypes_insertRowByKey">}
#+ Insert a row in the "employeetypes" table and return the primary key created
#+
#+ @param p_data - a row data LIKE employeetypes.*
#+
#+ @returnType INTEGER, STRING, SERIAL
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, employeetypes.emptypeid
PRIVATE FUNCTION consultcompanion_dbxdata_employeetypes_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE employeetypes.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.employeetypes_insertRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        CALL libdbapp_get_sequence("employeetypes") RETURNING errNo, p_data.emptypeid
        {<POINT Name="fct.employeetypes_insertRowByKey.init">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            IF consultcompanion_events.m_DbxDataEvent_employeetypes_BeforeInsertRowByKey IS NOT NULL THEN
                CALL consultcompanion_events.m_DbxDataEvent_employeetypes_BeforeInsertRowByKey(p_data.*)
                    RETURNING errNo, errMsg, p_data.*
            END IF
            IF errNo == ERROR_SUCCESS THEN
                CALL consultcompanion_dbxconstraints.consultcompanion_dbxconstraints_employeetypes_checkTableConstraints(FALSE, p_data.*) RETURNING errNo, errMsg
            END IF
            {<POINT Name="fct.employeetypes_insertRowByKey.beforeInsert">} {</POINT>}
            IF errNo == ERROR_SUCCESS THEN
                TRY
                    INSERT INTO employeetypes VALUES (p_data.*)
                    CALL libdbapp_get_inserted_sequence(p_data.emptypeid) RETURNING p_data.emptypeid
                CATCH
                    LET errNo = ERROR_FAILURE
                END TRY
                IF consultcompanion_events.m_DbxDataEvent_employeetypes_AfterInsertRowByKey IS NOT NULL THEN
                    CALL consultcompanion_events.m_DbxDataEvent_employeetypes_AfterInsertRowByKey(p_data.*)
                        RETURNING errNo, errMsg
                END IF
                {<POINT Name="fct.employeetypes_insertRowByKey.afterInsert">} {</POINT>}
            END IF
        END IF
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg, p_data.emptypeid
END FUNCTION
{</BLOCK>} --fct.employeetypes_insertRowByKey

{<BLOCK Name="fct.employeetypes_PK_employeeTypes_1_insertRowByKey">}
#+ Insert a row in the "employeetypes" table and return the table keys
#+
#+ @param p_data - a row data LIKE employeetypes.*
#+
#+ @returnType INTEGER, STRING, SERIAL
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, employeetypes.emptypeid
PUBLIC FUNCTION consultcompanion_dbxdata_employeetypes_PK_employeeTypes_1_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE employeetypes.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.employeetypes_PK_employeeTypes_1_insertRowByKey.define">} {</POINT>}
    {<POINT Name="fct.employeetypes_PK_employeeTypes_1_insertRowByKey.init">} {</POINT>}

    CALL consultcompanion_dbxdata_employeetypes_insertRowByKey(p_data.*) RETURNING errNo, errMsg, p_data.emptypeid
    RETURN errNo, errMsg, p_data.emptypeid
END FUNCTION
{</BLOCK>} --fct.employeetypes_PK_employeeTypes_1_insertRowByKey

{<BLOCK Name="fct.employeetypes_PK_employeeTypes_1_updateRowByKey">}
#+ Update a row identified by the primary key in the "employeetypes" table
#+
#+ @param p_dataT0 - a row data LIKE employeetypes.*
#+ @param p_dataT1 - a row data LIKE employeetypes.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxdata_employeetypes_PK_employeeTypes_1_updateRowByKey(p_dataT0, p_dataT1)
    DEFINE p_dataT0 RECORD LIKE employeetypes.*
    DEFINE p_dataT1 RECORD LIKE employeetypes.*
    DEFINE l_key
        RECORD
            employeetypes_emptypeid LIKE employeetypes.emptypeid
        END RECORD
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.employeetypes_PK_employeeTypes_1_updateRowByKey.define">} {</POINT>}
    LET l_key.employeetypes_emptypeid = p_dataT0.emptypeid
    INITIALIZE errMsg TO NULL
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.employeetypes_PK_employeeTypes_1_updateRowByKey.init">} {</POINT>}
        TRY
            LET errNo = consultcompanion_dbxdata_employeetypes_PK_employeeTypes_1_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
            {<POINT Name="fct.employeetypes_PK_employeeTypes_1_updateRowByKey.afterSelect">} {</POINT>}
            IF errNo == ERROR_SUCCESS THEN
                CALL consultcompanion_dbxconstraints.consultcompanion_dbxconstraints_employeetypes_checkTableConstraints(TRUE, p_dataT1.*) RETURNING errNo, errMsg
                {<POINT Name="fct.employeetypes_PK_employeeTypes_1_updateRowByKey.beforeUpdate">} {</POINT>}
                IF errNo == ERROR_SUCCESS THEN
                 IF consultcompanion_events.m_DbxDataEvent_employeetypes_BeforeUpdateRowByKey IS NOT NULL THEN
                    CALL consultcompanion_events.m_DbxDataEvent_employeetypes_BeforeUpdateRowByKey(p_dataT1.*)
                        RETURNING errNo, errMsg
                END IF
                    UPDATE employeetypes
                        SET employeetypes.* = p_dataT1.*
                        WHERE @employeetypes.emptypeid = l_key.employeetypes_emptypeid
                END IF
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        IF consultcompanion_events.m_DbxDataEvent_employeetypes_AfterUpdateRowByKey IS NOT NULL THEN
            CALL consultcompanion_events.m_DbxDataEvent_employeetypes_AfterUpdateRowByKey(p_dataT1.*)
                RETURNING errNo, errMsg
        END IF
        {<POINT Name="fct.employeetypes_PK_employeeTypes_1_updateRowByKey.afterUpdate">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.employeetypes_PK_employeeTypes_1_updateRowByKey

{<BLOCK Name="fct.employeetypes_PK_employeeTypes_1_deleteRowByKey">}
#+ Delete a row identified by the primary key in the "employeetypes" table
#+
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION consultcompanion_dbxdata_employeetypes_PK_employeeTypes_1_deleteRowByKey(p_key)
    DEFINE p_key
        RECORD
            employeetypes_emptypeid LIKE employeetypes.emptypeid
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.employeetypes_PK_employeeTypes_1_deleteRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.employeetypes_PK_employeeTypes_1_deleteRowByKey.init">} {</POINT>}
        IF consultcompanion_events.m_DbxDataEvent_employeetypes_BeforeDeleteRowByKey IS NOT NULL THEN
            CALL consultcompanion_events.m_DbxDataEvent_employeetypes_BeforeDeleteRowByKey(p_key.*)
                RETURNING errNo
        END IF
        TRY
            CALL consultcompanion_dbxdata_employeetypes_PK_employeeTypes_1_deleteReferencingRowsByKey(p_key.*) RETURNING errNo
            IF errNo == ERROR_SUCCESS THEN
                DELETE FROM employeetypes
                    WHERE @employeetypes.emptypeid = p_key.employeetypes_emptypeid
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        IF consultcompanion_events.m_DbxDataEvent_employeetypes_AfterDeleteRowByKey IS NOT NULL THEN
            CALL consultcompanion_events.m_DbxDataEvent_employeetypes_AfterDeleteRowByKey(p_key.*)
                RETURNING errNo
        END IF
        {<POINT Name="fct.employeetypes_PK_employeeTypes_1_deleteRowByKey.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.employeetypes_PK_employeeTypes_1_deleteRowByKey

{<BLOCK Name="fct.employeetypes_PK_employeeTypes_1_deleteRowByKeyWithConcurrentAccess">}
#+ Delete a row identified by the primary key in the "employeetypes" table if the concurrent access is success
#+
#+ @param p_dataT0 - a row data LIKE employeetypes.*
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION consultcompanion_dbxdata_employeetypes_PK_employeeTypes_1_deleteRowByKeyWithConcurrentAccess(p_dataT0)
    DEFINE p_dataT0 RECORD LIKE employeetypes.*
    DEFINE l_key
        RECORD
            employeetypes_emptypeid LIKE employeetypes.emptypeid
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.employeetypes_PK_employeeTypes_1_deleteRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.employeetypes_emptypeid = p_dataT0.emptypeid
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.employeetypes_PK_employeeTypes_1_deleteRowByKeyWithConcurrentAccess.init">} {</POINT>}
        LET errNo = consultcompanion_dbxdata_employeetypes_PK_employeeTypes_1_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
        {<POINT Name="fct.employeetypes_PK_employeeTypes_1_deleteRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = consultcompanion_dbxdata_employeetypes_PK_employeeTypes_1_deleteRowByKey(l_key.*)
        END IF
        {<POINT Name="fct.employeetypes_PK_employeeTypes_1_deleteRowByKeyWithConcurrentAccess.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.employeetypes_PK_employeeTypes_1_deleteRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.employeetypes_PK_employeeTypes_1_checkRowByKeyWithConcurrentAccess">}
#+ Check if a row identified by the primary key in the "employeetypes" table has been modified or deleted
#+
#+ @param p_dataT0 - a row data LIKE employeetypes.*
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE
PUBLIC FUNCTION consultcompanion_dbxdata_employeetypes_PK_employeeTypes_1_checkRowByKeyWithConcurrentAccess(p_dataT0, p_lock)
    DEFINE p_dataT0 RECORD LIKE employeetypes.*
    DEFINE l_dataT2 RECORD LIKE employeetypes.*
    DEFINE l_key
        RECORD
            employeetypes_emptypeid LIKE employeetypes.emptypeid
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE errNo INTEGER
    DEFINE errDiff INTEGER
    {<POINT Name="fct.employeetypes_PK_employeeTypes_1_checkRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.employeetypes_emptypeid = p_dataT0.emptypeid
    INITIALIZE l_dataT2.* TO NULL
    LET errDiff = FALSE
    {<POINT Name="fct.employeetypes_PK_employeeTypes_1_checkRowByKeyWithConcurrentAccess.init">} {</POINT>}
    CALL consultcompanion_dbxdata_employeetypes_PK_employeeTypes_1_selectRowByKey(l_key.*, p_lock) RETURNING errNo, l_dataT2.*
    CASE errNo
        WHEN ERROR_SUCCESS
            LET errDiff = (p_dataT0.* != l_dataT2.*)
            {<POINT Name="fct.employeetypes_PK_employeeTypes_1_checkRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
            IF NOT errDiff THEN
                LET errNo = ERROR_SUCCESS
            ELSE
                LET errNo = ERROR_CONCURRENT_ACCESS_FAILURE
            END IF
        WHEN ERROR_NOTFOUND
            LET errNo = ERROR_CONCURRENT_ACCESS_NOTFOUND
    END CASE
    {<POINT Name="fct.employeetypes_PK_employeeTypes_1_checkRowByKeyWithConcurrentAccess.afterCheck">} {</POINT>}
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.employeetypes_PK_employeeTypes_1_checkRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.employeetypes_PK_employeeTypes_1_deleteReferencingRowsByKey">}
#+ Delete rows referencing the primary key of the "employeetypes" table
#+
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION consultcompanion_dbxdata_employeetypes_PK_employeeTypes_1_deleteReferencingRowsByKey(p_key)
    DEFINE p_key
        RECORD
            employeetypes_emptypeid LIKE employeetypes.emptypeid
        END RECORD
    DEFINE l_data RECORD LIKE employeetypes.*
    DEFINE l_key_FK_employees_employeeTypes_1
        RECORD
            employees_employeeid LIKE employees.employeeid
        END RECORD
    DEFINE errNo INTEGER
    DEFINE l_sqlQuery STRING
    {<POINT Name="fct.employeetypes_PK_employeeTypes_1_deleteReferencingRowsByKey.define">} {</POINT>}

    INITIALIZE l_data.* TO NULL
    {<POINT Name="fct.employeetypes_PK_employeeTypes_1_deleteReferencingRowsByKey.init">} {</POINT>}
    CALL consultcompanion_dbxdata_employeetypes_PK_employeeTypes_1_selectRowByKey(p_key.*, FALSE)
        RETURNING errNo, l_data.*
    CASE errNo
        WHEN ERROR_SUCCESS
            --check Foreign Key FK_employees_employeeTypes_1
            LET l_sqlQuery = "SELECT employeeid FROM employees WHERE employees.emptype = ?"
            TRY
                DECLARE consultcompanion_dbxdata_employeetypes_PK_employeeTypes_1_deleteReferencingRowsByKey_FK_employees_employeeTypes_1 CURSOR FROM l_sqlQuery
                OPEN consultcompanion_dbxdata_employeetypes_PK_employeeTypes_1_deleteReferencingRowsByKey_FK_employees_employeeTypes_1
                    USING l_data.emptypeid
                FETCH consultcompanion_dbxdata_employeetypes_PK_employeeTypes_1_deleteReferencingRowsByKey_FK_employees_employeeTypes_1
                    INTO l_key_FK_employees_employeeTypes_1.*
                IF SQLCA.SQLCODE = 0 THEN
                    LET errNo = ERROR_DELETE_CASCADE_ROW_USED
                END IF
                CLOSE consultcompanion_dbxdata_employeetypes_PK_employeeTypes_1_deleteReferencingRowsByKey_FK_employees_employeeTypes_1
            CATCH
                LET errNo = ERROR_FAILURE
            END TRY

        WHEN ERROR_NOTFOUND
            LET errNo = ERROR_SUCCESS
    END CASE
    {<POINT Name="fct.employeetypes_PK_employeeTypes_1_deleteReferencingRowsByKey.afterDelete">} {</POINT>}
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.employeetypes_PK_employeeTypes_1_deleteReferencingRowsByKey

{<BLOCK Name="fct.employeetypes_setDefaultValuesFromDBSchema">}
#+ Set data with the default values coming from the DB schema
#+
PUBLIC FUNCTION consultcompanion_dbxdata_employeetypes_setDefaultValuesFromDBSchema()
    DEFINE l_data RECORD LIKE employeetypes.*
    {<POINT Name="fct.employeetypes_setDefaultValuesFromDBSchema.define">} {</POINT>}

    INITIALIZE l_data.* TO NULL
    {<POINT Name="fct.employeetypes_setDefaultValuesFromDBSchema.init">} {</POINT>}
    IF consultcompanion_events.m_DbxDataEvent_employeetypes_SetDefaultValues IS NOT NULL THEN
        CALL consultcompanion_events.m_DbxDataEvent_employeetypes_SetDefaultValues(l_data.*)
            RETURNING l_data.*
    END IF
    RETURN l_data.*
END FUNCTION
{</BLOCK>} --fct.employeetypes_setDefaultValuesFromDBSchema

{<BLOCK Name="fct.employees_PK_employees_1_selectRowByKey">}
#+ Select a row identified by the primary key in the "employees" table
#+
#+ @param p_key - Primary Key
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER, LIKE employees.*
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_NOTFOUND, RECORD LIKE employees.*
PUBLIC FUNCTION consultcompanion_dbxdata_employees_PK_employees_1_selectRowByKey(p_key, p_lock)
    DEFINE p_key
        RECORD
            employees_employeeid LIKE employees.employeeid
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE l_data RECORD LIKE employees.*
    DEFINE l_supportLock BOOLEAN
    DEFINE errNo INTEGER
    {<POINT Name="fct.employees_PK_employees_1_selectRowByKey.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    -- SQLite does not support the FOR UPDATE close in SELECT syntax
    LET l_supportLock = (UPSHIFT(fgl_db_driver_type()) != "SQT")
    {<POINT Name="fct.employees_PK_employees_1_selectRowByKey.init">} {</POINT>}
    TRY
        IF p_lock AND l_supportLock THEN
            SELECT * INTO l_data.* FROM employees
                WHERE @employees.employeeid = p_key.employees_employeeid
            FOR UPDATE
        ELSE
            SELECT * INTO l_data.* FROM employees
                WHERE @employees.employeeid = p_key.employees_employeeid
        END IF
        IF SQLCA.SQLCODE == NOTFOUND THEN
            LET errNo = ERROR_NOTFOUND
        END IF
    CATCH
        INITIALIZE l_data.* TO NULL
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.employees_PK_employees_1_selectRowByKey.afterSelect">} {</POINT>}
    RETURN errNo, l_data.*
END FUNCTION
{</BLOCK>} --fct.employees_PK_employees_1_selectRowByKey

{<BLOCK Name="fct.employees_insertRowByKey">}
#+ Insert a row in the "employees" table and return the primary key created
#+
#+ @param p_data - a row data LIKE employees.*
#+
#+ @returnType INTEGER, STRING, SERIAL
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, employees.employeeid
PRIVATE FUNCTION consultcompanion_dbxdata_employees_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE employees.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.employees_insertRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        CALL libdbapp_get_sequence("employees") RETURNING errNo, p_data.employeeid
        {<POINT Name="fct.employees_insertRowByKey.init">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            IF consultcompanion_events.m_DbxDataEvent_employees_BeforeInsertRowByKey IS NOT NULL THEN
                CALL consultcompanion_events.m_DbxDataEvent_employees_BeforeInsertRowByKey(p_data.*)
                    RETURNING errNo, errMsg, p_data.*
            END IF
            IF errNo == ERROR_SUCCESS THEN
                CALL consultcompanion_dbxconstraints.consultcompanion_dbxconstraints_employees_checkTableConstraints(FALSE, p_data.*) RETURNING errNo, errMsg
            END IF
            {<POINT Name="fct.employees_insertRowByKey.beforeInsert">} {</POINT>}
            IF errNo == ERROR_SUCCESS THEN
                TRY
                    INSERT INTO employees VALUES (p_data.*)
                    CALL libdbapp_get_inserted_sequence(p_data.employeeid) RETURNING p_data.employeeid
                CATCH
                    LET errNo = ERROR_FAILURE
                END TRY
                IF consultcompanion_events.m_DbxDataEvent_employees_AfterInsertRowByKey IS NOT NULL THEN
                    CALL consultcompanion_events.m_DbxDataEvent_employees_AfterInsertRowByKey(p_data.*)
                        RETURNING errNo, errMsg
                END IF
                {<POINT Name="fct.employees_insertRowByKey.afterInsert">} {</POINT>}
            END IF
        END IF
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg, p_data.employeeid
END FUNCTION
{</BLOCK>} --fct.employees_insertRowByKey

{<BLOCK Name="fct.employees_PK_employees_1_insertRowByKey">}
#+ Insert a row in the "employees" table and return the table keys
#+
#+ @param p_data - a row data LIKE employees.*
#+
#+ @returnType INTEGER, STRING, SERIAL
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, employees.employeeid
PUBLIC FUNCTION consultcompanion_dbxdata_employees_PK_employees_1_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE employees.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.employees_PK_employees_1_insertRowByKey.define">} {</POINT>}
    {<POINT Name="fct.employees_PK_employees_1_insertRowByKey.init">} {</POINT>}

    CALL consultcompanion_dbxdata_employees_insertRowByKey(p_data.*) RETURNING errNo, errMsg, p_data.employeeid
    RETURN errNo, errMsg, p_data.employeeid
END FUNCTION
{</BLOCK>} --fct.employees_PK_employees_1_insertRowByKey

{<BLOCK Name="fct.employees_PK_employees_1_updateRowByKey">}
#+ Update a row identified by the primary key in the "employees" table
#+
#+ @param p_dataT0 - a row data LIKE employees.*
#+ @param p_dataT1 - a row data LIKE employees.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxdata_employees_PK_employees_1_updateRowByKey(p_dataT0, p_dataT1)
    DEFINE p_dataT0 RECORD LIKE employees.*
    DEFINE p_dataT1 RECORD LIKE employees.*
    DEFINE l_key
        RECORD
            employees_employeeid LIKE employees.employeeid
        END RECORD
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.employees_PK_employees_1_updateRowByKey.define">} {</POINT>}
    LET l_key.employees_employeeid = p_dataT0.employeeid
    INITIALIZE errMsg TO NULL
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.employees_PK_employees_1_updateRowByKey.init">} {</POINT>}
        TRY
            LET errNo = consultcompanion_dbxdata_employees_PK_employees_1_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
            {<POINT Name="fct.employees_PK_employees_1_updateRowByKey.afterSelect">} {</POINT>}
            IF errNo == ERROR_SUCCESS THEN
                CALL consultcompanion_dbxconstraints.consultcompanion_dbxconstraints_employees_checkTableConstraints(TRUE, p_dataT1.*) RETURNING errNo, errMsg
                {<POINT Name="fct.employees_PK_employees_1_updateRowByKey.beforeUpdate">} {</POINT>}
                IF errNo == ERROR_SUCCESS THEN
                 IF consultcompanion_events.m_DbxDataEvent_employees_BeforeUpdateRowByKey IS NOT NULL THEN
                    CALL consultcompanion_events.m_DbxDataEvent_employees_BeforeUpdateRowByKey(p_dataT1.*)
                        RETURNING errNo, errMsg
                END IF
                    UPDATE employees
                        SET employees.* = p_dataT1.*
                        WHERE @employees.employeeid = l_key.employees_employeeid
                END IF
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        IF consultcompanion_events.m_DbxDataEvent_employees_AfterUpdateRowByKey IS NOT NULL THEN
            CALL consultcompanion_events.m_DbxDataEvent_employees_AfterUpdateRowByKey(p_dataT1.*)
                RETURNING errNo, errMsg
        END IF
        {<POINT Name="fct.employees_PK_employees_1_updateRowByKey.afterUpdate">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.employees_PK_employees_1_updateRowByKey

{<BLOCK Name="fct.employees_PK_employees_1_deleteRowByKey">}
#+ Delete a row identified by the primary key in the "employees" table
#+
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION consultcompanion_dbxdata_employees_PK_employees_1_deleteRowByKey(p_key)
    DEFINE p_key
        RECORD
            employees_employeeid LIKE employees.employeeid
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.employees_PK_employees_1_deleteRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.employees_PK_employees_1_deleteRowByKey.init">} {</POINT>}
        IF consultcompanion_events.m_DbxDataEvent_employees_BeforeDeleteRowByKey IS NOT NULL THEN
            CALL consultcompanion_events.m_DbxDataEvent_employees_BeforeDeleteRowByKey(p_key.*)
                RETURNING errNo
        END IF
        TRY
            DELETE FROM employees
                WHERE @employees.employeeid = p_key.employees_employeeid
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        IF consultcompanion_events.m_DbxDataEvent_employees_AfterDeleteRowByKey IS NOT NULL THEN
            CALL consultcompanion_events.m_DbxDataEvent_employees_AfterDeleteRowByKey(p_key.*)
                RETURNING errNo
        END IF
        {<POINT Name="fct.employees_PK_employees_1_deleteRowByKey.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.employees_PK_employees_1_deleteRowByKey

{<BLOCK Name="fct.employees_PK_employees_1_deleteRowByKeyWithConcurrentAccess">}
#+ Delete a row identified by the primary key in the "employees" table if the concurrent access is success
#+
#+ @param p_dataT0 - a row data LIKE employees.*
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION consultcompanion_dbxdata_employees_PK_employees_1_deleteRowByKeyWithConcurrentAccess(p_dataT0)
    DEFINE p_dataT0 RECORD LIKE employees.*
    DEFINE l_key
        RECORD
            employees_employeeid LIKE employees.employeeid
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.employees_PK_employees_1_deleteRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.employees_employeeid = p_dataT0.employeeid
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.employees_PK_employees_1_deleteRowByKeyWithConcurrentAccess.init">} {</POINT>}
        LET errNo = consultcompanion_dbxdata_employees_PK_employees_1_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
        {<POINT Name="fct.employees_PK_employees_1_deleteRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = consultcompanion_dbxdata_employees_PK_employees_1_deleteRowByKey(l_key.*)
        END IF
        {<POINT Name="fct.employees_PK_employees_1_deleteRowByKeyWithConcurrentAccess.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.employees_PK_employees_1_deleteRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.employees_PK_employees_1_checkRowByKeyWithConcurrentAccess">}
#+ Check if a row identified by the primary key in the "employees" table has been modified or deleted
#+
#+ @param p_dataT0 - a row data LIKE employees.*
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE
PUBLIC FUNCTION consultcompanion_dbxdata_employees_PK_employees_1_checkRowByKeyWithConcurrentAccess(p_dataT0, p_lock)
    DEFINE p_dataT0 RECORD LIKE employees.*
    DEFINE l_dataT2 RECORD LIKE employees.*
    DEFINE l_key
        RECORD
            employees_employeeid LIKE employees.employeeid
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE errNo INTEGER
    DEFINE errDiff INTEGER
    {<POINT Name="fct.employees_PK_employees_1_checkRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.employees_employeeid = p_dataT0.employeeid
    INITIALIZE l_dataT2.* TO NULL
    LET errDiff = FALSE
    {<POINT Name="fct.employees_PK_employees_1_checkRowByKeyWithConcurrentAccess.init">} {</POINT>}
    CALL consultcompanion_dbxdata_employees_PK_employees_1_selectRowByKey(l_key.*, p_lock) RETURNING errNo, l_dataT2.*
    CASE errNo
        WHEN ERROR_SUCCESS
            LET errDiff = (p_dataT0.* != l_dataT2.*)
            {<POINT Name="fct.employees_PK_employees_1_checkRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
            IF NOT errDiff THEN
                LET errNo = ERROR_SUCCESS
            ELSE
                LET errNo = ERROR_CONCURRENT_ACCESS_FAILURE
            END IF
        WHEN ERROR_NOTFOUND
            LET errNo = ERROR_CONCURRENT_ACCESS_NOTFOUND
    END CASE
    {<POINT Name="fct.employees_PK_employees_1_checkRowByKeyWithConcurrentAccess.afterCheck">} {</POINT>}
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.employees_PK_employees_1_checkRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.employees_setDefaultValuesFromDBSchema">}
#+ Set data with the default values coming from the DB schema
#+
PUBLIC FUNCTION consultcompanion_dbxdata_employees_setDefaultValuesFromDBSchema()
    DEFINE l_data RECORD LIKE employees.*
    {<POINT Name="fct.employees_setDefaultValuesFromDBSchema.define">} {</POINT>}

    INITIALIZE l_data.* TO NULL
    {<POINT Name="fct.employees_setDefaultValuesFromDBSchema.init">} {</POINT>}
    IF consultcompanion_events.m_DbxDataEvent_employees_SetDefaultValues IS NOT NULL THEN
        CALL consultcompanion_events.m_DbxDataEvent_employees_SetDefaultValues(l_data.*)
            RETURNING l_data.*
    END IF
    RETURN l_data.*
END FUNCTION
{</BLOCK>} --fct.employees_setDefaultValuesFromDBSchema

{<BLOCK Name="fct.country_PK_country_1_selectRowByKey">}
#+ Select a row identified by the primary key in the "country" table
#+
#+ @param p_key - Primary Key
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER, LIKE country.*
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_NOTFOUND, RECORD LIKE country.*
PUBLIC FUNCTION consultcompanion_dbxdata_country_PK_country_1_selectRowByKey(p_key, p_lock)
    DEFINE p_key
        RECORD
            country_countryid LIKE country.countryid
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE l_data RECORD LIKE country.*
    DEFINE l_supportLock BOOLEAN
    DEFINE errNo INTEGER
    {<POINT Name="fct.country_PK_country_1_selectRowByKey.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    -- SQLite does not support the FOR UPDATE close in SELECT syntax
    LET l_supportLock = (UPSHIFT(fgl_db_driver_type()) != "SQT")
    {<POINT Name="fct.country_PK_country_1_selectRowByKey.init">} {</POINT>}
    TRY
        IF p_lock AND l_supportLock THEN
            SELECT * INTO l_data.* FROM country
                WHERE @country.countryid = p_key.country_countryid
            FOR UPDATE
        ELSE
            SELECT * INTO l_data.* FROM country
                WHERE @country.countryid = p_key.country_countryid
        END IF
        IF SQLCA.SQLCODE == NOTFOUND THEN
            LET errNo = ERROR_NOTFOUND
        END IF
    CATCH
        INITIALIZE l_data.* TO NULL
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.country_PK_country_1_selectRowByKey.afterSelect">} {</POINT>}
    RETURN errNo, l_data.*
END FUNCTION
{</BLOCK>} --fct.country_PK_country_1_selectRowByKey

{<BLOCK Name="fct.country_insertRowByKey">}
#+ Insert a row in the "country" table and return the primary key created
#+
#+ @param p_data - a row data LIKE country.*
#+
#+ @returnType INTEGER, STRING, SERIAL
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, country.countryid
PRIVATE FUNCTION consultcompanion_dbxdata_country_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE country.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.country_insertRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        CALL libdbapp_get_sequence("country") RETURNING errNo, p_data.countryid
        {<POINT Name="fct.country_insertRowByKey.init">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            IF consultcompanion_events.m_DbxDataEvent_country_BeforeInsertRowByKey IS NOT NULL THEN
                CALL consultcompanion_events.m_DbxDataEvent_country_BeforeInsertRowByKey(p_data.*)
                    RETURNING errNo, errMsg, p_data.*
            END IF
            IF errNo == ERROR_SUCCESS THEN
                CALL consultcompanion_dbxconstraints.consultcompanion_dbxconstraints_country_checkTableConstraints(FALSE, p_data.*) RETURNING errNo, errMsg
            END IF
            {<POINT Name="fct.country_insertRowByKey.beforeInsert">} {</POINT>}
            IF errNo == ERROR_SUCCESS THEN
                TRY
                    INSERT INTO country VALUES (p_data.*)
                    CALL libdbapp_get_inserted_sequence(p_data.countryid) RETURNING p_data.countryid
                CATCH
                    LET errNo = ERROR_FAILURE
                END TRY
                IF consultcompanion_events.m_DbxDataEvent_country_AfterInsertRowByKey IS NOT NULL THEN
                    CALL consultcompanion_events.m_DbxDataEvent_country_AfterInsertRowByKey(p_data.*)
                        RETURNING errNo, errMsg
                END IF
                {<POINT Name="fct.country_insertRowByKey.afterInsert">} {</POINT>}
            END IF
        END IF
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg, p_data.countryid
END FUNCTION
{</BLOCK>} --fct.country_insertRowByKey

{<BLOCK Name="fct.country_PK_country_1_insertRowByKey">}
#+ Insert a row in the "country" table and return the table keys
#+
#+ @param p_data - a row data LIKE country.*
#+
#+ @returnType INTEGER, STRING, SERIAL
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, country.countryid
PUBLIC FUNCTION consultcompanion_dbxdata_country_PK_country_1_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE country.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.country_PK_country_1_insertRowByKey.define">} {</POINT>}
    {<POINT Name="fct.country_PK_country_1_insertRowByKey.init">} {</POINT>}

    CALL consultcompanion_dbxdata_country_insertRowByKey(p_data.*) RETURNING errNo, errMsg, p_data.countryid
    RETURN errNo, errMsg, p_data.countryid
END FUNCTION
{</BLOCK>} --fct.country_PK_country_1_insertRowByKey

{<BLOCK Name="fct.country_PK_country_1_updateRowByKey">}
#+ Update a row identified by the primary key in the "country" table
#+
#+ @param p_dataT0 - a row data LIKE country.*
#+ @param p_dataT1 - a row data LIKE country.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxdata_country_PK_country_1_updateRowByKey(p_dataT0, p_dataT1)
    DEFINE p_dataT0 RECORD LIKE country.*
    DEFINE p_dataT1 RECORD LIKE country.*
    DEFINE l_key
        RECORD
            country_countryid LIKE country.countryid
        END RECORD
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.country_PK_country_1_updateRowByKey.define">} {</POINT>}
    LET l_key.country_countryid = p_dataT0.countryid
    INITIALIZE errMsg TO NULL
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.country_PK_country_1_updateRowByKey.init">} {</POINT>}
        TRY
            LET errNo = consultcompanion_dbxdata_country_PK_country_1_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
            {<POINT Name="fct.country_PK_country_1_updateRowByKey.afterSelect">} {</POINT>}
            IF errNo == ERROR_SUCCESS THEN
                CALL consultcompanion_dbxconstraints.consultcompanion_dbxconstraints_country_checkTableConstraints(TRUE, p_dataT1.*) RETURNING errNo, errMsg
                {<POINT Name="fct.country_PK_country_1_updateRowByKey.beforeUpdate">} {</POINT>}
                IF errNo == ERROR_SUCCESS THEN
                 IF consultcompanion_events.m_DbxDataEvent_country_BeforeUpdateRowByKey IS NOT NULL THEN
                    CALL consultcompanion_events.m_DbxDataEvent_country_BeforeUpdateRowByKey(p_dataT1.*)
                        RETURNING errNo, errMsg
                END IF
                    UPDATE country
                        SET country.* = p_dataT1.*
                        WHERE @country.countryid = l_key.country_countryid
                END IF
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        IF consultcompanion_events.m_DbxDataEvent_country_AfterUpdateRowByKey IS NOT NULL THEN
            CALL consultcompanion_events.m_DbxDataEvent_country_AfterUpdateRowByKey(p_dataT1.*)
                RETURNING errNo, errMsg
        END IF
        {<POINT Name="fct.country_PK_country_1_updateRowByKey.afterUpdate">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.country_PK_country_1_updateRowByKey

{<BLOCK Name="fct.country_PK_country_1_deleteRowByKey">}
#+ Delete a row identified by the primary key in the "country" table
#+
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION consultcompanion_dbxdata_country_PK_country_1_deleteRowByKey(p_key)
    DEFINE p_key
        RECORD
            country_countryid LIKE country.countryid
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.country_PK_country_1_deleteRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.country_PK_country_1_deleteRowByKey.init">} {</POINT>}
        IF consultcompanion_events.m_DbxDataEvent_country_BeforeDeleteRowByKey IS NOT NULL THEN
            CALL consultcompanion_events.m_DbxDataEvent_country_BeforeDeleteRowByKey(p_key.*)
                RETURNING errNo
        END IF
        TRY
            CALL consultcompanion_dbxdata_country_PK_country_1_deleteReferencingRowsByKey(p_key.*) RETURNING errNo
            IF errNo == ERROR_SUCCESS THEN
                DELETE FROM country
                    WHERE @country.countryid = p_key.country_countryid
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        IF consultcompanion_events.m_DbxDataEvent_country_AfterDeleteRowByKey IS NOT NULL THEN
            CALL consultcompanion_events.m_DbxDataEvent_country_AfterDeleteRowByKey(p_key.*)
                RETURNING errNo
        END IF
        {<POINT Name="fct.country_PK_country_1_deleteRowByKey.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.country_PK_country_1_deleteRowByKey

{<BLOCK Name="fct.country_PK_country_1_deleteRowByKeyWithConcurrentAccess">}
#+ Delete a row identified by the primary key in the "country" table if the concurrent access is success
#+
#+ @param p_dataT0 - a row data LIKE country.*
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION consultcompanion_dbxdata_country_PK_country_1_deleteRowByKeyWithConcurrentAccess(p_dataT0)
    DEFINE p_dataT0 RECORD LIKE country.*
    DEFINE l_key
        RECORD
            country_countryid LIKE country.countryid
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.country_PK_country_1_deleteRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.country_countryid = p_dataT0.countryid
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.country_PK_country_1_deleteRowByKeyWithConcurrentAccess.init">} {</POINT>}
        LET errNo = consultcompanion_dbxdata_country_PK_country_1_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
        {<POINT Name="fct.country_PK_country_1_deleteRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = consultcompanion_dbxdata_country_PK_country_1_deleteRowByKey(l_key.*)
        END IF
        {<POINT Name="fct.country_PK_country_1_deleteRowByKeyWithConcurrentAccess.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.country_PK_country_1_deleteRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.country_PK_country_1_checkRowByKeyWithConcurrentAccess">}
#+ Check if a row identified by the primary key in the "country" table has been modified or deleted
#+
#+ @param p_dataT0 - a row data LIKE country.*
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE
PUBLIC FUNCTION consultcompanion_dbxdata_country_PK_country_1_checkRowByKeyWithConcurrentAccess(p_dataT0, p_lock)
    DEFINE p_dataT0 RECORD LIKE country.*
    DEFINE l_dataT2 RECORD LIKE country.*
    DEFINE l_key
        RECORD
            country_countryid LIKE country.countryid
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE errNo INTEGER
    DEFINE errDiff INTEGER
    {<POINT Name="fct.country_PK_country_1_checkRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.country_countryid = p_dataT0.countryid
    INITIALIZE l_dataT2.* TO NULL
    LET errDiff = FALSE
    {<POINT Name="fct.country_PK_country_1_checkRowByKeyWithConcurrentAccess.init">} {</POINT>}
    CALL consultcompanion_dbxdata_country_PK_country_1_selectRowByKey(l_key.*, p_lock) RETURNING errNo, l_dataT2.*
    CASE errNo
        WHEN ERROR_SUCCESS
            LET errDiff = (p_dataT0.* != l_dataT2.*)
            {<POINT Name="fct.country_PK_country_1_checkRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
            IF NOT errDiff THEN
                LET errNo = ERROR_SUCCESS
            ELSE
                LET errNo = ERROR_CONCURRENT_ACCESS_FAILURE
            END IF
        WHEN ERROR_NOTFOUND
            LET errNo = ERROR_CONCURRENT_ACCESS_NOTFOUND
    END CASE
    {<POINT Name="fct.country_PK_country_1_checkRowByKeyWithConcurrentAccess.afterCheck">} {</POINT>}
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.country_PK_country_1_checkRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.country_PK_country_1_deleteReferencingRowsByKey">}
#+ Delete rows referencing the primary key of the "country" table
#+
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION consultcompanion_dbxdata_country_PK_country_1_deleteReferencingRowsByKey(p_key)
    DEFINE p_key
        RECORD
            country_countryid LIKE country.countryid
        END RECORD
    DEFINE l_data RECORD LIKE country.*
    DEFINE l_key_FK_provinces_country_1
        RECORD
            provinces_provinceid LIKE provinces.provinceid
        END RECORD
    DEFINE l_key_FK_employees_country_1
        RECORD
            employees_employeeid LIKE employees.employeeid
        END RECORD
    DEFINE l_key_FK_clients_country_1
        RECORD
            clients_clientid LIKE clients.clientid
        END RECORD
    DEFINE errNo INTEGER
    DEFINE l_sqlQuery STRING
    {<POINT Name="fct.country_PK_country_1_deleteReferencingRowsByKey.define">} {</POINT>}

    INITIALIZE l_data.* TO NULL
    {<POINT Name="fct.country_PK_country_1_deleteReferencingRowsByKey.init">} {</POINT>}
    CALL consultcompanion_dbxdata_country_PK_country_1_selectRowByKey(p_key.*, FALSE)
        RETURNING errNo, l_data.*
    CASE errNo
        WHEN ERROR_SUCCESS
            --check Foreign Key FK_provinces_country_1
            LET l_sqlQuery = "SELECT provinceid FROM provinces WHERE provinces.countryid = ?"
            TRY
                DECLARE consultcompanion_dbxdata_country_PK_country_1_deleteReferencingRowsByKey_FK_provinces_country_1 CURSOR FROM l_sqlQuery
                OPEN consultcompanion_dbxdata_country_PK_country_1_deleteReferencingRowsByKey_FK_provinces_country_1
                    USING l_data.countryid
                FETCH consultcompanion_dbxdata_country_PK_country_1_deleteReferencingRowsByKey_FK_provinces_country_1
                    INTO l_key_FK_provinces_country_1.*
                IF SQLCA.SQLCODE = 0 THEN
                    LET errNo = ERROR_DELETE_CASCADE_ROW_USED
                END IF
                CLOSE consultcompanion_dbxdata_country_PK_country_1_deleteReferencingRowsByKey_FK_provinces_country_1
            CATCH
                LET errNo = ERROR_FAILURE
            END TRY

            IF errNo == ERROR_SUCCESS THEN
                --check Foreign Key FK_employees_country_1
                LET l_sqlQuery = "SELECT employeeid FROM employees WHERE employees.countryid = ?"
                TRY
                    DECLARE consultcompanion_dbxdata_country_PK_country_1_deleteReferencingRowsByKey_FK_employees_country_1 CURSOR FROM l_sqlQuery
                    OPEN consultcompanion_dbxdata_country_PK_country_1_deleteReferencingRowsByKey_FK_employees_country_1
                        USING l_data.countryid
                    FETCH consultcompanion_dbxdata_country_PK_country_1_deleteReferencingRowsByKey_FK_employees_country_1
                        INTO l_key_FK_employees_country_1.*
                    IF SQLCA.SQLCODE = 0 THEN
                        LET errNo = ERROR_DELETE_CASCADE_ROW_USED
                    END IF
                    CLOSE consultcompanion_dbxdata_country_PK_country_1_deleteReferencingRowsByKey_FK_employees_country_1
                CATCH
                    LET errNo = ERROR_FAILURE
                END TRY

            END IF

            IF errNo == ERROR_SUCCESS THEN
                --check Foreign Key FK_clients_country_1
                LET l_sqlQuery = "SELECT clientid FROM clients WHERE clients.countryid = ?"
                TRY
                    DECLARE consultcompanion_dbxdata_country_PK_country_1_deleteReferencingRowsByKey_FK_clients_country_1 CURSOR FROM l_sqlQuery
                    OPEN consultcompanion_dbxdata_country_PK_country_1_deleteReferencingRowsByKey_FK_clients_country_1
                        USING l_data.countryid
                    FETCH consultcompanion_dbxdata_country_PK_country_1_deleteReferencingRowsByKey_FK_clients_country_1
                        INTO l_key_FK_clients_country_1.*
                    IF SQLCA.SQLCODE = 0 THEN
                        LET errNo = ERROR_DELETE_CASCADE_ROW_USED
                    END IF
                    CLOSE consultcompanion_dbxdata_country_PK_country_1_deleteReferencingRowsByKey_FK_clients_country_1
                CATCH
                    LET errNo = ERROR_FAILURE
                END TRY

            END IF
        WHEN ERROR_NOTFOUND
            LET errNo = ERROR_SUCCESS
    END CASE
    {<POINT Name="fct.country_PK_country_1_deleteReferencingRowsByKey.afterDelete">} {</POINT>}
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.country_PK_country_1_deleteReferencingRowsByKey

{<BLOCK Name="fct.country_setDefaultValuesFromDBSchema">}
#+ Set data with the default values coming from the DB schema
#+
PUBLIC FUNCTION consultcompanion_dbxdata_country_setDefaultValuesFromDBSchema()
    DEFINE l_data RECORD LIKE country.*
    {<POINT Name="fct.country_setDefaultValuesFromDBSchema.define">} {</POINT>}

    INITIALIZE l_data.* TO NULL
    {<POINT Name="fct.country_setDefaultValuesFromDBSchema.init">} {</POINT>}
    IF consultcompanion_events.m_DbxDataEvent_country_SetDefaultValues IS NOT NULL THEN
        CALL consultcompanion_events.m_DbxDataEvent_country_SetDefaultValues(l_data.*)
            RETURNING l_data.*
    END IF
    RETURN l_data.*
END FUNCTION
{</BLOCK>} --fct.country_setDefaultValuesFromDBSchema

{<BLOCK Name="fct.clienttypes_PK_clientTypes_1_selectRowByKey">}
#+ Select a row identified by the primary key in the "clienttypes" table
#+
#+ @param p_key - Primary Key
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER, LIKE clienttypes.*
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_NOTFOUND, RECORD LIKE clienttypes.*
PUBLIC FUNCTION consultcompanion_dbxdata_clienttypes_PK_clientTypes_1_selectRowByKey(p_key, p_lock)
    DEFINE p_key
        RECORD
            clienttypes_clienttypeid LIKE clienttypes.clienttypeid
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE l_data RECORD LIKE clienttypes.*
    DEFINE l_supportLock BOOLEAN
    DEFINE errNo INTEGER
    {<POINT Name="fct.clienttypes_PK_clientTypes_1_selectRowByKey.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    -- SQLite does not support the FOR UPDATE close in SELECT syntax
    LET l_supportLock = (UPSHIFT(fgl_db_driver_type()) != "SQT")
    {<POINT Name="fct.clienttypes_PK_clientTypes_1_selectRowByKey.init">} {</POINT>}
    TRY
        IF p_lock AND l_supportLock THEN
            SELECT * INTO l_data.* FROM clienttypes
                WHERE @clienttypes.clienttypeid = p_key.clienttypes_clienttypeid
            FOR UPDATE
        ELSE
            SELECT * INTO l_data.* FROM clienttypes
                WHERE @clienttypes.clienttypeid = p_key.clienttypes_clienttypeid
        END IF
        IF SQLCA.SQLCODE == NOTFOUND THEN
            LET errNo = ERROR_NOTFOUND
        END IF
    CATCH
        INITIALIZE l_data.* TO NULL
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.clienttypes_PK_clientTypes_1_selectRowByKey.afterSelect">} {</POINT>}
    RETURN errNo, l_data.*
END FUNCTION
{</BLOCK>} --fct.clienttypes_PK_clientTypes_1_selectRowByKey

{<BLOCK Name="fct.clienttypes_insertRowByKey">}
#+ Insert a row in the "clienttypes" table and return the primary key created
#+
#+ @param p_data - a row data LIKE clienttypes.*
#+
#+ @returnType INTEGER, STRING, SERIAL
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, clienttypes.clienttypeid
PRIVATE FUNCTION consultcompanion_dbxdata_clienttypes_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE clienttypes.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.clienttypes_insertRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        CALL libdbapp_get_sequence("clienttypes") RETURNING errNo, p_data.clienttypeid
        {<POINT Name="fct.clienttypes_insertRowByKey.init">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            IF consultcompanion_events.m_DbxDataEvent_clienttypes_BeforeInsertRowByKey IS NOT NULL THEN
                CALL consultcompanion_events.m_DbxDataEvent_clienttypes_BeforeInsertRowByKey(p_data.*)
                    RETURNING errNo, errMsg, p_data.*
            END IF
            IF errNo == ERROR_SUCCESS THEN
                CALL consultcompanion_dbxconstraints.consultcompanion_dbxconstraints_clienttypes_checkTableConstraints(FALSE, p_data.*) RETURNING errNo, errMsg
            END IF
            {<POINT Name="fct.clienttypes_insertRowByKey.beforeInsert">} {</POINT>}
            IF errNo == ERROR_SUCCESS THEN
                TRY
                    INSERT INTO clienttypes VALUES (p_data.*)
                    CALL libdbapp_get_inserted_sequence(p_data.clienttypeid) RETURNING p_data.clienttypeid
                CATCH
                    LET errNo = ERROR_FAILURE
                END TRY
                IF consultcompanion_events.m_DbxDataEvent_clienttypes_AfterInsertRowByKey IS NOT NULL THEN
                    CALL consultcompanion_events.m_DbxDataEvent_clienttypes_AfterInsertRowByKey(p_data.*)
                        RETURNING errNo, errMsg
                END IF
                {<POINT Name="fct.clienttypes_insertRowByKey.afterInsert">} {</POINT>}
            END IF
        END IF
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg, p_data.clienttypeid
END FUNCTION
{</BLOCK>} --fct.clienttypes_insertRowByKey

{<BLOCK Name="fct.clienttypes_PK_clientTypes_1_insertRowByKey">}
#+ Insert a row in the "clienttypes" table and return the table keys
#+
#+ @param p_data - a row data LIKE clienttypes.*
#+
#+ @returnType INTEGER, STRING, SERIAL
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, clienttypes.clienttypeid
PUBLIC FUNCTION consultcompanion_dbxdata_clienttypes_PK_clientTypes_1_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE clienttypes.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.clienttypes_PK_clientTypes_1_insertRowByKey.define">} {</POINT>}
    {<POINT Name="fct.clienttypes_PK_clientTypes_1_insertRowByKey.init">} {</POINT>}

    CALL consultcompanion_dbxdata_clienttypes_insertRowByKey(p_data.*) RETURNING errNo, errMsg, p_data.clienttypeid
    RETURN errNo, errMsg, p_data.clienttypeid
END FUNCTION
{</BLOCK>} --fct.clienttypes_PK_clientTypes_1_insertRowByKey

{<BLOCK Name="fct.clienttypes_PK_clientTypes_1_updateRowByKey">}
#+ Update a row identified by the primary key in the "clienttypes" table
#+
#+ @param p_dataT0 - a row data LIKE clienttypes.*
#+ @param p_dataT1 - a row data LIKE clienttypes.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxdata_clienttypes_PK_clientTypes_1_updateRowByKey(p_dataT0, p_dataT1)
    DEFINE p_dataT0 RECORD LIKE clienttypes.*
    DEFINE p_dataT1 RECORD LIKE clienttypes.*
    DEFINE l_key
        RECORD
            clienttypes_clienttypeid LIKE clienttypes.clienttypeid
        END RECORD
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.clienttypes_PK_clientTypes_1_updateRowByKey.define">} {</POINT>}
    LET l_key.clienttypes_clienttypeid = p_dataT0.clienttypeid
    INITIALIZE errMsg TO NULL
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.clienttypes_PK_clientTypes_1_updateRowByKey.init">} {</POINT>}
        TRY
            LET errNo = consultcompanion_dbxdata_clienttypes_PK_clientTypes_1_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
            {<POINT Name="fct.clienttypes_PK_clientTypes_1_updateRowByKey.afterSelect">} {</POINT>}
            IF errNo == ERROR_SUCCESS THEN
                CALL consultcompanion_dbxconstraints.consultcompanion_dbxconstraints_clienttypes_checkTableConstraints(TRUE, p_dataT1.*) RETURNING errNo, errMsg
                {<POINT Name="fct.clienttypes_PK_clientTypes_1_updateRowByKey.beforeUpdate">} {</POINT>}
                IF errNo == ERROR_SUCCESS THEN
                 IF consultcompanion_events.m_DbxDataEvent_clienttypes_BeforeUpdateRowByKey IS NOT NULL THEN
                    CALL consultcompanion_events.m_DbxDataEvent_clienttypes_BeforeUpdateRowByKey(p_dataT1.*)
                        RETURNING errNo, errMsg
                END IF
                    UPDATE clienttypes
                        SET clienttypes.* = p_dataT1.*
                        WHERE @clienttypes.clienttypeid = l_key.clienttypes_clienttypeid
                END IF
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        IF consultcompanion_events.m_DbxDataEvent_clienttypes_AfterUpdateRowByKey IS NOT NULL THEN
            CALL consultcompanion_events.m_DbxDataEvent_clienttypes_AfterUpdateRowByKey(p_dataT1.*)
                RETURNING errNo, errMsg
        END IF
        {<POINT Name="fct.clienttypes_PK_clientTypes_1_updateRowByKey.afterUpdate">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.clienttypes_PK_clientTypes_1_updateRowByKey

{<BLOCK Name="fct.clienttypes_PK_clientTypes_1_deleteRowByKey">}
#+ Delete a row identified by the primary key in the "clienttypes" table
#+
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION consultcompanion_dbxdata_clienttypes_PK_clientTypes_1_deleteRowByKey(p_key)
    DEFINE p_key
        RECORD
            clienttypes_clienttypeid LIKE clienttypes.clienttypeid
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.clienttypes_PK_clientTypes_1_deleteRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.clienttypes_PK_clientTypes_1_deleteRowByKey.init">} {</POINT>}
        IF consultcompanion_events.m_DbxDataEvent_clienttypes_BeforeDeleteRowByKey IS NOT NULL THEN
            CALL consultcompanion_events.m_DbxDataEvent_clienttypes_BeforeDeleteRowByKey(p_key.*)
                RETURNING errNo
        END IF
        TRY
            CALL consultcompanion_dbxdata_clienttypes_PK_clientTypes_1_deleteReferencingRowsByKey(p_key.*) RETURNING errNo
            IF errNo == ERROR_SUCCESS THEN
                DELETE FROM clienttypes
                    WHERE @clienttypes.clienttypeid = p_key.clienttypes_clienttypeid
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        IF consultcompanion_events.m_DbxDataEvent_clienttypes_AfterDeleteRowByKey IS NOT NULL THEN
            CALL consultcompanion_events.m_DbxDataEvent_clienttypes_AfterDeleteRowByKey(p_key.*)
                RETURNING errNo
        END IF
        {<POINT Name="fct.clienttypes_PK_clientTypes_1_deleteRowByKey.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.clienttypes_PK_clientTypes_1_deleteRowByKey

{<BLOCK Name="fct.clienttypes_PK_clientTypes_1_deleteRowByKeyWithConcurrentAccess">}
#+ Delete a row identified by the primary key in the "clienttypes" table if the concurrent access is success
#+
#+ @param p_dataT0 - a row data LIKE clienttypes.*
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION consultcompanion_dbxdata_clienttypes_PK_clientTypes_1_deleteRowByKeyWithConcurrentAccess(p_dataT0)
    DEFINE p_dataT0 RECORD LIKE clienttypes.*
    DEFINE l_key
        RECORD
            clienttypes_clienttypeid LIKE clienttypes.clienttypeid
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.clienttypes_PK_clientTypes_1_deleteRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.clienttypes_clienttypeid = p_dataT0.clienttypeid
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.clienttypes_PK_clientTypes_1_deleteRowByKeyWithConcurrentAccess.init">} {</POINT>}
        LET errNo = consultcompanion_dbxdata_clienttypes_PK_clientTypes_1_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
        {<POINT Name="fct.clienttypes_PK_clientTypes_1_deleteRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = consultcompanion_dbxdata_clienttypes_PK_clientTypes_1_deleteRowByKey(l_key.*)
        END IF
        {<POINT Name="fct.clienttypes_PK_clientTypes_1_deleteRowByKeyWithConcurrentAccess.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.clienttypes_PK_clientTypes_1_deleteRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.clienttypes_PK_clientTypes_1_checkRowByKeyWithConcurrentAccess">}
#+ Check if a row identified by the primary key in the "clienttypes" table has been modified or deleted
#+
#+ @param p_dataT0 - a row data LIKE clienttypes.*
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE
PUBLIC FUNCTION consultcompanion_dbxdata_clienttypes_PK_clientTypes_1_checkRowByKeyWithConcurrentAccess(p_dataT0, p_lock)
    DEFINE p_dataT0 RECORD LIKE clienttypes.*
    DEFINE l_dataT2 RECORD LIKE clienttypes.*
    DEFINE l_key
        RECORD
            clienttypes_clienttypeid LIKE clienttypes.clienttypeid
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE errNo INTEGER
    DEFINE errDiff INTEGER
    {<POINT Name="fct.clienttypes_PK_clientTypes_1_checkRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.clienttypes_clienttypeid = p_dataT0.clienttypeid
    INITIALIZE l_dataT2.* TO NULL
    LET errDiff = FALSE
    {<POINT Name="fct.clienttypes_PK_clientTypes_1_checkRowByKeyWithConcurrentAccess.init">} {</POINT>}
    CALL consultcompanion_dbxdata_clienttypes_PK_clientTypes_1_selectRowByKey(l_key.*, p_lock) RETURNING errNo, l_dataT2.*
    CASE errNo
        WHEN ERROR_SUCCESS
            LET errDiff = (p_dataT0.* != l_dataT2.*)
            {<POINT Name="fct.clienttypes_PK_clientTypes_1_checkRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
            IF NOT errDiff THEN
                LET errNo = ERROR_SUCCESS
            ELSE
                LET errNo = ERROR_CONCURRENT_ACCESS_FAILURE
            END IF
        WHEN ERROR_NOTFOUND
            LET errNo = ERROR_CONCURRENT_ACCESS_NOTFOUND
    END CASE
    {<POINT Name="fct.clienttypes_PK_clientTypes_1_checkRowByKeyWithConcurrentAccess.afterCheck">} {</POINT>}
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.clienttypes_PK_clientTypes_1_checkRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.clienttypes_PK_clientTypes_1_deleteReferencingRowsByKey">}
#+ Delete rows referencing the primary key of the "clienttypes" table
#+
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION consultcompanion_dbxdata_clienttypes_PK_clientTypes_1_deleteReferencingRowsByKey(p_key)
    DEFINE p_key
        RECORD
            clienttypes_clienttypeid LIKE clienttypes.clienttypeid
        END RECORD
    DEFINE l_data RECORD LIKE clienttypes.*
    DEFINE l_key_FK_clients_clientTypes_1
        RECORD
            clients_clientid LIKE clients.clientid
        END RECORD
    DEFINE errNo INTEGER
    DEFINE l_sqlQuery STRING
    {<POINT Name="fct.clienttypes_PK_clientTypes_1_deleteReferencingRowsByKey.define">} {</POINT>}

    INITIALIZE l_data.* TO NULL
    {<POINT Name="fct.clienttypes_PK_clientTypes_1_deleteReferencingRowsByKey.init">} {</POINT>}
    CALL consultcompanion_dbxdata_clienttypes_PK_clientTypes_1_selectRowByKey(p_key.*, FALSE)
        RETURNING errNo, l_data.*
    CASE errNo
        WHEN ERROR_SUCCESS
            --check Foreign Key FK_clients_clientTypes_1
            LET l_sqlQuery = "SELECT clientid FROM clients WHERE clients.clienttypeid = ?"
            TRY
                DECLARE consultcompanion_dbxdata_clienttypes_PK_clientTypes_1_deleteReferencingRowsByKey_FK_clients_clientTypes_1 CURSOR FROM l_sqlQuery
                OPEN consultcompanion_dbxdata_clienttypes_PK_clientTypes_1_deleteReferencingRowsByKey_FK_clients_clientTypes_1
                    USING l_data.clienttypeid
                FETCH consultcompanion_dbxdata_clienttypes_PK_clientTypes_1_deleteReferencingRowsByKey_FK_clients_clientTypes_1
                    INTO l_key_FK_clients_clientTypes_1.*
                IF SQLCA.SQLCODE = 0 THEN
                    LET errNo = ERROR_DELETE_CASCADE_ROW_USED
                END IF
                CLOSE consultcompanion_dbxdata_clienttypes_PK_clientTypes_1_deleteReferencingRowsByKey_FK_clients_clientTypes_1
            CATCH
                LET errNo = ERROR_FAILURE
            END TRY

        WHEN ERROR_NOTFOUND
            LET errNo = ERROR_SUCCESS
    END CASE
    {<POINT Name="fct.clienttypes_PK_clientTypes_1_deleteReferencingRowsByKey.afterDelete">} {</POINT>}
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.clienttypes_PK_clientTypes_1_deleteReferencingRowsByKey

{<BLOCK Name="fct.clienttypes_setDefaultValuesFromDBSchema">}
#+ Set data with the default values coming from the DB schema
#+
PUBLIC FUNCTION consultcompanion_dbxdata_clienttypes_setDefaultValuesFromDBSchema()
    DEFINE l_data RECORD LIKE clienttypes.*
    {<POINT Name="fct.clienttypes_setDefaultValuesFromDBSchema.define">} {</POINT>}

    INITIALIZE l_data.* TO NULL
    {<POINT Name="fct.clienttypes_setDefaultValuesFromDBSchema.init">} {</POINT>}
    IF consultcompanion_events.m_DbxDataEvent_clienttypes_SetDefaultValues IS NOT NULL THEN
        CALL consultcompanion_events.m_DbxDataEvent_clienttypes_SetDefaultValues(l_data.*)
            RETURNING l_data.*
    END IF
    RETURN l_data.*
END FUNCTION
{</BLOCK>} --fct.clienttypes_setDefaultValuesFromDBSchema

{<BLOCK Name="fct.clientstakeholders_PK_clientStakeholders_1_selectRowByKey">}
#+ Select a row identified by the primary key in the "clientstakeholders" table
#+
#+ @param p_key - Primary Key
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER, LIKE clientstakeholders.*
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_NOTFOUND, RECORD LIKE clientstakeholders.*
PUBLIC FUNCTION consultcompanion_dbxdata_clientstakeholders_PK_clientStakeholders_1_selectRowByKey(p_key, p_lock)
    DEFINE p_key
        RECORD
            clientstakeholders_stakeholderId LIKE clientstakeholders.stakeholderId
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE l_data RECORD LIKE clientstakeholders.*
    DEFINE l_supportLock BOOLEAN
    DEFINE errNo INTEGER
    {<POINT Name="fct.clientstakeholders_PK_clientStakeholders_1_selectRowByKey.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    -- SQLite does not support the FOR UPDATE close in SELECT syntax
    LET l_supportLock = (UPSHIFT(fgl_db_driver_type()) != "SQT")
    {<POINT Name="fct.clientstakeholders_PK_clientStakeholders_1_selectRowByKey.init">} {</POINT>}
    TRY
        IF p_lock AND l_supportLock THEN
            SELECT * INTO l_data.* FROM clientstakeholders
                WHERE @clientstakeholders.stakeholderId = p_key.clientstakeholders_stakeholderId
            FOR UPDATE
        ELSE
            SELECT * INTO l_data.* FROM clientstakeholders
                WHERE @clientstakeholders.stakeholderId = p_key.clientstakeholders_stakeholderId
        END IF
        IF SQLCA.SQLCODE == NOTFOUND THEN
            LET errNo = ERROR_NOTFOUND
        END IF
    CATCH
        INITIALIZE l_data.* TO NULL
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.clientstakeholders_PK_clientStakeholders_1_selectRowByKey.afterSelect">} {</POINT>}
    RETURN errNo, l_data.*
END FUNCTION
{</BLOCK>} --fct.clientstakeholders_PK_clientStakeholders_1_selectRowByKey

{<BLOCK Name="fct.clientstakeholders_insertRowByKey">}
#+ Insert a row in the "clientstakeholders" table and return the primary key created
#+
#+ @param p_data - a row data LIKE clientstakeholders.*
#+
#+ @returnType INTEGER, STRING, SERIAL
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, clientstakeholders.stakeholderId
PRIVATE FUNCTION consultcompanion_dbxdata_clientstakeholders_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE clientstakeholders.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.clientstakeholders_insertRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        CALL libdbapp_get_sequence("clientstakeholders") RETURNING errNo, p_data.stakeholderId
        {<POINT Name="fct.clientstakeholders_insertRowByKey.init">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            IF consultcompanion_events.m_DbxDataEvent_clientstakeholders_BeforeInsertRowByKey IS NOT NULL THEN
                CALL consultcompanion_events.m_DbxDataEvent_clientstakeholders_BeforeInsertRowByKey(p_data.*)
                    RETURNING errNo, errMsg, p_data.*
            END IF
            IF errNo == ERROR_SUCCESS THEN
                CALL consultcompanion_dbxconstraints.consultcompanion_dbxconstraints_clientstakeholders_checkTableConstraints(FALSE, p_data.*) RETURNING errNo, errMsg
            END IF
            {<POINT Name="fct.clientstakeholders_insertRowByKey.beforeInsert">} {</POINT>}
            IF errNo == ERROR_SUCCESS THEN
                TRY
                    INSERT INTO clientstakeholders VALUES (p_data.*)
                    CALL libdbapp_get_inserted_sequence(p_data.stakeholderId) RETURNING p_data.stakeholderId
                CATCH
                    LET errNo = ERROR_FAILURE
                END TRY
                IF consultcompanion_events.m_DbxDataEvent_clientstakeholders_AfterInsertRowByKey IS NOT NULL THEN
                    CALL consultcompanion_events.m_DbxDataEvent_clientstakeholders_AfterInsertRowByKey(p_data.*)
                        RETURNING errNo, errMsg
                END IF
                {<POINT Name="fct.clientstakeholders_insertRowByKey.afterInsert">} {</POINT>}
            END IF
        END IF
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg, p_data.stakeholderId
END FUNCTION
{</BLOCK>} --fct.clientstakeholders_insertRowByKey

{<BLOCK Name="fct.clientstakeholders_PK_clientStakeholders_1_insertRowByKey">}
#+ Insert a row in the "clientstakeholders" table and return the table keys
#+
#+ @param p_data - a row data LIKE clientstakeholders.*
#+
#+ @returnType INTEGER, STRING, SERIAL
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, clientstakeholders.stakeholderId
PUBLIC FUNCTION consultcompanion_dbxdata_clientstakeholders_PK_clientStakeholders_1_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE clientstakeholders.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.clientstakeholders_PK_clientStakeholders_1_insertRowByKey.define">} {</POINT>}
    {<POINT Name="fct.clientstakeholders_PK_clientStakeholders_1_insertRowByKey.init">} {</POINT>}

    CALL consultcompanion_dbxdata_clientstakeholders_insertRowByKey(p_data.*) RETURNING errNo, errMsg, p_data.stakeholderId
    RETURN errNo, errMsg, p_data.stakeholderId
END FUNCTION
{</BLOCK>} --fct.clientstakeholders_PK_clientStakeholders_1_insertRowByKey

{<BLOCK Name="fct.clientstakeholders_PK_clientStakeholders_1_updateRowByKey">}
#+ Update a row identified by the primary key in the "clientstakeholders" table
#+
#+ @param p_dataT0 - a row data LIKE clientstakeholders.*
#+ @param p_dataT1 - a row data LIKE clientstakeholders.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxdata_clientstakeholders_PK_clientStakeholders_1_updateRowByKey(p_dataT0, p_dataT1)
    DEFINE p_dataT0 RECORD LIKE clientstakeholders.*
    DEFINE p_dataT1 RECORD LIKE clientstakeholders.*
    DEFINE l_key
        RECORD
            clientstakeholders_stakeholderId LIKE clientstakeholders.stakeholderId
        END RECORD
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.clientstakeholders_PK_clientStakeholders_1_updateRowByKey.define">} {</POINT>}
    LET l_key.clientstakeholders_stakeholderId = p_dataT0.stakeholderId
    INITIALIZE errMsg TO NULL
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.clientstakeholders_PK_clientStakeholders_1_updateRowByKey.init">} {</POINT>}
        TRY
            LET errNo = consultcompanion_dbxdata_clientstakeholders_PK_clientStakeholders_1_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
            {<POINT Name="fct.clientstakeholders_PK_clientStakeholders_1_updateRowByKey.afterSelect">} {</POINT>}
            IF errNo == ERROR_SUCCESS THEN
                CALL consultcompanion_dbxconstraints.consultcompanion_dbxconstraints_clientstakeholders_checkTableConstraints(TRUE, p_dataT1.*) RETURNING errNo, errMsg
                {<POINT Name="fct.clientstakeholders_PK_clientStakeholders_1_updateRowByKey.beforeUpdate">} {</POINT>}
                IF errNo == ERROR_SUCCESS THEN
                 IF consultcompanion_events.m_DbxDataEvent_clientstakeholders_BeforeUpdateRowByKey IS NOT NULL THEN
                    CALL consultcompanion_events.m_DbxDataEvent_clientstakeholders_BeforeUpdateRowByKey(p_dataT1.*)
                        RETURNING errNo, errMsg
                END IF
                    UPDATE clientstakeholders
                        SET clientstakeholders.* = p_dataT1.*
                        WHERE @clientstakeholders.stakeholderId = l_key.clientstakeholders_stakeholderId
                END IF
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        IF consultcompanion_events.m_DbxDataEvent_clientstakeholders_AfterUpdateRowByKey IS NOT NULL THEN
            CALL consultcompanion_events.m_DbxDataEvent_clientstakeholders_AfterUpdateRowByKey(p_dataT1.*)
                RETURNING errNo, errMsg
        END IF
        {<POINT Name="fct.clientstakeholders_PK_clientStakeholders_1_updateRowByKey.afterUpdate">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.clientstakeholders_PK_clientStakeholders_1_updateRowByKey

{<BLOCK Name="fct.clientstakeholders_PK_clientStakeholders_1_deleteRowByKey">}
#+ Delete a row identified by the primary key in the "clientstakeholders" table
#+
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION consultcompanion_dbxdata_clientstakeholders_PK_clientStakeholders_1_deleteRowByKey(p_key)
    DEFINE p_key
        RECORD
            clientstakeholders_stakeholderId LIKE clientstakeholders.stakeholderId
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.clientstakeholders_PK_clientStakeholders_1_deleteRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.clientstakeholders_PK_clientStakeholders_1_deleteRowByKey.init">} {</POINT>}
        IF consultcompanion_events.m_DbxDataEvent_clientstakeholders_BeforeDeleteRowByKey IS NOT NULL THEN
            CALL consultcompanion_events.m_DbxDataEvent_clientstakeholders_BeforeDeleteRowByKey(p_key.*)
                RETURNING errNo
        END IF
        TRY
            CALL consultcompanion_dbxdata_clientstakeholders_PK_clientStakeholders_1_deleteReferencingRowsByKey(p_key.*) RETURNING errNo
            IF errNo == ERROR_SUCCESS THEN
                DELETE FROM clientstakeholders
                    WHERE @clientstakeholders.stakeholderId = p_key.clientstakeholders_stakeholderId
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        IF consultcompanion_events.m_DbxDataEvent_clientstakeholders_AfterDeleteRowByKey IS NOT NULL THEN
            CALL consultcompanion_events.m_DbxDataEvent_clientstakeholders_AfterDeleteRowByKey(p_key.*)
                RETURNING errNo
        END IF
        {<POINT Name="fct.clientstakeholders_PK_clientStakeholders_1_deleteRowByKey.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.clientstakeholders_PK_clientStakeholders_1_deleteRowByKey

{<BLOCK Name="fct.clientstakeholders_PK_clientStakeholders_1_deleteRowByKeyWithConcurrentAccess">}
#+ Delete a row identified by the primary key in the "clientstakeholders" table if the concurrent access is success
#+
#+ @param p_dataT0 - a row data LIKE clientstakeholders.*
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION consultcompanion_dbxdata_clientstakeholders_PK_clientStakeholders_1_deleteRowByKeyWithConcurrentAccess(p_dataT0)
    DEFINE p_dataT0 RECORD LIKE clientstakeholders.*
    DEFINE l_key
        RECORD
            clientstakeholders_stakeholderId LIKE clientstakeholders.stakeholderId
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.clientstakeholders_PK_clientStakeholders_1_deleteRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.clientstakeholders_stakeholderId = p_dataT0.stakeholderId
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.clientstakeholders_PK_clientStakeholders_1_deleteRowByKeyWithConcurrentAccess.init">} {</POINT>}
        LET errNo = consultcompanion_dbxdata_clientstakeholders_PK_clientStakeholders_1_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
        {<POINT Name="fct.clientstakeholders_PK_clientStakeholders_1_deleteRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = consultcompanion_dbxdata_clientstakeholders_PK_clientStakeholders_1_deleteRowByKey(l_key.*)
        END IF
        {<POINT Name="fct.clientstakeholders_PK_clientStakeholders_1_deleteRowByKeyWithConcurrentAccess.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.clientstakeholders_PK_clientStakeholders_1_deleteRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.clientstakeholders_PK_clientStakeholders_1_checkRowByKeyWithConcurrentAccess">}
#+ Check if a row identified by the primary key in the "clientstakeholders" table has been modified or deleted
#+
#+ @param p_dataT0 - a row data LIKE clientstakeholders.*
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE
PUBLIC FUNCTION consultcompanion_dbxdata_clientstakeholders_PK_clientStakeholders_1_checkRowByKeyWithConcurrentAccess(p_dataT0, p_lock)
    DEFINE p_dataT0 RECORD LIKE clientstakeholders.*
    DEFINE l_dataT2 RECORD LIKE clientstakeholders.*
    DEFINE l_key
        RECORD
            clientstakeholders_stakeholderId LIKE clientstakeholders.stakeholderId
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE errNo INTEGER
    DEFINE errDiff INTEGER
    {<POINT Name="fct.clientstakeholders_PK_clientStakeholders_1_checkRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.clientstakeholders_stakeholderId = p_dataT0.stakeholderId
    INITIALIZE l_dataT2.* TO NULL
    LET errDiff = FALSE
    {<POINT Name="fct.clientstakeholders_PK_clientStakeholders_1_checkRowByKeyWithConcurrentAccess.init">} {</POINT>}
    CALL consultcompanion_dbxdata_clientstakeholders_PK_clientStakeholders_1_selectRowByKey(l_key.*, p_lock) RETURNING errNo, l_dataT2.*
    CASE errNo
        WHEN ERROR_SUCCESS
            LET errDiff = (p_dataT0.* != l_dataT2.*)
            {<POINT Name="fct.clientstakeholders_PK_clientStakeholders_1_checkRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
            IF NOT errDiff THEN
                LET errNo = ERROR_SUCCESS
            ELSE
                LET errNo = ERROR_CONCURRENT_ACCESS_FAILURE
            END IF
        WHEN ERROR_NOTFOUND
            LET errNo = ERROR_CONCURRENT_ACCESS_NOTFOUND
    END CASE
    {<POINT Name="fct.clientstakeholders_PK_clientStakeholders_1_checkRowByKeyWithConcurrentAccess.afterCheck">} {</POINT>}
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.clientstakeholders_PK_clientStakeholders_1_checkRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.clientstakeholders_PK_clientStakeholders_1_deleteReferencingRowsByKey">}
#+ Delete rows referencing the primary key of the "clientstakeholders" table
#+
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION consultcompanion_dbxdata_clientstakeholders_PK_clientStakeholders_1_deleteReferencingRowsByKey(p_key)
    DEFINE p_key
        RECORD
            clientstakeholders_stakeholderId LIKE clientstakeholders.stakeholderId
        END RECORD
    DEFINE l_data RECORD LIKE clientstakeholders.*
    DEFINE l_key_FK_RFS_clientStakeholders_1
        RECORD
            rfs_rfsId LIKE rfs.rfsId
        END RECORD
    DEFINE errNo INTEGER
    DEFINE l_sqlQuery STRING
    {<POINT Name="fct.clientstakeholders_PK_clientStakeholders_1_deleteReferencingRowsByKey.define">} {</POINT>}

    INITIALIZE l_data.* TO NULL
    {<POINT Name="fct.clientstakeholders_PK_clientStakeholders_1_deleteReferencingRowsByKey.init">} {</POINT>}
    CALL consultcompanion_dbxdata_clientstakeholders_PK_clientStakeholders_1_selectRowByKey(p_key.*, FALSE)
        RETURNING errNo, l_data.*
    CASE errNo
        WHEN ERROR_SUCCESS
            --check Foreign Key FK_RFS_clientStakeholders_1
            LET l_sqlQuery = "SELECT rfsId FROM rfs WHERE rfs.stakeholderId = ?"
            TRY
                DECLARE consultcompanion_dbxdata_clientstakeholders_PK_clientStakeholders_1_deleteReferencingRowsByKey_FK_RFS_clientStakeholders_1 CURSOR FROM l_sqlQuery
                OPEN consultcompanion_dbxdata_clientstakeholders_PK_clientStakeholders_1_deleteReferencingRowsByKey_FK_RFS_clientStakeholders_1
                    USING l_data.stakeholderId
                FETCH consultcompanion_dbxdata_clientstakeholders_PK_clientStakeholders_1_deleteReferencingRowsByKey_FK_RFS_clientStakeholders_1
                    INTO l_key_FK_RFS_clientStakeholders_1.*
                IF SQLCA.SQLCODE = 0 THEN
                    LET errNo = ERROR_DELETE_CASCADE_ROW_USED
                END IF
                CLOSE consultcompanion_dbxdata_clientstakeholders_PK_clientStakeholders_1_deleteReferencingRowsByKey_FK_RFS_clientStakeholders_1
            CATCH
                LET errNo = ERROR_FAILURE
            END TRY

        WHEN ERROR_NOTFOUND
            LET errNo = ERROR_SUCCESS
    END CASE
    {<POINT Name="fct.clientstakeholders_PK_clientStakeholders_1_deleteReferencingRowsByKey.afterDelete">} {</POINT>}
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.clientstakeholders_PK_clientStakeholders_1_deleteReferencingRowsByKey

{<BLOCK Name="fct.clientstakeholders_setDefaultValuesFromDBSchema">}
#+ Set data with the default values coming from the DB schema
#+
PUBLIC FUNCTION consultcompanion_dbxdata_clientstakeholders_setDefaultValuesFromDBSchema()
    DEFINE l_data RECORD LIKE clientstakeholders.*
    {<POINT Name="fct.clientstakeholders_setDefaultValuesFromDBSchema.define">} {</POINT>}

    INITIALIZE l_data.* TO NULL
    {<POINT Name="fct.clientstakeholders_setDefaultValuesFromDBSchema.init">} {</POINT>}
    IF consultcompanion_events.m_DbxDataEvent_clientstakeholders_SetDefaultValues IS NOT NULL THEN
        CALL consultcompanion_events.m_DbxDataEvent_clientstakeholders_SetDefaultValues(l_data.*)
            RETURNING l_data.*
    END IF
    RETURN l_data.*
END FUNCTION
{</BLOCK>} --fct.clientstakeholders_setDefaultValuesFromDBSchema

{<BLOCK Name="fct.clients_PK_clients_1_selectRowByKey">}
#+ Select a row identified by the primary key in the "clients" table
#+
#+ @param p_key - Primary Key
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER, LIKE clients.*
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_NOTFOUND, RECORD LIKE clients.*
PUBLIC FUNCTION consultcompanion_dbxdata_clients_PK_clients_1_selectRowByKey(p_key, p_lock)
    DEFINE p_key
        RECORD
            clients_clientid LIKE clients.clientid
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE l_data RECORD LIKE clients.*
    DEFINE l_supportLock BOOLEAN
    DEFINE errNo INTEGER
    {<POINT Name="fct.clients_PK_clients_1_selectRowByKey.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    -- SQLite does not support the FOR UPDATE close in SELECT syntax
    LET l_supportLock = (UPSHIFT(fgl_db_driver_type()) != "SQT")
    {<POINT Name="fct.clients_PK_clients_1_selectRowByKey.init">} {</POINT>}
    TRY
        IF p_lock AND l_supportLock THEN
            SELECT * INTO l_data.* FROM clients
                WHERE @clients.clientid = p_key.clients_clientid
            FOR UPDATE
        ELSE
            SELECT * INTO l_data.* FROM clients
                WHERE @clients.clientid = p_key.clients_clientid
        END IF
        IF SQLCA.SQLCODE == NOTFOUND THEN
            LET errNo = ERROR_NOTFOUND
        END IF
    CATCH
        INITIALIZE l_data.* TO NULL
        LET errNo = ERROR_FAILURE
    END TRY
    {<POINT Name="fct.clients_PK_clients_1_selectRowByKey.afterSelect">} {</POINT>}
    RETURN errNo, l_data.*
END FUNCTION
{</BLOCK>} --fct.clients_PK_clients_1_selectRowByKey

{<BLOCK Name="fct.clients_insertRowByKey">}
#+ Insert a row in the "clients" table and return the primary key created
#+
#+ @param p_data - a row data LIKE clients.*
#+
#+ @returnType INTEGER, STRING, SERIAL
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, clients.clientid
PRIVATE FUNCTION consultcompanion_dbxdata_clients_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE clients.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.clients_insertRowByKey.define" Status="MODIFIED">} 
    DEFINE l_scratch string
    {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        CALL libdbapp_get_sequence("clients") RETURNING errNo, p_data.clientid
        {<POINT Name="fct.clients_insertRowByKey.init">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            IF consultcompanion_events.m_DbxDataEvent_clients_BeforeInsertRowByKey IS NOT NULL THEN
                CALL consultcompanion_events.m_DbxDataEvent_clients_BeforeInsertRowByKey(p_data.*)
                    RETURNING errNo, errMsg, p_data.*
            END IF
            IF errNo == ERROR_SUCCESS THEN
                CALL consultcompanion_dbxconstraints.consultcompanion_dbxconstraints_clients_checkTableConstraints(FALSE, p_data.*) RETURNING errNo, errMsg
            END IF
            {<POINT Name="fct.clients_insertRowByKey.beforeInsert" Status="MODIFIED">} 
            {</POINT>}
            IF errNo == ERROR_SUCCESS THEN
                TRY
                    INSERT INTO clients VALUES (p_data.*)
                    CALL libdbapp_get_inserted_sequence(p_data.clientid) RETURNING p_data.clientid
                CATCH
                    LET errNo = ERROR_FAILURE
                END TRY
                IF consultcompanion_events.m_DbxDataEvent_clients_AfterInsertRowByKey IS NOT NULL THEN
                    CALL consultcompanion_events.m_DbxDataEvent_clients_AfterInsertRowByKey(p_data.*)
                        RETURNING errNo, errMsg
                END IF
                {<POINT Name="fct.clients_insertRowByKey.afterInsert">} {</POINT>}
            END IF
        END IF
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg, p_data.clientid
END FUNCTION
{</BLOCK>} --fct.clients_insertRowByKey

{<BLOCK Name="fct.clients_PK_clients_1_insertRowByKey">}
#+ Insert a row in the "clients" table and return the table keys
#+
#+ @param p_data - a row data LIKE clients.*
#+
#+ @returnType INTEGER, STRING, SERIAL
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, clients.clientid
PUBLIC FUNCTION consultcompanion_dbxdata_clients_PK_clients_1_insertRowByKey(p_data)
    DEFINE p_data RECORD LIKE clients.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.clients_PK_clients_1_insertRowByKey.define">} {</POINT>}
    {<POINT Name="fct.clients_PK_clients_1_insertRowByKey.init">} {</POINT>}

    CALL consultcompanion_dbxdata_clients_insertRowByKey(p_data.*) RETURNING errNo, errMsg, p_data.clientid
    RETURN errNo, errMsg, p_data.clientid
END FUNCTION
{</BLOCK>} --fct.clients_PK_clients_1_insertRowByKey

{<BLOCK Name="fct.clients_PK_clients_1_updateRowByKey">}
#+ Update a row identified by the primary key in the "clients" table
#+
#+ @param p_dataT0 - a row data LIKE clients.*
#+ @param p_dataT1 - a row data LIKE clients.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE, error message
PUBLIC FUNCTION consultcompanion_dbxdata_clients_PK_clients_1_updateRowByKey(p_dataT0, p_dataT1)
    DEFINE p_dataT0 RECORD LIKE clients.*
    DEFINE p_dataT1 RECORD LIKE clients.*
    DEFINE l_key
        RECORD
            clients_clientid LIKE clients.clientid
        END RECORD
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.clients_PK_clients_1_updateRowByKey.define">} {</POINT>}
    LET l_key.clients_clientid = p_dataT0.clientid
    INITIALIZE errMsg TO NULL
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.clients_PK_clients_1_updateRowByKey.init">} {</POINT>}
        TRY
            LET errNo = consultcompanion_dbxdata_clients_PK_clients_1_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
            {<POINT Name="fct.clients_PK_clients_1_updateRowByKey.afterSelect">} {</POINT>}
            IF errNo == ERROR_SUCCESS THEN
                CALL consultcompanion_dbxconstraints.consultcompanion_dbxconstraints_clients_checkTableConstraints(TRUE, p_dataT1.*) RETURNING errNo, errMsg
                {<POINT Name="fct.clients_PK_clients_1_updateRowByKey.beforeUpdate">} {</POINT>}
                IF errNo == ERROR_SUCCESS THEN
                 IF consultcompanion_events.m_DbxDataEvent_clients_BeforeUpdateRowByKey IS NOT NULL THEN
                    CALL consultcompanion_events.m_DbxDataEvent_clients_BeforeUpdateRowByKey(p_dataT1.*)
                        RETURNING errNo, errMsg
                END IF
                    UPDATE clients
                        SET clients.* = p_dataT1.*
                        WHERE @clients.clientid = l_key.clients_clientid
                END IF
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        IF consultcompanion_events.m_DbxDataEvent_clients_AfterUpdateRowByKey IS NOT NULL THEN
            CALL consultcompanion_events.m_DbxDataEvent_clients_AfterUpdateRowByKey(p_dataT1.*)
                RETURNING errNo, errMsg
        END IF
        {<POINT Name="fct.clients_PK_clients_1_updateRowByKey.afterUpdate">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.clients_PK_clients_1_updateRowByKey

{<BLOCK Name="fct.clients_PK_clients_1_deleteRowByKey">}
#+ Delete a row identified by the primary key in the "clients" table
#+
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION consultcompanion_dbxdata_clients_PK_clients_1_deleteRowByKey(p_key)
    DEFINE p_key
        RECORD
            clients_clientid LIKE clients.clientid
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.clients_PK_clients_1_deleteRowByKey.define">} {</POINT>}

    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.clients_PK_clients_1_deleteRowByKey.init">} {</POINT>}
        IF consultcompanion_events.m_DbxDataEvent_clients_BeforeDeleteRowByKey IS NOT NULL THEN
            CALL consultcompanion_events.m_DbxDataEvent_clients_BeforeDeleteRowByKey(p_key.*)
                RETURNING errNo
        END IF
        TRY
            CALL consultcompanion_dbxdata_clients_PK_clients_1_deleteReferencingRowsByKey(p_key.*) RETURNING errNo
            IF errNo == ERROR_SUCCESS THEN
                DELETE FROM clients
                    WHERE @clients.clientid = p_key.clients_clientid
            END IF
        CATCH
            LET errNo = ERROR_FAILURE
        END TRY
        IF consultcompanion_events.m_DbxDataEvent_clients_AfterDeleteRowByKey IS NOT NULL THEN
            CALL consultcompanion_events.m_DbxDataEvent_clients_AfterDeleteRowByKey(p_key.*)
                RETURNING errNo
        END IF
        {<POINT Name="fct.clients_PK_clients_1_deleteRowByKey.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.clients_PK_clients_1_deleteRowByKey

{<BLOCK Name="fct.clients_PK_clients_1_deleteRowByKeyWithConcurrentAccess">}
#+ Delete a row identified by the primary key in the "clients" table if the concurrent access is success
#+
#+ @param p_dataT0 - a row data LIKE clients.*
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION consultcompanion_dbxdata_clients_PK_clients_1_deleteRowByKeyWithConcurrentAccess(p_dataT0)
    DEFINE p_dataT0 RECORD LIKE clients.*
    DEFINE l_key
        RECORD
            clients_clientid LIKE clients.clientid
        END RECORD
    DEFINE errNo INTEGER
    {<POINT Name="fct.clients_PK_clients_1_deleteRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.clients_clientid = p_dataT0.clientid
    LET errNo = libdbapp_begin_work()
    IF errNo == ERROR_SUCCESS THEN
        {<POINT Name="fct.clients_PK_clients_1_deleteRowByKeyWithConcurrentAccess.init">} {</POINT>}
        LET errNo = consultcompanion_dbxdata_clients_PK_clients_1_checkRowByKeyWithConcurrentAccess(p_dataT0.*, TRUE)
        {<POINT Name="fct.clients_PK_clients_1_deleteRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = consultcompanion_dbxdata_clients_PK_clients_1_deleteRowByKey(l_key.*)
        END IF
        {<POINT Name="fct.clients_PK_clients_1_deleteRowByKeyWithConcurrentAccess.afterDelete">} {</POINT>}
        IF errNo == ERROR_SUCCESS THEN
            LET errNo = libdbapp_commit_work()
        ELSE
            CALL libdbapp_rollback_work()
        END IF
    END IF
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.clients_PK_clients_1_deleteRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.clients_PK_clients_1_checkRowByKeyWithConcurrentAccess">}
#+ Check if a row identified by the primary key in the "clients" table has been modified or deleted
#+
#+ @param p_dataT0 - a row data LIKE clients.*
#+ @param p_lock - Indicate if a lock is used in order to prevent several users editing the same rows at the same time
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE
PUBLIC FUNCTION consultcompanion_dbxdata_clients_PK_clients_1_checkRowByKeyWithConcurrentAccess(p_dataT0, p_lock)
    DEFINE p_dataT0 RECORD LIKE clients.*
    DEFINE l_dataT2 RECORD LIKE clients.*
    DEFINE l_key
        RECORD
            clients_clientid LIKE clients.clientid
        END RECORD
    DEFINE p_lock BOOLEAN
    DEFINE errNo INTEGER
    DEFINE errDiff INTEGER
    {<POINT Name="fct.clients_PK_clients_1_checkRowByKeyWithConcurrentAccess.define">} {</POINT>}

    LET l_key.clients_clientid = p_dataT0.clientid
    INITIALIZE l_dataT2.* TO NULL
    LET errDiff = FALSE
    {<POINT Name="fct.clients_PK_clients_1_checkRowByKeyWithConcurrentAccess.init">} {</POINT>}
    CALL consultcompanion_dbxdata_clients_PK_clients_1_selectRowByKey(l_key.*, p_lock) RETURNING errNo, l_dataT2.*
    CASE errNo
        WHEN ERROR_SUCCESS
            LET errDiff = (p_dataT0.* != l_dataT2.*)
            {<POINT Name="fct.clients_PK_clients_1_checkRowByKeyWithConcurrentAccess.afterSelect">} {</POINT>}
            IF NOT errDiff THEN
                LET errNo = ERROR_SUCCESS
            ELSE
                LET errNo = ERROR_CONCURRENT_ACCESS_FAILURE
            END IF
        WHEN ERROR_NOTFOUND
            LET errNo = ERROR_CONCURRENT_ACCESS_NOTFOUND
    END CASE
    {<POINT Name="fct.clients_PK_clients_1_checkRowByKeyWithConcurrentAccess.afterCheck">} {</POINT>}
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.clients_PK_clients_1_checkRowByKeyWithConcurrentAccess

{<BLOCK Name="fct.clients_PK_clients_1_deleteReferencingRowsByKey">}
#+ Delete rows referencing the primary key of the "clients" table
#+
#+ @param p_key - Primary Key
#+
#+ @returnType INTEGER
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_DELETE_CASCADE_ROW_USED
PUBLIC FUNCTION consultcompanion_dbxdata_clients_PK_clients_1_deleteReferencingRowsByKey(p_key)
    DEFINE p_key
        RECORD
            clients_clientid LIKE clients.clientid
        END RECORD
    DEFINE l_data RECORD LIKE clients.*
    DEFINE l_key_FK_RFS_clients_1
        RECORD
            rfs_rfsId LIKE rfs.rfsId
        END RECORD
    DEFINE l_key_FK_clientStakeholders_clients_1
        RECORD
            clientstakeholders_stakeholderId LIKE clientstakeholders.stakeholderId
        END RECORD
    DEFINE errNo INTEGER
    DEFINE l_sqlQuery STRING
    {<POINT Name="fct.clients_PK_clients_1_deleteReferencingRowsByKey.define">} {</POINT>}

    INITIALIZE l_data.* TO NULL
    {<POINT Name="fct.clients_PK_clients_1_deleteReferencingRowsByKey.init">} {</POINT>}
    CALL consultcompanion_dbxdata_clients_PK_clients_1_selectRowByKey(p_key.*, FALSE)
        RETURNING errNo, l_data.*
    CASE errNo
        WHEN ERROR_SUCCESS
            --check Foreign Key FK_RFS_clients_1
            LET l_sqlQuery = "SELECT rfsId FROM rfs WHERE rfs.clientid = ?"
            TRY
                DECLARE consultcompanion_dbxdata_clients_PK_clients_1_deleteReferencingRowsByKey_FK_RFS_clients_1 CURSOR FROM l_sqlQuery
                OPEN consultcompanion_dbxdata_clients_PK_clients_1_deleteReferencingRowsByKey_FK_RFS_clients_1
                    USING l_data.clientid
                FETCH consultcompanion_dbxdata_clients_PK_clients_1_deleteReferencingRowsByKey_FK_RFS_clients_1
                    INTO l_key_FK_RFS_clients_1.*
                IF SQLCA.SQLCODE = 0 THEN
                    LET errNo = ERROR_DELETE_CASCADE_ROW_USED
                END IF
                CLOSE consultcompanion_dbxdata_clients_PK_clients_1_deleteReferencingRowsByKey_FK_RFS_clients_1
            CATCH
                LET errNo = ERROR_FAILURE
            END TRY

            IF errNo == ERROR_SUCCESS THEN
                --check Foreign Key FK_clientStakeholders_clients_1
                LET l_sqlQuery = "SELECT stakeholderId FROM clientstakeholders WHERE clientstakeholders.clientId = ?"
                TRY
                    DECLARE consultcompanion_dbxdata_clients_PK_clients_1_deleteReferencingRowsByKey_FK_clientStakeholders_clients_1 CURSOR FROM l_sqlQuery
                    OPEN consultcompanion_dbxdata_clients_PK_clients_1_deleteReferencingRowsByKey_FK_clientStakeholders_clients_1
                        USING l_data.clientid
                    FETCH consultcompanion_dbxdata_clients_PK_clients_1_deleteReferencingRowsByKey_FK_clientStakeholders_clients_1
                        INTO l_key_FK_clientStakeholders_clients_1.*
                    IF SQLCA.SQLCODE = 0 THEN
                        LET errNo = ERROR_DELETE_CASCADE_ROW_USED
                    END IF
                    CLOSE consultcompanion_dbxdata_clients_PK_clients_1_deleteReferencingRowsByKey_FK_clientStakeholders_clients_1
                CATCH
                    LET errNo = ERROR_FAILURE
                END TRY

            END IF
        WHEN ERROR_NOTFOUND
            LET errNo = ERROR_SUCCESS
    END CASE
    {<POINT Name="fct.clients_PK_clients_1_deleteReferencingRowsByKey.afterDelete">} {</POINT>}
    RETURN errNo
END FUNCTION
{</BLOCK>} --fct.clients_PK_clients_1_deleteReferencingRowsByKey

{<BLOCK Name="fct.clients_setDefaultValuesFromDBSchema">}
#+ Set data with the default values coming from the DB schema
#+
PUBLIC FUNCTION consultcompanion_dbxdata_clients_setDefaultValuesFromDBSchema()
    DEFINE l_data RECORD LIKE clients.*
    {<POINT Name="fct.clients_setDefaultValuesFromDBSchema.define">} {</POINT>}

    INITIALIZE l_data.* TO NULL
    {<POINT Name="fct.clients_setDefaultValuesFromDBSchema.init">} {</POINT>}
    IF consultcompanion_events.m_DbxDataEvent_clients_SetDefaultValues IS NOT NULL THEN
        CALL consultcompanion_events.m_DbxDataEvent_clients_SetDefaultValues(l_data.*)
            RETURNING l_data.*
    END IF
    RETURN l_data.*
END FUNCTION
{</BLOCK>} --fct.clients_setDefaultValuesFromDBSchema

--------------------------------------------------------------------------------
--Add user functions
{<POINT Name="user.functions">} {</POINT>}
