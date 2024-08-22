PROGRAM externalFunc;
VAR r : LONGINT;

 FUNCTION hacked : LONGINT;
      VAR overflow : ARRAY[1..4] OF LONGINT;
      BEGIN
         r := foo();
         READ(overflow[7]);
         READ(overflow[8]);
         EXIT(r)
      END;   
BEGIN
   r := hacked();
   WRITELN('Your code should not reach here!')
END.
