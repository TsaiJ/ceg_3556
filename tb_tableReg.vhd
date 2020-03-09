LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

ENTITY TB_tableReg IS
END TB_tableReg;

ARCHITECTURE test OF TB_tableReg IS
  
  COMPONENT tablederegistre IS
    PORT(
    readReg1, readReg2, writeReg : IN STD_LOGIC_VECTOR(4 downto 0);
    readData1, readData2 : OUT STD_LOGIC_VECTOR(31 downto 0);
    writeData : IN STD_LOGIC_VECTOR(31 downto 0);
    Regwrite, gClock, gReset : IN STD_LOGIC
  );
  END COMPONENT;
  
  SIGNAL readReg1, readReg2, writeReg :STD_LOGIC_VECTOR(4 downto 0);
  SIGNAL readData1, readData2, writeData : STD_LOGIC_VECTOR(31 downto 0);
  SIGNAL regWrite, gClock, gReset : STD_LOGIC;
  
BEGIN
  
  UUT : tablederegistre
  PORT MAP(
    readReg1 => readReg1,
    readReg2 => readReg2,
    readData1 => readData1,
    readData2 => readData2,
    writeData => writeData,
    writeReg => writeReg,
    regWrite => regWrite,
    gClock => gClock,
    gReset => gReset
  );
  
  gen_clk : PROCESS
  BEGIN
    gClock <= '0';
    FOR I IN 0 TO 13 LOOP
      wait for 20 ns;
      gClock <= not gClock;
    END LOOP;
    wait;
  END PROCESS;
  
  gen_res : PROCESS
  BEGIN
    gReset <= '1';
    wait for 10 ns;
    gReset <= '0';
    wait for 30 ns;
    gReset <= '1';
    wait for 160 ns;
    gReset <= '0';
    wait for 30 ns;
    gReset <= '1';
    wait;
  END PROCESS;
  
  gen_read1 : PROCESS
  BEGIN
    readReg1 <= "00011";
    wait for 150 ns;
    readReg1 <= "00000";
    wait;
  END PROCESS;
  
  gen_read2 : PROCESS
  BEGIN
    readReg2 <= "00011";
    wait for 100 ns;
    readReg2 <= "00011";
    wait;
  END PROCESS;
  
  
  gen_dest : PROCESS
  BEGIN
    writeReg <= "00011";
    writeData <= x"1010FFFF";
    wait for 100 ns;
    writeReg <= "00000";
    writeData <= x"FFFFFFFF";
    wait;
  END PROCESS;
  
  gen_write : PROCESS
  BEGIN
    regWrite <= '0';
    wait for 80 ns;
    RegWrite <= '1';
    wait for 30 ns;
    RegWrite <= '0';
    wait for 40 ns;
    RegWrite <= '1';
    wait for 40 ns;
    RegWrite <= '0';
    wait;
  END PROCESS;
    
  
END test;