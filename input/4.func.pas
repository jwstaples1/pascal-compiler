PROGRAM func;
VAR a, b : LONGINT;

FUNCTION t : LONGINT;
VAR a : LONGINT; 
BEGIN
	b := 5;
	a := 2;
	WRITELN(a);
	EXIT(a+b)
END;

BEGIN
  a := 1;
  b := t();
  WRITELN(a+b)
END.
