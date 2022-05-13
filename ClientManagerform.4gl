--------------------------------------------------------------------------------
--Importing modules
IMPORT FGL libdbappCore
IMPORT FGL libdbappExt
IMPORT FGL libdbappFormUI
IMPORT FGL libdbappReportCore
IMPORT FGL libdbappReportUI
IMPORT FGL libdbappSql
IMPORT FGL libdbappUI
IMPORT FGL libdbappEvents
IMPORT FGL libdbappWS
IMPORT FGL libdbappWSClient
IMPORT FGL libdbappWSCore

IMPORT FGL consultcompanion_dbxdata
IMPORT FGL ClientManagerform_common

--------------------------------------------------------------------------------
--Database schema
SCHEMA consultcompanion

-- Declare your PUBLIC module variables here.
PUBLIC DEFINE dlgCtrlInstruction libdbappEvents.DlgCtrlInstruction_Type

PUBLIC FUNCTION dlgEvent_BeforeField_record1(dlg ui.DIALOG, uiMode SMALLINT, dlgCtrlInstruction libdbappEvents.DlgCtrlInstruction_Type, currentField STRING)
    RETURNS (libdbappEvents.DlgCtrlInstruction_Type)

    DISPLAY "dlgEvent_BeforeField_record1 (Field scope) is raised"

    CASE currentField
      WHEN "field_01"
        -- ...
      WHEN "field_02"
        -- ...
      OTHERWISE
        -- ...
    END CASE

    RETURN dlgCtrlInstruction
END FUNCTION

PUBLIC FUNCTION dataEvent_record1_BeforeInsertRow(dataInsert RECORD LIKE clients.*)
    RETURNS (INTEGER, STRING, RECORD LIKE clients.*)

    DEFINE errNo INTEGER
    DEFINE errMsg STRING

    DISPLAY "dataEvent_record1_BeforeInsertRow (Row scope) is raised"

    RETURN errNo, errMsg, dataInsert.*
END FUNCTION

PUBLIC FUNCTION dataEvent_record1_AfterInsertRow(errNo INTEGER, errMsg STRING, uniqueKey record1_br_uk_type)
    RETURNS (INTEGER, STRING)

    DISPLAY "dataEvent_record1_AfterInsertRow (Row scope) is raised"

    RETURN errNo, errMsg
END FUNCTION

PUBLIC FUNCTION dlgEvent_AfterField_record1(dlg ui.DIALOG, uiMode SMALLINT, dlgCtrlInstruction libdbappEvents.DlgCtrlInstruction_Type, currentField STRING)
    RETURNS (libdbappEvents.DlgCtrlInstruction_Type)

    DISPLAY "dlgEvent_AfterField_record1 (Field scope) is raised"

    CASE currentField
    
      WHEN "primaryemail"
      
      WHEN "primaryphone"
      
      WHEN "workphone"
      
      WHEN "mobilephone"
      
      WHEN "workextension"      
      
      WHEN "workextension"      
      
    END CASE

    RETURN dlgCtrlInstruction
END FUNCTION

PUBLIC FUNCTION dlgEvent_OnActionAccept(dlg ui.DIALOG, uiMode SMALLINT, dlgCtrlInstruction libdbappEvents.DlgCtrlInstruction_Type)
    RETURNS (libdbappEvents.DlgCtrlInstruction_Type)

    DISPLAY "dlgEvent_OnActionAccept (Form scope) is raised"

    RETURN dlgCtrlInstruction
END FUNCTION
