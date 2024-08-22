PROGRAM subprog;
 VAR a,b,c,d:LONGINT;


FUNCTION b4  : LONGINT;
BEGIN
	WRITELN(4);
	WRITELN(a+1);
	EXIT(a+1)
END;

FUNCTION d2 : LONGINT;
VAR tmp:LONGINT;
BEGIN
	WRITELN(b);
        WRITELN(a);
	tmp:=a;
	a:=b;
	b:=tmp;

	EXIT(1)
END;

FUNCTION d3:LONGINT;
BEGIN
	a:=a+1;
	b:=b+2;
	c:=c+3;
	d:=d;

	EXIT(c)
END;

FUNCTION d1:LONGINT;
VAR b:LONGINT;

BEGIN
	b:=a*200;
	WRITELN(a); WRITELN(b); WRITELN(c); WRITELN(d);
	WRITELN(d2());
	WRITELN(a); WRITELN(b); WRITELN(c); WRITELN(d);
	WRITELN(d3());
	WRITELN(a); WRITELN(b); WRITELN(c); WRITELN(d);

	EXIT(b)
END;

BEGIN
	a:=1; b:=2; c:=3; d:=4;


	a := 2;
	WRITELN(b4());
	WRITELN(d1());
	a := 1;
	WRITELN(b4())


END.
