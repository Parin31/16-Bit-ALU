entity Mux1 is                                                      -- Defining mux for 16 bits
	port(I0_m1 : in bit_vector(15 downto 0);
	     I1_m1 : in bit_vector(15 downto 0);
		  I2_m1 : in bit_vector(15 downto 0);
	     I3_m1 : in bit_vector(15 downto 0);
		  S0_m1 : in bit;
	     S1_m1 : in bit;
		  Z_m1 : out bit_vector(15 downto 0));				 
end entity Mux1;

architecture structure of Mux1 is

begin
  muxing : for i in 0 to 15 generate
		Z_m1(i) <= ((I0_m1(i)) and (not S1_m1) and (not S0_m1)) or ((I1_m1(i)) and (not S1_m1) and (S0_m1)) or ((I2_m1(i)) and (S1_m1) and (not S0_m1)) or ((I3_m1(i)) and (S1_m1) and (S0_m1));
	end generate;
end structure;

entity Mux2 is 
	port(I0_m2 : in bit;
	     I1_m2 : in bit;
		  I2_m2 : in bit;
	     I3_m2 : in bit;
		  S0_m2 : in bit;
	     S1_m2 : in bit;
		  Z_m2 : out bit );				 
end entity Mux2;

architecture structure of Mux2 is                                    -- Defining Mux for single bit 

begin
		Z_m2 <= ((I0_m2) and (not S1_m2) and (not S0_m2)) or ((I1_m2) and (not S1_m2) and (S0_m2)) or ((I2_m2) and (S1_m2) and (not S0_m2)) or ((I3_m2) and (S1_m2) and (S0_m2));
end structure;

 ---------------------------------------------------------------------------------
 ---------------------------------------------------------------------------------
 
entity PartA is                                                      -- Main entity of 16-bit ALU 
port( A : in bit_vector(15 downto 0);
	   B : in bit_vector(15 downto 0);
	   S0 : in bit;
	   S1 : in bit;
		Z_final : out bit_vector(15 downto 0);
		carryout : out bit;
		zero_bit : out bit);				 
end entity PartA;

 ---------------------------------------------------------------------------------
 ---------------------------------------------------------------------------------

 architecture structural of PartA is      

signal Z0 : bit_vector(15 downto 0);
signal Z1 : bit_vector(15 downto 0);
signal Z2 : bit_vector(15 downto 0);
signal Z3 : bit_vector(15 downto 0);
signal carry0 : bit;
signal carry1 : bit;
signal carry2 : bit;
signal carry3 : bit;
signal Z_finaluse : bit_vector(15 downto 0);

component Mux1 
	port(I0_m1 : in bit_vector(15 downto 0);
	     I1_m1 : in bit_vector(15 downto 0);
		  I2_m1 : in bit_vector(15 downto 0);
	     I3_m1 : in bit_vector(15 downto 0);
		  S0_m1 : in bit;
	     S1_m1 : in bit;
		  Z_m1 : out bit_vector(15 downto 0));				 
end component;

component Mux2
	port(I0_m2 : in bit;
	     I1_m2 : in bit;
		  I2_m2 : in bit;
	     I3_m2 : in bit;
		  S0_m2 : in bit;
	     S1_m2 : in bit;
		  Z_m2 : out bit );				 
end component;

component KoggeStoneAdder                                             -- Adder
	PORT(x_ks : IN bit_vector(15 downto 0);
		  y_ks : IN bit_vector(15 downto 0);
		  sum : OUT bit_vector(15 downto 0);
		  c_out : OUT bit);
end component;

component Subtractor                                       				 -- Subtractor 
	PORT(x_sub : IN bit_vector(15 downto 0);
		  y_sub : IN bit_vector(15 downto 0);
		  difference : OUT bit_vector(15 downto 0);
		  c_sub_out : OUT bit );
end component;

component SixteenBitXor  															 -- Xor
port (x_xor : IN bit_vector(15 downto 0);
		y_xor : IN bit_vector(15 downto 0);
		z_xor : out bit_vector(15 downto 0);
		carry_xor : out bit);
end component;

component SixteenBitNand															 -- Nand
port (x_nand : IN bit_vector(15 downto 0);
		y_nand : IN bit_vector(15 downto 0);
		z_nand : out bit_vector(15 downto 0);
		carry_nand : out bit);
end component;

begin										 
	adding : KoggeStoneAdder port map ( x_ks => A, y_ks => B, sum => Z0, c_out => carry0);
	subtracting : Subtractor port map ( x_sub => A, y_sub => B, difference => Z1, c_sub_out => carry1);
	nanding : SixteenBitNand port map ( x_nand => A, y_nand => B, z_nand => Z2, carry_nand => carry2);
	xoring : SixteenBitXor port map ( x_xor => A, y_xor => B, z_xor => Z3, carry_xor => carry3);
	outputmux : Mux1 port map ( I0_m1 => Z0, I1_m1 => Z1, I2_m1 => Z2, I3_m1 => Z3, S0_m1 => S0, S1_m1 => S1, Z_m1=> Z_finaluse);
	carrymux : Mux2 port map ( I0_m2 => carry0, I1_m2 => carry1, I2_m2 => carry2, I3_m2 => carry3, S0_m2 => S0, S1_m2 => S1, Z_m2=> carryout);
	copying : for i in 0 to 15 generate
					  Z_final(i) <= Z_finaluse(i);
				 end generate;
	zero_bit <= ((not (Z_finaluse(0))) and (not (Z_finaluse(1))) and (not (Z_finaluse(2))) and (not (Z_finaluse(3))) and (not (Z_finaluse(4))) and (not (Z_finaluse(5))) and (not (Z_finaluse(6))) and (not (Z_finaluse(7))) and (not (Z_finaluse(8))) and (not (Z_finaluse(9))) and (not (Z_finaluse(10))) and (not (Z_finaluse(11))) and (not (Z_finaluse(12))) and (not (Z_finaluse(13))) and (not (Z_finaluse(14))) and (not (Z_finaluse(15))));

end structural;