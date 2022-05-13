{<CODEFILE Path="CountryZoom.code" Hash="1B2M2Y8AsgTpgAmY7PhCfg==" />}
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
IMPORT FGL CountryZoom_common
IMPORT FGL CountryZoom
IMPORT FGL CountryZoom_events
IMPORT FGL CountryZoom_uidata
IMPORT FGL CountryZoom_uidialogdata
IMPORT FGL CountryZoom_uidialog
{<POINT Name="import">} {</POINT>}

--------------------------------------------------------------------------------
--Database schema
SCHEMA consultcompanion

--------------------------------------------------------------------------------
--Definition of constants, user-types, variables
{<POINT Name="define">} {</POINT>}

--------------------------------------------------------------------------------
--Functions

{<BLOCK Name="fct.uiOpenFormByKey">}
#+ Launch the module according to the open mode and position to the key
#+
#+ @param p_whereRelation   Part of the WHERE clause defined by entity relations in the BA
#+ @param p_uiSettings      UI Settings defined on the relation
#+ @param p_br_uk           Key used for position
PUBLIC FUNCTION CountryZoom_ui_uiOpenFormByKey(p_whereRelation, p_uiSettings, p_br_uk)
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

    OPEN WINDOW w_CountryZoom WITH FORM 'CountryZoom' ATTRIBUTES(STYLE=NVL(l_windowStyle, "zoom_dbapp"))
    --Initialize UI settings with default form UI settings
    CALL CountryZoom_ui_initializeDefaultUISettings() RETURNING l_defaultUISettings.*
    -- Update UI settings with Relation UI settings
    CALL libdbapp_mergeUISettings(p_uiSettings.*, l_defaultUISettings.*) RETURNING m_uiSettings.*
    --Initialize UI
    LET w = ui.Window.getCurrent()

    CALL CountryZoom_events.registerDlgEvents()
    CALL consultcompanion_events.registerDbxEvents()

    --Load actions in the ToolBar and the TopMenu
    IF NOT libdbapp_isMobile() THEN
        CALL CountryZoom_ui_uiInitializeDefaultActions(l_actionList)
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
    IF CountryZoom_events.m_DlgEvent_OnOpenForm IS NOT NULL THEN
        CALL CountryZoom_events.m_DlgEvent_OnOpenForm(w.getForm())
    END IF

    --Fetch keys and data according to open mode
    IF m_uiSettings.openMode != C_MODE_SEARCH AND m_uiSettings.openMode != C_MODE_EMPTY THEN
        CALL CountryZoom_uidialogdata_record1_fetchAll(m_where, m_detailList)
        LET m_record1_keyIndex = CountryZoom_uidialogdata_record1_seek(p_br_uk.*)
    END IF
    --Call the UI automaton
    CALL CountryZoom_ui_uiAutomaton(m_uiSettings.*) RETURNING errNo, actionNo
    INITIALIZE l_record1_br_uk.* TO NULL
    IF m_record1_keyIndex > 0 THEN
        LET l_record1_br_uk.country_countryid = m_record1_arrRecList[m_record1_keyIndex].country_countryid
    END IF
    CLOSE WINDOW w_CountryZoom

    {<POINT Name="fct.uiOpenFormByKey.user">} {</POINT>}
    RETURN errNo, actionNo, l_record1_br_uk.*
END FUNCTION
{</BLOCK>} --fct.uiOpenFormByKey

{<BLOCK Name="fct.uiAutomaton">}
#+ Application State Manager
#+ Automation based on UI settings and performed actions
#+
#+ @param p_uiSettings The merged UI settings - UI settings defined on the Relation overwrites the one defined on the form
PRIVATE FUNCTION CountryZoom_ui_uiAutomaton(p_uiSettings)
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
                CALL CountryZoom_ui_uiDisplay(prevState, prevAction, l_state) RETURNING errNo, actionNo
                LET nextState = libdbapp_getNextTransition(actionNo, C_MODE_DISPLAY, p_uiSettings.defaultMode, prevState, p_uiSettings.transitions)
                {<POINT Name="fct.uiAutomaton.afterDisplay">} {</POINT>}

            WHEN C_MODE_SEARCH
                {<POINT Name="fct.uiAutomaton.beforeSearch">} {</POINT>}
                CALL CountryZoom_ui_uiConstruct(prevState, prevAction, l_state) RETURNING errNo, actionNo
                LET nextState = libdbapp_getNextTransition(actionNo, C_MODE_SEARCH, p_uiSettings.defaultMode, prevState, p_uiSettings.transitions)
                {<POINT Name="fct.uiAutomaton.afterSearch">} {</POINT>}
            WHEN C_MODE_EMPTY
                {<POINT Name="fct.uiAutomaton.beforeEmpty">} {</POINT>}
                CALL CountryZoom_ui_uiEmpty(prevState, prevAction, l_state) RETURNING errNo, actionNo
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
FUNCTION CountryZoom_ui_uiDisplay(p_prevState, p_prevAction, p_state)
    DEFINE p_prevState SMALLINT
    DEFINE p_prevAction SMALLINT
    DEFINE p_state SMALLINT
    DEFINE errNo INTEGER

    {<POINT Name="fct.uiDisplay.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    LET m_prevAction = p_prevAction
    LET m_state = p_state
    LET m_actionNo = C_ACTION_EXIT_FORM
    {<POINT Name="fct.uiDisplay.init">} {</POINT>}

    DIALOG ATTRIBUTES(UNBUFFERED, FIELD ORDER FORM)
        SUBDIALOG CountryZoom_uidialog.CountryZoom_uidialog_record1_uiDisplay

        ON ACTION query
            {<POINT Name="fct.uiDisplay.dlg.onAction.query">} {</POINT>}
            LET m_actionNo = C_ACTION_QUERY

            LET CountryZoom_events.m_DlgCtrlInstruction = libdbappEvents.ACCEPT_DIALOG
            IF CountryZoom_events.m_DlgEvent_OnActionQuery IS NOT NULL THEN
                CALL CountryZoom_events.m_DlgEvent_OnActionQuery(DIALOG, m_state, CountryZoom_events.m_DlgCtrlInstruction)
                    RETURNING CountryZoom_events.m_DlgCtrlInstruction
            END IF

            CASE CountryZoom_events.m_DlgCtrlInstruction
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

            LET CountryZoom_events.m_DlgCtrlInstruction = libdbappEvents.ACCEPT_DIALOG
            IF CountryZoom_events.m_DlgEvent_OnActionAccept IS NOT NULL THEN
                CALL CountryZoom_events.m_DlgEvent_OnActionAccept(DIALOG, m_state, CountryZoom_events.m_DlgCtrlInstruction)
                    RETURNING CountryZoom_events.m_DlgCtrlInstruction
            END IF

            CASE CountryZoom_events.m_DlgCtrlInstruction
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

            LET CountryZoom_events.m_DlgCtrlInstruction = libdbappEvents.EXIT_DIALOG
            IF CountryZoom_events.m_DlgEvent_OnActionCancel IS NOT NULL THEN
                CALL CountryZoom_events.m_DlgEvent_OnActionCancel(DIALOG, m_state, CountryZoom_events.m_DlgCtrlInstruction)
                    RETURNING CountryZoom_events.m_DlgCtrlInstruction
            END IF

            CASE CountryZoom_events.m_DlgCtrlInstruction
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

            LET CountryZoom_events.m_DlgCtrlInstruction = libdbappEvents.EXIT_DIALOG
            IF CountryZoom_events.m_DlgEvent_OnActionClose IS NOT NULL THEN
                CALL CountryZoom_events.m_DlgEvent_OnActionClose(DIALOG, m_state, CountryZoom_events.m_DlgCtrlInstruction)
                    RETURNING CountryZoom_events.m_DlgCtrlInstruction
            END IF

            CASE CountryZoom_events.m_DlgCtrlInstruction
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

            LET CountryZoom_events.m_DlgCtrlInstruction = libdbappEvents.EXIT_DIALOG
            IF CountryZoom_events.m_DlgEvent_OnActionExit IS NOT NULL THEN
                CALL CountryZoom_events.m_DlgEvent_OnActionExit(DIALOG, m_state, CountryZoom_events.m_DlgCtrlInstruction)
                    RETURNING CountryZoom_events.m_DlgCtrlInstruction
            END IF

            CASE CountryZoom_events.m_DlgCtrlInstruction
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

            LET CountryZoom_events.m_DlgCtrlInstruction = libdbappEvents.CONTINUE_DIALOG
            IF CountryZoom_events.m_DlgEvent_Before_BrowseDialog IS NOT NULL THEN
                CALL CountryZoom_events.m_DlgEvent_Before_BrowseDialog(DIALOG, m_state, CountryZoom_events.m_DlgCtrlInstruction, m_NextField)
                    RETURNING CountryZoom_events.m_DlgCtrlInstruction, m_NextField
            END IF

            CASE CountryZoom_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    ACCEPT DIALOG
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
            END CASE

        AFTER DIALOG
            INITIALIZE CountryZoom_events.m_DlgCtrlInstruction TO NULL
            IF CountryZoom_events.m_DlgEvent_After_BrowseDialog IS NOT NULL THEN
                CALL CountryZoom_events.m_DlgEvent_After_BrowseDialog(DIALOG, m_state, CountryZoom_events.m_DlgCtrlInstruction)
                    RETURNING CountryZoom_events.m_DlgCtrlInstruction
            END IF

            CASE CountryZoom_events.m_DlgCtrlInstruction
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
FUNCTION CountryZoom_ui_uiConstruct(p_prevState, p_prevAction, p_state)
    DEFINE p_prevState SMALLINT
    DEFINE p_prevAction SMALLINT
    DEFINE p_state SMALLINT
    DEFINE l_where STRING
    DEFINE l_detailList STRING
    DEFINE errNo INTEGER

    {<POINT Name="fct.uiConstruct.define">} {</POINT>}

    LET errNo = ERROR_SUCCESS
    LET m_prevAction = p_prevAction
    LET m_state = p_state
    LET m_actionNo = C_ACTION_EXIT_FORM
    CLEAR FORM
    {<POINT Name="fct.uiConstruct.init">} {</POINT>}

    DIALOG ATTRIBUTES(UNBUFFERED, FIELD ORDER FORM)
        SUBDIALOG CountryZoom_uidialog.CountryZoom_uidialog_record1_uiConstruct

        ON ACTION accept
            {<POINT Name="fct.uiConstruct.dlg.onAction.accept">} {</POINT>}
            LET m_actionNo = C_ACTION_ACCEPT

            LET CountryZoom_events.m_DlgCtrlInstruction = libdbappEvents.ACCEPT_DIALOG
            IF CountryZoom_events.m_DlgEvent_OnActionAccept IS NOT NULL THEN
                CALL CountryZoom_events.m_DlgEvent_OnActionAccept(DIALOG, m_state, CountryZoom_events.m_DlgCtrlInstruction)
                    RETURNING CountryZoom_events.m_DlgCtrlInstruction
            END IF

            CASE CountryZoom_events.m_DlgCtrlInstruction
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

            LET CountryZoom_events.m_DlgCtrlInstruction = libdbappEvents.EXIT_DIALOG
            IF CountryZoom_events.m_DlgEvent_OnActionCancel IS NOT NULL THEN
                CALL CountryZoom_events.m_DlgEvent_OnActionCancel(DIALOG, m_state, CountryZoom_events.m_DlgCtrlInstruction)
                    RETURNING CountryZoom_events.m_DlgCtrlInstruction
            END IF

            CASE CountryZoom_events.m_DlgCtrlInstruction
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

            LET CountryZoom_events.m_DlgCtrlInstruction = libdbappEvents.EXIT_DIALOG
            IF CountryZoom_events.m_DlgEvent_OnActionClose IS NOT NULL THEN
                CALL CountryZoom_events.m_DlgEvent_OnActionClose(DIALOG, m_state, CountryZoom_events.m_DlgCtrlInstruction)
                    RETURNING CountryZoom_events.m_DlgCtrlInstruction
            END IF

            CASE CountryZoom_events.m_DlgCtrlInstruction
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

            LET CountryZoom_events.m_DlgCtrlInstruction = libdbappEvents.EXIT_DIALOG
            IF CountryZoom_events.m_DlgEvent_OnActionExit IS NOT NULL THEN
                CALL CountryZoom_events.m_DlgEvent_OnActionExit(DIALOG, m_state, CountryZoom_events.m_DlgCtrlInstruction)
                    RETURNING CountryZoom_events.m_DlgCtrlInstruction
            END IF

            CASE CountryZoom_events.m_DlgCtrlInstruction
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

            INITIALIZE CountryZoom_events.m_DlgCtrlInstruction TO NULL
            IF CountryZoom_events.m_DlgEvent_Before_SearchDialog IS NOT NULL THEN
                CALL CountryZoom_events.m_DlgEvent_Before_SearchDialog(DIALOG, m_state, CountryZoom_events.m_DlgCtrlInstruction)
                    RETURNING CountryZoom_events.m_DlgCtrlInstruction
            END IF
            CASE CountryZoom_events.m_DlgCtrlInstruction
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

            INITIALIZE CountryZoom_events.m_DlgCtrlInstruction TO NULL
            IF CountryZoom_events.m_DlgEvent_After_SearchDialog IS NOT NULL THEN
                CALL CountryZoom_events.m_DlgEvent_After_SearchDialog(DIALOG, m_state, CountryZoom_events.m_DlgCtrlInstruction, m_where, m_detailList)
                    RETURNING CountryZoom_events.m_DlgCtrlInstruction, m_where, m_detailList
            END IF

            CASE CountryZoom_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    ACCEPT DIALOG
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
            END CASE

            CALL CountryZoom_uidialogdata_record1_fetchAll(m_where, m_detailList)
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
FUNCTION CountryZoom_ui_uiEmpty(p_prevState, p_prevAction, p_state)
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
                CALL DIALOG.setActionActive('exit', FALSE)
                CALL DIALOG.setActionHidden('exit', TRUE)
            END IF
        INITIALIZE CountryZoom_events.m_DlgCtrlInstruction TO NULL
        IF CountryZoom_events.m_DlgEvent_Before_EmptyDialog IS NOT NULL THEN
            CALL CountryZoom_events.m_DlgEvent_Before_EmptyDialog(DIALOG, m_state, CountryZoom_events.m_DlgCtrlInstruction)
                RETURNING CountryZoom_events.m_DlgCtrlInstruction
        END IF

        CASE CountryZoom_events.m_DlgCtrlInstruction
            WHEN libdbappEvents.EXIT_MENU
                EXIT MENU
        END CASE

        ON ACTION query
            {<POINT Name="fct.uiEmpty.menu.onAction.query">} {</POINT>}
            LET m_actionNo = C_ACTION_QUERY

            LET CountryZoom_events.m_DlgCtrlInstruction = libdbappEvents.EXIT_MENU
            IF CountryZoom_events.m_DlgEvent_OnActionQuery IS NOT NULL THEN
                CALL CountryZoom_events.m_DlgEvent_OnActionQuery(DIALOG, m_state, CountryZoom_events.m_DlgCtrlInstruction)
                    RETURNING CountryZoom_events.m_DlgCtrlInstruction
            END IF

            CASE CountryZoom_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.EXIT_MENU
                    EXIT MENU
            END CASE

        ON ACTION close
            {<POINT Name="fct.uiEmpty.menu.onAction.close">} {</POINT>}
            LET m_actionNo = C_ACTION_CLOSE

            LET CountryZoom_events.m_DlgCtrlInstruction = libdbappEvents.EXIT_MENU
            IF CountryZoom_events.m_DlgEvent_OnActionClose IS NOT NULL THEN
                CALL CountryZoom_events.m_DlgEvent_OnActionClose(DIALOG, m_state, CountryZoom_events.m_DlgCtrlInstruction)
                    RETURNING CountryZoom_events.m_DlgCtrlInstruction
            END IF

            CASE CountryZoom_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.EXIT_MENU
                    EXIT MENU
            END CASE

        ON ACTION exit
            {<POINT Name="fct.uiEmpty.menu.onAction.exit">} {</POINT>}
            LET m_actionNo = C_ACTION_EXIT_FORM

            LET CountryZoom_events.m_DlgCtrlInstruction = libdbappEvents.EXIT_MENU
            IF CountryZoom_events.m_DlgEvent_OnActionExit IS NOT NULL THEN
                CALL CountryZoom_events.m_DlgEvent_OnActionExit(DIALOG, m_state, CountryZoom_events.m_DlgCtrlInstruction)
                    RETURNING CountryZoom_events.m_DlgCtrlInstruction
            END IF

            CASE CountryZoom_events.m_DlgCtrlInstruction
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
PUBLIC FUNCTION CountryZoom_ui_uiInitializeDefaultActions(p_actionList)
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
PUBLIC FUNCTION CountryZoom_ui_initializeDefaultUISettings()
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
--Add user functions
{<POINT Name="user.functions">} {</POINT>}
