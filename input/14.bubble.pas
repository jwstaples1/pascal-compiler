PROGRAM bubble;

VAR a : ARRAY [1..20] OF LONGINT;
    p, s, e, i : LONGINT;

FUNCTION sort : LONGINT;
VAR    i,j,t,least : LONGINT;
BEGIN

	i := s;
	WRITELN(s);
	WRITELN(e);
	WHILE i < e DO BEGIN
    	  least := i;
	  j := i + 1;
	  WHILE (j<=e) DO BEGIN
            IF (a[j] < a[least]) THEN
               least := j;
       
	    j := j + 1
	   END;

           t := a[i];
           a[i] := a[least];
           a[least] := t;
           i := i + 1
	END;
	EXIT(1) 
END;

FUNCTION output : LONGINT;
BEGIN
    i := 1;
    WHILE (i<=20) DO BEGIN
      WRITELN(a[i]);
      i := i + 1      
    END;
    EXIT(1)   
END;

FUNCTION input : LONGINT;
BEGIN
    s := 3;
    e := 7;
    i := s;
    WRITE('Enter a[3:7]:');
    WHILE (i<=e) DO BEGIN
      READ(a[i]);
      i := i + 1      
    END;
    EXIT(1)
END;

FUNCTION initialize : LONGINT;
BEGIN
    i := 1;
    WHILE (i<=20) DO BEGIN
      a[i] := 0;
      i := i + 1      
    END;
    EXIT(1)   
END;

BEGIN
  p := initialize();
  p := output();
  p := input();
  p := output();
  p := sort();
  p := output()
END.
