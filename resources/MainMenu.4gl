{<CODEFILE Path="MainMenu.code" Hash="1B2M2Y8AsgTpgAmY7PhCfg==" />}
#+ User Interface

--------------------------------------------------------------------------------
--This code is generated with the template dbapp5.0
--Warning: Enter your changes within a <BLOCK> or <POINT> section, otherwise they will be lost.
{<POINT Name="user.comments">} {</POINT>}

--------------------------------------------------------------------------------
--Importing modules
IMPORT FGL libdbappCore
IMPORT FGL libdbappFormUI
{<POINT Name="import">} {</POINT>}

--------------------------------------------------------------------------------
--Definition of constants, user-types, variables
PUBLIC TYPE record1_br_type
    RECORD
        edit1 CHAR(1),
        edit2 CHAR(1),
        edit3 CHAR(1),
        edit4 CHAR(1),
        edit5 CHAR(1),
        edit6 CHAR(1),
        phantom1 CHAR(1),
        phantom2 CHAR(1)
    END RECORD

{<POINT Name="define">} {</POINT>}

--------------------------------------------------------------------------------
--Functions

{<BLOCK Name="fct.uiOpenForm">}
#+ Launch the module
#+
#+ @param p_whereRelation   Part of the WHERE clause defined by entity relations in the BA
#+ @param p_uiSettings      UI Settings defined on the relation
PUBLIC FUNCTION MainMenu_ui_uiOpenForm(p_whereRelation, p_uiSettings)
    DEFINE p_whereRelation STRING
    DEFINE p_uiSettings UISettings_Type
    DEFINE errNo INTEGER
    DEFINE actionNo SMALLINT

    {<POINT Name="fct.uiOpenForm.user">} {</POINT>}
    RETURN errNo, actionNo
END FUNCTION
{</BLOCK>} --fct.uiOpenForm

--------------------------------------------------------------------------------
--Add user functions
{<POINT Name="user.functions">} {</POINT>}
