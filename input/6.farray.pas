PROGRAM func;
VAR i : LONGINT;
    a : ARRAY [1..10] OF LONGINT;
   
FUNCTION t : LONGINT;
VAR i, s : LONGINT; 
    b : ARRAY [2..11] OF LONGINT;
BEGIN
	i := 2;
	WHILE (i <=11) DO
        BEGIN
          b[i] := a[i-1];
          i := i + 1
        END;

	EXIT(b[5])
END;

BEGIN
  i := 1;
  WHILE (i <= 10) DO
  BEGIN
    a[i] := i;
    i := i + 1
  END;

  i := t();
  WRITELN(i)
END.
