#+ DB schema - Common (consultcompanion)

--------------------------------------------------------------------------------
--This code is generated with the template dbapp5.0

--------------------------------------------------------------------------------
--Database schema
SCHEMA consultcompanion

-- PRIMARY KEY TYPES - TABLE LEVEL

PUBLIC TYPE seqreg_pk
    RECORD
        seqreg_sr_name LIKE seqreg.sr_name
    END RECORD

PUBLIC TYPE rfs_pk
    RECORD
        rfs_rfsId LIKE rfs.rfsId
    END RECORD

PUBLIC TYPE provinces_pk
    RECORD
        provinces_provinceid LIKE provinces.provinceid
    END RECORD

PUBLIC TYPE projects_pk
    RECORD
        projects_projectId LIKE projects.projectId
    END RECORD

PUBLIC TYPE preferences_pk
    RECORD
        preferences_seqid LIKE preferences.seqid
    END RECORD

PUBLIC TYPE paymentterms_pk
    RECORD
        paymentterms_paytermid LIKE paymentterms.paytermid
    END RECORD

PUBLIC TYPE offerstatuses_pk
    RECORD
        offerstatuses_offerstatusid LIKE offerstatuses.offerstatusid
    END RECORD

PUBLIC TYPE employeetypes_pk
    RECORD
        employeetypes_emptypeid LIKE employeetypes.emptypeid
    END RECORD

PUBLIC TYPE employees_pk
    RECORD
        employees_employeeid LIKE employees.employeeid
    END RECORD

PUBLIC TYPE country_pk
    RECORD
        country_countryid LIKE country.countryid
    END RECORD

PUBLIC TYPE clienttypes_pk
    RECORD
        clienttypes_clienttypeid LIKE clienttypes.clienttypeid
    END RECORD

PUBLIC TYPE clientstakeholders_pk
    RECORD
        clientstakeholders_stakeholderId LIKE clientstakeholders.stakeholderId
    END RECORD

PUBLIC TYPE clients_pk
    RECORD
        clients_clientid LIKE clients.clientid
    END RECORD
