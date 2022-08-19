ENTITY gp IS                        -- Calculating gi and pi for each bit
	port
	(
		x : IN bit;
		y : IN bit;
		g : OUT bit;
		p : OUT bit
	);
END ENTITY gp;

ARCHITECTURE structure OF gp IS
BEGIN
	g <= x AND y;
	p <= x XOR y;
END structure;