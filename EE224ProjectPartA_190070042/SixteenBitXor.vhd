entity Xor1 is 
port (P, Q: in bit; R: out bit);
end entity Xor1; 
 
architecture Struct of Xor1 is                     -- structural definition of XOR 
begin 
R <= (((not Q) and P) or ((not P) and Q));
end Struct;

entity SixteenBitXor is 
port (x_xor : IN bit_vector(15 downto 0);
		y_xor : IN bit_vector(15 downto 0);
		z_xor : out bit_vector(15 downto 0);
		carry_xor : out bit);
end entity SixteenBitXor;

architecture Structure of SixteenBitXor is 
component Xor1 												-- using the Xor defined above as a component
port (P, Q: in bit; R: out bit);
end component;  

begin 
xoring : for i in 0 to 15 generate                 -- xor'ing all 16 bits
				xorit : Xor1 port map ( P => x_xor(i), Q => y_xor(i), R => z_xor(i));
			end generate;
carry_xor <= '0';
end Structure; 
