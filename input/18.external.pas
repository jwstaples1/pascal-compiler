PROGRAM externalFunc;
VAR i, j : LONGINT;

 FUNCTION runsums : LONGINT;
      VAR j : LONGINT;
      BEGIN
         i := 0;
         WRITE('#iterations = ');
         READ(j);
         WHILE (i< j) DO    
         BEGIN
            WRITELN(sumI());
            i := i+1
         END;
         EXIT(i)
      END;   
BEGIN
   WRITELN(runsums())
END.
