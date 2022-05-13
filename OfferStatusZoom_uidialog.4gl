{<CODEFILE Path="OfferStatusZoom.code" Hash="1B2M2Y8AsgTpgAmY7PhCfg==" />}
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

IMPORT FGL OfferStatusZoom_common
IMPORT FGL OfferStatusZoom
IMPORT FGL OfferStatusZoom_events
IMPORT FGL OfferStatusZoom_uidata
IMPORT FGL OfferStatusZoom_uidialogdata
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
DIALOG OfferStatusZoom_uidialog_record1_uiDisplay()

    {<POINT Name="dlg.record1.uiDisplay.define">} {</POINT>}

    DISPLAY ARRAY m_record1_arrRecList TO record1.*
        {<POINT Name="dlg.record1.uiDisplay.attributes">} {</POINT>}
        BEFORE DISPLAY
            LET m_subDialog = "record1"
            CALL OfferStatusZoom_uidialog_record1_setActionStates(DIALOG, C_MODE_DISPLAY)
            --Set the current row with the index of the subdialog, otherwise when you come:
            -- - from another mode
            -- - from a detail in INPUT to the master in DISPLAY (mixed mode)
            -- the index is reset to 1 by 'DIALOG.getCurrentRow'
            CALL DIALOG.setCurrentRow("record1", m_record1_keyIndex)
            IF NOT libdbapp_isMobile() THEN
                MESSAGE m_record1_keyIndex, "/", m_record1_arrRecList.getLength()
            END IF

            INITIALIZE OfferStatusZoom_events.m_DlgCtrlInstruction TO NULL
            IF OfferStatusZoom_events.m_DlgEvent_record1_BeforeDisplay IS NOT NULL THEN
                CALL OfferStatusZoom_events.m_DlgEvent_record1_BeforeDisplay(DIALOG, m_state, OfferStatusZoom_events.m_DlgCtrlInstruction)
                    RETURNING OfferStatusZoom_events.m_DlgCtrlInstruction
            END IF

            CASE OfferStatusZoom_events.m_DlgCtrlInstruction
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
                CALL OfferStatusZoom_uidialogdata_record1_fetchDetails()
            END IF
            CALL OfferStatusZoom_uidialog_setAllCurrentRow(DIALOG)
            IF NOT libdbapp_isMobile() THEN
                MESSAGE m_record1_keyIndex, "/", m_record1_arrRecList.getLength()
            END IF

            INITIALIZE OfferStatusZoom_events.m_DlgCtrlInstruction TO NULL
            IF OfferStatusZoom_events.m_DlgEvent_record1_BeforeRow IS NOT NULL THEN
                CALL OfferStatusZoom_events.m_DlgEvent_record1_BeforeRow(DIALOG, m_state, OfferStatusZoom_events.m_DlgCtrlInstruction)
                    RETURNING OfferStatusZoom_events.m_DlgCtrlInstruction
            END IF

            CASE OfferStatusZoom_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    ACCEPT DIALOG
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
            END CASE

        AFTER DISPLAY
        INITIALIZE OfferStatusZoom_events.m_DlgCtrlInstruction TO NULL
        IF OfferStatusZoom_events.m_DlgEvent_record1_AfterDisplay IS NOT NULL THEN
            CALL OfferStatusZoom_events.m_DlgEvent_record1_AfterDisplay(DIALOG, m_state, OfferStatusZoom_events.m_DlgCtrlInstruction)
                RETURNING OfferStatusZoom_events.m_DlgCtrlInstruction
        END IF

        CASE OfferStatusZoom_events.m_DlgCtrlInstruction
            WHEN libdbappEvents.ACCEPT_DIALOG
                ACCEPT DIALOG
            WHEN libdbappEvents.CONTINUE_DIALOG
                CONTINUE DIALOG
            WHEN libdbappEvents.EXIT_DIALOG
                EXIT DIALOG
        END CASE

        AFTER ROW
        INITIALIZE OfferStatusZoom_events.m_DlgCtrlInstruction TO NULL
        IF OfferStatusZoom_events.m_DlgEvent_record1_AfterRow IS NOT NULL THEN
            CALL OfferStatusZoom_events.m_DlgEvent_record1_AfterRow(DIALOG, m_state, OfferStatusZoom_events.m_DlgCtrlInstruction)
                RETURNING OfferStatusZoom_events.m_DlgCtrlInstruction
        END IF

        CASE OfferStatusZoom_events.m_DlgCtrlInstruction
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

{<BLOCK Name="dlg.record1.uiConstruct">}
DIALOG OfferStatusZoom_uidialog_record1_uiConstruct()

    {<POINT Name="dlg.record1.uiConstruct.define">} {</POINT>}

    CONSTRUCT m_record1_where
                 ON offerstatuses.offerstatusid,
                    offerstatuses.offerstatusname
             FROM offerstatuses.offerstatusid,
                    offerstatuses.offerstatusname

        BEFORE CONSTRUCT
        INITIALIZE OfferStatusZoom_events.m_DlgCtrlInstruction TO NULL
        IF OfferStatusZoom_events.m_DlgEvent_record1_BeforeConstruct IS NOT NULL THEN
            CALL OfferStatusZoom_events.m_DlgEvent_record1_BeforeConstruct(DIALOG, m_state, OfferStatusZoom_events.m_DlgCtrlInstruction)
                RETURNING OfferStatusZoom_events.m_DlgCtrlInstruction
        END IF

        CASE OfferStatusZoom_events.m_DlgCtrlInstruction
            WHEN libdbappEvents.ACCEPT_DIALOG
                ACCEPT DIALOG
            WHEN libdbappEvents.CONTINUE_DIALOG
                CONTINUE DIALOG
            WHEN libdbappEvents.EXIT_DIALOG
                EXIT DIALOG
        END CASE

        AFTER CONSTRUCT
        INITIALIZE OfferStatusZoom_events.m_DlgCtrlInstruction TO NULL
        IF OfferStatusZoom_events.m_DlgEvent_record1_AfterConstruct IS NOT NULL THEN
            CALL OfferStatusZoom_events.m_DlgEvent_record1_AfterConstruct(DIALOG, m_state, OfferStatusZoom_events.m_DlgCtrlInstruction)
                RETURNING OfferStatusZoom_events.m_DlgCtrlInstruction
        END IF

        CASE OfferStatusZoom_events.m_DlgCtrlInstruction
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
FUNCTION OfferStatusZoom_uidialog_record1_validateCRUDOperation(p_dialog, p_state, p_action)
    DEFINE p_dialog ui.Dialog
    DEFINE p_state SMALLINT
    DEFINE p_action SMALLINT
    DEFINE l_rec_br_uk record1_br_uk_type --key returned by INSERT operation
    DEFINE l_recordTouched BOOLEAN --TRUE if at least one field of the record was touched, else FALSE
    DEFINE l_requestConfirmation BOOLEAN
    DEFINE l_internalAction SMALLINT
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

    IF p_state == C_MODE_DISPLAY OR p_state == C_MODE_MODIFY THEN
        IF p_action == C_ACTION_REFRESH_CURRENT_ROW THEN
            LET l_internalAction = C_INTERNAL_ACTION_REFRESH_CURRENT_ROW
        END IF
        IF p_action == C_ACTION_REFRESH_ALL_ROWS THEN
            LET l_internalAction = C_INTERNAL_ACTION_REFRESH_ALL_ROWS
        END IF
    END IF
    --Check if an user confirmation is requested
    IF l_requestConfirmation THEN
        CALL libdbapp_utilConfirmCRUDOperation(p_action) RETURNING l_internalAction
    END IF
    IF l_internalAction != C_INTERNAL_ACTION_NEXT_FIELD_CURRENT AND l_internalAction != C_INTERNAL_EXIT_DIALOG THEN
        --call synchronize
        IF l_internalAction != C_INTERNAL_ACTION_NO_SYNC THEN
            CALL OfferStatusZoom_uidialog_record1_synchronizeUI(p_dialog, p_state, l_internalAction, l_rec_br_uk.*) RETURNING m_copy_record1.*
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
FUNCTION OfferStatusZoom_uidialog_record1_synchronizeUI(p_dialog, p_state, p_internalAction, p_rec_br_uk)
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

            WHEN C_INTERNAL_ACTION_REFRESH_DATA
                CALL OfferStatusZoom_uidialogdata_record1_fetchRowAndDetails() RETURNING errNo --Done to update the m_record1_arrRecDB
                IF errNo == ERROR_NOTFOUND THEN
                    LET l_internalAction = C_INTERNAL_ACTION_DELETE_DATA
                    LET l_continue = TRUE
                    CONTINUE WHILE
                END IF

            WHEN C_INTERNAL_ACTION_REFRESH_CURRENT_ROW
                CALL OfferStatusZoom_uidialogdata_record1_fetchRowAndDetails() RETURNING errNo
                IF errNo == ERROR_NOTFOUND THEN
                    LET l_internalAction = C_INTERNAL_ACTION_DELETE_DATA
                    LET l_continue = TRUE
                    CONTINUE WHILE
                END IF

            WHEN C_INTERNAL_ACTION_REFRESH_ALL_ROWS
                CALL OfferStatusZoom_uidialogdata_record1_fetchAll(m_where, m_detailList)

            WHEN C_INTERNAL_ACTION_DELETE_DATA
                CALL m_record1_arrRecDB.deleteElement(m_record1_keyIndex) --Delete the row in arrRecDB
                CALL p_dialog.deleteRow("record1", m_record1_keyIndex) --Delete the row in arrRecList
                LET m_record1_keyIndex = libdbapp_setRowIndex(p_dialog.getCurrentRow("record1"), m_record1_arrRecList.getLength())
                CALL OfferStatusZoom_uidialogdata_record1_fetchRowAndDetails() RETURNING errNo
                IF errNo == ERROR_NOTFOUND THEN
                    LET l_internalAction = C_INTERNAL_ACTION_DELETE_DATA
                    LET l_continue = TRUE
                    CONTINUE WHILE
                END IF

            WHEN C_INTERNAL_ACTION_CANCEL_ROW_CREATION
                CALL p_dialog.deleteRow("record1", m_record1_keyIndex) --Delete the row in arrRecList
                LET m_record1_keyIndex = libdbapp_setRowIndex(m_record1_keyIndex, m_record1_arrRecList.getLength())
                CALL OfferStatusZoom_uidialogdata_record1_fetchRowAndDetails() RETURNING errNo
                IF errNo == ERROR_NOTFOUND THEN
                    LET l_internalAction = C_INTERNAL_ACTION_DELETE_DATA
                    LET l_continue = TRUE
                    CONTINUE WHILE
                END IF
            OTHERWISE
                --Unexpected error
        END CASE
    END WHILE

    CALL OfferStatusZoom_uidialog_record1_setActionStates(p_dialog, p_state)
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
FUNCTION OfferStatusZoom_uidialog_setActionStates(p_dialog, p_mode)
    DEFINE p_dialog ui.Dialog
    DEFINE p_mode SMALLINT
    {<POINT Name="fct.setActionStates.define">} {</POINT>}
    {<POINT Name="fct.setActionStates.init">} {</POINT>}

    CASE p_mode
        WHEN C_MODE_DISPLAY
            CALL p_dialog.setActionActive('query', NOT m_uiSettings.disableSearch)
            CALL p_dialog.setActionHidden('query', m_uiSettings.disableSearch)
            {<POINT Name="fct.setActionStates.initDisplay">} {</POINT>}
        WHEN C_MODE_SEARCH
            {<POINT Name="fct.setActionStates.initSearch">} {</POINT>}
        WHEN C_MODE_EMPTY
            CALL p_dialog.setActionActive('query', NOT m_uiSettings.disableSearch)
            CALL p_dialog.setActionHidden('query', m_uiSettings.disableSearch)
            {<POINT Name="fct.setActionStates.initEmpty">} {</POINT>}
        OTHERWISE
            DISPLAY "unknown mode  ", p_mode
    END CASE

    IF OfferStatusZoom_events.m_DlgEvent_OnActionStatesChange IS NOT NULL THEN
        CALL OfferStatusZoom_events.m_DlgEvent_OnActionStatesChange(p_dialog, p_mode)
    END IF
END FUNCTION
{</BLOCK>} --fct.setActionStates

{<BLOCK Name="fct.record1_setActionStates">}
#+ Sets for 'record1' the state of the actions to active or inactive
#+
#+ @param p_dialog      The current DIALOG
#+ @param p_mode        The current mode
FUNCTION OfferStatusZoom_uidialog_record1_setActionStates(p_dialog, p_mode)
    DEFINE p_dialog ui.Dialog
    DEFINE p_mode SMALLINT
    {<POINT Name="fct.record1_setActionStates.define">} {</POINT>}

    --Sets the state of the DIALOG actions
    CALL OfferStatusZoom_uidialog_setActionStates(p_dialog, p_mode)
    {<POINT Name="fct.record1_setActionStates.init">} {</POINT>}
    --Sets the state of the subDialog actions
    CASE p_mode
        WHEN C_MODE_DISPLAY
            {<POINT Name="fct.record1_setActionStates.initDisplay">} {</POINT>}
        WHEN C_MODE_SEARCH
            {<POINT Name="fct.record1_setActionStates.initSearch">} {</POINT>}
        WHEN C_MODE_EMPTY
            {<POINT Name="fct.record1_setActionStates.initEmpty">} {</POINT>}
        OTHERWISE
            DISPLAY "unknown mode  ", p_mode
    END CASE

    IF OfferStatusZoom_events.m_DlgEvent_record1_OnActionStatesChange IS NOT NULL THEN
        CALL OfferStatusZoom_events.m_DlgEvent_record1_OnActionStatesChange(p_dialog, p_mode)
    END IF
END FUNCTION
{</BLOCK>} --fct.record1_setActionStates

{<BLOCK Name="fct.setAllCurrentRow">}
#+ Set the current row on all subdialogs whose container is a 'table' to restore the context
#+
#+ @param p_dialog The current DIALOG
PUBLIC FUNCTION OfferStatusZoom_uidialog_setAllCurrentRow(p_dialog)
    DEFINE p_dialog ui.Dialog
    {<POINT Name="fct.setAllCurrentRow.define">} {</POINT>}
    {<POINT Name="fct.setAllCurrentRow.init">} {</POINT>}

    CALL p_dialog.setCurrentRow("record1", m_record1_keyIndex)
END FUNCTION
{</BLOCK>} --fct.setAllCurrentRow

--------------------------------------------------------------------------------
--Add user functions
{<POINT Name="user.functions">} {</POINT>}
