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
IMPORT FGL ClientZoom_common

--------------------------------------------------------------------------------
--Database schema
SCHEMA consultcompanion

-- Declare your PUBLIC module variables here.
PUBLIC DEFINE dlgCtrlInstruction libdbappEvents.DlgCtrlInstruction_Type
