PROGRAM func;
VAR a, b : LONGINT;

FUNCTION t : LONGINT;
VAR a : LONGINT; 
BEGIN
	a := 2;
	WRITELN(a);
	EXIT(a+1)
END;

BEGIN
  a := 1;
  b := t();
  WRITELN(a+b)
END.
