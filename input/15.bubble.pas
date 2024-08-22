PROGRAM sortRecur;
VAR a : ARRAY [1..10] OF LONGINT;
    p, l, r : LONGINT;

FUNCTION sort : LONGINT;
VAR    i,j,t,least : LONGINT;
BEGIN	
    IF (l = r) THEN
       EXIT(1)
    ELSE BEGIN
	i := l;
        least := i;
        j := l + 1;
	WHILE (j <= r ) DO BEGIN
           IF (a[j] < a[least]) THEN
             least := j;
	   j := j + 1
	END;

        t := a[i];
        a[i] := a[least];
        a[least] := t;
        
        l := l+1;
	EXIT(sort())
    END
END;

FUNCTION output : LONGINT;
VAR i: LONGINT;
BEGIN
    i := 1;
    WHILE (i<=10) DO BEGIN
      WRITELN(a[i]);
      i := i + 1      
    END;
    EXIT(1)
END;

FUNCTION input : LONGINT;
VAR i: LONGINT;
BEGIN
    WRITELN('Enter a[1:10]:');
    i := 1;
    WHILE (i<=10) DO BEGIN
      READ(a[i]);
      i := i + 1      
    END;
    EXIT(1)
END;

BEGIN
  p := input();
  p := output();
  l := 1;
  r := 10;
  p := sort();
  p := output()
END.
