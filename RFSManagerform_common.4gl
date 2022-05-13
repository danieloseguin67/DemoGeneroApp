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
        rfs_rfsId LIKE rfs.rfsId,
        rfs_clientid LIKE rfs.clientid,
        rfs_stakeholderId LIKE rfs.stakeholderId,
        rfs_offernumber LIKE rfs.offernumber,
        rfs_offertitle LIKE rfs.offertitle,
        rfs_offerdate LIKE rfs.offerdate,
        rfs_offersubmitted LIKE rfs.offersubmitted,
        rfs_offerstatusid LIKE rfs.offerstatusid,
        rfs_interviewdate LIKE rfs.interviewdate,
        rfs_offerlink LIKE rfs.offerlink,
        rfs_offernote LIKE rfs.offernote,
        rfs_accepteddate LIKE rfs.accepteddate
    END RECORD

PUBLIC TYPE record1_br_uk_type
    RECORD
        rfs_rfsId LIKE rfs.rfsId
    END RECORD

PUBLIC DEFINE m_where STRING --The WHERE clause to fetch the data set
PUBLIC DEFINE m_detailList STRING --The list of details to fetch the data set
PUBLIC DEFINE m_whereRelation STRING --The part of the WHERE clause defined by entity relations in the BA
PUBLIC DEFINE m_record1_arrRecList DYNAMIC ARRAY OF record1_br_type
PUBLIC DEFINE m_record1_arrRecDB DYNAMIC ARRAY OF RECORD LIKE rfs.*
PUBLIC DEFINE m_record1_keyIndex INTEGER
