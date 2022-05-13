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
        employees_employeeid LIKE employees.employeeid,
        employees_empname LIKE employees.empname,
        employees_emptype LIKE employees.emptype,
        employees_address1 LIKE employees.address1,
        employees_address2 LIKE employees.address2,
        employees_city LIKE employees.city,
        employees_provinceId LIKE employees.provinceId,
        employees_countryid LIKE employees.countryid,
        employees_postalzip LIKE employees.postalzip,
        employees_mobilephone LIKE employees.mobilephone,
        employees_workphone LIKE employees.workphone,
        employees_homephone LIKE employees.homephone,
        employees_primaryphone LIKE employees.primaryphone,
        employees_dayRate LIKE employees.dayRate
    END RECORD

PUBLIC TYPE record1_br_uk_type
    RECORD
        employees_employeeid LIKE employees.employeeid
    END RECORD

PUBLIC DEFINE m_where STRING --The WHERE clause to fetch the data set
PUBLIC DEFINE m_detailList STRING --The list of details to fetch the data set
PUBLIC DEFINE m_whereRelation STRING --The part of the WHERE clause defined by entity relations in the BA
PUBLIC DEFINE m_record1_arrRecList DYNAMIC ARRAY OF record1_br_type
PUBLIC DEFINE m_record1_arrRecDB DYNAMIC ARRAY OF RECORD LIKE employees.*
PUBLIC DEFINE m_record1_keyIndex INTEGER
