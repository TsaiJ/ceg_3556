LIBRARY ieee;
USE ieee.std_logic_1164.ALL;


ENTITY TB_DP_32bitCPU IS
END ENTITY;

ARCHITECTURE test OF TB_DP_32bitCPU IS
  
  COMPONENT DP_32bitCPU IS
    PORT(
      gClock : IN STD_LOGIC;
      gReset : IN STD_LOGIC;
      ValueSelect: IN STD_LOGIC_VECTOR(2 downto 0);
      MuxOut : OUT STD_LOGIC_VECTOR(31 downto 0);
      InstructionOut : OUT STD_LOGIC_VECTOR(31 downto 0);
      BranchOut : OUT STD_LOGIC;
      ZeroOut : OUT STD_LOGIC;
      MemWriteOut : OUT STD_LOGIC ;
      RegWriteOut : OUT STD_LOGIC;
      i_WriteData : IN STD_LOGIC_VECTOR(31 downto 0);
      i_instruction : IN STD_LOGIC_VECTOR(31 downto 0)
    );
  END COMPONENT;
  
  SIGNAL int_clock, int_reset : STD_LOGIC;
  SIGNAL int_instruction : STD_LOGIC_VECTOR(31 downto 0);
  SIGNAL int_RegWriteData : STD_LOGIC_VECTOR(31 downto 0);
  SIGNAL int_MemWriteOut : STD_LOGIC;
  SIGNAL int_BranchOut : STD_LOGIC;
  SIGNAL int_zeroOut : STD_LOGIC;
  SIGNAL int_RegWriteOut : STD_LOGIC;
  SIGNAL int_sel : STD_LOGIC_VECTOR(2 downto 0);
  SIGNAL int_MuxOut : STD_LOGIC_VECTOR(31 downto 0);
  
BEGIN
  
  UUT : DP_32bitCPU
  PORT MAP(
    gClock => int_clock,
    gReset => int_reset,
    ValueSelect => int_sel,
    MuxOut => int_MuxOut,
    InstructionOut => open,
    BranchOut => int_branchOut,
    zeroOut => int_zeroOut,
    MemWriteOut => int_MemWriteOut,
    RegWriteOut => int_RegWriteOut,
    i_instruction => int_instruction,
    i_writeData => int_RegWriteData
  );
  
  gen_clk : PROCESS
  BEGIN
    int_Clock <= '0';
    FOR I IN 0 TO 28 LOOP
      wait for 50 ns;
      int_Clock <= not int_Clock;
    END LOOP;
    wait;
  END PROCESS;
  
  gen_Reset : PROCESS
  BEGIN
    int_Reset <= '1';
    wait for 25 ns;
    int_Reset <= '0';
    wait for 50 ns;
    int_Reset <= '1';
    wait;
  END PROCESS;
  
  gen_observ: PROCESS
  BEGIN
    int_instruction <= (others => '0');
    int_RegWriteData <= (others => '0');
    int_sel <= "000";
    wait for 50 ns;
    -- premier instruction
    int_instruction <= x"8C020000";
    int_RegWriteData <= x"00000055";
    -- PC
    int_sel <= "000";
    wait for 20 ns;
    -- ALU RESULT
    int_sel <= "001";
    wait for 20 ns;
    -- ReadData1
    int_sel <= "010";
    wait for 20 ns;
    -- ReadData1
    int_sel <= "011";
    wait for 20 ns;
    -- WriteData1
    int_sel <= "100";
    wait for 20 ns;
    
    -- instruction 2
    int_instruction <= x"8C030001";
    int_RegWriteData <= x"000000AA";
    
    -- PC
    int_sel <= "000";
    wait for 20 ns;
    -- ALU RESULT
    int_sel <= "001";
    wait for 20 ns;
    -- ReadData1
    int_sel <= "010";
    wait for 20 ns;
    -- ReadData1
    int_sel <= "011";
    wait for 20 ns;
    -- WriteData1
    int_sel <= "100";
    wait for 20 ns;
    
    -- instruction 3
    int_instruction <= x"00620802"; -- sub $1, $3, $2
    int_RegWriteData <= x"00000000"; -- doesnt matter
    
    -- PC
    int_sel <= "000";
    wait for 20 ns;
    -- ALU RESULT
    int_sel <= "001";
    wait for 20 ns;
    -- ReadData1
    int_sel <= "010";
    wait for 20 ns;
    -- ReadData1
    int_sel <= "011";
    wait for 20 ns;
    -- WriteData1
    int_sel <= "100";
    wait for 20 ns;
    
    -- instruction 4
    int_instruction <= x"00232005"; -- OR $4, $1, $3
    int_RegWriteData <= x"00000000"; -- doesnt matter
    
    -- PC
    int_sel <= "000";
    wait for 20 ns;
    -- ALU RESULT
    int_sel <= "001";
    wait for 20 ns;
    -- ReadData1
    int_sel <= "010";
    wait for 20 ns;
    -- ReadData1
    int_sel <= "011";
    wait for 20 ns;
    -- WriteData1
    int_sel <= "100";
    wait for 20 ns;
    
    
    -- instruction 5
    int_instruction <= x"AC040003"; -- SW $4, $0, 3
    int_RegWriteData <= x"00000000"; -- doesnt matter
    
    -- PC
    int_sel <= "000";
    wait for 20 ns;
    -- ALU RESULT
    int_sel <= "001";
    wait for 20 ns;
    -- ReadData1
    int_sel <= "010";
    wait for 20 ns;
    -- ReadData1
    int_sel <= "011";
    wait for 20 ns;
    -- WriteData1
    int_sel <= "100";
    wait for 20 ns;
    
    -- instruction 6
    int_instruction <= x"00430800"; -- ADD $1, $2, $3
    int_RegWriteData <= x"00000000"; -- doesnt matter
    
    -- PC
    int_sel <= "000";
    wait for 20 ns;
    -- ALU RESULT
    int_sel <= "001";
    wait for 20 ns;
    -- ReadData1
    int_sel <= "010";
    wait for 20 ns;
    -- ReadData1
    int_sel <= "011";
    wait for 20 ns;
    -- WriteData1
    int_sel <= "100";
    wait for 20 ns;
    
    -- instruction 7
    int_instruction <= x"AC010004"; -- sw $1, 4
    int_RegWriteData <= x"00000000"; -- doesnt matter
    
    -- PC
    int_sel <= "000";
    wait for 20 ns;
    -- ALU RESULT
    int_sel <= "001";
    wait for 20 ns;
    -- ReadData1
    int_sel <= "010";
    wait for 20 ns;
    -- ReadData1
    int_sel <= "011";
    wait for 20 ns;
    -- WriteData1
    int_sel <= "100";
    wait for 20 ns;


    -- instruction 8
    int_instruction <= x"8C020003"; -- lw $2, 3
    int_RegWriteData <= x"000000FF";
    
    -- PC
    int_sel <= "000";
    wait for 20 ns;
    -- ALU RESULT
    int_sel <= "001";
    wait for 20 ns;
    -- ReadData1
    int_sel <= "010";
    wait for 20 ns;
    -- ReadData1
    int_sel <= "011";
    wait for 20 ns;
    -- WriteData1
    int_sel <= "100";
    wait for 20 ns;
    
    -- instruction 9
    int_instruction <= x"8C030004"; -- lw $3, 4
    int_RegWriteData <= x"000000FF";
    
    -- PC
    int_sel <= "000";
    wait for 20 ns;
    -- ALU RESULT
    int_sel <= "001";
    wait for 20 ns;
    -- ReadData1
    int_sel <= "010";
    wait for 20 ns;
    -- ReadData1
    int_sel <= "011";
    wait for 20 ns;
    -- WriteData1
    int_sel <= "100";
    wait for 20 ns;

    -- instruction 10
    int_instruction <= x"0800000B"; -- j 11
    int_RegWriteData <= x"00000000";
    
    -- PC
    int_sel <= "000";
    wait for 20 ns;
    -- ALU RESULT
    int_sel <= "001";
    wait for 20 ns;
    -- ReadData1
    int_sel <= "010";
    wait for 20 ns;
    -- ReadData1
    int_sel <= "011";
    wait for 20 ns;
    -- WriteData1
    int_sel <= "100";
    wait for 20 ns;


    -- instruction 11
    --int_instruction <= x"1021FFD4"; -- BEQ $1, $1, -44
--    int_RegWriteData <= x"00000000";
--    
--    -- PC
--    int_sel <= "000";
--    wait for 20 ns;
--    -- ALU RESULT
--    int_sel <= "001";
--    wait for 20 ns;
--    -- ReadData1
--    int_sel <= "010";
--    wait for 20 ns;
--    -- ReadData1
--    int_sel <= "011";
--    wait for 20 ns;
--    -- WriteData1
--    int_sel <= "100";
--    wait for 20 ns;
    
     -- instruction 12
    int_instruction <= x"1022FFF8"; -- BEQ $1, $2, -8
    int_RegWriteData <= x"00000000";
    
    -- PC
    int_sel <= "000";
    wait for 20 ns;
    -- ALU RESULT
    int_sel <= "001";
    wait for 20 ns;
    -- ReadData1
    int_sel <= "010";
    wait for 20 ns;
    -- ReadData1
    int_sel <= "011";
    wait for 20 ns;
    -- WriteData1
    int_sel <= "100";
    wait for 20 ns;
    
    
    
    
    -- instruction 13
    int_instruction <= x"00210800"; -- ADD $1, $1, $1
    int_RegWriteData <= x"00000000";
    
    -- PC
    int_sel <= "000";
    wait for 20 ns;
    -- ALU RESULT
    int_sel <= "001";
    wait for 20 ns;
    -- ReadData1
    int_sel <= "010";
    wait for 20 ns;
    -- ReadData1
    int_sel <= "011";
    wait for 20 ns;
    -- WriteData1
    int_sel <= "100";
    wait for 20 ns;
    wait;
    
  END PROCESS;
  
  
END test;
    