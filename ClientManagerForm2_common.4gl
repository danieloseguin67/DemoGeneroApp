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
        clients_clientid LIKE clients.clientid,
        clients_clientname LIKE clients.clientname,
        clients_address1 LIKE clients.address1,
        clients_address2 LIKE clients.address2,
        clients_city LIKE clients.city,
        clients_provinceid LIKE clients.provinceid,
        clients_postalzip LIKE clients.postalzip,
        clients_primarycontact LIKE clients.primarycontact,
        clients_primaryemail LIKE clients.primaryemail,
        clients_clienttypeid LIKE clients.clienttypeid,
        clients_preferred LIKE clients.preferred,
        clients_paytermid LIKE clients.paytermid,
        clients_primaryphone LIKE clients.primaryphone,
        clients_homephone LIKE clients.homephone,
        clients_workphone LIKE clients.workphone,
        clients_mobilephone LIKE clients.mobilephone,
        clients_workextension LIKE clients.workextension,
        clients_countryid LIKE clients.countryid
    END RECORD

PUBLIC TYPE record1_br_uk_type
    RECORD
        clients_clientid LIKE clients.clientid
    END RECORD

PUBLIC DEFINE m_where STRING --The WHERE clause to fetch the data set
PUBLIC DEFINE m_detailList STRING --The list of details to fetch the data set
PUBLIC DEFINE m_whereRelation STRING --The part of the WHERE clause defined by entity relations in the BA
PUBLIC DEFINE m_record1_arrRecList DYNAMIC ARRAY OF record1_br_type
PUBLIC DEFINE m_record1_arrRecDB DYNAMIC ARRAY OF RECORD LIKE clients.*
PUBLIC DEFINE m_record1_keyIndex INTEGER
