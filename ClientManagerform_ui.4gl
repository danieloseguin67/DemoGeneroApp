{<CODEFILE Path="ClientManagerform.code" Hash="1B2M2Y8AsgTpgAmY7PhCfg==" />}
#+ User Interface

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

IMPORT FGL consultcompanion_events
IMPORT FGL consultcompanion_dbxdata
IMPORT FGL ClientManagerform_common
IMPORT FGL ClientManagerform
IMPORT FGL ClientManagerform_events
IMPORT FGL ClientManagerform_uidata
IMPORT FGL ClientManagerform_uidialogdata
IMPORT FGL ClientManagerform_uidialog
{<POINT Name="import">} {</POINT>}

--------------------------------------------------------------------------------
--Database schema
SCHEMA consultcompanion

--------------------------------------------------------------------------------
--Definition of constants, user-types, variables
{<POINT Name="define">} {</POINT>}

--------------------------------------------------------------------------------
--Functions
{<BLOCK Name="fct.uiOpenForm">}
#+ Launch the module according to the open mode
#+
#+ @param p_whereRelation   Part of the WHERE clause defined by entity relations in the BA
#+ @param p_uiSettings      UI Settings defined on the relation
PUBLIC FUNCTION ClientManagerform_ui_uiOpenForm(p_whereRelation, p_uiSettings)
    DEFINE p_whereRelation STRING
    DEFINE p_uiSettings UISettings_Type
    DEFINE errNo INTEGER
    DEFINE actionNo SMALLINT
    DEFINE l_record1_br_uk record1_br_uk_type
    {<POINT Name="fct.uiOpenForm.define">} {</POINT>}

    INITIALIZE l_record1_br_uk.* TO NULL
    {<POINT Name="fct.uiOpenForm.init">} {</POINT>}

    CALL ClientManagerform_ui_uiOpenFormByKey(p_whereRelation, p_uiSettings.*, l_record1_br_uk.*) RETURNING errNo, actionNo, l_record1_br_uk.*

    {<POINT Name="fct.uiOpenForm.user">} {</POINT>}
    RETURN errNo, actionNo
END FUNCTION
{</BLOCK>} --fct.uiOpenForm

{<BLOCK Name="fct.uiOpenFormByKey">}
#+ Launch the module according to the open mode and position to the key
#+
#+ @param p_whereRelation   Part of the WHERE clause defined by entity relations in the BA
#+ @param p_uiSettings      UI Settings defined on the relation
#+ @param p_br_uk           Key used for position
PUBLIC FUNCTION ClientManagerform_ui_uiOpenFormByKey(p_whereRelation, p_uiSettings, p_br_uk)
    DEFINE p_whereRelation STRING
    DEFINE p_uiSettings UISettings_Type
    DEFINE p_br_uk record1_br_uk_type
    DEFINE errNo INTEGER
    DEFINE actionNo SMALLINT
    DEFINE l_record1_br_uk record1_br_uk_type
    DEFINE l_defaultUISettings UISettings_Type
    DEFINE l_actionList DYNAMIC ARRAY OF STRING
    DEFINE l_windowStyle STRING
    DEFINE l_toolbar STRING
    DEFINE l_topmenu STRING
    DEFINE w ui.Window
    {<POINT Name="fct.uiOpenFormByKey.define">} {</POINT>}

    OPEN WINDOW w_ClientManagerform WITH FORM 'ClientManagerform' ATTRIBUTES(STYLE=NVL(l_windowStyle, "main_dbapp"))
    --Initialize UI settings with default form UI settings
    CALL ClientManagerform_ui_initializeDefaultUISettings() RETURNING l_defaultUISettings.*
    -- Update UI settings with Relation UI settings
    CALL libdbapp_mergeUISettings(p_uiSettings.*, l_defaultUISettings.*) RETURNING m_uiSettings.*
    --Initialize UI
    LET w = ui.Window.getCurrent()

    CALL ClientManagerform_events.registerDlgEvents()
    CALL consultcompanion_events.registerDbxEvents()

    --Load actions in the ToolBar and the TopMenu
    IF NOT libdbapp_isMobile() THEN
        CALL ClientManagerform_ui_uiInitializeDefaultActions(l_actionList)
        CALL libdbapp_utilInitToolBar(NVL(l_toolbar, "dbapp"), w, l_actionList)
        CALL libdbapp_utilInitTopMenu(NVL(l_topmenu, "dbapp"), w, l_actionList)
    END IF

    --Define the list of 'detail' records defined by entity relations in the BA
    INITIALIZE m_detailList TO NULL
    --Define the part of the WHERE clause defined by entity relations in the BA
    LET m_whereRelation = IIF(p_whereRelation IS NULL, ' 1=1', p_whereRelation)
    LET m_where = ' WHERE      ' || m_whereRelation
    --Initialize index(es) of keys array(s)
    LET m_record1_keyIndex = 0
    {<POINT Name="fct.uiOpenFormByKey.init">} {</POINT>}
    IF ClientManagerform_events.m_DlgEvent_OnOpenForm IS NOT NULL THEN
        CALL ClientManagerform_events.m_DlgEvent_OnOpenForm(w.getForm())
    END IF

    --Fetch keys and data according to open mode
    IF m_uiSettings.openMode != C_MODE_SEARCH AND m_uiSettings.openMode != C_MODE_EMPTY THEN
        CALL ClientManagerform_uidialogdata_record1_fetchAll(m_where, m_detailList)
        LET m_record1_keyIndex = ClientManagerform_uidialogdata_record1_seek(p_br_uk.*)
    END IF
    --Call the UI automaton
    CALL ClientManagerform_ui_uiAutomaton(m_uiSettings.*) RETURNING errNo, actionNo
    INITIALIZE l_record1_br_uk.* TO NULL
    IF m_record1_keyIndex > 0 THEN
        LET l_record1_br_uk.clients_clientid = m_record1_arrRecList[m_record1_keyIndex].clients_clientid
    END IF
    CLOSE WINDOW w_ClientManagerform

    {<POINT Name="fct.uiOpenFormByKey.user">} {</POINT>}
    RETURN errNo, actionNo, l_record1_br_uk.*
END FUNCTION
{</BLOCK>} --fct.uiOpenFormByKey

{<BLOCK Name="fct.uiAutomaton">}
#+ Application State Manager
#+ Automation based on UI settings and performed actions
#+
#+ @param p_uiSettings The merged UI settings - UI settings defined on the Relation overwrites the one defined on the form
PRIVATE FUNCTION ClientManagerform_ui_uiAutomaton(p_uiSettings)
    DEFINE p_uiSettings UISettings_Type
    DEFINE l_state SMALLINT
    DEFINE errNo INTEGER
    DEFINE actionNo SMALLINT
    DEFINE prevState SMALLINT
    DEFINE prevAction SMALLINT
    DEFINE nextState SMALLINT
    DEFINE runningAutomaton BOOLEAN
    {<POINT Name="fct.uiAutomaton.define">} {</POINT>}

    --Initialize automaton
    LET l_state = p_uiSettings.openMode
    LET prevState = C_MODE_UNDEFINED
    LET prevAction = C_ACTION_UNDEFINED
    IF l_state == C_MODE_ADD THEN
        LET prevAction = C_ACTION_NEW
    END IF
    LET runningAutomaton = TRUE
    {<POINT Name="fct.uiAutomaton.init">} {</POINT>}

    WHILE runningAutomaton
        CASE l_state
            {<POINT Name="fct.uiAutomaton.userStates">} {</POINT>}
            WHEN C_MODE_DISPLAY
                {<POINT Name="fct.uiAutomaton.beforeDisplay">} {</POINT>}
                CALL ClientManagerform_ui_uiDisplay(prevState, prevAction, l_state) RETURNING errNo, actionNo
                LET nextState = libdbapp_getNextTransition(actionNo, C_MODE_DISPLAY, p_uiSettings.defaultMode, prevState, p_uiSettings.transitions)
                {<POINT Name="fct.uiAutomaton.afterDisplay">} {</POINT>}
            WHEN C_MODE_MODIFY
                {<POINT Name="fct.uiAutomaton.beforeModify">} {</POINT>}
                CALL ClientManagerform_ui_uiInput(prevState, prevAction, l_state) RETURNING errNo, actionNo
                LET nextState = libdbapp_getNextTransition(actionNo, C_MODE_MODIFY, p_uiSettings.defaultMode, prevState, p_uiSettings.transitions)
                {<POINT Name="fct.uiAutomaton.afterModify">} {</POINT>}
            WHEN C_MODE_ADD
                {<POINT Name="fct.uiAutomaton.beforeAdd">} {</POINT>}
                CALL ClientManagerform_ui_uiInput(prevState, prevAction, l_state) RETURNING errNo, actionNo
                LET nextState = libdbapp_getNextTransition(actionNo, C_MODE_ADD, p_uiSettings.defaultMode, prevState, p_uiSettings.transitions)
                {<POINT Name="fct.uiAutomaton.afterAdd">} {</POINT>}
            WHEN C_MODE_SEARCH
                {<POINT Name="fct.uiAutomaton.beforeSearch">} {</POINT>}
                CALL ClientManagerform_ui_uiConstruct(prevState, prevAction, l_state) RETURNING errNo, actionNo
                LET nextState = libdbapp_getNextTransition(actionNo, C_MODE_SEARCH, p_uiSettings.defaultMode, prevState, p_uiSettings.transitions)
                {<POINT Name="fct.uiAutomaton.afterSearch">} {</POINT>}
            WHEN C_MODE_EMPTY
                {<POINT Name="fct.uiAutomaton.beforeEmpty">} {</POINT>}
                CALL ClientManagerform_ui_uiEmpty(prevState, prevAction, l_state) RETURNING errNo, actionNo
                LET nextState = libdbapp_getNextTransition(actionNo, C_MODE_EMPTY, p_uiSettings.defaultMode, prevState, p_uiSettings.transitions)
                {<POINT Name="fct.uiAutomaton.afterEmpty">} {</POINT>}
            WHEN C_MODE_EXIT_FORM
                {<POINT Name="fct.uiAutomaton.beforeExitForm">} {</POINT>}
                LET runningAutomaton = FALSE
                {<POINT Name="fct.uiAutomaton.afterExitForm">} {</POINT>}
            WHEN C_MODE_EXIT_APP
                {<POINT Name="fct.uiAutomaton.beforeExitApp">} {</POINT>}
                LET actionNo = C_ACTION_EXIT_APP
                LET runningAutomaton = FALSE
                {<POINT Name="fct.uiAutomaton.afterExitApp">} {</POINT>}
            OTHERWISE
                {<POINT Name="fct.uiAutomaton.beforeOtherwise">} {</POINT>}
                LET runningAutomaton = FALSE
                {<POINT Name="fct.uiAutomaton.afterOtherwise">} {</POINT>}
        END CASE
        {<POINT Name="fct.uiAutomaton.afterState">} {</POINT>}
        LET prevState = l_state
        LET prevAction = actionNo
        LET l_state = nextState
    END WHILE
    RETURN errNo, actionNo
END FUNCTION
{</BLOCK>} --fct.uiAutomaton

{<BLOCK Name="fct.uiDisplay">}
#+ DIALOG statement function for full DISPLAY mode
#+
#+ @param p_prevState  The state from which the function was invoked
#+ @param p_prevAction The action from which the function was invoked
#+ @param p_state      The current automaton state
#+
#+ @returnType         INTEGER, SMALLINT
#+ @return             Error number, 0-success, other-error
#+ @return             The next performed action
FUNCTION ClientManagerform_ui_uiDisplay(p_prevState, p_prevAction, p_state)
    DEFINE p_prevState SMALLINT
    DEFINE p_prevAction SMALLINT
    DEFINE p_state SMALLINT
    DEFINE errNo INTEGER

    {<POINT Name="fct.uiDisplay.define">} {</POINT>}

    INITIALIZE m_copy_record1.* TO NULL
    LET errNo = ERROR_SUCCESS
    LET m_prevAction = p_prevAction
    LET m_state = p_state
    LET m_actionNo = C_ACTION_EXIT_FORM
    {<POINT Name="fct.uiDisplay.init">} {</POINT>}

    DIALOG ATTRIBUTES(UNBUFFERED, FIELD ORDER FORM)
        SUBDIALOG ClientManagerform_uidialog.ClientManagerform_uidialog_record1_uiDisplay

        ON ACTION new
            {<POINT Name="fct.uiDisplay.dlg.onAction.new">} {</POINT>}
            LET m_actionNo = C_ACTION_NEW

            LET ClientManagerform_events.m_DlgCtrlInstruction = libdbappEvents.ACCEPT_DIALOG
            IF ClientManagerform_events.m_DlgEvent_OnActionNew IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_OnActionNew(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction)
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

        ON ACTION query
            {<POINT Name="fct.uiDisplay.dlg.onAction.query">} {</POINT>}
            LET m_actionNo = C_ACTION_QUERY

            LET ClientManagerform_events.m_DlgCtrlInstruction = libdbappEvents.ACCEPT_DIALOG
            IF ClientManagerform_events.m_DlgEvent_OnActionQuery IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_OnActionQuery(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction)
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

        ON ACTION accept
            {<POINT Name="fct.uiDisplay.dlg.onAction.accept">} {</POINT>}
            LET m_actionNo = C_ACTION_ACCEPT

            LET ClientManagerform_events.m_DlgCtrlInstruction = libdbappEvents.ACCEPT_DIALOG
            IF ClientManagerform_events.m_DlgEvent_OnActionAccept IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_OnActionAccept(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction)
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

        ON ACTION cancel
            {<POINT Name="fct.uiDisplay.dlg.onAction.cancel">} {</POINT>}
            LET m_actionNo = C_ACTION_CANCEL

            LET ClientManagerform_events.m_DlgCtrlInstruction = libdbappEvents.EXIT_DIALOG
            IF ClientManagerform_events.m_DlgEvent_OnActionCancel IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_OnActionCancel(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction)
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

        ON ACTION close
            {<POINT Name="fct.uiDisplay.dlg.onAction.close">} {</POINT>}
            LET m_actionNo = C_ACTION_CLOSE

            LET ClientManagerform_events.m_DlgCtrlInstruction = libdbappEvents.EXIT_DIALOG
            IF ClientManagerform_events.m_DlgEvent_OnActionClose IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_OnActionClose(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction)
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

        ON ACTION exit
            {<POINT Name="fct.uiDisplay.dlg.onAction.exit">} {</POINT>}
            LET m_actionNo = C_ACTION_EXIT_FORM

            LET ClientManagerform_events.m_DlgCtrlInstruction = libdbappEvents.EXIT_DIALOG
            IF ClientManagerform_events.m_DlgEvent_OnActionExit IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_OnActionExit(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction)
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

        BEFORE DIALOG
            {<POINT Name="fct.uiDisplay.dlg.beforeDialog">} {</POINT>}
            IF libdbapp_isMobile() THEN
                CALL DIALOG.setActionActive('exit', FALSE)
                CALL DIALOG.setActionHidden('exit', TRUE)
            END IF
            IF NOT libdbapp_isMobile() THEN
                MESSAGE "" --Clear the status bar (For example to clean DVM validation messages that have been displayed in a previous DIALOG)
            END IF
            LET m_dataProcessing = FALSE

            LET ClientManagerform_events.m_DlgCtrlInstruction = libdbappEvents.CONTINUE_DIALOG
            IF ClientManagerform_events.m_DlgEvent_Before_BrowseDialog IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_Before_BrowseDialog(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction, m_NextField)
                    RETURNING ClientManagerform_events.m_DlgCtrlInstruction, m_NextField
            END IF

            CASE ClientManagerform_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    ACCEPT DIALOG
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
            END CASE

        AFTER DIALOG
            INITIALIZE ClientManagerform_events.m_DlgCtrlInstruction TO NULL
            IF ClientManagerform_events.m_DlgEvent_After_BrowseDialog IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_After_BrowseDialog(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction)
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

        {<POINT Name="fct.uiDisplay.dlg.userControlBlocks">} {</POINT>}
    END DIALOG
    RETURN errNo, m_actionNo
END FUNCTION
{</BLOCK>} --fct.uiDisplay

{<BLOCK Name="fct.uiInput">}
#+ DIALOG for the MODIFY|ADD modes
#+
#+ @param p_prevState  The state from which the function was invoked
#+ @param p_prevAction The action from which the function was invoked
#+ @param p_state      The current automaton state
#+
#+ @returnType       INTEGER, SMALLINT
#+ @return           Error number, 0-success, other-error
#+ @return           The next performed action
FUNCTION ClientManagerform_ui_uiInput(p_prevState, p_prevAction, p_state)
    DEFINE p_prevState SMALLINT
    DEFINE p_prevAction SMALLINT
    DEFINE p_state SMALLINT
    DEFINE l_internalAction SMALLINT
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    DEFINE actionNo SMALLINT

    DEFINE l_br_uk_zm_provinces RECORD
        clients_provinceid LIKE clients.provinceid
    END RECORD
    DEFINE l_br_uk_zm_payterm RECORD
        clients_paytermid LIKE clients.paytermid
    END RECORD
    DEFINE l_br_uk_zm_clienttype RECORD
        clients_clienttypeid LIKE clients.clienttypeid
    END RECORD
    DEFINE l_br_uk_zm_country RECORD
        clients_countryid LIKE clients.countryid
    END RECORD
    {<POINT Name="fct.uiInput.define">} {</POINT>}

    INITIALIZE m_copy_record1.* TO NULL
    LET errNo = ERROR_SUCCESS
    LET m_prevAction = p_prevAction
    LET m_state = p_state
    LET m_actionNo = C_ACTION_EXIT_FORM
    {<POINT Name="fct.uiInput.init">} {</POINT>}
    DIALOG ATTRIBUTES(UNBUFFERED, FIELD ORDER FORM)
        SUBDIALOG ClientManagerform_uidialog.ClientManagerform_uidialog_record1_uiInput

        ON ACTION zm_provinces
            {<POINT Name="fct.uiInput.dlg.onAction.zm_provinces">} {</POINT>}
            CALL ClientManagerform_ui_action_zm_provinces() RETURNING errNo, actionNo, l_br_uk_zm_provinces.*
            IF errNo == ERROR_SUCCESS THEN
                IF actionNo == C_ACTION_EXIT_APP THEN --Exit Application was raised on the zoom, then the application should be closed without handle the return value of the zoom
                    LET m_actionNo = C_ACTION_EXIT_APP
                    LET m_dataProcessing = TRUE
                    ACCEPT DIALOG
                END IF
                IF actionNo == C_ACTION_ACCEPT THEN --Handle the return value of the zoom
                    IF m_record1_arrRecList.getLength() > 0 THEN
                        IF (m_record1_arrRecList[DIALOG.getCurrentRow("record1")].clients_provinceid IS NULL) OR (m_record1_arrRecList[DIALOG.getCurrentRow("record1")].clients_provinceid != l_br_uk_zm_provinces.clients_provinceid) THEN
                            CALL DIALOG.setFieldTouched("record1.provinceid", TRUE)
                            LET m_record1_arrRecList[DIALOG.getCurrentRow("record1")].clients_provinceid = l_br_uk_zm_provinces.clients_provinceid
                            --The 'NEXT FIELD CURRENT' is done to trigger existing 'ON CHANGE'.
                            --Especially in the following case:
                            --  - The value of the field is 'A'
                            --  - Select a value 'B' using the ZOOM functionality
                            --  - On the return of the zoom, the _runUpdates function is executed, the focus is in the field
                            --  - Remain in the field and input again the value 'A'
                            --  - Leave the field
                            NEXT FIELD CURRENT
                        END IF
                    END IF
                END IF
            ELSE
                MESSAGE "Error on the zoom"
            END IF
        ON ACTION zm_payterm
            {<POINT Name="fct.uiInput.dlg.onAction.zm_payterm">} {</POINT>}
            CALL ClientManagerform_ui_action_zm_payterm() RETURNING errNo, actionNo, l_br_uk_zm_payterm.*
            IF errNo == ERROR_SUCCESS THEN
                IF actionNo == C_ACTION_EXIT_APP THEN --Exit Application was raised on the zoom, then the application should be closed without handle the return value of the zoom
                    LET m_actionNo = C_ACTION_EXIT_APP
                    LET m_dataProcessing = TRUE
                    ACCEPT DIALOG
                END IF
                IF actionNo == C_ACTION_ACCEPT THEN --Handle the return value of the zoom
                    IF m_record1_arrRecList.getLength() > 0 THEN
                        IF (m_record1_arrRecList[DIALOG.getCurrentRow("record1")].clients_paytermid IS NULL) OR (m_record1_arrRecList[DIALOG.getCurrentRow("record1")].clients_paytermid != l_br_uk_zm_payterm.clients_paytermid) THEN
                            CALL DIALOG.setFieldTouched("record1.paytermid", TRUE)
                            LET m_record1_arrRecList[DIALOG.getCurrentRow("record1")].clients_paytermid = l_br_uk_zm_payterm.clients_paytermid
                            --The 'NEXT FIELD CURRENT' is done to trigger existing 'ON CHANGE'.
                            --Especially in the following case:
                            --  - The value of the field is 'A'
                            --  - Select a value 'B' using the ZOOM functionality
                            --  - On the return of the zoom, the _runUpdates function is executed, the focus is in the field
                            --  - Remain in the field and input again the value 'A'
                            --  - Leave the field
                            NEXT FIELD CURRENT
                        END IF
                    END IF
                END IF
            ELSE
                MESSAGE "Error on the zoom"
            END IF
        ON ACTION zm_clienttype
            {<POINT Name="fct.uiInput.dlg.onAction.zm_clienttype">} {</POINT>}
            CALL ClientManagerform_ui_action_zm_clienttype() RETURNING errNo, actionNo, l_br_uk_zm_clienttype.*
            IF errNo == ERROR_SUCCESS THEN
                IF actionNo == C_ACTION_EXIT_APP THEN --Exit Application was raised on the zoom, then the application should be closed without handle the return value of the zoom
                    LET m_actionNo = C_ACTION_EXIT_APP
                    LET m_dataProcessing = TRUE
                    ACCEPT DIALOG
                END IF
                IF actionNo == C_ACTION_ACCEPT THEN --Handle the return value of the zoom
                    IF m_record1_arrRecList.getLength() > 0 THEN
                        IF (m_record1_arrRecList[DIALOG.getCurrentRow("record1")].clients_clienttypeid IS NULL) OR (m_record1_arrRecList[DIALOG.getCurrentRow("record1")].clients_clienttypeid != l_br_uk_zm_clienttype.clients_clienttypeid) THEN
                            CALL DIALOG.setFieldTouched("record1.clienttypeid", TRUE)
                            LET m_record1_arrRecList[DIALOG.getCurrentRow("record1")].clients_clienttypeid = l_br_uk_zm_clienttype.clients_clienttypeid
                            --The 'NEXT FIELD CURRENT' is done to trigger existing 'ON CHANGE'.
                            --Especially in the following case:
                            --  - The value of the field is 'A'
                            --  - Select a value 'B' using the ZOOM functionality
                            --  - On the return of the zoom, the _runUpdates function is executed, the focus is in the field
                            --  - Remain in the field and input again the value 'A'
                            --  - Leave the field
                            NEXT FIELD CURRENT
                        END IF
                    END IF
                END IF
            ELSE
                MESSAGE "Error on the zoom"
            END IF
        ON ACTION zm_country
            {<POINT Name="fct.uiInput.dlg.onAction.zm_country">} {</POINT>}
            CALL ClientManagerform_ui_action_zm_country() RETURNING errNo, actionNo, l_br_uk_zm_country.*
            IF errNo == ERROR_SUCCESS THEN
                IF actionNo == C_ACTION_EXIT_APP THEN --Exit Application was raised on the zoom, then the application should be closed without handle the return value of the zoom
                    LET m_actionNo = C_ACTION_EXIT_APP
                    LET m_dataProcessing = TRUE
                    ACCEPT DIALOG
                END IF
                IF actionNo == C_ACTION_ACCEPT THEN --Handle the return value of the zoom
                    IF m_record1_arrRecList.getLength() > 0 THEN
                        IF (m_record1_arrRecList[DIALOG.getCurrentRow("record1")].clients_countryid IS NULL) OR (m_record1_arrRecList[DIALOG.getCurrentRow("record1")].clients_countryid != l_br_uk_zm_country.clients_countryid) THEN
                            CALL DIALOG.setFieldTouched("record1.countryid", TRUE)
                            LET m_record1_arrRecList[DIALOG.getCurrentRow("record1")].clients_countryid = l_br_uk_zm_country.clients_countryid
                            --The 'NEXT FIELD CURRENT' is done to trigger existing 'ON CHANGE'.
                            --Especially in the following case:
                            --  - The value of the field is 'A'
                            --  - Select a value 'B' using the ZOOM functionality
                            --  - On the return of the zoom, the _runUpdates function is executed, the focus is in the field
                            --  - Remain in the field and input again the value 'A'
                            --  - Leave the field
                            NEXT FIELD CURRENT
                        END IF
                    END IF
                END IF
            ELSE
                MESSAGE "Error on the zoom"
            END IF
        ON ACTION zoom
            {<POINT Name="fct.uiInput.dlg.onAction.zoom">} {</POINT>}
            IF INFIELD(record1.provinceid) THEN
                CALL ClientManagerform_ui_action_zm_provinces() RETURNING errNo, actionNo, l_br_uk_zm_provinces.*
                IF errNo == ERROR_SUCCESS THEN
                    IF actionNo == C_ACTION_EXIT_APP THEN --Exit Application was raised on the zoom, then the application should be closed without handle the return value of the zoom
                        LET m_actionNo = C_ACTION_EXIT_APP
                        LET m_dataProcessing = TRUE
                        ACCEPT DIALOG
                    END IF
                    IF actionNo == C_ACTION_ACCEPT THEN --Handle the return value of the zoom
                        IF m_record1_arrRecList.getLength() > 0 THEN
                            IF (m_record1_arrRecList[DIALOG.getCurrentRow("record1")].clients_provinceid IS NULL) OR (m_record1_arrRecList[DIALOG.getCurrentRow("record1")].clients_provinceid != l_br_uk_zm_provinces.clients_provinceid) THEN
                                CALL DIALOG.setFieldTouched("record1.provinceid", TRUE)
                                LET m_record1_arrRecList[DIALOG.getCurrentRow("record1")].clients_provinceid = l_br_uk_zm_provinces.clients_provinceid
                                --The 'NEXT FIELD CURRENT' is done to trigger existing 'ON CHANGE'.
                                --Especially in the following case:
                                --  - The value of the field is 'A'
                                --  - Select a value 'B' using the ZOOM functionality
                                --  - On the return of the zoom, the _runUpdates function is executed, the focus is in the field
                                --  - Remain in the field and input again the value 'A'
                                --  - Leave the field
                                NEXT FIELD CURRENT
                            END IF
                        END IF
                    END IF
                ELSE
                    MESSAGE "Error on the zoom"
                END IF
            END IF
            IF INFIELD(record1.paytermid) THEN
                CALL ClientManagerform_ui_action_zm_payterm() RETURNING errNo, actionNo, l_br_uk_zm_payterm.*
                IF errNo == ERROR_SUCCESS THEN
                    IF actionNo == C_ACTION_EXIT_APP THEN --Exit Application was raised on the zoom, then the application should be closed without handle the return value of the zoom
                        LET m_actionNo = C_ACTION_EXIT_APP
                        LET m_dataProcessing = TRUE
                        ACCEPT DIALOG
                    END IF
                    IF actionNo == C_ACTION_ACCEPT THEN --Handle the return value of the zoom
                        IF m_record1_arrRecList.getLength() > 0 THEN
                            IF (m_record1_arrRecList[DIALOG.getCurrentRow("record1")].clients_paytermid IS NULL) OR (m_record1_arrRecList[DIALOG.getCurrentRow("record1")].clients_paytermid != l_br_uk_zm_payterm.clients_paytermid) THEN
                                CALL DIALOG.setFieldTouched("record1.paytermid", TRUE)
                                LET m_record1_arrRecList[DIALOG.getCurrentRow("record1")].clients_paytermid = l_br_uk_zm_payterm.clients_paytermid
                                --The 'NEXT FIELD CURRENT' is done to trigger existing 'ON CHANGE'.
                                --Especially in the following case:
                                --  - The value of the field is 'A'
                                --  - Select a value 'B' using the ZOOM functionality
                                --  - On the return of the zoom, the _runUpdates function is executed, the focus is in the field
                                --  - Remain in the field and input again the value 'A'
                                --  - Leave the field
                                NEXT FIELD CURRENT
                            END IF
                        END IF
                    END IF
                ELSE
                    MESSAGE "Error on the zoom"
                END IF
            END IF
            IF INFIELD(record1.clienttypeid) THEN
                CALL ClientManagerform_ui_action_zm_clienttype() RETURNING errNo, actionNo, l_br_uk_zm_clienttype.*
                IF errNo == ERROR_SUCCESS THEN
                    IF actionNo == C_ACTION_EXIT_APP THEN --Exit Application was raised on the zoom, then the application should be closed without handle the return value of the zoom
                        LET m_actionNo = C_ACTION_EXIT_APP
                        LET m_dataProcessing = TRUE
                        ACCEPT DIALOG
                    END IF
                    IF actionNo == C_ACTION_ACCEPT THEN --Handle the return value of the zoom
                        IF m_record1_arrRecList.getLength() > 0 THEN
                            IF (m_record1_arrRecList[DIALOG.getCurrentRow("record1")].clients_clienttypeid IS NULL) OR (m_record1_arrRecList[DIALOG.getCurrentRow("record1")].clients_clienttypeid != l_br_uk_zm_clienttype.clients_clienttypeid) THEN
                                CALL DIALOG.setFieldTouched("record1.clienttypeid", TRUE)
                                LET m_record1_arrRecList[DIALOG.getCurrentRow("record1")].clients_clienttypeid = l_br_uk_zm_clienttype.clients_clienttypeid
                                --The 'NEXT FIELD CURRENT' is done to trigger existing 'ON CHANGE'.
                                --Especially in the following case:
                                --  - The value of the field is 'A'
                                --  - Select a value 'B' using the ZOOM functionality
                                --  - On the return of the zoom, the _runUpdates function is executed, the focus is in the field
                                --  - Remain in the field and input again the value 'A'
                                --  - Leave the field
                                NEXT FIELD CURRENT
                            END IF
                        END IF
                    END IF
                ELSE
                    MESSAGE "Error on the zoom"
                END IF
            END IF
            IF INFIELD(record1.countryid) THEN
                CALL ClientManagerform_ui_action_zm_country() RETURNING errNo, actionNo, l_br_uk_zm_country.*
                IF errNo == ERROR_SUCCESS THEN
                    IF actionNo == C_ACTION_EXIT_APP THEN --Exit Application was raised on the zoom, then the application should be closed without handle the return value of the zoom
                        LET m_actionNo = C_ACTION_EXIT_APP
                        LET m_dataProcessing = TRUE
                        ACCEPT DIALOG
                    END IF
                    IF actionNo == C_ACTION_ACCEPT THEN --Handle the return value of the zoom
                        IF m_record1_arrRecList.getLength() > 0 THEN
                            IF (m_record1_arrRecList[DIALOG.getCurrentRow("record1")].clients_countryid IS NULL) OR (m_record1_arrRecList[DIALOG.getCurrentRow("record1")].clients_countryid != l_br_uk_zm_country.clients_countryid) THEN
                                CALL DIALOG.setFieldTouched("record1.countryid", TRUE)
                                LET m_record1_arrRecList[DIALOG.getCurrentRow("record1")].clients_countryid = l_br_uk_zm_country.clients_countryid
                                --The 'NEXT FIELD CURRENT' is done to trigger existing 'ON CHANGE'.
                                --Especially in the following case:
                                --  - The value of the field is 'A'
                                --  - Select a value 'B' using the ZOOM functionality
                                --  - On the return of the zoom, the _runUpdates function is executed, the focus is in the field
                                --  - Remain in the field and input again the value 'A'
                                --  - Leave the field
                                NEXT FIELD CURRENT
                            END IF
                        END IF
                    END IF
                ELSE
                    MESSAGE "Error on the zoom"
                END IF
            END IF

        ON ACTION new
            {<POINT Name="fct.uiInput.dlg.onAction.new">} {</POINT>}
            LET m_actionNo = C_ACTION_NEW
            LET m_dataProcessing = TRUE
            ACCEPT DIALOG

            LET ClientManagerform_events.m_DlgCtrlInstruction = libdbappEvents.ACCEPT_DIALOG
            IF ClientManagerform_events.m_DlgEvent_OnActionNew IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_OnActionNew(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction)
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

        ON ACTION query
            {<POINT Name="fct.uiInput.dlg.onAction.query">} {</POINT>}
            LET m_actionNo = C_ACTION_QUERY
            IF m_state == C_MODE_ADD THEN
                IF NOT DIALOG.getFieldTouched("*") THEN
                    EXIT DIALOG
                END IF
            END IF
            LET m_dataProcessing = TRUE

            LET ClientManagerform_events.m_DlgCtrlInstruction = libdbappEvents.ACCEPT_DIALOG
            IF ClientManagerform_events.m_DlgEvent_OnActionQuery IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_OnActionQuery(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction)
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

        ON ACTION accept
            {<POINT Name="fct.uiInput.dlg.onAction.accept">} {</POINT>}
            LET m_actionNo = C_ACTION_ACCEPT
            LET m_dataProcessing = TRUE

            LET ClientManagerform_events.m_DlgCtrlInstruction = libdbappEvents.ACCEPT_DIALOG
            IF ClientManagerform_events.m_DlgEvent_OnActionAccept IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_OnActionAccept(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction)
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

        ON ACTION cancel
            {<POINT Name="fct.uiInput.dlg.onAction.cancel">} {</POINT>}
            CALL ClientManagerform_ui_validateCRUDOperationWrapper(DIALOG, m_subdialog, m_state, C_ACTION_CANCEL)
                RETURNING l_internalAction
            CASE l_internalAction
                WHEN C_INTERNAL_ACTION_NEXT_FIELD_CURRENT
                    LET m_dataProcessing = FALSE
                    CONTINUE DIALOG
                WHEN C_INTERNAL_EXIT_DIALOG
                    EXIT DIALOG
            END CASE
            LET m_actionNo = C_ACTION_CANCEL

            LET ClientManagerform_events.m_DlgCtrlInstruction = libdbappEvents.EXIT_DIALOG
            IF ClientManagerform_events.m_DlgEvent_OnActionCancel IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_OnActionCancel(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction)
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

        ON ACTION close
            {<POINT Name="fct.uiInput.dlg.onAction.close">} {</POINT>}
            LET m_actionNo = C_ACTION_CLOSE
            IF m_state == C_MODE_ADD THEN
                IF NOT DIALOG.getFieldTouched("*") THEN
                    EXIT DIALOG
                END IF
            END IF
            LET m_dataProcessing = TRUE

            LET ClientManagerform_events.m_DlgCtrlInstruction = libdbappEvents.ACCEPT_DIALOG
            IF ClientManagerform_events.m_DlgEvent_OnActionClose IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_OnActionClose(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction)
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

        ON ACTION exit
            {<POINT Name="fct.uiInput.dlg.onAction.exit">} {</POINT>}
            LET m_actionNo = C_ACTION_EXIT_FORM
            IF m_state == C_MODE_ADD THEN
                IF NOT DIALOG.getFieldTouched("*") THEN
                    EXIT DIALOG
                END IF
            END IF
            LET m_dataProcessing = TRUE
            LET ClientManagerform_events.m_DlgCtrlInstruction = libdbappEvents.ACCEPT_DIALOG
            IF ClientManagerform_events.m_DlgEvent_OnActionExit IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_OnActionExit(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction)
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

        BEFORE DIALOG
            {<POINT Name="fct.uiInput.dlg.beforeDialog">} {</POINT>}
            IF NOT libdbapp_isMobile() THEN
                MESSAGE "" --Clear the status bar (For example to clean DVM validation messages that have been displayed in a previous DIALOG)
            END IF
            LET m_dataProcessing = FALSE
            LET initializeUI = TRUE
            IF libdbapp_isMobile() THEN
                CALL DIALOG.setActionActive('exit', FALSE)
                CALL DIALOG.setActionHidden('exit', TRUE)
            END IF
            CALL DIALOG.setActionActive('zoom', FALSE)
            IF libdbapp_isMobile() THEN
                CALL DIALOG.setActionHidden('zoom', TRUE)
            END IF

        AFTER DIALOG
            INITIALIZE ClientManagerform_events.m_DlgCtrlInstruction TO NULL
            IF ClientManagerform_events.m_DlgEvent_After_EditDialog IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_After_EditDialog(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction)
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

        {<POINT Name="fct.uiInput.dlg.userControlBlocks">} {</POINT>}
    END DIALOG
    RETURN errNo, m_actionNo
END FUNCTION
{</BLOCK>} --fct.uiInput

{<BLOCK Name="fct.uiConstruct">}
#+ DIALOG statement function for full CONSTRUCT mode
#+
#+ @param p_prevState  The state from which the function was invoked
#+ @param p_prevAction The action from which the function was invoked
#+ @param p_state      The current automaton state
#+
#+ @returnType         INTEGER, SMALLINT
#+ @return             Error number, 0-success, other-error
#+ @return             The next performed action
FUNCTION ClientManagerform_ui_uiConstruct(p_prevState, p_prevAction, p_state)
    DEFINE p_prevState SMALLINT
    DEFINE p_prevAction SMALLINT
    DEFINE p_state SMALLINT
    DEFINE l_where STRING
    DEFINE l_detailList STRING
    DEFINE errNo INTEGER
    DEFINE actionNo SMALLINT
    DEFINE l_uiSettings UISettings_Type
    DEFINE l_br_uk_zm_provinces RECORD
        clients_provinceid LIKE clients.provinceid
    END RECORD
    DEFINE l_br_uk_zm_payterm RECORD
        clients_paytermid LIKE clients.paytermid
    END RECORD
    DEFINE l_br_uk_zm_clienttype RECORD
        clients_clienttypeid LIKE clients.clienttypeid
    END RECORD
    DEFINE l_br_uk_zm_country RECORD
        clients_countryid LIKE clients.countryid
    END RECORD
    {<POINT Name="fct.uiConstruct.define">} {</POINT>}

    INITIALIZE m_copy_record1.* TO NULL
    LET errNo = ERROR_SUCCESS
    LET m_prevAction = p_prevAction
    LET m_state = p_state
    LET m_actionNo = C_ACTION_EXIT_FORM
    CLEAR FORM
    {<POINT Name="fct.uiConstruct.init">} {</POINT>}

    DIALOG ATTRIBUTES(UNBUFFERED, FIELD ORDER FORM)
        SUBDIALOG ClientManagerform_uidialog.ClientManagerform_uidialog_record1_uiConstruct

        ON ACTION zm_provinces
            {<POINT Name="fct.uiConstruct.dlg.onAction.zm_provinces">} {</POINT>}
            CALL ClientManagerform_ui_action_zm_provinces() RETURNING errNo, actionNo, l_br_uk_zm_provinces.*
            IF errNo == ERROR_SUCCESS THEN
                IF actionNo == C_ACTION_EXIT_APP THEN --Exit Application was raised on the zoom, then the application should be closed without handle the return value of the zoom
                    LET m_actionNo = C_ACTION_EXIT_APP
                    LET m_dataProcessing = TRUE
                    ACCEPT DIALOG
                END IF
                IF actionNo == C_ACTION_ACCEPT THEN --Handle the return value of the zoom
                    DISPLAY l_br_uk_zm_provinces.clients_provinceid TO clients.provinceid
                END IF
            ELSE
                MESSAGE "Error on the zoom"
            END IF
        ON ACTION zm_payterm
            {<POINT Name="fct.uiConstruct.dlg.onAction.zm_payterm">} {</POINT>}
            CALL ClientManagerform_ui_action_zm_payterm() RETURNING errNo, actionNo, l_br_uk_zm_payterm.*
            IF errNo == ERROR_SUCCESS THEN
                IF actionNo == C_ACTION_EXIT_APP THEN --Exit Application was raised on the zoom, then the application should be closed without handle the return value of the zoom
                    LET m_actionNo = C_ACTION_EXIT_APP
                    LET m_dataProcessing = TRUE
                    ACCEPT DIALOG
                END IF
                IF actionNo == C_ACTION_ACCEPT THEN --Handle the return value of the zoom
                    DISPLAY l_br_uk_zm_payterm.clients_paytermid TO clients.paytermid
                END IF
            ELSE
                MESSAGE "Error on the zoom"
            END IF
        ON ACTION zm_clienttype
            {<POINT Name="fct.uiConstruct.dlg.onAction.zm_clienttype">} {</POINT>}
            CALL ClientManagerform_ui_action_zm_clienttype() RETURNING errNo, actionNo, l_br_uk_zm_clienttype.*
            IF errNo == ERROR_SUCCESS THEN
                IF actionNo == C_ACTION_EXIT_APP THEN --Exit Application was raised on the zoom, then the application should be closed without handle the return value of the zoom
                    LET m_actionNo = C_ACTION_EXIT_APP
                    LET m_dataProcessing = TRUE
                    ACCEPT DIALOG
                END IF
                IF actionNo == C_ACTION_ACCEPT THEN --Handle the return value of the zoom
                    DISPLAY l_br_uk_zm_clienttype.clients_clienttypeid TO clients.clienttypeid
                END IF
            ELSE
                MESSAGE "Error on the zoom"
            END IF
        ON ACTION zm_country
            {<POINT Name="fct.uiConstruct.dlg.onAction.zm_country">} {</POINT>}
            CALL ClientManagerform_ui_action_zm_country() RETURNING errNo, actionNo, l_br_uk_zm_country.*
            IF errNo == ERROR_SUCCESS THEN
                IF actionNo == C_ACTION_EXIT_APP THEN --Exit Application was raised on the zoom, then the application should be closed without handle the return value of the zoom
                    LET m_actionNo = C_ACTION_EXIT_APP
                    LET m_dataProcessing = TRUE
                    ACCEPT DIALOG
                END IF
                IF actionNo == C_ACTION_ACCEPT THEN --Handle the return value of the zoom
                    DISPLAY l_br_uk_zm_country.clients_countryid TO clients.countryid
                END IF
            ELSE
                MESSAGE "Error on the zoom"
            END IF
        ON ACTION zoom
            {<POINT Name="fct.uiConstruct.dlg.onAction.zoom">} {</POINT>}
            IF INFIELD(clients.provinceid) THEN
                CALL ClientManagerform_ui_action_zm_provinces() RETURNING errNo, actionNo, l_br_uk_zm_provinces.*
                IF errNo == ERROR_SUCCESS THEN
                    IF actionNo == C_ACTION_EXIT_APP THEN --Exit Application was raised on the zoom, then the application should be closed without handle the return value of the zoom
                        LET m_actionNo = C_ACTION_EXIT_APP
                        LET m_dataProcessing = TRUE
                        ACCEPT DIALOG
                    END IF
                    IF actionNo == C_ACTION_ACCEPT THEN --Handle the return value of the zoom
                        DISPLAY l_br_uk_zm_provinces.clients_provinceid TO clients.provinceid
                    END IF
                ELSE
                    MESSAGE "Error on the zoom"
                END IF
            END IF
            IF INFIELD(clients.paytermid) THEN
                CALL ClientManagerform_ui_action_zm_payterm() RETURNING errNo, actionNo, l_br_uk_zm_payterm.*
                IF errNo == ERROR_SUCCESS THEN
                    IF actionNo == C_ACTION_EXIT_APP THEN --Exit Application was raised on the zoom, then the application should be closed without handle the return value of the zoom
                        LET m_actionNo = C_ACTION_EXIT_APP
                        LET m_dataProcessing = TRUE
                        ACCEPT DIALOG
                    END IF
                    IF actionNo == C_ACTION_ACCEPT THEN --Handle the return value of the zoom
                        DISPLAY l_br_uk_zm_payterm.clients_paytermid TO clients.paytermid
                    END IF
                ELSE
                    MESSAGE "Error on the zoom"
                END IF
            END IF
            IF INFIELD(clients.clienttypeid) THEN
                CALL ClientManagerform_ui_action_zm_clienttype() RETURNING errNo, actionNo, l_br_uk_zm_clienttype.*
                IF errNo == ERROR_SUCCESS THEN
                    IF actionNo == C_ACTION_EXIT_APP THEN --Exit Application was raised on the zoom, then the application should be closed without handle the return value of the zoom
                        LET m_actionNo = C_ACTION_EXIT_APP
                        LET m_dataProcessing = TRUE
                        ACCEPT DIALOG
                    END IF
                    IF actionNo == C_ACTION_ACCEPT THEN --Handle the return value of the zoom
                        DISPLAY l_br_uk_zm_clienttype.clients_clienttypeid TO clients.clienttypeid
                    END IF
                ELSE
                    MESSAGE "Error on the zoom"
                END IF
            END IF
            IF INFIELD(clients.countryid) THEN
                CALL ClientManagerform_ui_action_zm_country() RETURNING errNo, actionNo, l_br_uk_zm_country.*
                IF errNo == ERROR_SUCCESS THEN
                    IF actionNo == C_ACTION_EXIT_APP THEN --Exit Application was raised on the zoom, then the application should be closed without handle the return value of the zoom
                        LET m_actionNo = C_ACTION_EXIT_APP
                        LET m_dataProcessing = TRUE
                        ACCEPT DIALOG
                    END IF
                    IF actionNo == C_ACTION_ACCEPT THEN --Handle the return value of the zoom
                        DISPLAY l_br_uk_zm_country.clients_countryid TO clients.countryid
                    END IF
                ELSE
                    MESSAGE "Error on the zoom"
                END IF
            END IF

        ON ACTION accept
            {<POINT Name="fct.uiConstruct.dlg.onAction.accept">} {</POINT>}
            LET m_actionNo = C_ACTION_ACCEPT

            LET ClientManagerform_events.m_DlgCtrlInstruction = libdbappEvents.ACCEPT_DIALOG
            IF ClientManagerform_events.m_DlgEvent_OnActionAccept IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_OnActionAccept(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction)
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

        ON ACTION cancel
            {<POINT Name="fct.uiConstruct.dlg.onAction.cancel">} {</POINT>}
            LET m_actionNo = C_ACTION_CANCEL

            LET ClientManagerform_events.m_DlgCtrlInstruction = libdbappEvents.EXIT_DIALOG
            IF ClientManagerform_events.m_DlgEvent_OnActionCancel IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_OnActionCancel(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction)
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

        ON ACTION close
            {<POINT Name="fct.uiConstruct.dlg.onAction.close">} {</POINT>}
            LET m_actionNo = C_ACTION_CLOSE

            LET ClientManagerform_events.m_DlgCtrlInstruction = libdbappEvents.EXIT_DIALOG
            IF ClientManagerform_events.m_DlgEvent_OnActionClose IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_OnActionClose(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction)
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

        ON ACTION exit
            {<POINT Name="fct.uiConstruct.dlg.onAction.exit">} {</POINT>}
            LET m_actionNo = C_ACTION_EXIT_FORM

            LET ClientManagerform_events.m_DlgCtrlInstruction = libdbappEvents.EXIT_DIALOG
            IF ClientManagerform_events.m_DlgEvent_OnActionExit IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_OnActionExit(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction)
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

        BEFORE DIALOG
            {<POINT Name="fct.uiConstruct.dlg.beforeDialog">} {</POINT>}
            IF libdbapp_isMobile() THEN
                CALL DIALOG.setActionActive('exit', FALSE)
                CALL DIALOG.setActionHidden('exit', TRUE)
            END IF
            IF NOT libdbapp_isMobile() THEN
                MESSAGE "" --Clear the status bar (For example to clean DVM validation messages that have been displayed in a previous DIALOG)
            END IF
            CALL DIALOG.setActionActive('zoom', FALSE)
            IF libdbapp_isMobile() THEN
                CALL DIALOG.setActionHidden('zoom', TRUE)
            END IF

            INITIALIZE ClientManagerform_events.m_DlgCtrlInstruction TO NULL
            IF ClientManagerform_events.m_DlgEvent_Before_SearchDialog IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_Before_SearchDialog(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction)
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

        AFTER DIALOG
            {<POINT Name="fct.uiConstruct.dlg.afterDialog">} {</POINT>}
            --Build WHERE clause
            LET l_where = ' 1=1'
            LET l_detailList = ''

            IF NOT m_record1_where.equals(' 1=1') THEN
                LET l_where = IIF(l_where.equals(' 1=1'), m_record1_where, l_where || ' and ' || m_record1_where)
            END IF
            IF NOT m_whereRelation.equals(' 1=1') THEN
                LET l_where = IIF(l_where.equals(' 1=1'), m_whereRelation, l_where || ' and ' || m_whereRelation)
            END IF
            LET l_where = ' WHERE      ' || l_where
            --Retrieve data
            LET m_where = l_where
            LET m_detailList = l_detailList

            INITIALIZE ClientManagerform_events.m_DlgCtrlInstruction TO NULL
            IF ClientManagerform_events.m_DlgEvent_After_SearchDialog IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_After_SearchDialog(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction, m_where, m_detailList)
                    RETURNING ClientManagerform_events.m_DlgCtrlInstruction, m_where, m_detailList
            END IF

            CASE ClientManagerform_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    ACCEPT DIALOG
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
            END CASE

            CALL ClientManagerform_uidialogdata_record1_fetchAll(m_where, m_detailList)
            --After the execution of the search, the focus goes to the master record of the form
            LET m_subDialog = "record1"
            CLEAR FORM

        {<POINT Name="fct.uiConstruct.dlg.userControlBlocks">} {</POINT>}
    END DIALOG
    RETURN errNo, m_actionNo
END FUNCTION
{</BLOCK>} --fct.uiConstruct

{<BLOCK Name="fct.uiEmpty">}
#+ MENU statement function for EMPTY mode
#+
#+ @param p_prevState  The state from which the function was invoked
#+ @param p_prevAction The action from which the function was invoked
#+ @param p_state      The current automaton state
#+
#+ @returnType         INTEGER, SMALLINT
#+ @return             Error number, 0-success, other-error
#+ @return             The next performed action
FUNCTION ClientManagerform_ui_uiEmpty(p_prevState, p_prevAction, p_state)
    DEFINE p_prevState SMALLINT
    DEFINE p_prevAction SMALLINT
    DEFINE p_state SMALLINT
    DEFINE errNo INTEGER

    {<POINT Name="fct.uiEmpty.define">} {</POINT>}

    LET m_prevAction = p_prevAction
    LET m_state = p_state
    LET m_actionNo = C_ACTION_EXIT_FORM
    {<POINT Name="fct.uiEmpty.init">} {</POINT>}

    MENU
        BEFORE MENU
            {<POINT Name="fct.uiEmpty.menu.beforeMenu">} {</POINT>}
            IF libdbapp_isMobile() THEN
                CALL DIALOG.setActionActive('new', FALSE)
                CALL DIALOG.setActionHidden('new', TRUE)
                CALL DIALOG.setActionActive('append', NOT m_uiSettings.disableAdd)
                CALL DIALOG.setActionHidden('append', m_uiSettings.disableAdd)
                CALL DIALOG.setActionActive('exit', FALSE)
                CALL DIALOG.setActionHidden('exit', TRUE)
            ELSE
                CALL DIALOG.setActionActive('new', NOT m_uiSettings.disableAdd)
                CALL DIALOG.setActionHidden('new', m_uiSettings.disableAdd)
                CALL DIALOG.setActionActive('append', FALSE)
                CALL DIALOG.setActionHidden('append', TRUE)
            END IF
        INITIALIZE ClientManagerform_events.m_DlgCtrlInstruction TO NULL
        IF ClientManagerform_events.m_DlgEvent_Before_EmptyDialog IS NOT NULL THEN
            CALL ClientManagerform_events.m_DlgEvent_Before_EmptyDialog(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction)
                RETURNING ClientManagerform_events.m_DlgCtrlInstruction
        END IF

        CASE ClientManagerform_events.m_DlgCtrlInstruction
            WHEN libdbappEvents.EXIT_MENU
                EXIT MENU
        END CASE

        ON ACTION new
            {<POINT Name="fct.uiEmpty.menu.onAction.new">} {</POINT>}
            LET m_actionNo = C_ACTION_NEW

            LET ClientManagerform_events.m_DlgCtrlInstruction = libdbappEvents.EXIT_MENU
            IF ClientManagerform_events.m_DlgEvent_OnActionNew IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_OnActionNew(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction)
                    RETURNING ClientManagerform_events.m_DlgCtrlInstruction
            END IF

            CASE ClientManagerform_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.EXIT_MENU
                    EXIT MENU
            END CASE

        ON ACTION append
            {<POINT Name="fct.uiEmpty.menu.onAction.append">} {</POINT>}
            LET m_actionNo = C_ACTION_NEW

            LET ClientManagerform_events.m_DlgCtrlInstruction = libdbappEvents.EXIT_MENU
            IF ClientManagerform_events.m_DlgEvent_OnActionNew IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_OnActionNew(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction)
                    RETURNING ClientManagerform_events.m_DlgCtrlInstruction
            END IF

            CASE ClientManagerform_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.EXIT_MENU
                    EXIT MENU
            END CASE

        ON ACTION query
            {<POINT Name="fct.uiEmpty.menu.onAction.query">} {</POINT>}
            LET m_actionNo = C_ACTION_QUERY

            LET ClientManagerform_events.m_DlgCtrlInstruction = libdbappEvents.EXIT_MENU
            IF ClientManagerform_events.m_DlgEvent_OnActionQuery IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_OnActionQuery(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction)
                    RETURNING ClientManagerform_events.m_DlgCtrlInstruction
            END IF

            CASE ClientManagerform_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.EXIT_MENU
                    EXIT MENU
            END CASE

        ON ACTION close
            {<POINT Name="fct.uiEmpty.menu.onAction.close">} {</POINT>}
            LET m_actionNo = C_ACTION_CLOSE

            LET ClientManagerform_events.m_DlgCtrlInstruction = libdbappEvents.EXIT_MENU
            IF ClientManagerform_events.m_DlgEvent_OnActionClose IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_OnActionClose(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction)
                    RETURNING ClientManagerform_events.m_DlgCtrlInstruction
            END IF

            CASE ClientManagerform_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.EXIT_MENU
                    EXIT MENU
            END CASE

        ON ACTION exit
            {<POINT Name="fct.uiEmpty.menu.onAction.exit">} {</POINT>}
            LET m_actionNo = C_ACTION_EXIT_FORM

            LET ClientManagerform_events.m_DlgCtrlInstruction = libdbappEvents.EXIT_MENU
            IF ClientManagerform_events.m_DlgEvent_OnActionExit IS NOT NULL THEN
                CALL ClientManagerform_events.m_DlgEvent_OnActionExit(DIALOG, m_state, ClientManagerform_events.m_DlgCtrlInstruction)
                    RETURNING ClientManagerform_events.m_DlgCtrlInstruction
            END IF

            CASE ClientManagerform_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.EXIT_MENU
                    EXIT MENU
            END CASE

        {<POINT Name="fct.uiEmpty.menu.userControlBlocks">} {</POINT>}
    END MENU
    RETURN errNo, m_actionNo
END FUNCTION
{</BLOCK>} --fct.uiEmpty

{<BLOCK Name="fct.uiInitializeDefaultActions">}
#+ Initialize the list of default actions
#+
#+ @param p_actionList  a dynamic array of STRING
PUBLIC FUNCTION ClientManagerform_ui_uiInitializeDefaultActions(p_actionList)
    DEFINE p_actionList DYNAMIC ARRAY OF STRING
    CALL p_actionList.clear()
    LET p_actionList[1] = "accept"
    LET p_actionList[2] = "cancel"
    LET p_actionList[3] = "editcut"
    LET p_actionList[4] = "editcopy"
    LET p_actionList[5] = "editpaste"
    LET p_actionList[6] = "firstrow"
    LET p_actionList[7] = "prevrow"
    LET p_actionList[8] = "nextrow"
    LET p_actionList[9] = "lastrow"
    LET p_actionList[10] = "prevpage"
    LET p_actionList[11] = "nextpage"
    LET p_actionList[12] = "exit"
    LET p_actionList[13] = "zoom"
    LET p_actionList[14] = "zm_provinces"
    LET p_actionList[15] = "zm_payterm"
    LET p_actionList[16] = "zm_clienttype"
    LET p_actionList[17] = "zm_country"
    IF NOT m_uiSettings.disableAdd THEN
        LET p_actionList[p_actionList.getLength() + 1] = "new"
        LET p_actionList[p_actionList.getLength() + 1] = "insert"
    END IF
    IF NOT m_uiSettings.disableModify THEN
        LET p_actionList[p_actionList.getLength() + 1] = "update"
    END IF
    IF NOT m_uiSettings.disableDelete THEN
        LET p_actionList[p_actionList.getLength() + 1] = "delete"
    END IF
    IF NOT m_uiSettings.disableSearch THEN
        LET p_actionList[p_actionList.getLength() + 1] = "query"
    END IF
    {<POINT Name="fct.uiInitializeDefaultActions.init">} {</POINT>}
END FUNCTION
{</BLOCK>} --fct.uiInitializeDefaultActions

{<BLOCK Name="fct.initializeDefaultUISettings">}
#+ Initialize the UI settings defined on the form
#+
#+ @returnType UISettings_Type
#+ @return The UI settings defined on the form
PUBLIC FUNCTION ClientManagerform_ui_initializeDefaultUISettings()
    DEFINE l_uiSettings UISettings_Type
    {<POINT Name="fct.initializeDefaultUISettings.define">} {</POINT>}

    LET l_uiSettings.openMode = C_MODE_DISPLAY
    LET l_uiSettings.defaultMode = C_MODE_DISPLAY

    CALL l_uiSettings.transitions.clear()
    LET l_uiSettings.transitions[C_MODE_ADD].onClose = C_TRANSITION_EXIT_FORM
    LET l_uiSettings.transitions[C_MODE_SEARCH].onOk = C_TRANSITION_RETURN_TO_DEFAULT_MODE
    LET l_uiSettings.transitions[C_MODE_DISPLAY].onOk = C_TRANSITION_EXIT_FORM
    LET l_uiSettings.transitions[C_MODE_MODIFY].onOk = C_TRANSITION_RETURN_TO_DEFAULT_MODE
    LET l_uiSettings.transitions[C_MODE_ADD].onOk = C_TRANSITION_RETURN_TO_DEFAULT_MODE
    LET l_uiSettings.transitions[C_MODE_SEARCH].onClose = C_TRANSITION_EXIT_FORM
    LET l_uiSettings.transitions[C_MODE_SEARCH].onCancel = C_TRANSITION_RETURN_TO_DEFAULT_MODE
    LET l_uiSettings.transitions[C_MODE_DISPLAY].onCancel = C_TRANSITION_EXIT_FORM
    LET l_uiSettings.transitions[C_MODE_DISPLAY].onClose = C_TRANSITION_EXIT_FORM
    LET l_uiSettings.transitions[C_MODE_MODIFY].onCancel = C_TRANSITION_RETURN_TO_DEFAULT_MODE
    LET l_uiSettings.transitions[C_MODE_MODIFY].onClose = C_TRANSITION_EXIT_FORM
    LET l_uiSettings.transitions[C_MODE_ADD].onCancel = C_TRANSITION_RETURN_TO_DEFAULT_MODE
    LET l_uiSettings.transitions[C_MODE_SEARCH].onExit = C_TRANSITION_EXIT_APP
    LET l_uiSettings.transitions[C_MODE_DISPLAY].onExit = C_TRANSITION_EXIT_APP
    LET l_uiSettings.transitions[C_MODE_MODIFY].onExit = C_TRANSITION_EXIT_APP
    LET l_uiSettings.transitions[C_MODE_ADD].onExit = C_TRANSITION_EXIT_APP
    {<POINT Name="fct.initializeDefaultUISettings.init">} {</POINT>}

    RETURN l_uiSettings.*
END FUNCTION
{</BLOCK>} --fct.initializeDefaultUISettings

--------------------------------------------------------------------------------
--zoom open functions
{<BLOCK Name="fct.action_zm_provinces">}
#+ Launch the module
#+
#+
#+ @return None
FUNCTION ClientManagerform_ui_action_zm_provinces()
    DEFINE l_uiSettings UISettings_Type

    DEFINE l_br_uk RECORD
        clients_provinceid LIKE clients.provinceid
    END RECORD

    DEFINE l_whereRelation STRING
    DEFINE errNo INTEGER
    DEFINE actionNo SMALLINT
    {<POINT Name="fct.action_zm_provinces.define">} {</POINT>}

    --Initialized UI settings defined on the relation
    LET l_uiSettings.openMode = C_MODE_UNDEFINED
    LET l_uiSettings.defaultMode = C_MODE_UNDEFINED
    LET l_uiSettings.disableDisplay = FALSE
    LET l_uiSettings.disableAdd = FALSE
    LET l_uiSettings.disableModify = FALSE
    LET l_uiSettings.disableDelete = FALSE
    LET l_uiSettings.disableSearch = FALSE
    LET l_uiSettings.disableEmpty = FALSE

    CALL l_uiSettings.transitions.clear()

    LET l_br_uk.clients_provinceid = IIF(m_record1_keyIndex > 0, m_record1_arrRecList[m_record1_keyIndex].clients_provinceid, NULL)
    LET l_whereRelation = SFMT("provinces.countryid='%1'", IIF(m_record1_keyIndex > 0, m_record1_arrRecList[m_record1_keyIndex].clients_countryid, NULL))

    {<POINT Name="fct.action_zm_provinces.init">} {</POINT>}
    IF ClientManagerform_events.m_DlgEvent__action_zm_provinces_BeforeOpeningTheForm IS NOT NULL THEN
        CALL ClientManagerform_events.m_DlgEvent__action_zm_provinces_BeforeOpeningTheForm(m_state)
    END IF

    CALL ProvinceZoom_ui_uiOpenFormByKey(l_whereRelation, l_uiSettings.*, l_br_uk.*) RETURNING errNo, actionNo, l_br_uk.*

    IF ClientManagerform_events.m_DlgEvent__action_zm_provinces_AfterClosingTheForm IS NOT NULL THEN
        CALL ClientManagerform_events.m_DlgEvent__action_zm_provinces_AfterClosingTheForm(m_state)
    END IF

    RETURN errNo, actionNo, l_br_uk.*
END FUNCTION
{</BLOCK>} --fct.action_zm_provinces

{<BLOCK Name="fct.action_zm_payterm">}
#+ Launch the module
#+
#+
#+ @return None
FUNCTION ClientManagerform_ui_action_zm_payterm()
    DEFINE l_uiSettings UISettings_Type

    DEFINE l_br_uk RECORD
        clients_paytermid LIKE clients.paytermid
    END RECORD

    DEFINE l_whereRelation STRING
    DEFINE errNo INTEGER
    DEFINE actionNo SMALLINT
    {<POINT Name="fct.action_zm_payterm.define">} {</POINT>}

    --Initialized UI settings defined on the relation
    LET l_uiSettings.openMode = C_MODE_UNDEFINED
    LET l_uiSettings.defaultMode = C_MODE_UNDEFINED
    LET l_uiSettings.disableDisplay = FALSE
    LET l_uiSettings.disableAdd = FALSE
    LET l_uiSettings.disableModify = FALSE
    LET l_uiSettings.disableDelete = FALSE
    LET l_uiSettings.disableSearch = FALSE
    LET l_uiSettings.disableEmpty = FALSE

    CALL l_uiSettings.transitions.clear()

    LET l_br_uk.clients_paytermid = IIF(m_record1_keyIndex > 0, m_record1_arrRecList[m_record1_keyIndex].clients_paytermid, NULL)
    INITIALIZE l_whereRelation TO NULL

    {<POINT Name="fct.action_zm_payterm.init">} {</POINT>}
    IF ClientManagerform_events.m_DlgEvent__action_zm_payterm_BeforeOpeningTheForm IS NOT NULL THEN
        CALL ClientManagerform_events.m_DlgEvent__action_zm_payterm_BeforeOpeningTheForm(m_state)
    END IF

    CALL PayTermZoom_ui_uiOpenFormByKey(l_whereRelation, l_uiSettings.*, l_br_uk.*) RETURNING errNo, actionNo, l_br_uk.*

    IF ClientManagerform_events.m_DlgEvent__action_zm_payterm_AfterClosingTheForm IS NOT NULL THEN
        CALL ClientManagerform_events.m_DlgEvent__action_zm_payterm_AfterClosingTheForm(m_state)
    END IF

    RETURN errNo, actionNo, l_br_uk.*
END FUNCTION
{</BLOCK>} --fct.action_zm_payterm

{<BLOCK Name="fct.action_zm_clienttype">}
#+ Launch the module
#+
#+
#+ @return None
FUNCTION ClientManagerform_ui_action_zm_clienttype()
    DEFINE l_uiSettings UISettings_Type

    DEFINE l_br_uk RECORD
        clients_clienttypeid LIKE clients.clienttypeid
    END RECORD

    DEFINE l_whereRelation STRING
    DEFINE errNo INTEGER
    DEFINE actionNo SMALLINT
    {<POINT Name="fct.action_zm_clienttype.define">} {</POINT>}

    --Initialized UI settings defined on the relation
    LET l_uiSettings.openMode = C_MODE_UNDEFINED
    LET l_uiSettings.defaultMode = C_MODE_UNDEFINED
    LET l_uiSettings.disableDisplay = FALSE
    LET l_uiSettings.disableAdd = FALSE
    LET l_uiSettings.disableModify = FALSE
    LET l_uiSettings.disableDelete = FALSE
    LET l_uiSettings.disableSearch = FALSE
    LET l_uiSettings.disableEmpty = FALSE

    CALL l_uiSettings.transitions.clear()

    LET l_br_uk.clients_clienttypeid = IIF(m_record1_keyIndex > 0, m_record1_arrRecList[m_record1_keyIndex].clients_clienttypeid, NULL)
    INITIALIZE l_whereRelation TO NULL

    {<POINT Name="fct.action_zm_clienttype.init">} {</POINT>}
    IF ClientManagerform_events.m_DlgEvent__action_zm_clienttype_BeforeOpeningTheForm IS NOT NULL THEN
        CALL ClientManagerform_events.m_DlgEvent__action_zm_clienttype_BeforeOpeningTheForm(m_state)
    END IF

    CALL ClientTypeZoom_ui_uiOpenFormByKey(l_whereRelation, l_uiSettings.*, l_br_uk.*) RETURNING errNo, actionNo, l_br_uk.*

    IF ClientManagerform_events.m_DlgEvent__action_zm_clienttype_AfterClosingTheForm IS NOT NULL THEN
        CALL ClientManagerform_events.m_DlgEvent__action_zm_clienttype_AfterClosingTheForm(m_state)
    END IF

    RETURN errNo, actionNo, l_br_uk.*
END FUNCTION
{</BLOCK>} --fct.action_zm_clienttype

{<BLOCK Name="fct.action_zm_country">}
#+ Launch the module
#+
#+
#+ @return None
FUNCTION ClientManagerform_ui_action_zm_country()
    DEFINE l_uiSettings UISettings_Type

    DEFINE l_br_uk RECORD
        clients_countryid LIKE clients.countryid
    END RECORD

    DEFINE l_whereRelation STRING
    DEFINE errNo INTEGER
    DEFINE actionNo SMALLINT
    {<POINT Name="fct.action_zm_country.define">} {</POINT>}

    --Initialized UI settings defined on the relation
    LET l_uiSettings.openMode = C_MODE_UNDEFINED
    LET l_uiSettings.defaultMode = C_MODE_UNDEFINED
    LET l_uiSettings.disableDisplay = FALSE
    LET l_uiSettings.disableAdd = FALSE
    LET l_uiSettings.disableModify = FALSE
    LET l_uiSettings.disableDelete = FALSE
    LET l_uiSettings.disableSearch = FALSE
    LET l_uiSettings.disableEmpty = FALSE

    CALL l_uiSettings.transitions.clear()

    LET l_br_uk.clients_countryid = IIF(m_record1_keyIndex > 0, m_record1_arrRecList[m_record1_keyIndex].clients_countryid, NULL)
    INITIALIZE l_whereRelation TO NULL

    {<POINT Name="fct.action_zm_country.init">} {</POINT>}
    IF ClientManagerform_events.m_DlgEvent__action_zm_country_BeforeOpeningTheForm IS NOT NULL THEN
        CALL ClientManagerform_events.m_DlgEvent__action_zm_country_BeforeOpeningTheForm(m_state)
    END IF

    CALL CountryZoom_ui_uiOpenFormByKey(l_whereRelation, l_uiSettings.*, l_br_uk.*) RETURNING errNo, actionNo, l_br_uk.*

    IF ClientManagerform_events.m_DlgEvent__action_zm_country_AfterClosingTheForm IS NOT NULL THEN
        CALL ClientManagerform_events.m_DlgEvent__action_zm_country_AfterClosingTheForm(m_state)
    END IF

    RETURN errNo, actionNo, l_br_uk.*
END FUNCTION
{</BLOCK>} --fct.action_zm_country

{<BLOCK Name="fct.validateCRUDOperationWrapper">}
#+ Validate a CRUD operation for a record (INSERT, UPDATE, DELETE)
#+
#+ @param p_dialog The current DIALOG
#+ @param p_subdialog_name The current DIALOG name
#+ @param p_state The current state
#+ @param p_action The action which triggered the CRUD operation
#+
#+ @returnType SMALLINT
#+ @return The internal action
FUNCTION ClientManagerform_ui_validateCRUDOperationWrapper(p_dialog, p_subdialog_name, p_state, p_action)
    DEFINE p_dialog ui.Dialog
    DEFINE p_subdialog_name STRING
    DEFINE p_state SMALLINT
    DEFINE p_action SMALLINT
    DEFINE l_internalAction SMALLINT
    {<POINT Name="fct.validateCRUDOperationWrapper.define">} {</POINT>}
    {<POINT Name="fct.validateCRUDOperationWrapper.init">} {</POINT>}

    CASE p_subdialog_name
        WHEN "record1"
            CALL ClientManagerform_uidialog.ClientManagerform_uidialog_record1_validateCRUDOperation(p_dialog, p_state, p_action)
                RETURNING l_internalAction
    END CASE
    RETURN l_internalAction
END FUNCTION
{</BLOCK>} --fct.validateCRUDOperationWrapper

--------------------------------------------------------------------------------
--Add user functions
{<POINT Name="user.functions">} {</POINT>}
