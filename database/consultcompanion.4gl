IMPORT FGL libdbappCore

IMPORT FGL libdbappEvents
IMPORT FGL consultcompanion_common

--------------------------------------------------------------------------------
--Database schema
SCHEMA consultcompanion

-- Declare your PUBLIC module variables here.
PUBLIC DEFINE dlgCtrlInstruction libdbappEvents.DlgCtrlInstruction_Type

PUBLIC FUNCTION dbxDataEvent_clients_BeforeInsertRowByKey(p_data RECORD LIKE clients.*)
    RETURNS (INTEGER, STRING, RECORD LIKE clients.*)

    DEFINE errNo INTEGER
    DEFINE errMsg STRING

    DISPLAY "dbxDataEvent_clients_BeforeInsertRowByKey (Table scope) is raised"

    RETURN errNo, errMsg, p_data.*
END FUNCTION
