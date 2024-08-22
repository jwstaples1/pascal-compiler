PROGRAM subprog;
 VAR i,j,k,l:LONGINT;


FUNCTION a1 : LONGINT;
BEGIN
	WRITELN(1);
	EXIT(0)
END;

FUNCTION a2 : LONGINT;
BEGIN
	j := a1(); 
	WRITELN(2);
	EXIT(0)
END;

FUNCTION a3 : LONGINT;
BEGIN
	i := a1();
	j := a2();
	WRITELN(3);
	EXIT(0)
END;

FUNCTION a4 : LONGINT;
BEGIN
	i := a1();
	j := a2();
	k := a3();
	WRITELN(4);
	EXIT(0)
END;


BEGIN


	i := a1(); j := a2(); k := a3(); l := a4() 



END.
