entity Nand1 is 
port (A, B: in bit; C: out bit);
end entity Nand1; 
 
architecture Struct of Nand1 is                            -- structural definition of Nand
begin 
C <= not((B and A));
end Struct;

entity SixteenBitNand is 
port (x_nand : IN bit_vector(15 downto 0);
		y_nand : IN bit_vector(15 downto 0);
		z_nand : out bit_vector(15 downto 0);
		carry_nand : out bit);
end entity SixteenBitNand;

architecture Structure of SixteenBitNand is 
component Nand1 															-- using Nand defined above as component
port (A, B: in bit; C: out bit);
end component;  

begin 
nanding : for i in 0 to 15 generate									-- Nand'ing all 16 bits
				nandit : Nand1 port map ( A => x_nand(i), B => y_nand(i), C => z_nand(i));
			end generate;
carry_nand <= '0';
end Structure; 

