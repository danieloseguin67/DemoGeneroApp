{<CODEFILE Path="ClientTypeConfig.code" Hash="1B2M2Y8AsgTpgAmY7PhCfg==" />}
#+ Main program

--------------------------------------------------------------------------------
--This code is generated with the template dbapp5.0
--Warning: Enter your changes within a <BLOCK> or <POINT> section, otherwise they will be lost.
{<POINT Name="user.comments">} {</POINT>}

--------------------------------------------------------------------------------
--Importing modules
IMPORT FGL libdbappUI
IMPORT FGL libdbappFormUI
IMPORT os
{<POINT Name="import">} {</POINT>}

--------------------------------------------------------------------------------
--Database schema
SCHEMA consultcompanion

--------------------------------------------------------------------------------
--Functions
{<BLOCK Name="MAIN">}
MAIN
    DEFINE errNo INTEGER
    DEFINE actionNo SMALLINT
    DEFINE l_actionDefaults STRING
    DEFINE l_style STRING
    {<POINT Name="MAIN.define">} {</POINT>}

    {<BLOCK Name="MAIN.options">}
    OPTIONS INPUT WRAP
    {</BLOCK>} --MAIN.options
    CLOSE WINDOW SCREEN

    {<BLOCK Name="MAIN.loadResources">}
    IF libdbapp_isMobile() THEN
        CALL ui.Interface.loadActionDefaults(NVL(l_actionDefaults, "mobile_dbapp"))
    ELSE
        CALL ui.Interface.loadActionDefaults(NVL(l_actionDefaults, "dbapp"))
    END IF
    CALL ui.Interface.loadStyles(NVL(l_style, "dbapp"))
    {</BLOCK>} --MAIN.loadResources

    {<POINT Name="MAIN.init">} {</POINT>}

    CALL ClientTypeConfig_install()

    CONNECT TO "consultcompanion"

    CALL ClientTypeConfig_openFirstForm() RETURNING errNo, actionNo

    {<POINT Name="MAIN.finish">} {</POINT>}
END MAIN
{</BLOCK>} --MAIN

{<BLOCK Name="fct.install">}
#+ Copy read-only files to the writable document area
PUBLIC FUNCTION ClientTypeConfig_install()
    DEFINE src STRING
    DEFINE dest STRING
    DEFINE dbFilename STRING
    DEFINE dbDestFilename STRING
    DEFINE ret BOOLEAN
    {<POINT Name="fct.install.define">} {</POINT>}
    {<POINT Name="fct.install.init">} {</POINT>}

    --Copy read-only database file (nothing to do for GMa)
    IF ui.Interface.getFrontEndName() == "GMI" AND base.Application.isMobile() THEN
        LET dbFilename = base.Application.getResourceEntry("dbi.database.consultcompanion.source")
        IF dbFilename IS NULL THEN
            LET dbFilename = "consultcompanion.db"
            LET dbDestFilename = "consultcompanion"
        ELSE
            LET dbDestFilename = dbFilename
        END if
        LET dest = os.Path.fullPath(os.Path.join(os.Path.pwd(), dbDestFilename))
        IF NOT os.Path.exists(dest) THEN
            --Copy to writable directory
            LET src = os.Path.fullPath(os.Path.join(base.Application.getProgramDir(), dbFilename))
            CALL os.Path.copy(src, dest) RETURNING ret
        END IF
    END IF
    {<POINT Name="fct.install.user">} {</POINT>}
END FUNCTION
{</BLOCK>} --fct.install

--------------------------------------------------------------------------------
--form open functions
{<BLOCK Name="fct.openFirstForm">}
#+ Launch the module
#+
#+
#+ @return None
FUNCTION ClientTypeConfig_openFirstForm()
    DEFINE l_uiSettings UISettings_Type

    DEFINE l_whereRelation STRING
    DEFINE errNo INTEGER
    DEFINE actionNo SMALLINT
    {<POINT Name="fct.openFirstForm.define">} {</POINT>}

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

    INITIALIZE l_whereRelation TO NULL

    {<POINT Name="fct.openFirstForm.init">} {</POINT>}

    CALL ClientTypeConfigForm_ui_uiOpenForm(l_whereRelation, l_uiSettings.*) RETURNING errNo, actionNo

    {<POINT Name="fct.openFirstForm.user">} {</POINT>}

    RETURN errNo, actionNo
END FUNCTION
{</BLOCK>} --fct.openFirstForm

--------------------------------------------------------------------------------
--Add user functions
{<POINT Name="user.functions">} {</POINT>}
