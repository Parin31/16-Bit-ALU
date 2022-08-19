ENTITY Group_GP IS                           -- Dot operation on Group Propogate and Group Generate Pair
	PORT(
		g1 : IN bit;
		p1 : IN bit;
		g2 : IN bit;
		p2 : IN bit;
		go : OUT bit;
		po : OUT bit
	);
END ENTITY Group_GP;

ARCHITECTURE structure OF Group_GP IS
BEGIN
	go <= g2 OR (g1 AND p2);
	po <= P2 AND p1;
END structure;