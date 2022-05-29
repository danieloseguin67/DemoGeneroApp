DEFINE xlapp INTEGER
DEFINE xlwb INTEGER

SCHEMA consultcompanion

FUNCTION openexcel()

  DEFINE result INTEGER
  DEFINE str STRING
  DEFINE l_excelcell STRING
  DEFINE l_id LIKE clients.clientid
  DEFINE l_name LIKE clients.clientname
  DEFINE l_ptr SMALLINT
  DEFINE l_sptr STRING
  DEFINE l_celldef STRING 
  
--initialization of global variables
  LET xlapp = -1
  LET xlwb = -1
  
--first, we must create an Instance of an Excel Application
  CALL ui.Interface.frontCall("WinCOM", "CreateInstance",
  ["Excel.Application"], [xlapp])
  CALL CheckError(xlapp, __LINE__)
  
--then adding a Workbook to the current document
  CALL ui.interface.frontCall("WinCOM", "CallMethod",
  [xlapp, "WorkBooks.Add"], [xlwb])
  CALL CheckError(xlwb, __LINE__)
  
--then, setting it to be visible
  CALL ui.interface.frontCall("WinCOM", "SetProperty",
  [xlapp, "Visible", true], [result])
  CALL CheckError(result, __LINE__)

  CONNECT TO "consultcompanion"
  PREPARE ex_stmt FROM "SELECT clientid, clientname FROM clients ORDER BY clientname"
  DECLARE curs_test cursor FOR ex_stmt
  
  LET l_ptr = 1
  OPEN curs_test
  WHILE TRUE
    FETCH curs_test INTO l_id, l_name
    IF status <> 0 THEN
       EXIT WHILE
    END IF
    IF l_ptr = 1 THEN
        # need put header line
        LET l_excelcell = "activesheet.Range(""A1"").Value"
        CALL ui.Interface.frontCall("WinCOM", "SetProperty", [xlwb, l_excelcell, "CustomerID" ],[result])
        CALL CheckError(result, __LINE__)
        CALL ui.Interface.frontCall("WinCOM", "GetProperty", [xlwb, l_excelcell], [str])
        CALL CheckError(str, __LINE__)
        DISPLAY "content of the cell is: " || str
        LET l_excelcell = "activesheet.Range(""B1"").Value"
        CALL ui.Interface.frontCall("WinCOM", "SetProperty", [xlwb, l_excelcell, "Customer Name" ],[result])
        CALL CheckError(result, __LINE__)
        CALL ui.Interface.frontCall("WinCOM", "GetProperty", [xlwb, l_excelcell], [str])
        CALL CheckError(str, __LINE__)
        DISPLAY "content of the cell is: " || str
        LET l_ptr = l_ptr + 1    
    END if        
    
    # need put data line
    
    LET l_celldef = "A", l_ptr USING "<<<"    
    LET l_excelcell = "activesheet.Range(""", l_celldef CLIPPED, """).Value"
    CALL ui.Interface.frontCall("WinCOM", "SetProperty", [xlwb, l_excelcell, l_id ],[result])
    CALL CheckError(result, __LINE__)
    CALL ui.Interface.frontCall("WinCOM", "GetProperty", [xlwb, l_excelcell], [str])
    CALL CheckError(str, __LINE__)
    DISPLAY "content of the cell is: " || str
    LET l_celldef = "B", l_ptr USING "<<<"    
    LET l_excelcell = "activesheet.Range(""", l_celldef CLIPPED, """).Value"
    CALL ui.Interface.frontCall("WinCOM", "SetProperty", [xlwb, l_excelcell, l_name clipped ],[result])
    CALL CheckError(result, __LINE__)
    CALL ui.Interface.frontCall("WinCOM", "GetProperty", [xlwb, l_excelcell], [str])
    CALL CheckError(str, __LINE__)
    DISPLAY "content of the cell is: " || str

    LET l_ptr = l_ptr + 1
    
  END WHILE
  CLOSE curs_test

 --then Free the memory on the client side
  CALL freeMemory()
  
END FUNCTION

FUNCTION freeMemory()

 DEFINE res INTEGER
  IF xlwb != -1 THEN
    CALL ui.Interface.frontCall("WinCOM","ReleaseInstance", [xlwb], [res] )
  END IF
  IF xlapp != -1 THEN
    CALL ui.Interface.frontCall("WinCOM","ReleaseInstance", [xlapp], [res] )
  END IF
  
END FUNCTION

FUNCTION checkError(res, lin)

  DEFINE res INTEGER
  DEFINE lin INTEGER
  DEFINE mess STRING
  
  IF res = -1 THEN
    DISPLAY "COM Error for call at line:", lin
    CALL ui.Interface.frontCall("WinCOM","GetError",[],[mess])
    DISPLAY mess
--let's release the memory on the GDC side
    CALL freeMemory()
    DISPLAY "Exit with COM Error."
    EXIT PROGRAM (-1)
  END IF
  
END FUNCTION
