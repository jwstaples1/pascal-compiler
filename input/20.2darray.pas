PROGRAM twoDArray;
VAR  a : ARRAY[1..10, 1..20] OF LONGINT;

FUNCTION local : LONGINT;
  VAR  a : ARRAY[1..10, 1..20] OF LONGINT;
  BEGIN
   WRITE('input a[3, 5] = ');
   READ(a[3, 5]);
   WRITE('you input ');
   WRITELN(a[3, 5]);
   EXIT(a[3,5])
  END;

BEGIN
   a[3, 5]  := 10;
   WRITELN(a[3, 5]+local())
END.
