{<CODEFILE Path="LogonForm.code" Hash="4cMhYN8rWDjxf3529Egiyg==" />}
#+ User Interface

--------------------------------------------------------------------------------
--This code is generated with the template dbapp5.0
--Warning: Enter your changes within a <BLOCK> or <POINT> section, otherwise they will be lost.
{<POINT Name="user.comments">} {</POINT>}

--------------------------------------------------------------------------------
--Importing modules
IMPORT FGL libdbappCore
IMPORT FGL libdbappFormUI
{<POINT Name="import" Status="MODIFIED">}
DATABASE consultcompanion {</POINT>}

--------------------------------------------------------------------------------
--Definition of constants, user-types, variables
PUBLIC TYPE record1_br_type
    RECORD
        login CHAR(12),
        password CHAR(50)
    END RECORD

{<POINT Name="define">} {</POINT>}

--------------------------------------------------------------------------------
--Functions

{<BLOCK Name="fct.uiOpenForm">}
#+ Launch the module
#+
#+ @param p_whereRelation   Part of the WHERE clause defined by entity relations in the BA
#+ @param p_uiSettings      UI Settings defined on the relation
PUBLIC FUNCTION LogonForm_ui_uiOpenForm(p_whereRelation, p_uiSettings)
    DEFINE p_whereRelation STRING
    DEFINE p_uiSettings UISettings_Type
    DEFINE errNo INTEGER
    DEFINE actionNo SMALLINT

    {<POINT Name="fct.uiOpenForm.user" Status="MODIFIED">} 
    DEFINE rec record1_br_type
    DEFINE ok BOOLEAN
    DEFINE errMsg STRING

    LET ok = false
    OPEN WINDOW w_SimpleFormLogin WITH FORM 'LogonForm' ATTRIBUTE (STYLE="login")
    INPUT rec.* FROM record1.* ATTRIBUTES (UNBUFFERED)
        ON ACTION dialogtouched
            MESSAGE ""
        ON ACTION accept
            IF rec.login IS NULL THEN
                ERROR "login is required"
                IF INFIELD(record1.password) THEN
                    NEXT FIELD record1.login
                END IF
            ELSE
                IF rec.password IS NULL THEN
                    ERROR "password is required"
                    IF INFIELD(record1.login) THEN
                        NEXT FIELD record1.password
                    END IF
                ELSE
                    CALL signIn(rec.login, rec.password) RETURNING ok, errMsg
                    IF NOT ok THEN
                        ERROR errMsg
                        NEXT FIELD record1.login
                    END IF
                    EXIT INPUT
               END IF
            END IF
        ON ACTION cancel
            EXIT INPUT
    END INPUT

    CLOSE WINDOW w_SimpleFormLogin

    {</POINT>}
    RETURN errNo, actionNo
END FUNCTION
{</BLOCK>} --fct.uiOpenForm

--------------------------------------------------------------------------------
--Add user functions
{<POINT Name="user.functions" Status="MODIFIED">} 
FUNCTION signIn(p_username,  p_password)
    DEFINE p_username CHAR(10)
    DEFINE p_password CHAR(20)
    DEFINE l_answer STRING
    DEFINE l_ok BOOLEAN = true
{
    DEFINE p_username LIKE appusers.username
    DEFINE p_password LIKE appusers.userpwd
    DEFINE l_pwd LIKE appusers.userpwd

       SELECT userpwd
       INTO l_pwd
       FROM appusers
       WHERE username = p_username

    IF sqlca.sqlcode <> 0 THEN
       LET l_ok = FALSE
       LET l_answer = "You have entered an invalid user name, please try again"
    ELSE
       IF p_password != l_pwd THEN
          LET l_ok = FALSE
          LET l_answer = "The entered password does not match the user's password"
       END if
    END if    

 }   
    RETURN l_ok, l_answer
    
END FUNCTION
{</POINT>}
