PROGRAM func;
VAR a : LONGINT;

FUNCTION t : LONGINT;
BEGIN
	WRITELN('inside function');
	EXIT(10)
END;

BEGIN
  a := t();
  WRITELN(a)
END.
