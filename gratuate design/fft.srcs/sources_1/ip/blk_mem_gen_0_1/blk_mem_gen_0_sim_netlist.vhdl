-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Sun Mar  8 21:23:41 2020
-- Host        : LAPTOP-O8J4EGBC running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim -rename_top blk_mem_gen_0 -prefix
--               blk_mem_gen_0_ blk_mem_gen_0_sim_netlist.vhdl
-- Design      : blk_mem_gen_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a35tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity blk_mem_gen_0_blk_mem_gen_prim_wrapper_init is
  port (
    douta : out STD_LOGIC_VECTOR ( 10 downto 0 );
    clka : in STD_LOGIC;
    addra : in STD_LOGIC_VECTOR ( 8 downto 0 )
  );
end blk_mem_gen_0_blk_mem_gen_prim_wrapper_init;

architecture STRUCTURE of blk_mem_gen_0_blk_mem_gen_prim_wrapper_init is
  signal \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_0\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_1\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_10\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_11\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_12\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_16\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_17\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_18\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_19\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_2\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_20\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_21\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_24\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_25\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_26\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_27\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_28\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_3\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_32\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_33\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_34\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_35\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_4\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_8\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_9\ : STD_LOGIC;
  attribute box_type : string;
  attribute box_type of \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram\ : label is "PRIMITIVE";
begin
\DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram\: unisim.vcomponents.RAMB18E1
    generic map(
      DOA_REG => 1,
      DOB_REG => 1,
      INITP_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_00 => X"0004000000040000000400000004000000040000000400000004000000040000",
      INIT_01 => X"0003070700030707000307070003070700030707000400000004000000040000",
      INIT_02 => X"0003070500030706000307060003070600030706000307060003070700030707",
      INIT_03 => X"0003070300030704000307040003070400030704000307050003070500030705",
      INIT_04 => X"0003070100030701000307010003070200030702000307020003070300030703",
      INIT_05 => X"0003060500030606000306060003060700030607000307000003070000030700",
      INIT_06 => X"0003060200030602000306030003060300030604000306040003060500030605",
      INIT_07 => X"0003050500030506000305060003050700030507000306000003060100030601",
      INIT_08 => X"0003050000030501000305010003050200030503000305030003050400030505",
      INIT_09 => X"0003040300030403000304040003040500030405000304060003040700030407",
      INIT_0A => X"0003030400030305000303060003030700030400000304000003040100030402",
      INIT_0B => X"0003020600030207000302070003030000030301000303020003030300030304",
      INIT_0C => X"0003010700030107000302000003020100030202000302030003020400030205",
      INIT_0D => X"0003000700030100000301010003010200030103000301040003010500030106",
      INIT_0E => X"0002070700030000000300010003000200030003000300040003000500030006",
      INIT_0F => X"0002060600020607000207000002070100020702000207040002070500020706",
      INIT_10 => X"0002050500020506000205070002060100020602000206030002060400020605",
      INIT_11 => X"0002040400020405000204060002040700020500000205020002050300020504",
      INIT_12 => X"0002030200020303000203040002030500020307000204000002040100020402",
      INIT_13 => X"0002020000020201000202020002020300020205000202060002020700020300",
      INIT_14 => X"0002000500020006000201000002010100020102000201040002010500020106",
      INIT_15 => X"0001070200010703000107050001070600020000000200010002000200020004",
      INIT_16 => X"0001050700010600000106020001060300010605000106060001060700010701",
      INIT_17 => X"0001040300010405000104060001050000010501000105030001050400010505",
      INIT_18 => X"0001030000010301000103030001030400010306000103070001040100010402",
      INIT_19 => X"0001010400010105000101070001020000010202000102030001020500010206",
      INIT_1A => X"0001000000010001000100030001000400010006000100070001010100010102",
      INIT_1B => X"0000060300000605000006070000070000000702000007030000070500000706",
      INIT_1C => X"0000040700000501000005020000050400000505000005070000060000000602",
      INIT_1D => X"0000030300000304000003060000030700000401000004020000040400000406",
      INIT_1E => X"0000010600000200000002010000020300000204000002060000030000000301",
      INIT_1F => X"0000000200000003000000050000000600000100000001010000010300000105",
      INIT_20 => X"0307060503070607030707000307070203070703030707050307070600000000",
      INIT_21 => X"0307050003070502030705040307050503070507030706000307060203070603",
      INIT_22 => X"0307030403070306030703070307040103070402030704040307040503070407",
      INIT_23 => X"0307020003070201030702030307020403070206030702070307030103070302",
      INIT_24 => X"0307000303070005030700060307010003070101030701030307010503070106",
      INIT_25 => X"0306060703060701030607020306070403060705030607070307000003070002",
      INIT_26 => X"0306050303060505030605060306060003060601030606030306060403060606",
      INIT_27 => X"0306030703060401030604020306040403060405030604070306050003060502",
      INIT_28 => X"0306020403060205030602070306030003060302030603030306030503060306",
      INIT_29 => X"0306010103060102030601030306010503060106030602000306020103060203",
      INIT_2A => X"0305070603050707030600000306000203060003030600050306000603060007",
      INIT_2B => X"0305060303050604030506060305060703050700030507020305070303050704",
      INIT_2C => X"0305050103050502030505030305050503050506030505070305060003050602",
      INIT_2D => X"0305030703050400030504010305040303050404030504050305040603050500",
      INIT_2E => X"0305020503050206030503000305030103050302030503030305030403050306",
      INIT_2F => X"0305010403050105030501060305010703050201030502020305020303050204",
      INIT_30 => X"0305000303050004030500060305000703050100030501010305010203050103",
      INIT_31 => X"0304070303040704030407050304070603040707030500000305000103050002",
      INIT_32 => X"0304060303040604030406050304060603040607030407000304070103040702",
      INIT_33 => X"0304050403040505030405060304050703040600030406010304060103040602",
      INIT_34 => X"0304040503040406030404070304050003040501030405010304050203040503",
      INIT_35 => X"0304030703040400030404000304040103040402030404030304040403040404",
      INIT_36 => X"0304030103040302030403030304030303040304030403050304030503040306",
      INIT_37 => X"0304020403040205030402050304020603040207030402070304030003040301",
      INIT_38 => X"0304010703040200030402010304020103040202030402020304020303040203",
      INIT_39 => X"0304010303040104030401040304010503040105030401060304010603040107",
      INIT_3A => X"0304010003040100030401010304010103040102030401020304010303040103",
      INIT_3B => X"0304000503040006030400060304000603040007030400070304000703040100",
      INIT_3C => X"0304000303040003030400040304000403040004030400040304000503040005",
      INIT_3D => X"0304000103040002030400020304000203040002030400020304000303040003",
      INIT_3E => X"0304000003040000030400010304000103040001030400010304000103040001",
      INIT_3F => X"0304000003040000030400000304000003040000030400000304000003040000",
      INIT_A => X"00000",
      INIT_B => X"00000",
      INIT_FILE => "NONE",
      IS_CLKARDCLK_INVERTED => '0',
      IS_CLKBWRCLK_INVERTED => '0',
      IS_ENARDEN_INVERTED => '0',
      IS_ENBWREN_INVERTED => '0',
      IS_RSTRAMARSTRAM_INVERTED => '0',
      IS_RSTRAMB_INVERTED => '0',
      IS_RSTREGARSTREG_INVERTED => '0',
      IS_RSTREGB_INVERTED => '0',
      RAM_MODE => "TDP",
      RDADDR_COLLISION_HWCONFIG => "PERFORMANCE",
      READ_WIDTH_A => 18,
      READ_WIDTH_B => 18,
      RSTREG_PRIORITY_A => "REGCE",
      RSTREG_PRIORITY_B => "REGCE",
      SIM_COLLISION_CHECK => "ALL",
      SIM_DEVICE => "7SERIES",
      SRVAL_A => X"00000",
      SRVAL_B => X"00000",
      WRITE_MODE_A => "WRITE_FIRST",
      WRITE_MODE_B => "WRITE_FIRST",
      WRITE_WIDTH_A => 18,
      WRITE_WIDTH_B => 18
    )
        port map (
      ADDRARDADDR(13 downto 5) => addra(8 downto 0),
      ADDRARDADDR(4 downto 0) => B"00000",
      ADDRBWRADDR(13 downto 5) => addra(8 downto 0),
      ADDRBWRADDR(4 downto 0) => B"10000",
      CLKARDCLK => clka,
      CLKBWRCLK => clka,
      DIADI(15 downto 0) => B"0000000000000000",
      DIBDI(15 downto 0) => B"0000000000000000",
      DIPADIP(1 downto 0) => B"00",
      DIPBDIP(1 downto 0) => B"00",
      DOADO(15) => \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_0\,
      DOADO(14) => \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_1\,
      DOADO(13) => \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_2\,
      DOADO(12) => \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_3\,
      DOADO(11) => \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_4\,
      DOADO(10 downto 8) => douta(5 downto 3),
      DOADO(7) => \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_8\,
      DOADO(6) => \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_9\,
      DOADO(5) => \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_10\,
      DOADO(4) => \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_11\,
      DOADO(3) => \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_12\,
      DOADO(2 downto 0) => douta(2 downto 0),
      DOBDO(15) => \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_16\,
      DOBDO(14) => \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_17\,
      DOBDO(13) => \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_18\,
      DOBDO(12) => \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_19\,
      DOBDO(11) => \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_20\,
      DOBDO(10) => \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_21\,
      DOBDO(9 downto 8) => douta(10 downto 9),
      DOBDO(7) => \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_24\,
      DOBDO(6) => \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_25\,
      DOBDO(5) => \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_26\,
      DOBDO(4) => \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_27\,
      DOBDO(3) => \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_28\,
      DOBDO(2 downto 0) => douta(8 downto 6),
      DOPADOP(1) => \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_32\,
      DOPADOP(0) => \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_33\,
      DOPBDOP(1) => \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_34\,
      DOPBDOP(0) => \DEVICE_7SERIES.NO_BMM_INFO.SP.WIDE_PRIM18.ram_n_35\,
      ENARDEN => '1',
      ENBWREN => '1',
      REGCEAREGCE => '1',
      REGCEB => '1',
      RSTRAMARSTRAM => '0',
      RSTRAMB => '0',
      RSTREGARSTREG => '0',
      RSTREGB => '0',
      WEA(1 downto 0) => B"00",
      WEBWE(3 downto 0) => B"0000"
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity blk_mem_gen_0_blk_mem_gen_prim_width is
  port (
    douta : out STD_LOGIC_VECTOR ( 10 downto 0 );
    clka : in STD_LOGIC;
    addra : in STD_LOGIC_VECTOR ( 8 downto 0 )
  );
end blk_mem_gen_0_blk_mem_gen_prim_width;

architecture STRUCTURE of blk_mem_gen_0_blk_mem_gen_prim_width is
begin
\prim_init.ram\: entity work.blk_mem_gen_0_blk_mem_gen_prim_wrapper_init
     port map (
      addra(8 downto 0) => addra(8 downto 0),
      clka => clka,
      douta(10 downto 0) => douta(10 downto 0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity blk_mem_gen_0_blk_mem_gen_generic_cstr is
  port (
    douta : out STD_LOGIC_VECTOR ( 10 downto 0 );
    clka : in STD_LOGIC;
    addra : in STD_LOGIC_VECTOR ( 8 downto 0 )
  );
end blk_mem_gen_0_blk_mem_gen_generic_cstr;

architecture STRUCTURE of blk_mem_gen_0_blk_mem_gen_generic_cstr is
begin
\ramloop[0].ram.r\: entity work.blk_mem_gen_0_blk_mem_gen_prim_width
     port map (
      addra(8 downto 0) => addra(8 downto 0),
      clka => clka,
      douta(10 downto 0) => douta(10 downto 0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity blk_mem_gen_0_blk_mem_gen_top is
  port (
    douta : out STD_LOGIC_VECTOR ( 10 downto 0 );
    clka : in STD_LOGIC;
    addra : in STD_LOGIC_VECTOR ( 8 downto 0 )
  );
end blk_mem_gen_0_blk_mem_gen_top;

architecture STRUCTURE of blk_mem_gen_0_blk_mem_gen_top is
begin
\valid.cstr\: entity work.blk_mem_gen_0_blk_mem_gen_generic_cstr
     port map (
      addra(8 downto 0) => addra(8 downto 0),
      clka => clka,
      douta(10 downto 0) => douta(10 downto 0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity blk_mem_gen_0_blk_mem_gen_v8_4_2_synth is
  port (
    douta : out STD_LOGIC_VECTOR ( 10 downto 0 );
    clka : in STD_LOGIC;
    addra : in STD_LOGIC_VECTOR ( 8 downto 0 )
  );
end blk_mem_gen_0_blk_mem_gen_v8_4_2_synth;

architecture STRUCTURE of blk_mem_gen_0_blk_mem_gen_v8_4_2_synth is
begin
\gnbram.gnativebmg.native_blk_mem_gen\: entity work.blk_mem_gen_0_blk_mem_gen_top
     port map (
      addra(8 downto 0) => addra(8 downto 0),
      clka => clka,
      douta(10 downto 0) => douta(10 downto 0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity blk_mem_gen_0_blk_mem_gen_v8_4_2 is
  port (
    clka : in STD_LOGIC;
    rsta : in STD_LOGIC;
    ena : in STD_LOGIC;
    regcea : in STD_LOGIC;
    wea : in STD_LOGIC_VECTOR ( 0 to 0 );
    addra : in STD_LOGIC_VECTOR ( 8 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 10 downto 0 );
    douta : out STD_LOGIC_VECTOR ( 10 downto 0 );
    clkb : in STD_LOGIC;
    rstb : in STD_LOGIC;
    enb : in STD_LOGIC;
    regceb : in STD_LOGIC;
    web : in STD_LOGIC_VECTOR ( 0 to 0 );
    addrb : in STD_LOGIC_VECTOR ( 8 downto 0 );
    dinb : in STD_LOGIC_VECTOR ( 10 downto 0 );
    doutb : out STD_LOGIC_VECTOR ( 10 downto 0 );
    injectsbiterr : in STD_LOGIC;
    injectdbiterr : in STD_LOGIC;
    eccpipece : in STD_LOGIC;
    sbiterr : out STD_LOGIC;
    dbiterr : out STD_LOGIC;
    rdaddrecc : out STD_LOGIC_VECTOR ( 8 downto 0 );
    sleep : in STD_LOGIC;
    deepsleep : in STD_LOGIC;
    shutdown : in STD_LOGIC;
    rsta_busy : out STD_LOGIC;
    rstb_busy : out STD_LOGIC;
    s_aclk : in STD_LOGIC;
    s_aresetn : in STD_LOGIC;
    s_axi_awid : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 10 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wlast : in STD_LOGIC;
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bid : out STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_arid : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rid : out STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_rdata : out STD_LOGIC_VECTOR ( 10 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rlast : out STD_LOGIC;
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    s_axi_injectsbiterr : in STD_LOGIC;
    s_axi_injectdbiterr : in STD_LOGIC;
    s_axi_sbiterr : out STD_LOGIC;
    s_axi_dbiterr : out STD_LOGIC;
    s_axi_rdaddrecc : out STD_LOGIC_VECTOR ( 8 downto 0 )
  );
  attribute C_ADDRA_WIDTH : integer;
  attribute C_ADDRA_WIDTH of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 9;
  attribute C_ADDRB_WIDTH : integer;
  attribute C_ADDRB_WIDTH of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 9;
  attribute C_ALGORITHM : integer;
  attribute C_ALGORITHM of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 1;
  attribute C_AXI_ID_WIDTH : integer;
  attribute C_AXI_ID_WIDTH of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 4;
  attribute C_AXI_SLAVE_TYPE : integer;
  attribute C_AXI_SLAVE_TYPE of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 0;
  attribute C_AXI_TYPE : integer;
  attribute C_AXI_TYPE of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 1;
  attribute C_BYTE_SIZE : integer;
  attribute C_BYTE_SIZE of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 9;
  attribute C_COMMON_CLK : integer;
  attribute C_COMMON_CLK of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 0;
  attribute C_COUNT_18K_BRAM : string;
  attribute C_COUNT_18K_BRAM of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is "1";
  attribute C_COUNT_36K_BRAM : string;
  attribute C_COUNT_36K_BRAM of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is "0";
  attribute C_CTRL_ECC_ALGO : string;
  attribute C_CTRL_ECC_ALGO of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is "NONE";
  attribute C_DEFAULT_DATA : string;
  attribute C_DEFAULT_DATA of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is "0";
  attribute C_DISABLE_WARN_BHV_COLL : integer;
  attribute C_DISABLE_WARN_BHV_COLL of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 0;
  attribute C_DISABLE_WARN_BHV_RANGE : integer;
  attribute C_DISABLE_WARN_BHV_RANGE of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 0;
  attribute C_ELABORATION_DIR : string;
  attribute C_ELABORATION_DIR of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is "./";
  attribute C_ENABLE_32BIT_ADDRESS : integer;
  attribute C_ENABLE_32BIT_ADDRESS of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 0;
  attribute C_EN_DEEPSLEEP_PIN : integer;
  attribute C_EN_DEEPSLEEP_PIN of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 0;
  attribute C_EN_ECC_PIPE : integer;
  attribute C_EN_ECC_PIPE of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 0;
  attribute C_EN_RDADDRA_CHG : integer;
  attribute C_EN_RDADDRA_CHG of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 0;
  attribute C_EN_RDADDRB_CHG : integer;
  attribute C_EN_RDADDRB_CHG of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 0;
  attribute C_EN_SAFETY_CKT : integer;
  attribute C_EN_SAFETY_CKT of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 0;
  attribute C_EN_SHUTDOWN_PIN : integer;
  attribute C_EN_SHUTDOWN_PIN of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 0;
  attribute C_EN_SLEEP_PIN : integer;
  attribute C_EN_SLEEP_PIN of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 0;
  attribute C_EST_POWER_SUMMARY : string;
  attribute C_EST_POWER_SUMMARY of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is "Estimated Power for IP     :     2.5016 mW";
  attribute C_FAMILY : string;
  attribute C_FAMILY of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is "artix7";
  attribute C_HAS_AXI_ID : integer;
  attribute C_HAS_AXI_ID of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 0;
  attribute C_HAS_ENA : integer;
  attribute C_HAS_ENA of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 0;
  attribute C_HAS_ENB : integer;
  attribute C_HAS_ENB of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 0;
  attribute C_HAS_INJECTERR : integer;
  attribute C_HAS_INJECTERR of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 0;
  attribute C_HAS_MEM_OUTPUT_REGS_A : integer;
  attribute C_HAS_MEM_OUTPUT_REGS_A of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 1;
  attribute C_HAS_MEM_OUTPUT_REGS_B : integer;
  attribute C_HAS_MEM_OUTPUT_REGS_B of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 0;
  attribute C_HAS_MUX_OUTPUT_REGS_A : integer;
  attribute C_HAS_MUX_OUTPUT_REGS_A of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 0;
  attribute C_HAS_MUX_OUTPUT_REGS_B : integer;
  attribute C_HAS_MUX_OUTPUT_REGS_B of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 0;
  attribute C_HAS_REGCEA : integer;
  attribute C_HAS_REGCEA of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 0;
  attribute C_HAS_REGCEB : integer;
  attribute C_HAS_REGCEB of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 0;
  attribute C_HAS_RSTA : integer;
  attribute C_HAS_RSTA of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 0;
  attribute C_HAS_RSTB : integer;
  attribute C_HAS_RSTB of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 0;
  attribute C_HAS_SOFTECC_INPUT_REGS_A : integer;
  attribute C_HAS_SOFTECC_INPUT_REGS_A of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 0;
  attribute C_HAS_SOFTECC_OUTPUT_REGS_B : integer;
  attribute C_HAS_SOFTECC_OUTPUT_REGS_B of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 0;
  attribute C_INITA_VAL : string;
  attribute C_INITA_VAL of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is "0";
  attribute C_INITB_VAL : string;
  attribute C_INITB_VAL of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is "0";
  attribute C_INIT_FILE : string;
  attribute C_INIT_FILE of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is "blk_mem_gen_0.mem";
  attribute C_INIT_FILE_NAME : string;
  attribute C_INIT_FILE_NAME of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is "blk_mem_gen_0.mif";
  attribute C_INTERFACE_TYPE : integer;
  attribute C_INTERFACE_TYPE of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 0;
  attribute C_LOAD_INIT_FILE : integer;
  attribute C_LOAD_INIT_FILE of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 1;
  attribute C_MEM_TYPE : integer;
  attribute C_MEM_TYPE of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 3;
  attribute C_MUX_PIPELINE_STAGES : integer;
  attribute C_MUX_PIPELINE_STAGES of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 0;
  attribute C_PRIM_TYPE : integer;
  attribute C_PRIM_TYPE of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 1;
  attribute C_READ_DEPTH_A : integer;
  attribute C_READ_DEPTH_A of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 512;
  attribute C_READ_DEPTH_B : integer;
  attribute C_READ_DEPTH_B of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 512;
  attribute C_READ_LATENCY_A : integer;
  attribute C_READ_LATENCY_A of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 1;
  attribute C_READ_LATENCY_B : integer;
  attribute C_READ_LATENCY_B of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 1;
  attribute C_READ_WIDTH_A : integer;
  attribute C_READ_WIDTH_A of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 11;
  attribute C_READ_WIDTH_B : integer;
  attribute C_READ_WIDTH_B of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 11;
  attribute C_RSTRAM_A : integer;
  attribute C_RSTRAM_A of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 0;
  attribute C_RSTRAM_B : integer;
  attribute C_RSTRAM_B of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 0;
  attribute C_RST_PRIORITY_A : string;
  attribute C_RST_PRIORITY_A of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is "CE";
  attribute C_RST_PRIORITY_B : string;
  attribute C_RST_PRIORITY_B of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is "CE";
  attribute C_SIM_COLLISION_CHECK : string;
  attribute C_SIM_COLLISION_CHECK of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is "ALL";
  attribute C_USE_BRAM_BLOCK : integer;
  attribute C_USE_BRAM_BLOCK of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 0;
  attribute C_USE_BYTE_WEA : integer;
  attribute C_USE_BYTE_WEA of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 0;
  attribute C_USE_BYTE_WEB : integer;
  attribute C_USE_BYTE_WEB of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 0;
  attribute C_USE_DEFAULT_DATA : integer;
  attribute C_USE_DEFAULT_DATA of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 0;
  attribute C_USE_ECC : integer;
  attribute C_USE_ECC of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 0;
  attribute C_USE_SOFTECC : integer;
  attribute C_USE_SOFTECC of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 0;
  attribute C_USE_URAM : integer;
  attribute C_USE_URAM of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 0;
  attribute C_WEA_WIDTH : integer;
  attribute C_WEA_WIDTH of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 1;
  attribute C_WEB_WIDTH : integer;
  attribute C_WEB_WIDTH of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 1;
  attribute C_WRITE_DEPTH_A : integer;
  attribute C_WRITE_DEPTH_A of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 512;
  attribute C_WRITE_DEPTH_B : integer;
  attribute C_WRITE_DEPTH_B of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 512;
  attribute C_WRITE_MODE_A : string;
  attribute C_WRITE_MODE_A of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is "WRITE_FIRST";
  attribute C_WRITE_MODE_B : string;
  attribute C_WRITE_MODE_B of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is "WRITE_FIRST";
  attribute C_WRITE_WIDTH_A : integer;
  attribute C_WRITE_WIDTH_A of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 11;
  attribute C_WRITE_WIDTH_B : integer;
  attribute C_WRITE_WIDTH_B of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is 11;
  attribute C_XDEVICEFAMILY : string;
  attribute C_XDEVICEFAMILY of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is "artix7";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of blk_mem_gen_0_blk_mem_gen_v8_4_2 : entity is "yes";
end blk_mem_gen_0_blk_mem_gen_v8_4_2;

architecture STRUCTURE of blk_mem_gen_0_blk_mem_gen_v8_4_2 is
  signal \<const0>\ : STD_LOGIC;
begin
  dbiterr <= \<const0>\;
  doutb(10) <= \<const0>\;
  doutb(9) <= \<const0>\;
  doutb(8) <= \<const0>\;
  doutb(7) <= \<const0>\;
  doutb(6) <= \<const0>\;
  doutb(5) <= \<const0>\;
  doutb(4) <= \<const0>\;
  doutb(3) <= \<const0>\;
  doutb(2) <= \<const0>\;
  doutb(1) <= \<const0>\;
  doutb(0) <= \<const0>\;
  rdaddrecc(8) <= \<const0>\;
  rdaddrecc(7) <= \<const0>\;
  rdaddrecc(6) <= \<const0>\;
  rdaddrecc(5) <= \<const0>\;
  rdaddrecc(4) <= \<const0>\;
  rdaddrecc(3) <= \<const0>\;
  rdaddrecc(2) <= \<const0>\;
  rdaddrecc(1) <= \<const0>\;
  rdaddrecc(0) <= \<const0>\;
  rsta_busy <= \<const0>\;
  rstb_busy <= \<const0>\;
  s_axi_arready <= \<const0>\;
  s_axi_awready <= \<const0>\;
  s_axi_bid(3) <= \<const0>\;
  s_axi_bid(2) <= \<const0>\;
  s_axi_bid(1) <= \<const0>\;
  s_axi_bid(0) <= \<const0>\;
  s_axi_bresp(1) <= \<const0>\;
  s_axi_bresp(0) <= \<const0>\;
  s_axi_bvalid <= \<const0>\;
  s_axi_dbiterr <= \<const0>\;
  s_axi_rdaddrecc(8) <= \<const0>\;
  s_axi_rdaddrecc(7) <= \<const0>\;
  s_axi_rdaddrecc(6) <= \<const0>\;
  s_axi_rdaddrecc(5) <= \<const0>\;
  s_axi_rdaddrecc(4) <= \<const0>\;
  s_axi_rdaddrecc(3) <= \<const0>\;
  s_axi_rdaddrecc(2) <= \<const0>\;
  s_axi_rdaddrecc(1) <= \<const0>\;
  s_axi_rdaddrecc(0) <= \<const0>\;
  s_axi_rdata(10) <= \<const0>\;
  s_axi_rdata(9) <= \<const0>\;
  s_axi_rdata(8) <= \<const0>\;
  s_axi_rdata(7) <= \<const0>\;
  s_axi_rdata(6) <= \<const0>\;
  s_axi_rdata(5) <= \<const0>\;
  s_axi_rdata(4) <= \<const0>\;
  s_axi_rdata(3) <= \<const0>\;
  s_axi_rdata(2) <= \<const0>\;
  s_axi_rdata(1) <= \<const0>\;
  s_axi_rdata(0) <= \<const0>\;
  s_axi_rid(3) <= \<const0>\;
  s_axi_rid(2) <= \<const0>\;
  s_axi_rid(1) <= \<const0>\;
  s_axi_rid(0) <= \<const0>\;
  s_axi_rlast <= \<const0>\;
  s_axi_rresp(1) <= \<const0>\;
  s_axi_rresp(0) <= \<const0>\;
  s_axi_rvalid <= \<const0>\;
  s_axi_sbiterr <= \<const0>\;
  s_axi_wready <= \<const0>\;
  sbiterr <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
inst_blk_mem_gen: entity work.blk_mem_gen_0_blk_mem_gen_v8_4_2_synth
     port map (
      addra(8 downto 0) => addra(8 downto 0),
      clka => clka,
      douta(10 downto 0) => douta(10 downto 0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity blk_mem_gen_0 is
  port (
    clka : in STD_LOGIC;
    addra : in STD_LOGIC_VECTOR ( 8 downto 0 );
    douta : out STD_LOGIC_VECTOR ( 10 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of blk_mem_gen_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of blk_mem_gen_0 : entity is "blk_mem_gen_0,blk_mem_gen_v8_4_2,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of blk_mem_gen_0 : entity is "yes";
  attribute x_core_info : string;
  attribute x_core_info of blk_mem_gen_0 : entity is "blk_mem_gen_v8_4_2,Vivado 2018.3";
end blk_mem_gen_0;

architecture STRUCTURE of blk_mem_gen_0 is
  signal NLW_U0_dbiterr_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_rsta_busy_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_rstb_busy_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_arready_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_awready_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_bvalid_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_dbiterr_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_rlast_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_rvalid_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_sbiterr_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_wready_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_sbiterr_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_doutb_UNCONNECTED : STD_LOGIC_VECTOR ( 10 downto 0 );
  signal NLW_U0_rdaddrecc_UNCONNECTED : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal NLW_U0_s_axi_bid_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_U0_s_axi_bresp_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_U0_s_axi_rdaddrecc_UNCONNECTED : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal NLW_U0_s_axi_rdata_UNCONNECTED : STD_LOGIC_VECTOR ( 10 downto 0 );
  signal NLW_U0_s_axi_rid_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_U0_s_axi_rresp_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  attribute C_ADDRA_WIDTH : integer;
  attribute C_ADDRA_WIDTH of U0 : label is 9;
  attribute C_ADDRB_WIDTH : integer;
  attribute C_ADDRB_WIDTH of U0 : label is 9;
  attribute C_ALGORITHM : integer;
  attribute C_ALGORITHM of U0 : label is 1;
  attribute C_AXI_ID_WIDTH : integer;
  attribute C_AXI_ID_WIDTH of U0 : label is 4;
  attribute C_AXI_SLAVE_TYPE : integer;
  attribute C_AXI_SLAVE_TYPE of U0 : label is 0;
  attribute C_AXI_TYPE : integer;
  attribute C_AXI_TYPE of U0 : label is 1;
  attribute C_BYTE_SIZE : integer;
  attribute C_BYTE_SIZE of U0 : label is 9;
  attribute C_COMMON_CLK : integer;
  attribute C_COMMON_CLK of U0 : label is 0;
  attribute C_COUNT_18K_BRAM : string;
  attribute C_COUNT_18K_BRAM of U0 : label is "1";
  attribute C_COUNT_36K_BRAM : string;
  attribute C_COUNT_36K_BRAM of U0 : label is "0";
  attribute C_CTRL_ECC_ALGO : string;
  attribute C_CTRL_ECC_ALGO of U0 : label is "NONE";
  attribute C_DEFAULT_DATA : string;
  attribute C_DEFAULT_DATA of U0 : label is "0";
  attribute C_DISABLE_WARN_BHV_COLL : integer;
  attribute C_DISABLE_WARN_BHV_COLL of U0 : label is 0;
  attribute C_DISABLE_WARN_BHV_RANGE : integer;
  attribute C_DISABLE_WARN_BHV_RANGE of U0 : label is 0;
  attribute C_ELABORATION_DIR : string;
  attribute C_ELABORATION_DIR of U0 : label is "./";
  attribute C_ENABLE_32BIT_ADDRESS : integer;
  attribute C_ENABLE_32BIT_ADDRESS of U0 : label is 0;
  attribute C_EN_DEEPSLEEP_PIN : integer;
  attribute C_EN_DEEPSLEEP_PIN of U0 : label is 0;
  attribute C_EN_ECC_PIPE : integer;
  attribute C_EN_ECC_PIPE of U0 : label is 0;
  attribute C_EN_RDADDRA_CHG : integer;
  attribute C_EN_RDADDRA_CHG of U0 : label is 0;
  attribute C_EN_RDADDRB_CHG : integer;
  attribute C_EN_RDADDRB_CHG of U0 : label is 0;
  attribute C_EN_SAFETY_CKT : integer;
  attribute C_EN_SAFETY_CKT of U0 : label is 0;
  attribute C_EN_SHUTDOWN_PIN : integer;
  attribute C_EN_SHUTDOWN_PIN of U0 : label is 0;
  attribute C_EN_SLEEP_PIN : integer;
  attribute C_EN_SLEEP_PIN of U0 : label is 0;
  attribute C_EST_POWER_SUMMARY : string;
  attribute C_EST_POWER_SUMMARY of U0 : label is "Estimated Power for IP     :     2.5016 mW";
  attribute C_FAMILY : string;
  attribute C_FAMILY of U0 : label is "artix7";
  attribute C_HAS_AXI_ID : integer;
  attribute C_HAS_AXI_ID of U0 : label is 0;
  attribute C_HAS_ENA : integer;
  attribute C_HAS_ENA of U0 : label is 0;
  attribute C_HAS_ENB : integer;
  attribute C_HAS_ENB of U0 : label is 0;
  attribute C_HAS_INJECTERR : integer;
  attribute C_HAS_INJECTERR of U0 : label is 0;
  attribute C_HAS_MEM_OUTPUT_REGS_A : integer;
  attribute C_HAS_MEM_OUTPUT_REGS_A of U0 : label is 1;
  attribute C_HAS_MEM_OUTPUT_REGS_B : integer;
  attribute C_HAS_MEM_OUTPUT_REGS_B of U0 : label is 0;
  attribute C_HAS_MUX_OUTPUT_REGS_A : integer;
  attribute C_HAS_MUX_OUTPUT_REGS_A of U0 : label is 0;
  attribute C_HAS_MUX_OUTPUT_REGS_B : integer;
  attribute C_HAS_MUX_OUTPUT_REGS_B of U0 : label is 0;
  attribute C_HAS_REGCEA : integer;
  attribute C_HAS_REGCEA of U0 : label is 0;
  attribute C_HAS_REGCEB : integer;
  attribute C_HAS_REGCEB of U0 : label is 0;
  attribute C_HAS_RSTA : integer;
  attribute C_HAS_RSTA of U0 : label is 0;
  attribute C_HAS_RSTB : integer;
  attribute C_HAS_RSTB of U0 : label is 0;
  attribute C_HAS_SOFTECC_INPUT_REGS_A : integer;
  attribute C_HAS_SOFTECC_INPUT_REGS_A of U0 : label is 0;
  attribute C_HAS_SOFTECC_OUTPUT_REGS_B : integer;
  attribute C_HAS_SOFTECC_OUTPUT_REGS_B of U0 : label is 0;
  attribute C_INITA_VAL : string;
  attribute C_INITA_VAL of U0 : label is "0";
  attribute C_INITB_VAL : string;
  attribute C_INITB_VAL of U0 : label is "0";
  attribute C_INIT_FILE : string;
  attribute C_INIT_FILE of U0 : label is "blk_mem_gen_0.mem";
  attribute C_INIT_FILE_NAME : string;
  attribute C_INIT_FILE_NAME of U0 : label is "blk_mem_gen_0.mif";
  attribute C_INTERFACE_TYPE : integer;
  attribute C_INTERFACE_TYPE of U0 : label is 0;
  attribute C_LOAD_INIT_FILE : integer;
  attribute C_LOAD_INIT_FILE of U0 : label is 1;
  attribute C_MEM_TYPE : integer;
  attribute C_MEM_TYPE of U0 : label is 3;
  attribute C_MUX_PIPELINE_STAGES : integer;
  attribute C_MUX_PIPELINE_STAGES of U0 : label is 0;
  attribute C_PRIM_TYPE : integer;
  attribute C_PRIM_TYPE of U0 : label is 1;
  attribute C_READ_DEPTH_A : integer;
  attribute C_READ_DEPTH_A of U0 : label is 512;
  attribute C_READ_DEPTH_B : integer;
  attribute C_READ_DEPTH_B of U0 : label is 512;
  attribute C_READ_LATENCY_A : integer;
  attribute C_READ_LATENCY_A of U0 : label is 1;
  attribute C_READ_LATENCY_B : integer;
  attribute C_READ_LATENCY_B of U0 : label is 1;
  attribute C_READ_WIDTH_A : integer;
  attribute C_READ_WIDTH_A of U0 : label is 11;
  attribute C_READ_WIDTH_B : integer;
  attribute C_READ_WIDTH_B of U0 : label is 11;
  attribute C_RSTRAM_A : integer;
  attribute C_RSTRAM_A of U0 : label is 0;
  attribute C_RSTRAM_B : integer;
  attribute C_RSTRAM_B of U0 : label is 0;
  attribute C_RST_PRIORITY_A : string;
  attribute C_RST_PRIORITY_A of U0 : label is "CE";
  attribute C_RST_PRIORITY_B : string;
  attribute C_RST_PRIORITY_B of U0 : label is "CE";
  attribute C_SIM_COLLISION_CHECK : string;
  attribute C_SIM_COLLISION_CHECK of U0 : label is "ALL";
  attribute C_USE_BRAM_BLOCK : integer;
  attribute C_USE_BRAM_BLOCK of U0 : label is 0;
  attribute C_USE_BYTE_WEA : integer;
  attribute C_USE_BYTE_WEA of U0 : label is 0;
  attribute C_USE_BYTE_WEB : integer;
  attribute C_USE_BYTE_WEB of U0 : label is 0;
  attribute C_USE_DEFAULT_DATA : integer;
  attribute C_USE_DEFAULT_DATA of U0 : label is 0;
  attribute C_USE_ECC : integer;
  attribute C_USE_ECC of U0 : label is 0;
  attribute C_USE_SOFTECC : integer;
  attribute C_USE_SOFTECC of U0 : label is 0;
  attribute C_USE_URAM : integer;
  attribute C_USE_URAM of U0 : label is 0;
  attribute C_WEA_WIDTH : integer;
  attribute C_WEA_WIDTH of U0 : label is 1;
  attribute C_WEB_WIDTH : integer;
  attribute C_WEB_WIDTH of U0 : label is 1;
  attribute C_WRITE_DEPTH_A : integer;
  attribute C_WRITE_DEPTH_A of U0 : label is 512;
  attribute C_WRITE_DEPTH_B : integer;
  attribute C_WRITE_DEPTH_B of U0 : label is 512;
  attribute C_WRITE_MODE_A : string;
  attribute C_WRITE_MODE_A of U0 : label is "WRITE_FIRST";
  attribute C_WRITE_MODE_B : string;
  attribute C_WRITE_MODE_B of U0 : label is "WRITE_FIRST";
  attribute C_WRITE_WIDTH_A : integer;
  attribute C_WRITE_WIDTH_A of U0 : label is 11;
  attribute C_WRITE_WIDTH_B : integer;
  attribute C_WRITE_WIDTH_B of U0 : label is 11;
  attribute C_XDEVICEFAMILY : string;
  attribute C_XDEVICEFAMILY of U0 : label is "artix7";
  attribute downgradeipidentifiedwarnings of U0 : label is "yes";
  attribute x_interface_info : string;
  attribute x_interface_info of clka : signal is "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK";
  attribute x_interface_parameter : string;
  attribute x_interface_parameter of clka : signal is "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1";
  attribute x_interface_info of addra : signal is "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR";
  attribute x_interface_info of douta : signal is "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT";
begin
U0: entity work.blk_mem_gen_0_blk_mem_gen_v8_4_2
     port map (
      addra(8 downto 0) => addra(8 downto 0),
      addrb(8 downto 0) => B"000000000",
      clka => clka,
      clkb => '0',
      dbiterr => NLW_U0_dbiterr_UNCONNECTED,
      deepsleep => '0',
      dina(10 downto 0) => B"00000000000",
      dinb(10 downto 0) => B"00000000000",
      douta(10 downto 0) => douta(10 downto 0),
      doutb(10 downto 0) => NLW_U0_doutb_UNCONNECTED(10 downto 0),
      eccpipece => '0',
      ena => '0',
      enb => '0',
      injectdbiterr => '0',
      injectsbiterr => '0',
      rdaddrecc(8 downto 0) => NLW_U0_rdaddrecc_UNCONNECTED(8 downto 0),
      regcea => '0',
      regceb => '0',
      rsta => '0',
      rsta_busy => NLW_U0_rsta_busy_UNCONNECTED,
      rstb => '0',
      rstb_busy => NLW_U0_rstb_busy_UNCONNECTED,
      s_aclk => '0',
      s_aresetn => '0',
      s_axi_araddr(31 downto 0) => B"00000000000000000000000000000000",
      s_axi_arburst(1 downto 0) => B"00",
      s_axi_arid(3 downto 0) => B"0000",
      s_axi_arlen(7 downto 0) => B"00000000",
      s_axi_arready => NLW_U0_s_axi_arready_UNCONNECTED,
      s_axi_arsize(2 downto 0) => B"000",
      s_axi_arvalid => '0',
      s_axi_awaddr(31 downto 0) => B"00000000000000000000000000000000",
      s_axi_awburst(1 downto 0) => B"00",
      s_axi_awid(3 downto 0) => B"0000",
      s_axi_awlen(7 downto 0) => B"00000000",
      s_axi_awready => NLW_U0_s_axi_awready_UNCONNECTED,
      s_axi_awsize(2 downto 0) => B"000",
      s_axi_awvalid => '0',
      s_axi_bid(3 downto 0) => NLW_U0_s_axi_bid_UNCONNECTED(3 downto 0),
      s_axi_bready => '0',
      s_axi_bresp(1 downto 0) => NLW_U0_s_axi_bresp_UNCONNECTED(1 downto 0),
      s_axi_bvalid => NLW_U0_s_axi_bvalid_UNCONNECTED,
      s_axi_dbiterr => NLW_U0_s_axi_dbiterr_UNCONNECTED,
      s_axi_injectdbiterr => '0',
      s_axi_injectsbiterr => '0',
      s_axi_rdaddrecc(8 downto 0) => NLW_U0_s_axi_rdaddrecc_UNCONNECTED(8 downto 0),
      s_axi_rdata(10 downto 0) => NLW_U0_s_axi_rdata_UNCONNECTED(10 downto 0),
      s_axi_rid(3 downto 0) => NLW_U0_s_axi_rid_UNCONNECTED(3 downto 0),
      s_axi_rlast => NLW_U0_s_axi_rlast_UNCONNECTED,
      s_axi_rready => '0',
      s_axi_rresp(1 downto 0) => NLW_U0_s_axi_rresp_UNCONNECTED(1 downto 0),
      s_axi_rvalid => NLW_U0_s_axi_rvalid_UNCONNECTED,
      s_axi_sbiterr => NLW_U0_s_axi_sbiterr_UNCONNECTED,
      s_axi_wdata(10 downto 0) => B"00000000000",
      s_axi_wlast => '0',
      s_axi_wready => NLW_U0_s_axi_wready_UNCONNECTED,
      s_axi_wstrb(0) => '0',
      s_axi_wvalid => '0',
      sbiterr => NLW_U0_sbiterr_UNCONNECTED,
      shutdown => '0',
      sleep => '0',
      wea(0) => '0',
      web(0) => '0'
    );
end STRUCTURE;
