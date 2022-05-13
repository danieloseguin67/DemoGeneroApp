#+ Database creation script for Microsoft SQL Server 2008 and higher
#+
#+ Note: This script is a helper script to create an empty database schema
#+       Adapt it to fit your needs

MAIN
    DATABASE consultcompanion

    CALL db_drop_constraints()
    CALL db_drop_tables()
    CALL db_create_tables()
    CALL db_add_constraints()

    #+ load predefined values in the drop down list tables of the application
    CALL db_add_predefinedvalues()
    
    CALL db_update_seqreg()
    
END MAIN


#+ Create all tables in database.
FUNCTION db_create_tables()

    WHENEVER ERROR STOP

    EXECUTE IMMEDIATE "CREATE TABLE seqreg (
        sr_name VARCHAR(30) NOT NULL,
        sr_last INTEGER NOT NULL)"
        
    EXECUTE IMMEDIATE "CREATE TABLE preferences (
        seqid INTEGER NOT NULL)"
        
    EXECUTE IMMEDIATE "CREATE TABLE clients (
        clientid int NOT NULL,
        clientname CHAR(30) NOT NULL,
        address1 CHAR(60) NOT NULL,
        address2 CHAR(60),
        city CHAR(30) NOT NULL,
        provinceid INTEGER NOT NULL,
        postalzip CHAR(10) NOT NULL,
        primarycontact CHAR(30) NOT NULL,
        primaryemail CHAR(80) NOT NULL,
        clienttypeid INTEGER NOT NULL,
        preferred BOOLEAN NOT NULL,
        paytermid INTEGER NOT NULL,
        primaryphone CHAR(1) NOT NULL,
        homephone CHAR(15),
        workphone CHAR(15),
        mobilephone CHAR(15),
        workextension CHAR(10),
        countryid INTEGER NOT NULL)"
        
    EXECUTE IMMEDIATE "CREATE TABLE provinces (
        provinceid int NOT NULL,
        provincename CHAR(30) NOT NULL,
        countryid INTEGER NOT NULL)"
        
    EXECUTE IMMEDIATE "CREATE TABLE clienttypes (
        clienttypeid INTEGER NOT NULL,
        clientypename CHAR(30) NOT NULL)"
        
    EXECUTE IMMEDIATE "CREATE TABLE paymentterms (
        paytermid INTEGER NOT NULL,
        paytermname CHAR(30) NOT NULL,
        paytermdays INTEGER NOT NULL)"
        
    EXECUTE IMMEDIATE "CREATE TABLE clientstakeholders (
        clientid int NOT NULL,
        stakeholderid int NOT NULL,
        stakeholdername CHAR(30) NOT NULL)"
        
    EXECUTE IMMEDIATE "CREATE TABLE employees (
        employeeid int NOT NULL,
        empname CHAR(30) NOT NULL,
        emptype INTEGER NOT NULL,
        address1 CHAR(60) NOT NULL,
        address2 CHAR(60),
        city CHAR(30) NOT NULL,
        provinceid INTEGER NOT NULL,
        postalzip CHAR(10) NOT NULL,
        mobilephone CHAR(15),
        workphone CHAR(15),
        homephone CHAR(15),
        primaryphone CHAR(1) NOT NULL,
        dayrate DECIMAL(5,2) NOT NULL,
        countryid INTEGER NOT NULL)"
        
    EXECUTE IMMEDIATE "CREATE TABLE employeetypes (
        emptypeid int NOT NULL,
        emptypename CHAR(30) NOT NULL)"
        
    EXECUTE IMMEDIATE "CREATE TABLE projects (
        projectid INTEGER NOT NULL,
        projectname CHAR(30) NOT NULL)"
        
    EXECUTE IMMEDIATE "CREATE TABLE rfs (
        rfsid INTEGER NOT NULL,
        clientid INTEGER NOT NULL,
        stakeholderid INTEGER NOT NULL,
        offernumber CHAR(20),
        offertitle CHAR(60) NOT NULL,
        offerdate DATE NOT NULL,
        offersubmitted DATE,
        offerstatusid INTEGER NOT NULL,
        interviewdate DATE,
        offerlink TEXT,
        offernote TEXT,
        accepteddate DATE)"
        
    EXECUTE IMMEDIATE "CREATE TABLE offerstatuses (
        offerstatusid INTEGER NOT NULL,
        offerstatusname CHAR(30) NOT NULL)"

    EXECUTE IMMEDIATE "CREATE TABLE country (
        countryid INTEGER NOT NULL,
        countryname CHAR(30) NOT NULL)"
        
END FUNCTION


#+ Drop all tables from database.
FUNCTION db_drop_tables()

    WHENEVER ERROR CONTINUE

    EXECUTE IMMEDIATE "DROP TABLE seqreg"
    EXECUTE IMMEDIATE "DROP TABLE preferences"
    EXECUTE IMMEDIATE "DROP TABLE clients"
    EXECUTE IMMEDIATE "DROP TABLE provinces"
    EXECUTE IMMEDIATE "DROP TABLE clienttypes"
    EXECUTE IMMEDIATE "DROP TABLE paymentterms"
    EXECUTE IMMEDIATE "DROP TABLE clientstakeholders"
    EXECUTE IMMEDIATE "DROP TABLE employees"
    EXECUTE IMMEDIATE "DROP TABLE employeetypes"
    EXECUTE IMMEDIATE "DROP TABLE projects"
    EXECUTE IMMEDIATE "DROP TABLE rfs"
    EXECUTE IMMEDIATE "DROP TABLE offerstatuses"
    EXECUTE IMMEDIATE "DROP TABLE country"

END FUNCTION


#+ Add constraints for all tables.
FUNCTION db_add_constraints()

    WHENEVER ERROR STOP

    #+ set primary keys
    EXECUTE IMMEDIATE "ALTER TABLE seqreg ADD CONSTRAINT pk_seqreg
        PRIMARY KEY (sr_name)"
    EXECUTE IMMEDIATE "ALTER TABLE preferences ADD CONSTRAINT pk_preferences_1
        PRIMARY KEY (seqid)"
    EXECUTE IMMEDIATE "ALTER TABLE clients ADD CONSTRAINT pk_clients_1
        PRIMARY KEY (clientid)"
    EXECUTE IMMEDIATE "ALTER TABLE provinces ADD CONSTRAINT pk_provinces_1
        PRIMARY KEY (provinceid)"
    EXECUTE IMMEDIATE "ALTER TABLE clienttypes ADD CONSTRAINT pk_clienttypes_1
        PRIMARY KEY (clienttypeid)"
    EXECUTE IMMEDIATE "ALTER TABLE paymentterms ADD CONSTRAINT pk_paymentterms_1
        PRIMARY KEY (paytermid)"
    EXECUTE IMMEDIATE "ALTER TABLE clientstakeholders ADD CONSTRAINT pk_clientstakeholders_1
        PRIMARY KEY (stakeholderid)"
    EXECUTE IMMEDIATE "ALTER TABLE employees ADD CONSTRAINT pk_employees_1
        PRIMARY KEY (employeeid)"
    EXECUTE IMMEDIATE "ALTER TABLE employeetypes ADD CONSTRAINT pk_employeetypes_1
        PRIMARY KEY (emptypeid)"
    EXECUTE IMMEDIATE "ALTER TABLE projects ADD CONSTRAINT pk_projects_1
        PRIMARY KEY (projectid)"
    EXECUTE IMMEDIATE "ALTER TABLE rfs ADD CONSTRAINT pk_rfs_1
        PRIMARY KEY (rfsid)"
    EXECUTE IMMEDIATE "ALTER TABLE offerstatuses ADD CONSTRAINT pk_offerstatuses_1
        PRIMARY KEY (offerstatusid)"
    EXECUTE IMMEDIATE "ALTER TABLE country ADD CONSTRAINT pk_country_1
        PRIMARY KEY (countryid)"        

    #+ set foreign keys
    EXECUTE IMMEDIATE "ALTER TABLE clients ADD CONSTRAINT fk_clients_provinces_1
        FOREIGN KEY (provinceid)
        REFERENCES provinces (provinceid)"
    EXECUTE IMMEDIATE "ALTER TABLE clients ADD CONSTRAINT fk_clients_clienttypes_1
        FOREIGN KEY (clienttypeid)
        REFERENCES clienttypes (clienttypeid)"
    EXECUTE IMMEDIATE "ALTER TABLE clients ADD CONSTRAINT fk_clients_paymentterms_1
        FOREIGN KEY (paytermid)
        REFERENCES paymentterms (paytermid)"
    EXECUTE IMMEDIATE "ALTER TABLE clientstakeholders ADD CONSTRAINT fk_clientstakeholders_clients_1
        FOREIGN KEY (clientid)
        REFERENCES clients (clientid)"
    EXECUTE IMMEDIATE "ALTER TABLE employees ADD CONSTRAINT fk_employees_provinces_1
        FOREIGN KEY (provinceid)
        REFERENCES provinces (provinceid)"
    EXECUTE IMMEDIATE "ALTER TABLE employees ADD CONSTRAINT fk_employees_employeetypes_1
        FOREIGN KEY (emptype)
        REFERENCES employeetypes (emptypeid)"
    EXECUTE IMMEDIATE "ALTER TABLE rfs ADD CONSTRAINT fk_rfs_clients_1
        FOREIGN KEY (clientid)
        REFERENCES clients (clientid)"
    EXECUTE IMMEDIATE "ALTER TABLE rfs ADD CONSTRAINT fk_rfs_clientstakeholders_1
        FOREIGN KEY (stakeholderid)
        REFERENCES clientstakeholders (stakeholderid)"
    EXECUTE IMMEDIATE "ALTER TABLE rfs ADD CONSTRAINT fk_rfs_offerstatuses_1
        FOREIGN KEY (offerstatusid)
        REFERENCES offerstatuses (offerstatusid)"
    EXECUTE IMMEDIATE "ALTER TABLE clients ADD CONSTRAINT fk_clients_country_1
        FOREIGN KEY (countryid)
        REFERENCES country (countryid)"
    EXECUTE IMMEDIATE "ALTER TABLE provinces ADD CONSTRAINT fk_provinces_country_1
        FOREIGN KEY (countryid)
        REFERENCES country (countryid)"    
    EXECUTE IMMEDIATE "ALTER TABLE employees ADD CONSTRAINT fk_employees_country_1
        FOREIGN KEY (countryid)
        REFERENCES country (countryid)"

END FUNCTION


#+ Drop all constraints from all tables.
FUNCTION db_drop_constraints()

    WHENEVER ERROR CONTINUE

    EXECUTE IMMEDIATE "ALTER TABLE clients DROP CONSTRAINT fk_clients_provinces_1"
    EXECUTE IMMEDIATE "ALTER TABLE clients DROP CONSTRAINT fk_clients_clienttypes_1"
    EXECUTE IMMEDIATE "ALTER TABLE clients DROP CONSTRAINT fk_clients_paymentterms_1"
    EXECUTE IMMEDIATE "ALTER TABLE clientstakeholders DROP CONSTRAINT fk_clientstakeholders_clients_1"
    EXECUTE IMMEDIATE "ALTER TABLE employees DROP CONSTRAINT fk_employees_provinces_1"
    EXECUTE IMMEDIATE "ALTER TABLE employees DROP CONSTRAINT fk_employees_employeetypes_1"
    EXECUTE IMMEDIATE "ALTER TABLE rfs DROP CONSTRAINT fk_rfs_clients_1"
    EXECUTE IMMEDIATE "ALTER TABLE rfs DROP CONSTRAINT fk_rfs_clientstakeholders_1"
    EXECUTE IMMEDIATE "ALTER TABLE rfs DROP CONSTRAINT fk_rfs_offerstatuses_1"
    EXECUTE IMMEDIATE "ALTER TABLE clients DROP CONSTRAINT fk_clients_country_1"
    EXECUTE IMMEDIATE "ALTER TABLE provinces DROP CONSTRAINT fk_provinces_country_1"
    EXECUTE IMMEDIATE "ALTER TABLE employees DROP CONSTRAINT fk_employees_country_1"    
    
END FUNCTION


#+ Update the System table handling the serial sequence generators
FUNCTION db_update_seqreg()

    CALL db_update_seqreg_value("preferences", "seqid")
    CALL db_update_seqreg_value("clients", "clientid")
    CALL db_update_seqreg_value("provinces", "provinceid")
    CALL db_update_seqreg_value("clienttypes", "clienttypeid")
    CALL db_update_seqreg_value("paymentterms", "paytermid")
    CALL db_update_seqreg_value("clientstakeholders", "stakeholderid")
    CALL db_update_seqreg_value("employees", "employeeid")
    CALL db_update_seqreg_value("employeetypes", "emptypeid")
    CALL db_update_seqreg_value("projects", "projectid")
    CALL db_update_seqreg_value("rfs", "rfsid")
    CALL db_update_seqreg_value("offerstatuses", "offerstatusid")
    CALL db_update_seqreg_value("country", "countryid")
     
END FUNCTION


#+ Update the System table handling the serial sequence generators for the
#+ given table and field
#+ 
#+ @param tableName Name of the table using a serial sequence generator
#+ @param serialFieldName Name of the serial field
FUNCTION db_update_seqreg_value(tableName, serialFieldName)

    DEFINE
        tableName       STRING,
        serialFieldName STRING,
        lastSerial      INTEGER

    WHENEVER ERROR STOP

    DELETE FROM seqreg WHERE sr_name = tableName

    # Get the largest serial value found in the table data
    PREPARE selectmax FROM "SELECT MAX(" || serialFieldName || ") FROM " || tableName
    EXECUTE selectmax INTO lastSerial
    FREE selectmax

    IF lastSerial IS NULL THEN
        LET lastSerial = 0
    END IF

    INSERT INTO seqreg(sr_name, sr_last) VALUES (tableName, lastSerial)
    
END FUNCTION


FUNCTION db_add_predefinedvalues()

   #+ populate client types
   INSERT INTO clienttypes VALUES (1,"Direct Client")
   INSERT INTO clienttypes VALUES (2,"Agency Client")
   INSERT INTO clienttypes VALUES (3,"Government Client")
   
   #+ populate employee types
   INSERT INTO employeetypes VALUES (1,"Full-time")
   INSERT INTO employeetypes VALUES (2,"Part-time")
   
   #+ populate offer statuses
   INSERT INTO offerstatuses VALUES (1,"New")
   INSERT INTO offerstatuses VALUES (2,"Waiting confirmation")
   INSERT INTO offerstatuses VALUES (3,"Waiting for inteview")
   INSERT INTO offerstatuses VALUES (4,"Interview scheduled")
   INSERT INTO offerstatuses VALUES (5,"Waiting for interview results")
   INSERT INTO offerstatuses VALUES (6,"Accepted")
   INSERT INTO offerstatuses VALUES (7,"Not accepted")
   INSERT INTO offerstatuses VALUES (8,"Cancelled")
   
   #+ populate payment terms
   INSERT INTO paymentterms VALUES (1,"Net 15",15)
   INSERT INTO paymentterms VALUES (2,"Net 30",30)
   INSERT INTO paymentterms VALUES (3,"Cash",0)

   #+ populate countries
   INSERT INTO country VALUES (1,"Canada")
   INSERT INTO country VALUES (2,"United States of America")
   INSERT INTO country VALUES (3,"Mexico")
   
   #+ populate provinces
   #+ Canada provinces   
   INSERT INTO provinces VALUES (1,"Quebec",1)
   INSERT INTO provinces VALUES (2,"Ontario",1)
   INSERT INTO provinces VALUES (3,"Manitoba",1)
   INSERT INTO provinces VALUES (4,"Saskatchewan",1)
   INSERT INTO provinces VALUES (5,"Alberta",1)
   INSERT INTO provinces VALUES (6,"Colombie-Britannique",1)
   INSERT INTO provinces VALUES (7,"Terre-Neuve",1)
   INSERT INTO provinces VALUES (8,"Nouveau-Brunswick",1)
   INSERT INTO provinces VALUES (9,"Nouvelle-Ecosse",1)
   INSERT INTO provinces VALUES (10,"Ile du Prince Edouard",1)
   INSERT INTO provinces VALUES (11,"Yukon",1)
   INSERT INTO provinces VALUES (12,"Nunavut",1)
   INSERT INTO provinces VALUES (13,"Territoire du Nord Ouest",1)
   #+ USA states
   INSERT INTO provinces VALUES (14,"TX",2)
   #+ Mexico states
   INSERT INTO provinces VALUES (15,"MX",3)
   
END FUNCTION
    
