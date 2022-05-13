#+ User Interface - Common

--------------------------------------------------------------------------------
--This code is generated with the template dbapp5.0

--------------------------------------------------------------------------------
--Importing modules

--------------------------------------------------------------------------------
--Database schema
SCHEMA consultcompanion

--------------------------------------------------------------------------------
--Definition of constants, user-types, variables
PUBLIC TYPE record1_br_type
    RECORD
        offerstatuses_offerstatusid LIKE offerstatuses.offerstatusid,
        offerstatuses_offerstatusname LIKE offerstatuses.offerstatusname
    END RECORD

PUBLIC TYPE record1_br_uk_type
    RECORD
        offerstatuses_offerstatusid LIKE offerstatuses.offerstatusid
    END RECORD

PUBLIC DEFINE m_where STRING --The WHERE clause to fetch the data set
PUBLIC DEFINE m_detailList STRING --The list of details to fetch the data set
PUBLIC DEFINE m_whereRelation STRING --The part of the WHERE clause defined by entity relations in the BA
PUBLIC DEFINE m_record1_arrRecList DYNAMIC ARRAY OF record1_br_type
PUBLIC DEFINE m_record1_arrRecDB DYNAMIC ARRAY OF RECORD LIKE offerstatuses.*
PUBLIC DEFINE m_record1_keyIndex INTEGER
