{<CODEFILE Path="SerialNumConfig.code" Hash="1B2M2Y8AsgTpgAmY7PhCfg==" />}
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

    {<POINT Name="MAIN.finish">} {</POINT>}
END MAIN
{</BLOCK>} --MAIN

--------------------------------------------------------------------------------
--Add user functions
{<POINT Name="user.functions">} {</POINT>}
