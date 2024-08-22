PROGRAM messy;
VAR a : LONGINT;
    b : ARRAY [1..10] OF LONGINT;

FUNCTION f1 : LONGINT;
VAR a : LONGINT; 
BEGIN
	a := 10;
	WHILE (a > 0) DO
        BEGIN
          b[a] := b[a]-1;
          a := a - 1
        END;

	EXIT(b[5])
END;
   
FUNCTION f2 : LONGINT;
VAR b : LONGINT; 
    a : ARRAY [2..11] OF LONGINT;
BEGIN
	b := 2;
	WHILE (b <= 11) DO
        BEGIN
          IF (b < 5) THEN
             a[b] := 0
          ELSE
             a[b] := 1;

          b := b + 1
        END;

	EXIT(a[10])
END;

BEGIN
  a := 1;
  WHILE (a <= 10) DO
  BEGIN
    b[a] := a*a;
    a := a + 1
  END;
  
  WRITELN(f1());
  WRITELN(a);
  WRITELN(f2());
  WRITELN(a);
  WRITELN(b[10])
END.
