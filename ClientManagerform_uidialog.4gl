{<CODEFILE Path="ClientManagerform.code" Hash="b5xZEgY75qocqCH0EIagaQ==" />}
#+ User Interface - Dialog Management (consultcompanion)

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
IMPORT FGL libdbappEvents

IMPORT FGL ClientManagerform_common
IMPORT FGL ClientManagerform
IMPORT FGL ClientManagerform_events
IMPORT FGL ClientManagerform_uidata
IMPORT FGL ClientManagerform_uidialogdata
{<POINT Name="import">} {</POINT>}

--------------------------------------------------------------------------------
--Database schema
SCHEMA consultcompanion

--------------------------------------------------------------------------------
--Definition of constants, user-types, variables
PUBLIC DEFINE m_subDialog STRING
PUBLIC DEFINE m_dataProcessing BOOLEAN --Used to skip the DVM validation in other subdialogs than the current dialog if a data processing is in progress on the current subdialog
PUBLIC DEFINE m_actionNo SMALLINT
PUBLIC DEFINE m_prevAction SMALLINT
PUBLIC DEFINE m_state SMALLINT
PUBLIC DEFINE M_errMsg STRING
PUBLIC DEFINE initializeUI BOOLEAN
PUBLIC DEFINE m_uiSettings UISettings_Type
PUBLIC DEFINE m_record1_where STRING
PUBLIC DEFINE m_nextField STRING
PUBLIC DEFINE m_copy_record1 record1_br_type
{<POINT Name="define">} {</POINT>}

--------------------------------------------------------------------------------
--Dialog Blocks
{<BLOCK Name="dlg.record1.uiDisplay">}
DIALOG ClientManagerform_uidialog_record1_uiDisplay()
    DEFINE l_internalAction SMALLINT

    {<POINT Name="dlg.record1.uiDisplay.define">} {</POINT>}

    DISPLAY ARRAY m_record1_arrRecList TO record1.*
        {<POINT Name="dlg.record1.uiDisplay.attributes">} {</POINT>}
        BEFORE DISPLAY
            LET m_subDialog = "record1"
            CALL ClientManagerform_uidialog_record1_setActionStates(DIALOG, C_MODE_DISPLAY)
            --Set the current row with the index of the subdialog, otherwise when you come:
            -- - from another mode
            -- - from a detail in INPUT to the master in DISPLAY (mixed mode)
            -- the index is reset to 1 by 'DIALOG.getCurrentRow'
            CALL DIALOG.setCurrentRow("record1", m_record1_keyIndex)
            IF NOT libdbapp_isMobile() THEN
                MESSAGE m_record1_keyIndex, "/", m_record1_arrRecList.getLength()
            END IF

            INITIALIZE ClientManagerform_events.m_DlgCtrlInstruction TO NULL
            IF ClientManagerform_events.m_DlgEvent_record1_BeforeDisplay IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_record1_BeforeDisplay(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction)
                    RETURNING ClientManagerform_events.m_DlgCtrlInstruction
            END IF

            CASE ClientManagerform_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    ACCEPT DIALOG
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
            END CASE

        BEFORE ROW
            {<POINT Name="dlg.record1.uiDisplay.beforeRow">} {</POINT>}
            IF (m_record1_keyIndex != DIALOG.getCurrentRow("record1") OR m_prevAction == C_ACTION_CANCEL) THEN
                LET m_record1_keyIndex = DIALOG.getCurrentRow("record1")
                CALL ClientManagerform_uidialogdata_record1_fetchDetails()
            END IF
            CALL ClientManagerform_uidialog_setAllCurrentRow(DIALOG)
            IF NOT libdbapp_isMobile() THEN
                MESSAGE m_record1_keyIndex, "/", m_record1_arrRecList.getLength()
            END IF

            INITIALIZE ClientManagerform_events.m_DlgCtrlInstruction TO NULL
            IF ClientManagerform_events.m_DlgEvent_record1_BeforeRow IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_record1_BeforeRow(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction)
                    RETURNING ClientManagerform_events.m_DlgCtrlInstruction
            END IF

            CASE ClientManagerform_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    ACCEPT DIALOG
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
            END CASE

        ON ACTION append
            {<POINT Name="dlg.record1.uiDisplay.onAction.append">} {</POINT>}
            LET m_actionNo = C_ACTION_APPEND

            LET ClientManagerform_events.m_DlgCtrlInstruction = libdbappEvents.ACCEPT_DIALOG
            IF ClientManagerform_events.m_DlgEvent_record1_OnActionAppend IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_record1_OnActionAppend(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction)
                    RETURNING ClientManagerform_events.m_DlgCtrlInstruction
            END IF

            CASE ClientManagerform_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    ACCEPT DIALOG
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
            END CASE

        ON ACTION insert
            {<POINT Name="dlg.record1.uiDisplay.onAction.insert">} {</POINT>}
            LET m_actionNo = C_ACTION_INSERT

            LET ClientManagerform_events.m_DlgCtrlInstruction = libdbappEvents.ACCEPT_DIALOG
            IF ClientManagerform_events.m_DlgEvent_record1_OnActionInsert IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_record1_OnActionInsert(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction)
                    RETURNING ClientManagerform_events.m_DlgCtrlInstruction
            END IF

            CASE ClientManagerform_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    ACCEPT DIALOG
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
            END CASE

        ON ACTION update
            {<POINT Name="dlg.record1.uiDisplay.onAction.update">} {</POINT>}
            LET m_actionNo = C_ACTION_UPDATE

            LET ClientManagerform_events.m_DlgCtrlInstruction = libdbappEvents.ACCEPT_DIALOG
            IF ClientManagerform_events.m_DlgEvent_record1_OnActionUpdate IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_record1_OnActionUpdate(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction)
                    RETURNING ClientManagerform_events.m_DlgCtrlInstruction
            END IF

            CASE ClientManagerform_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    ACCEPT DIALOG
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
            END CASE

        ON ACTION delete --DISPLAY (record1)
            {<POINT Name="dlg.record1.uiDisplay.onAction.delete">} {</POINT>}
            CALL ClientManagerform_uidialog_record1_validateCRUDOperation(DIALOG, m_state, C_ACTION_DELETE) RETURNING l_internalAction
            CASE l_internalAction
                WHEN C_INTERNAL_ACTION_NEXT_FIELD_CURRENT --We remain in input mode
                    CONTINUE DIALOG
                WHEN C_INTERNAL_EXIT_DIALOG
                    EXIT DIALOG
                OTHERWISE
            END CASE

            INITIALIZE ClientManagerform_events.m_DlgCtrlInstruction TO NULL
            IF ClientManagerform_events.m_DlgEvent_record1_OnActionDelete IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_record1_OnActionDelete(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction)
                    RETURNING ClientManagerform_events.m_DlgCtrlInstruction
            END IF

            CASE ClientManagerform_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    ACCEPT DIALOG
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
            END CASE

        AFTER DISPLAY
        INITIALIZE ClientManagerform_events.m_DlgCtrlInstruction TO NULL
        IF ClientManagerform_events.m_DlgEvent_record1_AfterDisplay IS NOT NULL THEN
            CALL ClientManagerform_events.m_DlgEvent_record1_AfterDisplay(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction)
                RETURNING ClientManagerform_events.m_DlgCtrlInstruction
        END IF

        CASE ClientManagerform_events.m_DlgCtrlInstruction
            WHEN libdbappEvents.ACCEPT_DIALOG
                ACCEPT DIALOG
            WHEN libdbappEvents.CONTINUE_DIALOG
                CONTINUE DIALOG
            WHEN libdbappEvents.EXIT_DIALOG
                EXIT DIALOG
        END CASE

        AFTER ROW
        INITIALIZE ClientManagerform_events.m_DlgCtrlInstruction TO NULL
        IF ClientManagerform_events.m_DlgEvent_record1_AfterRow IS NOT NULL THEN
            CALL ClientManagerform_events.m_DlgEvent_record1_AfterRow(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction)
                RETURNING ClientManagerform_events.m_DlgCtrlInstruction
        END IF

        CASE ClientManagerform_events.m_DlgCtrlInstruction
            WHEN libdbappEvents.ACCEPT_DIALOG
                ACCEPT DIALOG
            WHEN libdbappEvents.CONTINUE_DIALOG
                CONTINUE DIALOG
            WHEN libdbappEvents.EXIT_DIALOG
                EXIT DIALOG
        END CASE

        {<POINT Name="dlg.record1.uiDisplay.userControlBlocks">} {</POINT>}
    END DISPLAY
END DIALOG
{</BLOCK>} --dlg.record1.uiDisplay

{<BLOCK Name="dlg.record1.uiInput">}
DIALOG ClientManagerform_uidialog_record1_uiInput()
    DEFINE l_internalAction SMALLINT
    DEFINE errNo INTEGER

    {<POINT Name="dlg.record1.uiInput.define" Status="MODIFIED">} 
    DEFINE l_checkprovince SMALLINT = 0
    {</POINT>}

    INPUT ARRAY m_record1_arrRecList
    FROM record1.*
    ATTRIBUTES(WITHOUT DEFAULTS = TRUE, APPEND ROW = TRUE, INSERT ROW = TRUE, DELETE ROW = TRUE)
        BEFORE INPUT
            {<POINT Name="dlg.record1.uiInput.beforeInput">} {</POINT>}

            --Automatically set the ADD mode if there is no row in this subdialog
            IF m_state == C_MODE_MODIFY AND m_record1_arrRecList.getLength() == 0 THEN
                LET m_state = C_MODE_ADD
            END IF

            --Enter in this subdialog
            LET m_subDialog = "record1"
            IF initializeUI THEN
                LET initializeUI = FALSE
            END IF
            --The New|Append|Insert action was raised in another mode than INPUT mode
            IF m_state == C_MODE_ADD THEN
                IF m_prevAction != C_ACTION_INSERT THEN
                    CALL DIALOG.appendRow("record1")
                    LET m_record1_keyIndex = DIALOG.getArrayLength("record1")
                ELSE
                    IF m_record1_keyIndex == 0 THEN
                        LET m_record1_keyIndex = 1
                    END IF
                    CALL DIALOG.insertRow("record1", m_record1_keyIndex)
                END IF
                CALL ClientManagerform_uidialogdata_record1_setDefaultValues(DIALOG)
                CALL ClientManagerform_uidialogdata_record1_fetchDetails()
            END IF
            CALL ClientManagerform_uidialog_record1_setFieldActive(DIALOG, m_state)
            CALL ClientManagerform_uidialog_record1_setActionStates(DIALOG, m_state)
            CALL ClientManagerform_uidialog_setAllCurrentRow(DIALOG)
            IF NOT libdbapp_isMobile() THEN
                MESSAGE m_record1_keyIndex, "/", m_record1_arrRecList.getLength()
            END IF

            INITIALIZE ClientManagerform_events.m_DlgCtrlInstruction TO NULL
            IF ClientManagerform_events.m_DlgEvent_record1_BeforeInput IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_record1_BeforeInput(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction)
                    RETURNING ClientManagerform_events.m_DlgCtrlInstruction
            END IF

            CASE ClientManagerform_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    ACCEPT DIALOG
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
            END CASE

        AFTER INPUT
            {<POINT Name="dlg.record1.uiInput.afterInput">} {</POINT>}
            IF m_dataProcessing THEN --Skip the DVM validation because a data processing is in progress in an other subdialog
                LET ClientManagerform_events.m_DlgCtrlInstruction = libdbappEvents.EXIT_DIALOG
            ELSE
                INITIALIZE ClientManagerform_events.m_DlgCtrlInstruction TO NULL
            END IF
            IF ClientManagerform_events.m_DlgEvent_record1_AfterInput IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_record1_AfterInput(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction)
                    RETURNING ClientManagerform_events.m_DlgCtrlInstruction
            END IF

            CASE ClientManagerform_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    ACCEPT DIALOG
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
            END CASE

        BEFORE ROW
            {<POINT Name="dlg.record1.uiInput.beforeRow">} {</POINT>}
            IF m_record1_keyIndex != DIALOG.getCurrentRow("record1") THEN
                LET m_record1_keyIndex = DIALOG.getCurrentRow("record1")
                CALL ClientManagerform_uidialogdata_record1_fetchDetails()
            END IF
            IF m_record1_keyIndex > 0 THEN
                LET m_copy_record1.* = m_record1_arrRecList[m_record1_keyIndex].* --Keep a local copy
            END IF
            CALL ClientManagerform_uidialog_setAllCurrentRow(DIALOG)
            IF NOT libdbapp_isMobile() THEN
                MESSAGE m_record1_keyIndex, "/", m_record1_arrRecList.getLength()
            END IF

            INITIALIZE ClientManagerform_events.m_DlgCtrlInstruction TO NULL
            IF ClientManagerform_events.m_DlgEvent_record1_BeforeRow IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_record1_BeforeRow(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction)
                    RETURNING ClientManagerform_events.m_DlgCtrlInstruction
            END IF

            CASE ClientManagerform_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    ACCEPT DIALOG
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
            END CASE

        AFTER ROW
            {<POINT Name="dlg.record1.uiInput.afterRow">} {</POINT>}
            CALL ClientManagerform_uidialog_record1_validateCRUDOperation(DIALOG, m_state, m_actionNo) RETURNING l_internalAction
            CASE l_internalAction
                WHEN C_INTERNAL_ACTION_NEXT_FIELD_CURRENT --We remain in input mode
                    CALL DIALOG.nextField(FGL_DIALOG_GETFIELDNAME())
                    LET m_dataProcessing = FALSE
                    CONTINUE DIALOG
                WHEN C_INTERNAL_EXIT_DIALOG
                    EXIT DIALOG
                OTHERWISE
                    LET m_state = C_MODE_MODIFY
            END CASE

            INITIALIZE ClientManagerform_events.m_DlgCtrlInstruction TO NULL
            IF ClientManagerform_events.m_DlgEvent_record1_AfterRow IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_record1_AfterRow(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction)
                    RETURNING ClientManagerform_events.m_DlgCtrlInstruction
            END IF

            CASE ClientManagerform_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    ACCEPT DIALOG
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
            END CASE

        BEFORE INSERT
            {<POINT Name="dlg.record1.uiInput.beforeInsert">} {</POINT>}
            --The New|Append|Insert action was raised inside the INPUT mode
            LET m_state = C_MODE_ADD
            CALL ClientManagerform_uidialogdata_record1_setDefaultValues(DIALOG)
            CALL ClientManagerform_uidialogdata_record1_fetchDetails()
            CALL ClientManagerform_uidialog_record1_setFieldActive(DIALOG, C_MODE_ADD)
            CALL ClientManagerform_uidialog_record1_setActionStates(DIALOG, C_MODE_ADD)
            CALL ClientManagerform_uidialog_setAllCurrentRow(DIALOG)
            IF NOT libdbapp_isMobile() THEN
                MESSAGE m_record1_keyIndex, "/", m_record1_arrRecList.getLength()
            END IF

            INITIALIZE ClientManagerform_events.m_DlgCtrlInstruction TO NULL
            IF ClientManagerform_events.m_DlgEvent_record1_BeforeInsert IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_record1_BeforeInsert(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction)
                    RETURNING ClientManagerform_events.m_DlgCtrlInstruction
            END IF

            CASE ClientManagerform_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    ACCEPT DIALOG
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
            END CASE

        ON ACTION delete --MODIFY (record1)
            {<POINT Name="dlg.record1.uiInput.onAction.delete">} {</POINT>}
            CALL ClientManagerform_uidialog_record1_validateCRUDOperation(DIALOG, C_MODE_MODIFY, C_ACTION_DELETE) RETURNING l_internalAction
            CASE l_internalAction
                WHEN C_INTERNAL_ACTION_NEXT_FIELD_CURRENT --We remain in input mode
                    CALL DIALOG.nextField(FGL_DIALOG_GETFIELDNAME())
                    LET m_dataProcessing = FALSE
                    CONTINUE DIALOG
                WHEN C_INTERNAL_EXIT_DIALOG
                    EXIT DIALOG
                OTHERWISE
                    LET m_state = C_MODE_MODIFY
            END CASE

            --Automatically set the ADD mode if there is no row in this subdialog
            IF m_state == C_MODE_MODIFY AND m_record1_arrRecList.getLength() == 0 THEN
                LET m_state = C_MODE_ADD
            END IF

            INITIALIZE ClientManagerform_events.m_DlgCtrlInstruction TO NULL
            IF ClientManagerform_events.m_DlgEvent_record1_OnActionDelete IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_record1_OnActionDelete(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction)
                    RETURNING ClientManagerform_events.m_DlgCtrlInstruction
            END IF

            CASE ClientManagerform_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    ACCEPT DIALOG
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
            END CASE

            IF m_state == C_MODE_MODIFY THEN
                LET m_copy_record1.* = m_record1_arrRecList[m_record1_keyIndex].* --Keep a local copy
            END IF

            IF m_state == C_MODE_ADD THEN
                CALL ClientManagerform_uidialogdata_record1_setDefaultValues(DIALOG)
                CALL ClientManagerform_uidialogdata_record1_fetchDetails()
            END IF
            CALL ClientManagerform_uidialog_record1_setFieldActive(DIALOG, m_state)
            CALL ClientManagerform_uidialog_record1_setActionStates(DIALOG, m_state)
            CALL ClientManagerform_uidialog_setAllCurrentRow(DIALOG)
            IF NOT libdbapp_isMobile() THEN
                MESSAGE m_record1_keyIndex, "/", m_record1_arrRecList.getLength()
            END IF

        BEFORE FIELD record1.countryid
            {<POINT Name="dlg.record1.uiInput.beforeField.record1.countryid">} {</POINT>}
            CALL DIALOG.setActionActive('zoom', TRUE)
            IF libdbapp_isMobile() THEN
                CALL DIALOG.setActionHidden('zoom', FALSE)
            END IF

            INITIALIZE ClientManagerform_events.m_DlgCtrlInstruction TO NULL
            IF ClientManagerform_events.m_DlgEvent_record1_BeforeField IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_record1_BeforeField(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction, "record1.countryid")
                    RETURNING ClientManagerform_events.m_DlgCtrlInstruction
            END IF

            CASE ClientManagerform_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    ACCEPT DIALOG
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
            END CASE

        BEFORE FIELD record1.provinceid
            {<POINT Name="dlg.record1.uiInput.beforeField.record1.provinceid">} {</POINT>}
            CALL DIALOG.setActionActive('zoom', TRUE)
            IF libdbapp_isMobile() THEN
                CALL DIALOG.setActionHidden('zoom', FALSE)
            END IF

            INITIALIZE ClientManagerform_events.m_DlgCtrlInstruction TO NULL
            IF ClientManagerform_events.m_DlgEvent_record1_BeforeField IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_record1_BeforeField(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction, "record1.provinceid")
                    RETURNING ClientManagerform_events.m_DlgCtrlInstruction
            END IF

            CASE ClientManagerform_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    ACCEPT DIALOG
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
            END CASE

        BEFORE FIELD record1.clienttypeid
            {<POINT Name="dlg.record1.uiInput.beforeField.record1.clienttypeid">} {</POINT>}
            CALL DIALOG.setActionActive('zoom', TRUE)
            IF libdbapp_isMobile() THEN
                CALL DIALOG.setActionHidden('zoom', FALSE)
            END IF

            INITIALIZE ClientManagerform_events.m_DlgCtrlInstruction TO NULL
            IF ClientManagerform_events.m_DlgEvent_record1_BeforeField IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_record1_BeforeField(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction, "record1.clienttypeid")
                    RETURNING ClientManagerform_events.m_DlgCtrlInstruction
            END IF

            CASE ClientManagerform_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    ACCEPT DIALOG
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
            END CASE

        BEFORE FIELD record1.paytermid
            {<POINT Name="dlg.record1.uiInput.beforeField.record1.paytermid">} {</POINT>}
            CALL DIALOG.setActionActive('zoom', TRUE)
            IF libdbapp_isMobile() THEN
                CALL DIALOG.setActionHidden('zoom', FALSE)
            END IF

            INITIALIZE ClientManagerform_events.m_DlgCtrlInstruction TO NULL
            IF ClientManagerform_events.m_DlgEvent_record1_BeforeField IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_record1_BeforeField(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction, "record1.paytermid")
                    RETURNING ClientManagerform_events.m_DlgCtrlInstruction
            END IF

            CASE ClientManagerform_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    ACCEPT DIALOG
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
            END CASE

        AFTER FIELD record1.countryid
            {<POINT Name="dlg.record1.uiInput.afterField.record1.countryid">} {</POINT>}
            CALL DIALOG.setActionActive('zoom', FALSE)
            IF libdbapp_isMobile() THEN
                CALL DIALOG.setActionHidden('zoom', TRUE)
            END IF

            INITIALIZE ClientManagerform_events.m_DlgCtrlInstruction TO NULL
            IF ClientManagerform_events.m_DlgEvent_record1_AfterField IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_record1_AfterField(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction, "record1.countryid")
                    RETURNING ClientManagerform_events.m_DlgCtrlInstruction
            END IF

            CASE ClientManagerform_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    ACCEPT DIALOG
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
            END CASE

        AFTER FIELD record1.provinceid
            {<POINT Name="dlg.record1.uiInput.afterField.record1.provinceid" Status="MODIFIED">} 
            SELECT COUNT(*)
               INTO l_checkprovince
               FROM provinces
               WHERE provinceid = m_record1_arrRecList[m_record1_keyIndex].clients_provinceid
            IF l_checkprovince = 0 THEN
               ERROR "You have not selected the province/state"
               NEXT FIELD record1.provinceid
            ELSE
                SELECT countryid 
                   INTO m_record1_arrRecList[m_record1_keyIndex].clients_countryid
                   FROM provinces
                   WHERE provinceid = m_record1_arrRecList[m_record1_keyIndex].clients_provinceid
            END IF
            {</POINT>}
            CALL DIALOG.setActionActive('zoom', FALSE)
            IF libdbapp_isMobile() THEN
                CALL DIALOG.setActionHidden('zoom', TRUE)
            END IF

            INITIALIZE ClientManagerform_events.m_DlgCtrlInstruction TO NULL
            IF ClientManagerform_events.m_DlgEvent_record1_AfterField IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_record1_AfterField(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction, "record1.provinceid")
                    RETURNING ClientManagerform_events.m_DlgCtrlInstruction
            END IF

            CASE ClientManagerform_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    ACCEPT DIALOG
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
            END CASE

        AFTER FIELD record1.clienttypeid
            {<POINT Name="dlg.record1.uiInput.afterField.record1.clienttypeid">} {</POINT>}
            CALL DIALOG.setActionActive('zoom', FALSE)
            IF libdbapp_isMobile() THEN
                CALL DIALOG.setActionHidden('zoom', TRUE)
            END IF

            INITIALIZE ClientManagerform_events.m_DlgCtrlInstruction TO NULL
            IF ClientManagerform_events.m_DlgEvent_record1_AfterField IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_record1_AfterField(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction, "record1.clienttypeid")
                    RETURNING ClientManagerform_events.m_DlgCtrlInstruction
            END IF

            CASE ClientManagerform_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    ACCEPT DIALOG
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
            END CASE

        AFTER FIELD record1.paytermid
            {<POINT Name="dlg.record1.uiInput.afterField.record1.paytermid">} {</POINT>}
            CALL DIALOG.setActionActive('zoom', FALSE)
            IF libdbapp_isMobile() THEN
                CALL DIALOG.setActionHidden('zoom', TRUE)
            END IF

            INITIALIZE ClientManagerform_events.m_DlgCtrlInstruction TO NULL
            IF ClientManagerform_events.m_DlgEvent_record1_AfterField IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_record1_AfterField(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction, "record1.paytermid")
                    RETURNING ClientManagerform_events.m_DlgCtrlInstruction
            END IF

            CASE ClientManagerform_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    ACCEPT DIALOG
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
            END CASE

        ON ACTION dialogtouched --INPUT (record1)
            {<POINT Name="dlg.record1.uiInput.onAction.dialogtouched">} {</POINT>}
            IF m_state == C_MODE_MODIFY THEN
                CALL ClientManagerform_uidialog_record1_validateCRUDOperation(DIALOG, C_MODE_MODIFY, C_ACTION_DIALOGTOUCHED) RETURNING l_internalAction
                CASE l_internalAction
                    WHEN C_INTERNAL_ACTION_NEXT_FIELD_CURRENT --We remain in input mode
                        CALL DIALOG.nextField(FGL_DIALOG_GETFIELDNAME())
                        CONTINUE DIALOG
                    WHEN C_INTERNAL_EXIT_DIALOG
                        EXIT DIALOG
                    OTHERWISE
                        --Do nothing
                END CASE
            END IF
            CALL DIALOG.setActionActive('dialogtouched', FALSE) --disable the dialogtouched action
            CALL DIALOG.setActionActive('delete', FALSE) --disable the delete action in order to force to deletion of data that are not being modified
            IF libdbapp_isMobile() THEN
                CALL DIALOG.setActionHidden('delete', TRUE)
            END IF

        AFTER INSERT
        INITIALIZE ClientManagerform_events.m_DlgCtrlInstruction TO NULL
    IF ClientManagerform_events.m_DlgEvent_record1_AfterInsert IS NOT NULL THEN
        CALL ClientManagerform_events.m_DlgEvent_record1_AfterInsert(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction)
            RETURNING ClientManagerform_events.m_DlgCtrlInstruction
    END IF

    CASE ClientManagerform_events.m_DlgCtrlInstruction
        WHEN libdbappEvents.ACCEPT_DIALOG
            ACCEPT DIALOG
        WHEN libdbappEvents.CONTINUE_DIALOG
            CONTINUE DIALOG
        WHEN libdbappEvents.EXIT_DIALOG
            EXIT DIALOG
    END CASE

        BEFORE DELETE
        INITIALIZE ClientManagerform_events.m_DlgCtrlInstruction TO NULL
    IF ClientManagerform_events.m_DlgEvent_record1_BeforeDelete IS NOT NULL THEN
        CALL ClientManagerform_events.m_DlgEvent_record1_BeforeDelete(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction)
            RETURNING ClientManagerform_events.m_DlgCtrlInstruction
    END IF

    CASE ClientManagerform_events.m_DlgCtrlInstruction
        WHEN libdbappEvents.ACCEPT_DIALOG
            ACCEPT DIALOG
        WHEN libdbappEvents.CONTINUE_DIALOG
            CONTINUE DIALOG
        WHEN libdbappEvents.EXIT_DIALOG
            EXIT DIALOG
    END CASE

        AFTER DELETE
        INITIALIZE ClientManagerform_events.m_DlgCtrlInstruction TO NULL
    IF ClientManagerform_events.m_DlgEvent_record1_AfterDelete IS NOT NULL THEN
        CALL ClientManagerform_events.m_DlgEvent_record1_AfterDelete(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction)
            RETURNING ClientManagerform_events.m_DlgCtrlInstruction
    END IF

    CASE ClientManagerform_events.m_DlgCtrlInstruction
        WHEN libdbappEvents.ACCEPT_DIALOG
            ACCEPT DIALOG
        WHEN libdbappEvents.CONTINUE_DIALOG
            CONTINUE DIALOG
        WHEN libdbappEvents.EXIT_DIALOG
            EXIT DIALOG
    END CASE

        {<POINT Name="dlg.record1.uiInput.userControlBlocks">} {</POINT>}
    END INPUT
END DIALOG
{</BLOCK>} --dlg.record1.uiInput

{<BLOCK Name="dlg.record1.uiConstruct">}
DIALOG ClientManagerform_uidialog_record1_uiConstruct()

    {<POINT Name="dlg.record1.uiConstruct.define">} {</POINT>}

    CONSTRUCT m_record1_where
                 ON clients.clientid,
                    clients.clientname,
                    clients.address1,
                    clients.address2,
                    clients.city,
                    clients.countryid,
                    clients.provinceid,
                    clients.postalzip,
                    clients.primarycontact,
                    clients.primaryemail,
                    clients.clienttypeid,
                    clients.preferred,
                    clients.paytermid,
                    clients.primaryphone,
                    clients.homephone,
                    clients.workphone,
                    clients.workextension,
                    clients.mobilephone
             FROM clients.clientid,
                    clients.clientname,
                    clients.address1,
                    clients.address2,
                    clients.city,
                    clients.countryid,
                    clients.provinceid,
                    clients.postalzip,
                    clients.primarycontact,
                    clients.primaryemail,
                    clients.clienttypeid,
                    clients.preferred,
                    clients.paytermid,
                    clients.primaryphone,
                    clients.homephone,
                    clients.workphone,
                    clients.workextension,
                    clients.mobilephone
        BEFORE FIELD clients.countryid
            {<POINT Name="dlg.record1.uiConstruct.beforeField.clients.countryid">} {</POINT>}
            CALL DIALOG.setActionActive('zoom', TRUE)
            IF libdbapp_isMobile() THEN
                CALL DIALOG.setActionHidden('zoom', FALSE)
            END IF

            INITIALIZE ClientManagerform_events.m_DlgCtrlInstruction TO NULL
            IF ClientManagerform_events.m_DlgEvent_record1_BeforeField IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_record1_BeforeField(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction, "clients.countryid")
                    RETURNING ClientManagerform_events.m_DlgCtrlInstruction
            END IF

            CASE ClientManagerform_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    ACCEPT DIALOG
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
            END CASE

        BEFORE FIELD clients.provinceid
            {<POINT Name="dlg.record1.uiConstruct.beforeField.clients.provinceid">} {</POINT>}
            CALL DIALOG.setActionActive('zoom', TRUE)
            IF libdbapp_isMobile() THEN
                CALL DIALOG.setActionHidden('zoom', FALSE)
            END IF

            INITIALIZE ClientManagerform_events.m_DlgCtrlInstruction TO NULL
            IF ClientManagerform_events.m_DlgEvent_record1_BeforeField IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_record1_BeforeField(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction, "clients.provinceid")
                    RETURNING ClientManagerform_events.m_DlgCtrlInstruction
            END IF

            CASE ClientManagerform_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    ACCEPT DIALOG
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
            END CASE

        BEFORE FIELD clients.clienttypeid
            {<POINT Name="dlg.record1.uiConstruct.beforeField.clients.clienttypeid">} {</POINT>}
            CALL DIALOG.setActionActive('zoom', TRUE)
            IF libdbapp_isMobile() THEN
                CALL DIALOG.setActionHidden('zoom', FALSE)
            END IF

            INITIALIZE ClientManagerform_events.m_DlgCtrlInstruction TO NULL
            IF ClientManagerform_events.m_DlgEvent_record1_BeforeField IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_record1_BeforeField(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction, "clients.clienttypeid")
                    RETURNING ClientManagerform_events.m_DlgCtrlInstruction
            END IF

            CASE ClientManagerform_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    ACCEPT DIALOG
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
            END CASE

        BEFORE FIELD clients.paytermid
            {<POINT Name="dlg.record1.uiConstruct.beforeField.clients.paytermid">} {</POINT>}
            CALL DIALOG.setActionActive('zoom', TRUE)
            IF libdbapp_isMobile() THEN
                CALL DIALOG.setActionHidden('zoom', FALSE)
            END IF

            INITIALIZE ClientManagerform_events.m_DlgCtrlInstruction TO NULL
            IF ClientManagerform_events.m_DlgEvent_record1_BeforeField IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_record1_BeforeField(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction, "clients.paytermid")
                    RETURNING ClientManagerform_events.m_DlgCtrlInstruction
            END IF

            CASE ClientManagerform_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    ACCEPT DIALOG
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
            END CASE

        AFTER FIELD clients.countryid
            {<POINT Name="dlg.record1.uiConstruct.afterField.clients.countryid">} {</POINT>}
            CALL DIALOG.setActionActive('zoom', FALSE)
            IF libdbapp_isMobile() THEN
                CALL DIALOG.setActionHidden('zoom', TRUE)
            END IF

            INITIALIZE ClientManagerform_events.m_DlgCtrlInstruction TO NULL
            IF ClientManagerform_events.m_DlgEvent_record1_AfterField IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_record1_AfterField(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction, "clients.countryid")
                    RETURNING ClientManagerform_events.m_DlgCtrlInstruction
            END IF

            CASE ClientManagerform_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    ACCEPT DIALOG
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
            END CASE

        AFTER FIELD clients.provinceid
            {<POINT Name="dlg.record1.uiConstruct.afterField.clients.provinceid">} {</POINT>}
            CALL DIALOG.setActionActive('zoom', FALSE)
            IF libdbapp_isMobile() THEN
                CALL DIALOG.setActionHidden('zoom', TRUE)
            END IF

            INITIALIZE ClientManagerform_events.m_DlgCtrlInstruction TO NULL
            IF ClientManagerform_events.m_DlgEvent_record1_AfterField IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_record1_AfterField(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction, "clients.provinceid")
                    RETURNING ClientManagerform_events.m_DlgCtrlInstruction
            END IF

            CASE ClientManagerform_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    ACCEPT DIALOG
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
            END CASE

        AFTER FIELD clients.clienttypeid
            {<POINT Name="dlg.record1.uiConstruct.afterField.clients.clienttypeid">} {</POINT>}
            CALL DIALOG.setActionActive('zoom', FALSE)
            IF libdbapp_isMobile() THEN
                CALL DIALOG.setActionHidden('zoom', TRUE)
            END IF

            INITIALIZE ClientManagerform_events.m_DlgCtrlInstruction TO NULL
            IF ClientManagerform_events.m_DlgEvent_record1_AfterField IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_record1_AfterField(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction, "clients.clienttypeid")
                    RETURNING ClientManagerform_events.m_DlgCtrlInstruction
            END IF

            CASE ClientManagerform_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    ACCEPT DIALOG
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
            END CASE

        AFTER FIELD clients.paytermid
            {<POINT Name="dlg.record1.uiConstruct.afterField.clients.paytermid">} {</POINT>}
            CALL DIALOG.setActionActive('zoom', FALSE)
            IF libdbapp_isMobile() THEN
                CALL DIALOG.setActionHidden('zoom', TRUE)
            END IF

            INITIALIZE ClientManagerform_events.m_DlgCtrlInstruction TO NULL
            IF ClientManagerform_events.m_DlgEvent_record1_AfterField IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_record1_AfterField(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction, "clients.paytermid")
                    RETURNING ClientManagerform_events.m_DlgCtrlInstruction
            END IF

            CASE ClientManagerform_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    ACCEPT DIALOG
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
            END CASE

        BEFORE CONSTRUCT
        INITIALIZE ClientManagerform_events.m_DlgCtrlInstruction TO NULL
        IF ClientManagerform_events.m_DlgEvent_record1_BeforeConstruct IS NOT NULL THEN
            CALL ClientManagerform_events.m_DlgEvent_record1_BeforeConstruct(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction)
                RETURNING ClientManagerform_events.m_DlgCtrlInstruction
        END IF

        CASE ClientManagerform_events.m_DlgCtrlInstruction
            WHEN libdbappEvents.ACCEPT_DIALOG
                ACCEPT DIALOG
            WHEN libdbappEvents.CONTINUE_DIALOG
                CONTINUE DIALOG
            WHEN libdbappEvents.EXIT_DIALOG
                EXIT DIALOG
        END CASE

        AFTER CONSTRUCT
        INITIALIZE ClientManagerform_events.m_DlgCtrlInstruction TO NULL
        IF ClientManagerform_events.m_DlgEvent_record1_AfterConstruct IS NOT NULL THEN
            CALL ClientManagerform_events.m_DlgEvent_record1_AfterConstruct(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction)
                RETURNING ClientManagerform_events.m_DlgCtrlInstruction
        END IF

        CASE ClientManagerform_events.m_DlgCtrlInstruction
            WHEN libdbappEvents.ACCEPT_DIALOG
                ACCEPT DIALOG
            WHEN libdbappEvents.CONTINUE_DIALOG
                CONTINUE DIALOG
            WHEN libdbappEvents.EXIT_DIALOG
                EXIT DIALOG
        END CASE

        {<POINT Name="dlg.record1.uiConstruct.userControlBlocks">} {</POINT>}
    END CONSTRUCT
END DIALOG
{</BLOCK>} --dlg.record1.uiConstruct

--------------------------------------------------------------------------------
--Functions
{<BLOCK Name="fct.record1_validateCRUDOperation">}
#+ Validate a CRUD operation for 'record1' (INSERT, UPDATE, DELETE)
#+
#+ @param p_dialog The current DIALOG
#+ @param p_state The current state
#+ @param p_action The action which triggered the CRUD operation
#+
#+ @returnType SMALLINT
#+ @return The internal action
FUNCTION ClientManagerform_uidialog_record1_validateCRUDOperation(p_dialog, p_state, p_action)
    DEFINE p_dialog ui.Dialog
    DEFINE p_state SMALLINT
    DEFINE p_action SMALLINT
    DEFINE l_rec_br_uk record1_br_uk_type --key returned by INSERT operation
    DEFINE l_recordTouched BOOLEAN --TRUE if at least one field of the record was touched, else FALSE
    DEFINE l_requestConfirmation BOOLEAN
    DEFINE l_internalAction SMALLINT
    DEFINE l_action SMALLINT
    {<POINT Name="fct.record1_validateCRUDOperation.define">} {</POINT>}
    INITIALIZE l_rec_br_uk.* TO NULL
    LET l_requestConfirmation = IIF((p_action == C_ACTION_ACCEPT) || (p_action == C_ACTION_DIALOGTOUCHED) || (p_action == C_ACTION_REFRESH_CURRENT_ROW) || (p_action == C_ACTION_REFRESH_ALL_ROWS), FALSE, TRUE)
    CASE p_action
        WHEN C_ACTION_REFRESH_CURRENT_ROW
            LET l_internalAction = C_INTERNAL_ACTION_REFRESH_CURRENT_ROW
        WHEN C_ACTION_REFRESH_ALL_ROWS
            LET l_internalAction = C_INTERNAL_ACTION_REFRESH_ALL_ROWS
        OTHERWISE
            LET l_internalAction = C_INTERNAL_ACTION_PROCESS_OPERATION
    END CASE
    LET l_recordTouched = IIF(p_state == C_MODE_DISPLAY, FALSE, p_dialog.getFieldTouched("record1.*"))
    {<POINT Name="fct.record1_validateCRUDOperation.init">} {</POINT>}

    IF p_action == C_ACTION_CANCEL THEN
        LET l_requestConfirmation = FALSE
        IF p_state == C_MODE_MODIFY THEN
            LET l_internalAction = C_INTERNAL_ACTION_RESTORE_DATA
        END IF
        IF p_state == C_MODE_ADD THEN
            LET l_internalAction = C_INTERNAL_ACTION_CANCEL_ROW_CREATION --Only for the table container and on row creation, the row created by the DVM is deleted
        END IF
    END IF

    --Check if the user has not started to modify the current record and he didn't want to delete the current record
    IF NOT l_recordTouched AND p_action != C_ACTION_DELETE THEN
        LET l_requestConfirmation = FALSE
        LET l_internalAction = C_INTERNAL_ACTION_SYNC_UI_COMPONENTS
        IF p_state == C_MODE_ADD THEN
            LET l_internalAction = C_INTERNAL_ACTION_CANCEL_ROW_CREATION --Only for the table container and on row creation, if the user didn't started to modify data, then the row created by the DVM is deleted
        END IF
        IF p_state == C_MODE_DISPLAY OR p_state == C_MODE_MODIFY THEN
            IF p_action == C_ACTION_REFRESH_CURRENT_ROW THEN
                LET l_internalAction = C_INTERNAL_ACTION_REFRESH_CURRENT_ROW
            END IF
            IF p_action == C_ACTION_REFRESH_ALL_ROWS THEN
                LET l_internalAction = C_INTERNAL_ACTION_REFRESH_ALL_ROWS
            END IF
        END IF
    END IF
    --Check if an user confirmation is requested
    IF l_requestConfirmation THEN
        CALL libdbapp_utilConfirmCRUDOperation(p_action) RETURNING l_internalAction
    END IF
    --Check if the operation must be performed
    IF l_internalAction == C_INTERNAL_ACTION_PROCESS_OPERATION THEN
        LET l_action = p_action
        IF l_action != C_ACTION_DELETE AND l_action != C_ACTION_DIALOGTOUCHED THEN
            IF p_state == C_MODE_ADD THEN
                LET l_action = C_ACTION_APPEND
            END IF
            IF p_state == C_MODE_MODIFY THEN
                LET l_action = C_ACTION_UPDATE
            END IF
        END IF
        CALL ClientManagerform_uidialog_record1_processCRUDOperation(l_action) RETURNING l_internalAction, l_rec_br_uk.*
    END IF
    IF l_internalAction != C_INTERNAL_ACTION_NEXT_FIELD_CURRENT AND l_internalAction != C_INTERNAL_EXIT_DIALOG THEN
        --call synchronize
        IF l_internalAction != C_INTERNAL_ACTION_NO_SYNC THEN
            CALL ClientManagerform_uidialog_record1_synchronizeUI(p_dialog, p_state, l_internalAction, l_rec_br_uk.*) RETURNING m_copy_record1.*
        END IF
        IF p_action == C_ACTION_DIALOGTOUCHED AND (l_internalAction == C_INTERNAL_ACTION_REFRESH_DATA OR l_internalAction == C_INTERNAL_ACTION_DELETE_DATA) THEN
            LET l_internalAction = C_INTERNAL_ACTION_NEXT_FIELD_CURRENT
        ELSE
            LET l_internalAction = C_INTERNAL_ACTION_SUCCESS
            IF p_action == C_ACTION_EXIT_APP THEN
                LET l_internalAction = C_INTERNAL_EXIT_DIALOG
            END IF
        END IF
    END IF
    RETURN l_internalAction
END FUNCTION
{</BLOCK>} --fct.record1_validateCRUDOperation

{<BLOCK Name="fct.record1_processCRUDOperation">}
#+ Process a CRUD operation for 'record1' (INSERT, UPDATE, DELETE, Check the concurrent access)
#+
#+ @param p_action The action which triggered the CRUD operation
#+
#+ @returnType SMALLINT, record1_br_uk_type
#+ @return The internal action
#+ @return The Business Record (BR) Unique Key (UK)
FUNCTION ClientManagerform_uidialog_record1_processCRUDOperation(p_action)
    DEFINE p_action SMALLINT
    DEFINE l_internalAction SMALLINT
    DEFINE l_rec_br_uk record1_br_uk_type --key returned by INSERT operation
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.record1_processCRUDOperation.define">} {</POINT>}
    {<POINT Name="fct.record1_processCRUDOperation.init">} {</POINT>}
    INITIALIZE l_rec_br_uk.* TO NULL
    --The input of the current row is going to be save
    CASE p_action
        WHEN C_ACTION_APPEND --Insert the row in the database
            CALL ClientManagerform_uidata.ClientManagerform_uidata_record1_insertRow(m_record1_arrRecList[m_record1_keyIndex].*) RETURNING errNo, errMsg, l_rec_br_uk.*
        WHEN C_ACTION_UPDATE --Update the row in the database
            CALL ClientManagerform_uidata.ClientManagerform_uidata_record1_updateRow(m_record1_arrRecList[m_record1_keyIndex].*, m_record1_arrRecDB[m_record1_keyIndex].*) RETURNING errNo, errMsg
        WHEN C_ACTION_DIALOGTOUCHED --Check the row in the database
            CALL ClientManagerform_uidata.ClientManagerform_uidata_record1_checkRowConcurrentAccess(m_record1_arrRecDB[m_record1_keyIndex].*) RETURNING errNo, errMsg

        WHEN C_ACTION_DELETE --Delete the row in the database
            CALL ClientManagerform_uidata.ClientManagerform_uidata_record1_deleteRowWithConcurrentAccess(m_record1_arrRecDB[m_record1_keyIndex].*) RETURNING errNo, errMsg
        OTHERWISE
         -- unexpected error
    END CASE
    --Treat the result of the saving
    CASE errNo
        WHEN ERROR_SUCCESS
            CASE p_action
                WHEN C_ACTION_APPEND
                    LET l_internalAction = C_INTERNAL_ACTION_SUCCESS
                WHEN C_ACTION_UPDATE
                    LET l_internalAction = C_INTERNAL_ACTION_SUCCESS
                WHEN C_ACTION_DIALOGTOUCHED
                    LET l_internalAction = C_INTERNAL_ACTION_NO_SYNC
                WHEN C_ACTION_DELETE
                    LET l_internalAction = C_INTERNAL_ACTION_DELETE_DATA
                OTHERWISE
                    --unexpected error
            END CASE
            CALL libdbapp_utilMsgStatusBar(errNo, errMsg)
        WHEN ERROR_FAILURE
            LET l_internalAction = C_INTERNAL_ACTION_NEXT_FIELD_CURRENT --We remain in input mode
            CALL libdbapp_utilMsgStatusBar(errNo, errMsg)
        WHEN ERROR_CONCURRENT_ACCESS_FAILURE
            LET l_internalAction = C_INTERNAL_ACTION_NEXT_FIELD_CURRENT --We remain in input mode
            IF libdbapp_utilMsgBox(C_TXT_WARNING_TITLE, errMsg, C_BTN_OK_CANCEL, C_OK, C_ICON_WARNING) == C_OK THEN
                LET l_internalAction = C_INTERNAL_ACTION_REFRESH_DATA
            END IF
        WHEN ERROR_CONCURRENT_ACCESS_NOTFOUND
            LET l_internalAction = C_INTERNAL_ACTION_NEXT_FIELD_CURRENT --We remain in input mode
            IF libdbapp_utilMsgBox(C_TXT_WARNING_TITLE, errMsg, C_BTN_OK_CANCEL, C_OK, C_ICON_WARNING) == C_OK THEN
                LET l_internalAction = C_INTERNAL_ACTION_DELETE_DATA
            END IF
        WHEN ERROR_DELETE_CASCADE_ROW_USED
            LET l_internalAction = C_INTERNAL_ACTION_NEXT_FIELD_CURRENT --We remain in input mode
            CALL libdbapp_utilMsgStatusBar(errNo, errMsg)
        OTHERWISE --Unexpected error
    END CASE

    RETURN l_internalAction, l_rec_br_uk.*
END FUNCTION
{</BLOCK>} --fct.record1_processCRUDOperation

{<BLOCK Name="fct.record1_synchronizeUI">}
#+ Synchronize the UI according an internal action returned by a CRUD operation for 'record1'
#+
#+ @param p_dialog The current DIALOG
#+ @param p_state The current state
#+ @param p_internalAction A internal action
#+ @param p_rec_br_uk The Business Record (BR) Unique Key (UK)
#+
#+ @returnType record1_br_type
#+ @return The local copy of the current row
FUNCTION ClientManagerform_uidialog_record1_synchronizeUI(p_dialog, p_state, p_internalAction, p_rec_br_uk)
    DEFINE p_dialog ui.Dialog
    DEFINE p_state SMALLINT
    DEFINE p_internalAction SMALLINT
    DEFINE p_rec_br_uk record1_br_uk_type
    DEFINE l_internalAction SMALLINT
    DEFINE l_continue BOOLEAN
    DEFINE errNo INTEGER
    {<POINT Name="fct.record1_synchronizeUI.define">} {</POINT>}
    {<POINT Name="fct.record1_synchronizeUI.init">} {</POINT>}

    --Synchronize UI data
    LET l_internalAction = p_internalAction
    LET l_continue = TRUE
    WHILE l_continue
        LET l_continue = FALSE
        CASE l_internalAction
            WHEN C_INTERNAL_ACTION_SUCCESS
                IF p_state == C_MODE_ADD THEN
                    CALL m_record1_arrRecDB.insertElement(m_record1_keyIndex) --Add an item in arrRecDB with the new index
                    LET m_record1_arrRecList[m_record1_keyIndex].clients_clientid = p_rec_br_uk.clients_clientid --Refresh the inserted key value in the UI (may be a composite key) (Useful in the case of SERIALS which are known after the INSERT sql statement)
                END IF
                CALL ClientManagerform_uidialogdata_record1_fetchRowAndDetails() RETURNING errNo --Done to update the m_record1_arrRecDB
                IF errNo == ERROR_NOTFOUND THEN
                    LET l_internalAction = C_INTERNAL_ACTION_DELETE_DATA
                    LET l_continue = TRUE
                    CONTINUE WHILE
                END IF

            WHEN C_INTERNAL_ACTION_REFRESH_DATA
                CALL ClientManagerform_uidialogdata_record1_fetchRowAndDetails() RETURNING errNo --Done to update the m_record1_arrRecDB
                IF errNo == ERROR_NOTFOUND THEN
                    LET l_internalAction = C_INTERNAL_ACTION_DELETE_DATA
                    LET l_continue = TRUE
                    CONTINUE WHILE
                END IF

            WHEN C_INTERNAL_ACTION_REFRESH_CURRENT_ROW
                CALL ClientManagerform_uidialogdata_record1_fetchRowAndDetails() RETURNING errNo
                IF errNo == ERROR_NOTFOUND THEN
                    LET l_internalAction = C_INTERNAL_ACTION_DELETE_DATA
                    LET l_continue = TRUE
                    CONTINUE WHILE
                END IF

            WHEN C_INTERNAL_ACTION_REFRESH_ALL_ROWS
                CALL ClientManagerform_uidialogdata_record1_fetchAll(m_where, m_detailList)

            WHEN C_INTERNAL_ACTION_RESTORE_DATA
                IF p_state == C_MODE_MODIFY AND m_record1_keyIndex > 0 THEN
                    LET m_record1_arrRecList[m_record1_keyIndex].* = m_copy_record1.* --Restore a local copy
                    LET M_errMsg = C_TXT_DATA_RESTORED
                END IF
                IF p_state == C_MODE_ADD THEN
                    CALL p_dialog.deleteRow("record1", m_record1_keyIndex)
                END IF

            WHEN C_INTERNAL_ACTION_DELETE_DATA
                CALL m_record1_arrRecDB.deleteElement(m_record1_keyIndex) --Delete the row in arrRecDB
                CALL p_dialog.deleteRow("record1", m_record1_keyIndex) --Delete the row in arrRecList
                LET m_record1_keyIndex = libdbapp_setRowIndex(p_dialog.getCurrentRow("record1"), m_record1_arrRecList.getLength())
                CALL ClientManagerform_uidialogdata_record1_fetchRowAndDetails() RETURNING errNo
                IF errNo == ERROR_NOTFOUND THEN
                    LET l_internalAction = C_INTERNAL_ACTION_DELETE_DATA
                    LET l_continue = TRUE
                    CONTINUE WHILE
                END IF

            WHEN C_INTERNAL_ACTION_CANCEL_ROW_CREATION
                CALL p_dialog.deleteRow("record1", m_record1_keyIndex) --Delete the row in arrRecList
                LET m_record1_keyIndex = libdbapp_setRowIndex(m_record1_keyIndex, m_record1_arrRecList.getLength())
                CALL ClientManagerform_uidialogdata_record1_fetchRowAndDetails() RETURNING errNo
                IF errNo == ERROR_NOTFOUND THEN
                    LET l_internalAction = C_INTERNAL_ACTION_DELETE_DATA
                    LET l_continue = TRUE
                    CONTINUE WHILE
                END IF
            OTHERWISE
                --Unexpected error
        END CASE
    END WHILE
    --Synchronize UI components
    IF p_state != C_MODE_DISPLAY THEN
        LET p_state = C_MODE_MODIFY
        CALL p_dialog.setActionActive('dialogtouched', TRUE) --Reset 'touched' flag
        CALL p_dialog.setFieldTouched("record1.*", FALSE) --Reset 'touched' flag
        CALL ClientManagerform_uidialog_record1_setFieldActive(p_dialog, p_state)
    END IF

    CALL ClientManagerform_uidialog_record1_setActionStates(p_dialog, p_state)
    IF NOT libdbapp_isMobile() THEN
        MESSAGE m_record1_keyIndex, "/", m_record1_arrRecList.getLength()
    END IF

    IF m_record1_keyIndex > 0 THEN
        LET m_copy_record1.* = m_record1_arrRecList[m_record1_keyIndex].* --Keep a local copy
    ELSE
        INITIALIZE m_copy_record1.* TO NULL --Reset a local copy
    END IF
    RETURN m_copy_record1.*
END FUNCTION
{</BLOCK>} --fct.record1_synchronizeUI

{<BLOCK Name="fct.setActionStates">}
#+ Sets the state of the dialog actions to active or inactive according to the mode
#+
#+ @param p_dialog      The current DIALOG
#+ @param p_mode        The current mode
FUNCTION ClientManagerform_uidialog_setActionStates(p_dialog, p_mode)
    DEFINE p_dialog ui.Dialog
    DEFINE p_mode SMALLINT
    {<POINT Name="fct.setActionStates.define">} {</POINT>}
    {<POINT Name="fct.setActionStates.init">} {</POINT>}

    CASE p_mode
        WHEN C_MODE_DISPLAY
            IF libdbapp_isMobile() THEN
                CALL p_dialog.setActionActive('new', FALSE)
                CALL p_dialog.setActionHidden('new', TRUE)
            ELSE
                CALL p_dialog.setActionActive('new', NOT m_uiSettings.disableAdd)
                CALL p_dialog.setActionHidden('new', m_uiSettings.disableAdd)
            END IF
            CALL p_dialog.setActionActive('query', NOT m_uiSettings.disableSearch)
            CALL p_dialog.setActionHidden('query', m_uiSettings.disableSearch)
            CALL p_dialog.setActionActive('accept', FALSE)
            IF libdbapp_isMobile() THEN
                CALL p_dialog.setActionHidden('accept', TRUE)
            END IF
            CALL p_dialog.setActionActive('cancel', FALSE)
            IF libdbapp_isMobile() THEN
                CALL p_dialog.setActionHidden('cancel', TRUE)
            END IF
            {<POINT Name="fct.setActionStates.initDisplay">} {</POINT>}
        WHEN C_MODE_MODIFY
            IF libdbapp_isMobile() THEN
                CALL p_dialog.setActionActive('new', FALSE)
                CALL p_dialog.setActionHidden('new', TRUE)
            ELSE
                CALL p_dialog.setActionActive('new', NOT m_uiSettings.disableAdd)
                CALL p_dialog.setActionHidden('new', m_uiSettings.disableAdd)
            END IF
            CALL p_dialog.setActionActive('accept', TRUE)
            CALL p_dialog.setActionActive('cancel', TRUE)
            IF libdbapp_isMobile() THEN
                CALL p_dialog.setActionHidden('accept', FALSE)
                CALL p_dialog.setActionHidden('cancel', FALSE)
            END IF
            {<POINT Name="fct.setActionStates.initModify">} {</POINT>}
        WHEN C_MODE_ADD
            IF libdbapp_isMobile() THEN
                CALL p_dialog.setActionActive('new', FALSE)
                CALL p_dialog.setActionHidden('new', TRUE)
            ELSE
                CALL p_dialog.setActionActive('new', FALSE)
                CALL p_dialog.setActionHidden('new', m_uiSettings.disableAdd)
            END IF
            CALL p_dialog.setActionActive('accept', TRUE)
            CALL p_dialog.setActionActive('cancel', TRUE)
            IF libdbapp_isMobile() THEN
                CALL p_dialog.setActionHidden('accept', FALSE)
                CALL p_dialog.setActionHidden('cancel', FALSE)
            END IF
            {<POINT Name="fct.setActionStates.initAdd">} {</POINT>}
        WHEN C_MODE_SEARCH
            {<POINT Name="fct.setActionStates.initSearch">} {</POINT>}
        WHEN C_MODE_EMPTY
            IF libdbapp_isMobile() THEN
                CALL p_dialog.setActionActive('new', FALSE)
                CALL p_dialog.setActionHidden('new', TRUE)
            ELSE
                CALL p_dialog.setActionActive('new', NOT m_uiSettings.disableAdd)
                CALL p_dialog.setActionHidden('new', m_uiSettings.disableAdd)
            END IF
            CALL p_dialog.setActionActive('query', NOT m_uiSettings.disableSearch)
            CALL p_dialog.setActionHidden('query', m_uiSettings.disableSearch)
            {<POINT Name="fct.setActionStates.initEmpty">} {</POINT>}
        OTHERWISE
            DISPLAY "unknown mode  ", p_mode
    END CASE

    IF ClientManagerform_events.m_DlgEvent_OnActionStatesChange IS NOT NULL THEN
        CALL ClientManagerform_events.m_DlgEvent_OnActionStatesChange(p_dialog, p_mode)
    END IF
END FUNCTION
{</BLOCK>} --fct.setActionStates

{<BLOCK Name="fct.record1_setActionStates">}
#+ Sets for 'record1' the state of the actions to active or inactive
#+
#+ @param p_dialog      The current DIALOG
#+ @param p_mode        The current mode
FUNCTION ClientManagerform_uidialog_record1_setActionStates(p_dialog, p_mode)
    DEFINE p_dialog ui.Dialog
    DEFINE p_mode SMALLINT
    {<POINT Name="fct.record1_setActionStates.define">} {</POINT>}

    --Sets the state of the DIALOG actions
    CALL ClientManagerform_uidialog_setActionStates(p_dialog, p_mode)
    {<POINT Name="fct.record1_setActionStates.init">} {</POINT>}
    --Sets the state of the subDialog actions
    CASE p_mode
        WHEN C_MODE_DISPLAY
            IF libdbapp_isMobile() THEN
                CALL p_dialog.setActionActive('append', NOT m_uiSettings.disableAdd)
                CALL p_dialog.setActionHidden('append', m_uiSettings.disableAdd)
            ELSE
                CALL p_dialog.setActionActive('append', FALSE)
                CALL p_dialog.setActionHidden('append', TRUE)
            END IF
            IF libdbapp_isMobile() THEN
                CALL p_dialog.setActionActive('insert', FALSE)
                CALL p_dialog.setActionHidden('insert', TRUE)
            ELSE
                CALL p_dialog.setActionActive('insert', m_record1_arrRecList.getLength() > 0 AND NOT m_uiSettings.disableAdd)
                CALL p_dialog.setActionHidden('insert', m_uiSettings.disableAdd)
            END IF
            CALL p_dialog.setActionActive('update', m_record1_arrRecList.getLength() > 0 AND NOT m_uiSettings.disableModify)
            IF libdbapp_isMobile() THEN
                CALL p_dialog.setActionHidden('update', NOT (m_record1_arrRecList.getLength() > 0 AND NOT m_uiSettings.disableModify))
            ELSE
                CALL p_dialog.setActionHidden('update', m_uiSettings.disableModify)
            END IF
            CALL p_dialog.setActionActive('delete', m_record1_arrRecList.getLength() > 0 AND NOT m_uiSettings.disableDelete)
            IF libdbapp_isMobile() THEN
                CALL p_dialog.setActionHidden('delete', NOT (m_record1_arrRecList.getLength() > 0 AND NOT m_uiSettings.disableDelete))
            ELSE
                CALL p_dialog.setActionHidden('delete', m_uiSettings.disableDelete)
            END IF
            {<POINT Name="fct.record1_setActionStates.initDisplay">} {</POINT>}
        WHEN C_MODE_MODIFY
            IF libdbapp_isMobile() THEN
                CALL p_dialog.setActionActive('append', NOT m_uiSettings.disableAdd)
                CALL p_dialog.setActionHidden('append', m_uiSettings.disableAdd)
            ELSE
                CALL p_dialog.setActionActive('append', FALSE)
                CALL p_dialog.setActionHidden('append', TRUE)
            END IF
            IF libdbapp_isMobile() THEN
                CALL p_dialog.setActionActive('insert', FALSE)
                CALL p_dialog.setActionHidden('insert', TRUE)
            ELSE
                CALL p_dialog.setActionActive('insert', m_record1_arrRecList.getLength() > 0 AND NOT m_uiSettings.disableAdd)
                CALL p_dialog.setActionHidden('insert', m_uiSettings.disableAdd)
            END IF
            CALL p_dialog.setActionActive('delete', m_record1_arrRecList.getLength() > 0 AND NOT m_uiSettings.disableDelete)
            IF libdbapp_isMobile() THEN
                CALL p_dialog.setActionHidden('delete', NOT (m_record1_arrRecList.getLength() > 0 AND NOT m_uiSettings.disableDelete))
            ELSE
                CALL p_dialog.setActionHidden('delete', m_uiSettings.disableDelete)
            END IF
            CALL p_dialog.setActionActive('query', NOT m_uiSettings.disableSearch)
            CALL p_dialog.setActionHidden('query', m_uiSettings.disableSearch)
            {<POINT Name="fct.record1_setActionStates.initModify">} {</POINT>}
        WHEN C_MODE_ADD
            CALL p_dialog.setActionActive('append', FALSE)
            CALL p_dialog.setActionHidden('append', TRUE)
            IF libdbapp_isMobile() THEN
                CALL p_dialog.setActionActive('insert', FALSE)
                CALL p_dialog.setActionHidden('insert', TRUE)
            ELSE
                CALL p_dialog.setActionActive('insert', FALSE)
                CALL p_dialog.setActionHidden('insert', m_uiSettings.disableAdd)
            END IF
            CALL p_dialog.setActionActive('delete', FALSE)
            IF libdbapp_isMobile() THEN
                CALL p_dialog.setActionHidden('delete', TRUE)
            ELSE
                CALL p_dialog.setActionHidden('delete', m_uiSettings.disableDelete)
            END IF
            CALL p_dialog.setActionActive('query', NOT m_uiSettings.disableSearch)
            CALL p_dialog.setActionHidden('query', m_uiSettings.disableSearch)
            {<POINT Name="fct.record1_setActionStates.initAdd">} {</POINT>}
        WHEN C_MODE_SEARCH
            {<POINT Name="fct.record1_setActionStates.initSearch">} {</POINT>}
        WHEN C_MODE_EMPTY
            IF libdbapp_isMobile() THEN
                CALL p_dialog.setActionActive('append', NOT m_uiSettings.disableAdd)
                CALL p_dialog.setActionHidden('append', m_uiSettings.disableAdd)
            ELSE
                CALL p_dialog.setActionActive('append', FALSE)
                CALL p_dialog.setActionHidden('append', TRUE)
            END IF
            {<POINT Name="fct.record1_setActionStates.initEmpty">} {</POINT>}
        OTHERWISE
            DISPLAY "unknown mode  ", p_mode
    END CASE

    IF ClientManagerform_events.m_DlgEvent_record1_OnActionStatesChange IS NOT NULL THEN
        CALL ClientManagerform_events.m_DlgEvent_record1_OnActionStatesChange(p_dialog, p_mode)
    END IF
END FUNCTION
{</BLOCK>} --fct.record1_setActionStates

{<BLOCK Name="fct.record1_setFieldActive">}
#+ Initialize fields state of 'record1' according to startup state
#+
#+ All 'noEntry' fields are not enabled/disabled by programming
#+
#+ The fields that satisfy at least one of the following conditions are ALWAYS disabled:
#+  o fields that are not on the master table and which do not trigger ascending lookups
#+  o formonly fields
#+  o BR relation fields (foreignFields) of details
#+  o DB foreignKey fields of details
#+  o fields which trigger ascending lookups and update BR relation fields (foreignFields) of details
#+  o fields which trigger ascending lookups and update DB foreignKey fields of details
#+
#+ The fields that satisfy at least one of the following conditions are disabled in MODIFY mode:
#+  o fields that are unique keys
#+  o fields that are primary keys
#+  o fields which trigger ascending lookups and update unique keys
#+  o fields which trigger ascending lookups and update primary keys
#+
#+ @param p_dialog     The current DIALOG
#+ @param p_state      The startup state
PUBLIC FUNCTION ClientManagerform_uidialog_record1_setFieldActive(p_dialog, p_state)
    DEFINE p_dialog ui.Dialog
    DEFINE p_state SMALLINT
    {<POINT Name="fct.record1_setFieldActive.define">} {</POINT>}
    {<POINT Name="fct.record1_setFieldActive.init">} {</POINT>}

    CALL p_dialog.setFieldActive("record1.clientid", p_state == C_MODE_ADD)

    {<POINT Name="fct.record1_setFieldActive.user">} {</POINT>}
    IF ClientManagerform_events.m_DlgEvent_record1_OnFieldsActivation IS NOT NULL THEN
        CALL ClientManagerform_events.m_DlgEvent_record1_OnFieldsActivation(p_dialog, p_state)
    END IF
END FUNCTION
{</BLOCK>} --fct.record1_setFieldActive

{<BLOCK Name="fct.setAllCurrentRow">}
#+ Set the current row on all subdialogs whose container is a 'table' to restore the context
#+
#+ @param p_dialog The current DIALOG
PUBLIC FUNCTION ClientManagerform_uidialog_setAllCurrentRow(p_dialog)
    DEFINE p_dialog ui.Dialog
    {<POINT Name="fct.setAllCurrentRow.define">} {</POINT>}
    {<POINT Name="fct.setAllCurrentRow.init">} {</POINT>}

    CALL p_dialog.setCurrentRow("record1", m_record1_keyIndex)
END FUNCTION
{</BLOCK>} --fct.setAllCurrentRow

--------------------------------------------------------------------------------
--Add user functions
{<POINT Name="user.functions" Status="MODIFIED">} 
FUNCTION isPrimaryEmailValid(p_email)
   DEFINE p_email STRING 
   RETURN TRUE
END function


FUNCTION isPhoneValid(p_phone)

   DEFINE p_phone STRING 
   
   RETURN TRUE
   
END function

{</POINT>}
{<POINT Name="dlg.record1.uiInput.afterField.record1.PRIMARYEMAIL" Status="LOST">}
--  
--         AFTER FIELD record1.primaryemail
--            IF m_record1_arrRecList[m_record1_keyIndex].clients_primaryemail IS NULL THEN
--               ERROR "Primary email address is not valid"
--               NEXT FIELD primaryemail
--            END IF           
{</POINT>}
{<POINT Name="dlg.record1.uiInput.afterField.record1.homephone" Status="LOST">}
--  
--         AFTER FIELD record1.homephone
--         
{</POINT>}
{<POINT Name="dlg.record1.uiInput.afterField.record1.mobilephone" Status="LOST">}
--  
--         AFTER FIELD record1.mobilephone
--         
{</POINT>}
{<POINT Name="dlg.record1.uiInput.afterField.record1.workphone" Status="LOST">}
--  
--         AFTER FIELD record1.workphone
--         
{</POINT>}
{<POINT Name="dlg.record1.uiInput.afterField.record1.PRIMARYEMAIL" Status="LOST">}
--  
--         AFTER FIELD primaryemail
--            IF m_record1_arrRecList[m_record1_keyIndex].clients_primaryemail IS NULL THEN
--               ERROR "Primary email address is not valid"
--               NEXT FIELD primaryemail
--            END IF           
{</POINT>}
{<BLOCK Name="fct." Status="LOST">}
-- #+ Populate the 'clients.primaryphone' ComboBox
-- #+
-- #+ @param cb   The comboBox to populate
-- PUBLIC FUNCTION (cb)
--     --Declaration of parameters
--     DEFINE cb ui.ComboBox
--     --Declaration of local types, variables, constants
--     DEFINE cbKeyValuePairs DYNAMIC ARRAY OF record1_clients_primaryphone_br_type
--     DEFINE errNo INTEGER
--     DEFINE i INTEGER
--     {<POINT Name="fct..define">} {</POINT>}
--     {<POINT Name="fct..init">} {</POINT>}
--     CALL cb.clear()
--     CALL  ClientManagerform_uidata.ClientManagerform_uidata_record1__FillArray(cbKeyValuePairs) RETURNING errNo
--     IF errNo >= ERROR_SQL_SUCCESS THEN
--         FOR i=1 TO cbKeyValuePairs.getLength()
--             CALL cb.addItem(cbKeyValuePairs[i].key CLIPPED, cbKeyValuePairs[i].value CLIPPED)
--         END FOR
--     ELSE
--         CALL libdbapp_utilMsgStatusBar(errNo, libdbapp_formatSqlErrorMsg(errNo))
--     END IF
--     {<POINT Name="fct..user">} {</POINT>}
-- END FUNCTION
{</BLOCK>}
