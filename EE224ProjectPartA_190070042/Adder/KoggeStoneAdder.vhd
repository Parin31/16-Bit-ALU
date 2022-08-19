ENTITY KoggeStoneAdder IS
	PORT(x_ks : IN bit_vector(15 downto 0);
		  y_ks : IN bit_vector(15 downto 0);
		  sum : OUT bit_vector(15 downto 0);
		  c_out : OUT bit    );
END ENTITY KoggeStoneAdder;

ARCHITECTURE structure OF KoggeStoneAdder IS

	SIGNAL gin,g_1,g_2,g_3,g_4 : bit_vector(15 downto 0);  -- g signals of each level--
	SIGNAL pin,p_1,p_2,p_3,p_4 : bit_vector(15 downto 0);  -- p signals of each level--
	

		
	-- final carry out of each bit
	SIGNAL c :bit_vector(15 downto 0);
	
  COMPONENT Group_GP IS
	PORT(
		g1 : IN bit;
		p1 : IN bit;
		g2 : IN bit;
		p2 : IN bit;
		go : OUT bit;
		po : OUT bit
	);
END COMPONENT Group_GP;

COMPONENT gp IS
	port
	(
		x : IN bit;
		y : IN bit;
		g : OUT bit;
		p : OUT bit
	);
END COMPONENT gp;
	
	
	
BEGIN
	--generating level0 g,p signals--
	lvl00:
			FOR i IN 0 TO 15 GENERATE
				pm1: gp PORT MAP (x => x_ks(i) , y => y_ks(i) , g => gin(i) , p => pin(i) );
			END GENERATE;

			
	--level 1 GP operations--
	g_1(0) <= gin(0);
	p_1(0) <= pin(0);
	lvl01:
			FOR i IN 0 TO 14 GENERATE
				pm1: Group_GP PORT MAP (g1 => gin(i) , p1 => pin(i) , g2 => gin(i+1) , p2 => pin(i+1) , go => g_1(i+1) , po => p_1(i+1) );
			END GENERATE;	
			
	--level 2 GP operations--
	forward1:
			FOR i IN 0 TO 1 GENERATE
				g_2(i) <= g_1(i);
				p_2(i) <= p_1(i);
			END GENERATE;
	lvl02:		
			FOR i IN 0 TO 13 GENERATE
				pm1: Group_GP PORT MAP (g1 => g_1(i) , p1 => p_1(i) , g2 => g_1(i+2) , p2 => p_1(i+2) , go => g_2(i+2) , po => p_2(i+2) );
			END GENERATE;
			
	--level 3 GP operations--
	forward2:
			FOR i IN 0 TO 3 GENERATE
				g_3(i) <= g_2(i);
				p_3(i) <= p_2(i);
			END GENERATE;
	lvl03:		
			FOR i IN 0 TO 11 GENERATE
				pm1: Group_GP PORT MAP (g1 => g_2(i) , p1 => p_2(i) , g2 => g_2(i+4) , p2 => p_2(i+4) , go => g_3(i+4) , po => p_3(i+4) );
			END GENERATE;

	--level 4 GP operations--
	forward3:
			FOR i IN 0 TO 7 GENERATE
				g_4(i) <= g_3(i);
				p_4(i) <= p_3(i);
			END GENERATE;
	lvl04:		
			FOR i IN 0 TO 7 GENERATE
				pm1: Group_GP PORT MAP (g1 => g_3(i) , p1 => p_3(i) , g2 => g_3(i+8) , p2 => p_3(i+8) , go => g_4(i+8) , po => p_4(i+8) );
			END GENERATE;
			
	
			
	finalcarry:
			FOR i IN 0 TO 15 GENERATE
				c(i) <= g_4(i);
			END GENERATE;
	c_out  <= c(15);
	sum(0) <=  pin(0);
	add:
			FOR i IN 1 TO 15 GENERATE
				sum(i) <= c(i-1) XOR pin(i);
			END GENERATE;
END structure;	