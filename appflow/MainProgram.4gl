{<CODEFILE Path="MainProgram.code" Hash="0D7E3S616Px+eIiqJsuH6g==" />}
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
{<POINT Name="import" Status="MODIFIED">} 

DATABASE consultcompanion

{</POINT>}

--------------------------------------------------------------------------------
--Functions
{<BLOCK Name="MAIN" Status="MODIFIED">}
MAIN
    DEFINE errNo INTEGER
    DEFINE actionNo SMALLINT
    DEFINE l_actionDefaults STRING
    DEFINE l_style STRING
    {<POINT Name="MAIN.define" Status="MODIFIED">} 
    {</POINT>}

    {<BLOCK Name="MAIN.options">}
    OPTIONS INPUT WRAP
    {</BLOCK>} --MAIN.options
    CLOSE WINDOW SCREEN

    {<BLOCK Name="MAIN.loadResources" Status="MODIFIED">}
    IF libdbapp_isMobile() THEN
        CALL ui.Interface.loadActionDefaults(NVL(l_actionDefaults, "mobile_dbapp"))
    ELSE
        CALL ui.Interface.loadActionDefaults(NVL(l_actionDefaults, "dbapp"))
    END IF
    CALL ui.Interface.loadStyles(NVL(l_style, "dbapp"))
    {</BLOCK>} --MAIN.loadResources

    {<POINT Name="MAIN.init" Status="MODIFIED">} 
    CALL showmenu()
    {</POINT>}

    CALL MainProgram_openFirstForm() RETURNING errNo, actionNo

    {<POINT Name="MAIN.finish" Status="MODIFIED">} 
    {</POINT>}
    
END MAIN
{</BLOCK>} --MAIN

--------------------------------------------------------------------------------
--customForm open functions
{<BLOCK Name="fct.openFirstForm">}
#+ Launch the module
#+
#+
#+ @return None
FUNCTION MainProgram_openFirstForm()
    DEFINE l_uiSettings UISettings_Type

    DEFINE l_whereRelation STRING
    DEFINE errNo INTEGER
    DEFINE actionNo SMALLINT
    {<POINT Name="fct.openFirstForm.define" Status="MODIFIED">} 
    {</POINT>}

    INITIALIZE l_whereRelation TO NULL

    {<POINT Name="fct.openFirstForm.init" Status="MODIFIED">} 
    {</POINT>}

    CALL LogonForm_ui_uiOpenForm(l_whereRelation, l_uiSettings.*) RETURNING errNo, actionNo

    {<POINT Name="fct.openFirstForm.user" Status="MODIFIED">} 
    {</POINT>}

    RETURN errNo, actionNo
END FUNCTION
{</BLOCK>} --fct.openFirstForm

--------------------------------------------------------------------------------
--Add user functions
{<POINT Name="user.functions" Status="MODIFIED">}
--------------------------------------------------------------------------------
--customForm open functions
--------------------------------------------------------------------------------

FUNCTION showmenu()

  DEFINE aui om.DomNode 
  DEFINE sm  om.DomNode 
  DEFINE errNo INTEGER
  DEFINE actionNo SMALLINT
  
  DEFINE ConfigSmg om.DomNode
  DEFINE ConfigSmc om.DomNode

  DEFINE ClientSmg om.DomNode
  DEFINE ClientSmc om.DomNode

  DEFINE ServiceSmg om.DomNode
  DEFINE ServiceSmc om.DomNode

  DEFINE EmployeeSmg om.DomNode
  DEFINE EmployeeSmc om.DomNode
  
  DEFINE ReportSmg om.DomNode
  DEFINE ReportSmc om.DomNode

  DEFINE HelpSmg om.DomNode
  DEFINE HelpSmc om.DomNode
  
  DEFINE l_whereRelation STRING
  DEFINE l_uiSettings UISettings_Type
  DEFINE l_cmd STRING
  DEFINE w ui.Window  
  DEFINE f ui.Form
  DEFINE ok BOOLEAN 
  
  INITIALIZE l_whereRelation TO NULL

  #OPEN WINDOW win_mainform WITH 25 ROWS, 80 columns
  #OPEN FORM win_dashboard FROM "MainForm"
  #DISPLAY FORM win_dashboard
    
  LET w = ui.Window.getCurrent()
  LET aui = ui.Interface.getRootNode()  
  LET sm = aui.createChild("StartMenu")
  
  LET ConfigSmg = createStartMenuGroup(sm,"Configuration")
  LET ConfigSmc = createStartMenuCommand(ConfigSmg,"Preferences","fglrun Preferenceconfig",null)
  LET ConfigSmc = createStartMenuCommand(ConfigSmg,"Client Types","fglrun ClientTypeConfig",null)
  LET ConfigSmc = createStartMenuCommand(ConfigSmg,"Employee Types","fglrun EmployeeTypeManager",null)
  LET ConfigSmc = createStartMenuCommand(ConfigSmg,"Offer Status","fglrun OfferStastusConfig",NULL)
  LET ConfigSmc = createStartMenuCommand(ConfigSmg,"Payment Terms","fglrun PayTermConfig",NULL)
  LET ConfigSmc = createStartMenuCommand(ConfigSmg,"Stakehoolders","fglrun StakeholderManager",NULL)
  LET ConfigSmc = createStartMenuCommand(ConfigSmg,"Serial Numbers","fglrun SerialNumConfig",NULL)

  LET ClientSmg = createStartMenuGroup(sm,"Clients")
  LET ClientSmc = createStartMenuCommand(clientSmg,"Client Manager","fglrun ClientManager",null)

  LET ServiceSmg = createStartMenuGroup(sm,"Services")
  LET ServiceSmc = createStartMenuCommand(ServiceSmg,"Request for services","fglrun RFSManager",null)
  LET ServiceSmc = createStartMenuCommand(ServiceSmg,"Project Manager","fglrun ProjectManager",null)
  
  LET EmployeeSmg = createStartMenuGroup(sm,"Employees")
  LET EmployeeSmc = createStartMenuCommand(EmployeeSmg,"Order Entry/Items","fglrun OrderItems",null)

  LET ReportSmg = createStartMenuGroup(sm,"Reports")
  LET ReportSmc = createStartMenuCommand(ReportSmg,"Export Customer List in Excel","fglrun ExportExcelCustomers",NULL)
  LET ReportSmc = createStartMenuCommand(ReportSmg,"Export Customer List in PDF","fglrun ExportPdfCustomers",NULL)

  LET HelpSmg = createStartMenuGroup(sm,"Help")
  LET HelpSmc = createStartMenuCommand(HelpSmg,"About ConsultantCompanion","fglrun aboutpage",NULL)

  MENU "Options"
    COMMAND "Exit" "This will exit the application"
      EXIT PROGRAM       
  END MENU

  #CLOSE WINDOW win_mainform
    
END function


FUNCTION createStartMenuGroup(p,t)

  DEFINE p om.DomNode 
  DEFINE t STRING
  DEFINE s om.DomNode 
  LET s = p.createChild("StartMenuGroup")
  CALL s.setAttribute("text",t)
  RETURN s 

END FUNCTION


FUNCTION createStartMenuCommand(p,t,c,i)

  DEFINE p om.DomNode 
  DEFINE t,c,i STRING
  DEFINE s om.DomNode 
  LET s = p.createChild("StartMenuCommand")
  CALL s.setAttribute("text",t)
  CALL s.setAttribute("exec",c)
  CALL s.setAttribute("image",i)
  RETURN s 

END FUNCTION

{</POINT>}
