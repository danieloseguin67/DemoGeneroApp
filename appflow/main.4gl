MAIN

  DEFINE aui om.DomNode 
  DEFINE sm  om.DomNode 
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
    COMMAND "Excel" "Test excel feature"
       CALL openexcel()   
    COMMAND "Exit" "This will exit the application"
      EXIT PROGRAM       
  END MENU

END MAIN


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
