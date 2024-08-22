PROGRAM func;
VAR a, b : LONGINT;
   
FUNCTION t : LONGINT;
VAR a : LONGINT; 
    b : ARRAY [0..9] OF LONGINT;
BEGIN
	b[3] := 5;
	a := 2;
	WRITELN(a);
	EXIT(a+b[3])
END;

BEGIN
  a := 1;
  b := t();
  WRITELN(a+b)
END.
