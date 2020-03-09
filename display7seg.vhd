library IEEE;
use IEEE.Std_Logic_1164.all;

entity Display7Seg is
port (B : in std_logic_vector((3) downto (0));
		F : out std_logic_vector(6 downto (0))
		);
end Display7Seg;

architecture logic of Display7Seg is
begin
--	 F(0) <= NOT(B(3) OR B(1)) AND (B(2) OR B(0));
--	 F(1) <= NOT B(3) AND B(2) AND (B(1) XOR B(0));
--	 F(2) <= NOT B(3) AND NOT B(2) AND B(1) AND NOT B(0);
--	 F(3) <= (NOT(B(3) OR B(1)) AND (B(2) OR B(0))) OR (B(2) AND B(1) AND B(0));
--	 F(4) <= B(0) OR (B(2) AND NOT B(1) AND NOT B(0));
--	 F(5) <= (NOT B(3) AND NOT B(2) AND (B(1) OR B(0))) OR (B(2) AND B(1) AND B(0));
--	 F(6) <= (NOT ( B(3) OR B(2) OR B(1))) OR ( B(2) AND B(1) AND B(0));

	F<= "1000000" when B = "0000" else
		 "1111001" when B = "0001" else
		 "0100100" when B = "0010" else
		 "0110000" when B = "0011" else
		 "0011001" when B = "0100" else
		 "0010010" when B = "0101" else
		 "0000010" when B = "0110" else --6
		 "1111000" when B = "0111" else
		 "0000000" when B = "1000" else --8
		 "0010000" when B = "1001" else --9
		 "0001000" when B = "1010" else --A
		 "0000011" when B = "1011" else --B
		 "0100111" when B = "1100" else --C
		 "0100001" when B = "1101" else --d
		 "0000110" when B = "1110" else --E
		 "0001110" when B = "1111" else
		 "1111111";
		 
end logic;



