entity Testbench is 
end Testbench;

architecture tb of Testbench is                                 
	signal x_test: bit_vector(15 downto 0);
	signal y_test: bit_vector(15 downto 0);
	signal z_test: bit_vector(15 downto 0);
	signal carry_test: bit;
	signal S0_test: bit;
	signal S1_test: bit;
	signal zero_test : bit;
	component PartA is 								
	port( A : in bit_vector(15 downto 0);
	      B : in bit_vector(15 downto 0);
	      S0 : in bit;
	      S1 : in bit;
		   Z_final : out bit_vector(15 downto 0);
		   carryout : out bit;
			zero_bit : out bit);	
	end component;
	
begin
dut_instance : PartA port map( A => x_test, B => y_test, S0 => S0_test, S1 => S1_test, Z_final => z_test, carryout => carry_test, zero_bit => zero_test);
process
begin

 -- test vectors for adder --
 
x_test <="0000000000001001";         -- all 16 bits 0 
y_test <="1111111111110111";
S0_test<='0';
S1_test<='0';
wait for 5 ns;

x_test <="0000000000010101";         -- no carry generated
y_test <="0000001001001001";
S0_test<='0';
S1_test<='0';
wait for 5 ns;

x_test <="1010101010101010";    		 -- all 16 bits 1 
y_test <="0101010101010101";
S0_test<='0';
S1_test<='0';
wait for 5 ns;

x_test <="1100111010000101";         -- carry generated 
y_test <="0101110000011010";
S0_test<='0';
S1_test<='0';
wait for 5 ns;

x_test <="0000001000000000";         -- single bit is 1  
y_test <="0000001000000000";
S0_test<='0';
S1_test<='0';
wait for 5 ns;
 
 --------------------------------------------------------------------------------------------
 --------------------------------------------------------------------------------------------
 
 -- test vectors for subtractor --
 
x_test <="0001100010001001";         -- all 16 bits 0 
y_test <="0001100010001001";
S0_test<='1';
S1_test<='0';
wait for 5 ns;

x_test <="0010001010010101";         -- no carry generated
y_test <="0011011001001001";
S0_test<='1';
S1_test<='0';
wait for 5 ns;

x_test <="0111110101010100";    		 -- all 16 bits 1 
y_test <="0111110101010101";
S0_test<='1';
S1_test<='0';
wait for 5 ns;

x_test <="1100111010000101";         -- carry generated 
y_test <="0101110000011011";
S0_test<='1';
S1_test<='0';
wait for 5 ns;

x_test <="0101110101011011";         -- single bit is 1  
y_test <="0101110011011011";
S0_test<='1';
S1_test<='0';
wait for 5 ns;

--------------------------------------------------------------------------------------------
 --------------------------------------------------------------------------------------------
 
 -- test vectors for nand --
 
x_test <="1111111111111111";         -- all 16 bits 0 
y_test <="1111111111111111";
S0_test<='0';
S1_test<='1';
wait for 5 ns;

x_test <="1001110110100111";         -- single bit is 0
y_test <="0010010001001000";
S0_test<='0';
S1_test<='1';
wait for 5 ns;

x_test <="0110111010101001";    		 -- all 16 bits 1 
y_test <="1000000001010010";
S0_test<='0';
S1_test<='1';
wait for 5 ns;

x_test <="1111111011111111";         -- single bit is 1
y_test <="1111111111111111";
S0_test<='0';
S1_test<='1';
wait for 5 ns;

--------------------------------------------------------------------------------------------
 --------------------------------------------------------------------------------------------
 
 -- test vectors for xor --
 
x_test <="0110001001001001";         -- all 16 bits 0 
y_test <="0110001001001001";
S0_test<='1';
S1_test<='1';
wait for 5 ns;

x_test <="0111001111100110";         -- single bit is 0
y_test <="1000100000011001";
S0_test<='1';
S1_test<='1';
wait for 5 ns;

x_test <="1100010010001000";    		 -- all 16 bits 1 
y_test <="0011101101110111";
S0_test<='1';
S1_test<='1';
wait for 5 ns;

x_test <="1001001111001001";         -- single bit is 1
y_test <="1001101111001001";
S0_test<='1';
S1_test<='1';
wait for 5 ns;

end process;
end tb;