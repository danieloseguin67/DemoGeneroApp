{<CODEFILE Path="MainForm.code" Hash="9HGqpq5YRle0hePkJH+ryA==" />}
#+ User Interface

--------------------------------------------------------------------------------
--This code is generated with the template dbapp5.0
--Warning: Enter your changes within a <BLOCK> or <POINT> section, otherwise they will be lost.
{<POINT Name="user.comments">} {</POINT>}

--------------------------------------------------------------------------------
--Importing modules
IMPORT FGL libdbappCore
IMPORT FGL libdbappFormUI
{<POINT Name="import" Status="MODIFIED">}
IMPORT FGL fgldialog
 {</POINT>}

--------------------------------------------------------------------------------
--Definition of constants, user-types, variables

{<POINT Name="define">} {</POINT>}

--------------------------------------------------------------------------------
--Functions

{<BLOCK Name="fct.uiOpenForm">}
#+ Launch the module
#+
#+ @param p_whereRelation   Part of the WHERE clause defined by entity relations in the BA
#+ @param p_uiSettings      UI Settings defined on the relation
PUBLIC FUNCTION MainForm_ui_uiOpenForm(p_whereRelation, p_uiSettings)
    DEFINE p_whereRelation STRING
    DEFINE p_uiSettings UISettings_Type
    DEFINE errNo INTEGER
    DEFINE actionNo SMALLINT

    {<POINT Name="fct.uiOpenForm.user" Status="MODIFIED">} 

    DEFINE l_cmd STRING 
    
    OPEN WINDOW w_mainmenu AT 1,1 WITH FORM "MAINFORM"  ATTRIBUTE (BORDER)
    
    MENU "Main Menu"
        COMMAND "Setup" "Setup components needed throughout the application"
          CALL fgl_winmessage("Message","Option not implemented yet", "information")
        COMMAND "Client" "Client manager"
           LET l_cmd = "Fglrun ClientManager.42r"             
           RUN l_cmd clipped          
        COMMAND "Employee" "Employee manager"
          CALL fgl_winmessage("Message","Option not implemented yet", "information")
        COMMAND "RFS" "Request for service  manager"
          CALL fgl_winmessage("Message","Option not implemented yet", "information")
        COMMAND "Reports" "View reports"
          CALL fgl_winmessage("Message","Option not implemented yet", "information")
        COMMAND "Exit" 
           EXIT PROGRAM (0)
    END MENU

    CLOSE WINDOW w_mainmenu
    
    {</POINT>}
    RETURN errNo, actionNo
END FUNCTION
{</BLOCK>} --fct.uiOpenForm

--------------------------------------------------------------------------------
--Add user functions
{<POINT Name="user.functions">} {</POINT>}
