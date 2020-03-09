LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY signExtend16to32bit IS
  PORT(
    i_v : IN STD_LOGIC_VECTOR(15 downto 0);
    o_v : OUT STD_LOGIC_VECTOR(31 downto 0)
  );
END signExtend16to32bit;

ARCHITECTURE struct OF signExtend16to32bit IS

BEGIN
  GEN_OUT: FOR I IN 0 TO 31 GENERATE
    
    LB: IF I < 16 GENERATE
      o_v(I) <= i_v(I);
    END GENERATE;
      
    UB: IF I > 15 GENERATE
      o_V(I) <= i_v(15);
      
    END GENERATE;
  END GENERATE GEN_OUT;

END ARCHITECTURE;