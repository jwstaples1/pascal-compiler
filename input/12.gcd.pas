PROGRAM example;
   VAR x, y : LONGINT;
   FUNCTION gcd :LONGINT;
      VAR t : LONGINT;
      BEGIN
         IF y=0
            THEN EXIT(x)
            ELSE BEGIN
	      t := x;
	      x := y;
	      y := t - y * (t DIV y);
	      EXIT(gcd())
	    END
       END;
      BEGIN
	 WRITE('x=');
         READ (x);
	 WRITE('y=');
         READ (y);
         WHILE (x <> 0) OR (y <> 0) DO
            BEGIN
	       WRITE('gcd=');
	       WRITELN(gcd());
	       WRITE('x=');
               READ (x);
	       WRITE('y=');
               READ (y)
             END
      END.
