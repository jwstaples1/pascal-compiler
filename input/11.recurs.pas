
PROGRAM foo;
  VAR a:LONGINT;

FUNCTION decls : LONGINT;
BEGIN
  WRITELN(a);
  IF (a > 0) THEN
  BEGIN
    a := a - 1;
    EXIT(decls())
  END
  ELSE BEGIN
    a := 0;
    EXIT(a)
  END
END;

BEGIN
  WRITE('Enter a:'); 
  READ(a);
  WRITELN(decls())
END.
