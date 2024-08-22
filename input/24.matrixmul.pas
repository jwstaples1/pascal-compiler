PROGRAM MatrixMul;
VAR  a : ARRAY[1..20, 1..15] OF LONGINT;
     b : ARRAY[1..15, 1..5] OF LONGINT;
     c : ARRAY[1..20, 1..5] OF LONGINT;    
     cur: LONGINT; 

FUNCTION init :LONGINT;
VAR i, j: LONGINT; 
BEGIN 
  i := 1;
  WHILE (i <= 20) DO
  BEGIN
    j := 1;
    WHILE (j <= 15) DO
    BEGIN
      cur := cur * 7 - (cur * 7) DIV 1811*1811;
      a[i, j] := cur;
      WRITE(a[i, j]);
      WRITE('  ');
      j := j+1
    END;
    WRITELN('|');
    i := i+1
  END;
  
  WRITELN('*');

  i := 1;
  WHILE (i <= 15) DO
  BEGIN
    j := 1;
    WHILE (j <= 5) DO
    BEGIN
      cur := cur * 5 - (cur * 5) DIV 1811*1811;
      b[i, j] := cur;
      WRITE(b[i, j]);
      WRITE('  ');
      j := j+1
    END;
    WRITELN('|');
    i := i+1
  END;
  EXIT(1)
END;
  
FUNCTION mm : LONGINT;
VAR s, i, j, k: LONGINT;
BEGIN
  i := 1;
  WHILE (i <= 20) DO
  BEGIN
    j := 1;
    WHILE (j <= 5) DO
    BEGIN
       k := 1;
       s := 0;
       WHILE (k <= 15) DO
       BEGIN
        s := s + a[i, k] * b[k, j];
        k := k+1
       END;
       c[i, j] := s;
       WRITE(c[i, j]);
       WRITE('  ');
       j := j+1
    END;
    WRITELN('|');
    i := i+1
  END;
  EXIT(1)
END;

BEGIN 
  WRITE('pick a prime seed (7, 11, 13, 17): ');
  READ(cur);
  IF (init() = 1) THEN
  BEGIN
    WRITELN('='); 
    cur := mm()
  END
END.
