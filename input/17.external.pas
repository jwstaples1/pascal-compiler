PROGRAM externalFunc;
VAR i, j : LONGINT;

BEGIN
   i := 0;
   WRITE('#iterations = ');
   READ(j);
   WHILE (i< j) DO    
   BEGIN
      WRITELN(sumI());
      i := i+1
   END
END.
