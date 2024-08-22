PROGRAM func;
VAR a : LONGINT;

FUNCTION t : LONGINT;
VAR b : LONGINT; 
BEGIN
	WRITELN('inside function');
	b := 10;
	EXIT(b+5)
END;

BEGIN
  a := t();
  WRITELN(a)
END.
