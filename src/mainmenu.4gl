#+***************************************************************************************
#+ Program name:  StartMain.4gl
#+ Author:  Daniel Seguin
#+***************************************************************************************

#+ non renegerable code

IMPORT FGL libdbappUI
IMPORT FGL libdbappFormUI

database consultcompanion

MAIN

  DEFINE aui om.DomNode 
  DEFINE sm  om.DomNode 
  DEFINE errNo INTEGER
  DEFINE actionNo SMALLINT
  
  DEFINE ConfigSmg om.DomNode
  DEFINE ConfigSmc om.DomNode

  DEFINE SaleSmg om.DomNode
  DEFINE SaleSmc om.DomNode

  DEFINE ProcSmg om.DomNode
  DEFINE ProcSmc om.DomNode
  
  DEFINE RptSmg om.DomNode
  DEFINE RptSmc om.DomNode

  DEFINE ExtSmg om.DomNode
  DEFINE ExtSmc om.DomNode
  
  DEFINE l_whereRelation STRING
  DEFINE l_uiSettings UISettings_Type
  DEFINE l_cmd STRING
  DEFINE w ui.Window  
  DEFINE f ui.Form
  DEFINE ok BOOLEAN 
  
  INITIALIZE l_whereRelation TO NULL

  OPEN FORM win_dashboard FROM "MainMenu"
  DISPLAY FORM win_dashboard
  
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

  LET SaleSmg = createStartMenuGroup(sm,"Clients")
  LET SaleSmc = createStartMenuCommand(SaleSmg,"Client Manager","fglrun ClientManager",null)

  LET SaleSmg = createStartMenuGroup(sm,"Services")
  LET SaleSmc = createStartMenuCommand(SaleSmg,"Request for services","fglrun RFSManager",null)
  LET SaleSmc = createStartMenuCommand(SaleSmg,"Project Manager","fglrun ProjectManager",null)
  
  LET SaleSmg = createStartMenuGroup(sm,"Employees")
  LET SaleSmc = createStartMenuCommand(SaleSmg,"Order Entry/Items","fglrun OrderItems",null)

  LET ExtSmg = createStartMenuGroup(sm,"Reports")
  LET ExtSmc = createStartMenuCommand(ExtSmg,"Export Customer List in Excel","fglrun ExportCustomers",NULL)

  LET ExtSmg = createStartMenuGroup(sm,"Help")
  LET ExtSmc = createStartMenuCommand(ExtSmg,"About ConsultantCompanion","fglrun aboutpage",NULL)
  
  CALL LogonForm_ui_uiOpenForm(l_whereRelation, l_uiSettings.*) RETURNING errNo, actionNo
        
  MENU "Options"
    COMMAND "Exit" "This will exit the application"
      EXIT PROGRAM       
  END MENU
  
END main


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
