CLS

'Made using QB64
'Any Issues or suggestion? Create an issue using the link(https://github.com/Creativeminds0987/Dictionary/issues)
'Found a flaw? Create an issue using the link(https://github.com/Creativeminds0987/Dictionary/issues)

_TITLE "OPENSOURCE DICTIONARY BOT"
CONST DATFILE = "Data.txt"
DIM SHARED LINE$(1 TO 1000000) 'need base 1
DIM SHARED Lines AS LONG

OPEN DATFILE FOR APPEND AS #1
CLOSE #1
OPEN DATFILE FOR INPUT AS #1
WHILE NOT EOF(1)
    Lines = Lines + 1
    INPUT #1, LINE$(Lines)
WEND
CLOSE #1
PRINT "LOADED" + STR$(Lines) + "ASSETS"

DIM SHARED Commands(1 TO 6) AS STRING
Commands(1) = "show "
Commands(2) = "bye"
Commands(3) = "good bye"
Commands(4) = "goodbye"
Commands(5) = "shutup"
Commands(6) = "shut up"

DIM SHARED Parameters(1 TO 5) AS STRING
Parameters(1) = "data"
Parameters(2) = "time"
Parameters(3) = "date"
Parameters(4) = "today"
Parameters(5) = "commands"

DO
    found = 0
    LINE INPUT "Input >> ", in$
    modIN$ = RemovePunctuation$(in$)
    testInterpret = Interpret(modIN$)
    IF testInterpret = 0 THEN
        FOR n = 1 TO Lines STEP 2
            IF modIN$ = RemovePunctuation$(LINE$(n)) THEN
                found = n
                EXIT FOR
            END IF
        NEXT
        IF found THEN
            PRINT LINE$(found + 1)
        ELSE

            PRINT "This text is not there in my database! plese, raise an issue on Github(https://github.com/Creativeminds0987/Dictionary/issues) and click enter to continue."
            IF res$ <> "" THEN
                modRes$ = RemovePunctuation$(res$)
                test = Interpret(modRes$)
                IF test = 0 THEN
                    OPEN DATFILE FOR APPEND AS #1
                    WRITE #1, in$
                    WRITE #1, res$
                    CLOSE #1

                    LINE$(Lines + 1) = in$
                    LINE$(Lines + 2) = res$
                    Lines = Lines + 2
                ELSE
                END IF
            END IF
        END IF
    END IF
LOOP

FUNCTION RemovePunctuation$ (s$)
    FOR i = 1 TO LEN(s$)
        IF INSTR(".,?!;:", MID$(s$, i, 1)) <= 0 THEN
            b$ = b$ + LCASE$(MID$(s$, i, 1))
        END IF
    NEXT
    RemovePunctuation$ = b$
END FUNCTION
SUB ShowData
    FOR i = 1 TO Lines STEP 2
        PRINT i, LINE$(i)
        PRINT i + 1, LINE$(i + 1)
        PRINT
        IF i MOD 10 = 0 THEN
            PRINT
            INPUT "Press enter to see the complete database or click any other to quit database display."; cont$
            IF LEN(cont$) THEN EXIT FOR
        END IF
    NEXT
    INPUT "End of Data, Press enter to continue... any other to quit."; cont$
    IF LEN(cont$) THEN END
END SUB
FUNCTION Interpret% (s$)
    Interpret = 1
    IF s$ = "bye" OR s$ = "Bye" OR s$ = "BYe" OR s$ = "good bye" OR s$ = "goodbye" OR s$ = "shutup" OR s$ = "shut up" THEN
        INPUT "Exit dictionary bot? type exit to close the bot. Thanks for using opensource dictionary bot", cont$
        IF LEFT$(LCASE$(cont$), 1) = "exit" THEN END ELSE EXIT FUNCTION
    END IF
    FOR i = LBOUND(Commands) TO UBOUND(Commands)
        IF INSTR(s$, Commands(i)) > 0 THEN
            FOR j = LBOUND(Parameters) TO UBOUND(Parameters)
                IF INSTR(s$, Parameters(j)) > 0 THEN
                    SELECT CASE Commands(i) + Parameters(j)
                        CASE "show  data": ShowData: EXIT FUNCTION
                        CASE "show  time", "show  date", "show  today": PRINT DATE$ + " " + TIME$: EXIT FUNCTION
                        CASE "show  commands"
                            CLS
                            FOR k = LBOUND(commands) TO UBOUND(commands)
                                PRINT "Command"; k, Commands(k)
                                lineCount = lineCount + 1
                                IF lineCount MOD 25 = 24 THEN
                                    INPUT "Press enter to continue, any other to quit ", cont$
                                    IF LEN(cont$) THEN EXIT FUNCTION
                                    CLS: lineCount = 0
                                END IF
                            NEXT
                            FOR k = LBOUND(pashsssSSSSrameters) TO UBOUND(parameters)
                                PRINT "Parameter"; k, Parameters(k)
                                IF lineCount MOD 25 = 24 THEN
                                    INPUT "Press enter to continue, any other to quit ", cont$
                                    IF LEN(cont$) THEN EXIT FUNCTION
                                    CLS: lineCount = 0
                                END IF
                            NEXT
                            EXIT FUNCTION
                    END SELECT
                END IF
            NEXT
        END IF
    NEXT
    Interpret = 0
END FUNCTION
' Thanks for using opensource dictionary bot
