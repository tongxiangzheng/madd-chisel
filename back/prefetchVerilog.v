module Prefetch(
  input         clock,
  input         reset,
  input  [31:0] io_pc,
  input  [31:0] io_address,
  input         io_enable,
  input         io_reset,
  output [31:0] io_prefetch_address,
  output        io_prefetch_valid,
  output        io_ready,
  output        io_inited
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] dfn; // @[prefetchModule.scala 35:20]
  reg  prefetch_valid; // @[prefetchModule.scala 37:31]
  reg [31:0] prefetch_address; // @[prefetchModule.scala 38:33]
  reg  ready; // @[prefetchModule.scala 39:22]
  reg  inited; // @[prefetchModule.scala 40:23]
  reg [31:0] queueReg_0_pc; // @[prefetchModule.scala 56:25]
  reg [31:0] queueReg_0_address; // @[prefetchModule.scala 56:25]
  reg [31:0] queueReg_0_timestamp; // @[prefetchModule.scala 56:25]
  reg [31:0] queueReg_0_stride; // @[prefetchModule.scala 56:25]
  reg [31:0] queueReg_0_reliability; // @[prefetchModule.scala 56:25]
  reg [31:0] queueReg_1_pc; // @[prefetchModule.scala 56:25]
  reg [31:0] queueReg_1_address; // @[prefetchModule.scala 56:25]
  reg [31:0] queueReg_1_timestamp; // @[prefetchModule.scala 56:25]
  reg [31:0] queueReg_1_stride; // @[prefetchModule.scala 56:25]
  reg [31:0] queueReg_1_reliability; // @[prefetchModule.scala 56:25]
  reg [31:0] queueReg_2_pc; // @[prefetchModule.scala 56:25]
  reg [31:0] queueReg_2_address; // @[prefetchModule.scala 56:25]
  reg [31:0] queueReg_2_timestamp; // @[prefetchModule.scala 56:25]
  reg [31:0] queueReg_2_stride; // @[prefetchModule.scala 56:25]
  reg [31:0] queueReg_2_reliability; // @[prefetchModule.scala 56:25]
  reg [31:0] queueReg_3_pc; // @[prefetchModule.scala 56:25]
  reg [31:0] queueReg_3_address; // @[prefetchModule.scala 56:25]
  reg [31:0] queueReg_3_timestamp; // @[prefetchModule.scala 56:25]
  reg [31:0] queueReg_3_stride; // @[prefetchModule.scala 56:25]
  reg [31:0] queueReg_3_reliability; // @[prefetchModule.scala 56:25]
  reg [31:0] queueReg_4_pc; // @[prefetchModule.scala 56:25]
  reg [31:0] queueReg_4_address; // @[prefetchModule.scala 56:25]
  reg [31:0] queueReg_4_timestamp; // @[prefetchModule.scala 56:25]
  reg [31:0] queueReg_4_stride; // @[prefetchModule.scala 56:25]
  reg [31:0] queueReg_4_reliability; // @[prefetchModule.scala 56:25]
  reg [31:0] queueReg_5_pc; // @[prefetchModule.scala 56:25]
  reg [31:0] queueReg_5_address; // @[prefetchModule.scala 56:25]
  reg [31:0] queueReg_5_timestamp; // @[prefetchModule.scala 56:25]
  reg [31:0] queueReg_5_stride; // @[prefetchModule.scala 56:25]
  reg [31:0] queueReg_5_reliability; // @[prefetchModule.scala 56:25]
  reg [31:0] queueReg_6_pc; // @[prefetchModule.scala 56:25]
  reg [31:0] queueReg_6_address; // @[prefetchModule.scala 56:25]
  reg [31:0] queueReg_6_timestamp; // @[prefetchModule.scala 56:25]
  reg [31:0] queueReg_6_stride; // @[prefetchModule.scala 56:25]
  reg [31:0] queueReg_6_reliability; // @[prefetchModule.scala 56:25]
  reg [31:0] queueReg_7_pc; // @[prefetchModule.scala 56:25]
  reg [31:0] queueReg_7_address; // @[prefetchModule.scala 56:25]
  reg [31:0] queueReg_7_timestamp; // @[prefetchModule.scala 56:25]
  reg [31:0] queueReg_7_stride; // @[prefetchModule.scala 56:25]
  reg [31:0] queueReg_7_reliability; // @[prefetchModule.scala 56:25]
  reg  REG; // @[prefetchModule.scala 138:18]
  wire [31:0] _GEN_0 = ~REG ? 32'h0 : queueReg_0_pc; // @[prefetchModule.scala 138:29 prefetchModule.scala 62:27 prefetchModule.scala 56:25]
  wire [31:0] _GEN_1 = ~REG ? 32'h0 : queueReg_0_address; // @[prefetchModule.scala 138:29 prefetchModule.scala 63:32 prefetchModule.scala 56:25]
  wire [31:0] _GEN_2 = ~REG ? 32'h0 : queueReg_0_stride; // @[prefetchModule.scala 138:29 prefetchModule.scala 64:31 prefetchModule.scala 56:25]
  wire [31:0] _GEN_3 = ~REG ? 32'h0 : queueReg_0_reliability; // @[prefetchModule.scala 138:29 prefetchModule.scala 65:30 prefetchModule.scala 56:25]
  wire [31:0] _GEN_4 = ~REG ? 32'h0 : queueReg_0_timestamp; // @[prefetchModule.scala 138:29 prefetchModule.scala 66:28 prefetchModule.scala 56:25]
  wire [31:0] _GEN_5 = ~REG ? 32'h0 : queueReg_1_pc; // @[prefetchModule.scala 138:29 prefetchModule.scala 62:27 prefetchModule.scala 56:25]
  wire [31:0] _GEN_6 = ~REG ? 32'h0 : queueReg_1_address; // @[prefetchModule.scala 138:29 prefetchModule.scala 63:32 prefetchModule.scala 56:25]
  wire [31:0] _GEN_7 = ~REG ? 32'h0 : queueReg_1_stride; // @[prefetchModule.scala 138:29 prefetchModule.scala 64:31 prefetchModule.scala 56:25]
  wire [31:0] _GEN_8 = ~REG ? 32'h0 : queueReg_1_reliability; // @[prefetchModule.scala 138:29 prefetchModule.scala 65:30 prefetchModule.scala 56:25]
  wire [31:0] _GEN_9 = ~REG ? 32'h0 : queueReg_1_timestamp; // @[prefetchModule.scala 138:29 prefetchModule.scala 66:28 prefetchModule.scala 56:25]
  wire [31:0] _GEN_10 = ~REG ? 32'h0 : queueReg_2_pc; // @[prefetchModule.scala 138:29 prefetchModule.scala 62:27 prefetchModule.scala 56:25]
  wire [31:0] _GEN_11 = ~REG ? 32'h0 : queueReg_2_address; // @[prefetchModule.scala 138:29 prefetchModule.scala 63:32 prefetchModule.scala 56:25]
  wire [31:0] _GEN_12 = ~REG ? 32'h0 : queueReg_2_stride; // @[prefetchModule.scala 138:29 prefetchModule.scala 64:31 prefetchModule.scala 56:25]
  wire [31:0] _GEN_13 = ~REG ? 32'h0 : queueReg_2_reliability; // @[prefetchModule.scala 138:29 prefetchModule.scala 65:30 prefetchModule.scala 56:25]
  wire [31:0] _GEN_14 = ~REG ? 32'h0 : queueReg_2_timestamp; // @[prefetchModule.scala 138:29 prefetchModule.scala 66:28 prefetchModule.scala 56:25]
  wire [31:0] _GEN_15 = ~REG ? 32'h0 : queueReg_3_pc; // @[prefetchModule.scala 138:29 prefetchModule.scala 62:27 prefetchModule.scala 56:25]
  wire [31:0] _GEN_16 = ~REG ? 32'h0 : queueReg_3_address; // @[prefetchModule.scala 138:29 prefetchModule.scala 63:32 prefetchModule.scala 56:25]
  wire [31:0] _GEN_17 = ~REG ? 32'h0 : queueReg_3_stride; // @[prefetchModule.scala 138:29 prefetchModule.scala 64:31 prefetchModule.scala 56:25]
  wire [31:0] _GEN_18 = ~REG ? 32'h0 : queueReg_3_reliability; // @[prefetchModule.scala 138:29 prefetchModule.scala 65:30 prefetchModule.scala 56:25]
  wire [31:0] _GEN_19 = ~REG ? 32'h0 : queueReg_3_timestamp; // @[prefetchModule.scala 138:29 prefetchModule.scala 66:28 prefetchModule.scala 56:25]
  wire [31:0] _GEN_20 = ~REG ? 32'h0 : queueReg_4_pc; // @[prefetchModule.scala 138:29 prefetchModule.scala 62:27 prefetchModule.scala 56:25]
  wire [31:0] _GEN_21 = ~REG ? 32'h0 : queueReg_4_address; // @[prefetchModule.scala 138:29 prefetchModule.scala 63:32 prefetchModule.scala 56:25]
  wire [31:0] _GEN_22 = ~REG ? 32'h0 : queueReg_4_stride; // @[prefetchModule.scala 138:29 prefetchModule.scala 64:31 prefetchModule.scala 56:25]
  wire [31:0] _GEN_23 = ~REG ? 32'h0 : queueReg_4_reliability; // @[prefetchModule.scala 138:29 prefetchModule.scala 65:30 prefetchModule.scala 56:25]
  wire [31:0] _GEN_24 = ~REG ? 32'h0 : queueReg_4_timestamp; // @[prefetchModule.scala 138:29 prefetchModule.scala 66:28 prefetchModule.scala 56:25]
  wire [31:0] _GEN_25 = ~REG ? 32'h0 : queueReg_5_pc; // @[prefetchModule.scala 138:29 prefetchModule.scala 62:27 prefetchModule.scala 56:25]
  wire [31:0] _GEN_26 = ~REG ? 32'h0 : queueReg_5_address; // @[prefetchModule.scala 138:29 prefetchModule.scala 63:32 prefetchModule.scala 56:25]
  wire [31:0] _GEN_27 = ~REG ? 32'h0 : queueReg_5_stride; // @[prefetchModule.scala 138:29 prefetchModule.scala 64:31 prefetchModule.scala 56:25]
  wire [31:0] _GEN_28 = ~REG ? 32'h0 : queueReg_5_reliability; // @[prefetchModule.scala 138:29 prefetchModule.scala 65:30 prefetchModule.scala 56:25]
  wire [31:0] _GEN_29 = ~REG ? 32'h0 : queueReg_5_timestamp; // @[prefetchModule.scala 138:29 prefetchModule.scala 66:28 prefetchModule.scala 56:25]
  wire [31:0] _GEN_30 = ~REG ? 32'h0 : queueReg_6_pc; // @[prefetchModule.scala 138:29 prefetchModule.scala 62:27 prefetchModule.scala 56:25]
  wire [31:0] _GEN_31 = ~REG ? 32'h0 : queueReg_6_address; // @[prefetchModule.scala 138:29 prefetchModule.scala 63:32 prefetchModule.scala 56:25]
  wire [31:0] _GEN_32 = ~REG ? 32'h0 : queueReg_6_stride; // @[prefetchModule.scala 138:29 prefetchModule.scala 64:31 prefetchModule.scala 56:25]
  wire [31:0] _GEN_33 = ~REG ? 32'h0 : queueReg_6_reliability; // @[prefetchModule.scala 138:29 prefetchModule.scala 65:30 prefetchModule.scala 56:25]
  wire [31:0] _GEN_34 = ~REG ? 32'h0 : queueReg_6_timestamp; // @[prefetchModule.scala 138:29 prefetchModule.scala 66:28 prefetchModule.scala 56:25]
  wire [31:0] _GEN_35 = ~REG ? 32'h0 : queueReg_7_pc; // @[prefetchModule.scala 138:29 prefetchModule.scala 62:27 prefetchModule.scala 56:25]
  wire [31:0] _GEN_36 = ~REG ? 32'h0 : queueReg_7_address; // @[prefetchModule.scala 138:29 prefetchModule.scala 63:32 prefetchModule.scala 56:25]
  wire [31:0] _GEN_37 = ~REG ? 32'h0 : queueReg_7_stride; // @[prefetchModule.scala 138:29 prefetchModule.scala 64:31 prefetchModule.scala 56:25]
  wire [31:0] _GEN_38 = ~REG ? 32'h0 : queueReg_7_reliability; // @[prefetchModule.scala 138:29 prefetchModule.scala 65:30 prefetchModule.scala 56:25]
  wire [31:0] _GEN_39 = ~REG ? 32'h0 : queueReg_7_timestamp; // @[prefetchModule.scala 138:29 prefetchModule.scala 66:28 prefetchModule.scala 56:25]
  wire  _GEN_41 = ~REG | inited; // @[prefetchModule.scala 138:29 prefetchModule.scala 140:13 prefetchModule.scala 40:23]
  wire [31:0] _GEN_42 = io_reset ? _GEN_0 : queueReg_0_pc; // @[prefetchModule.scala 137:17 prefetchModule.scala 56:25]
  wire [31:0] _GEN_43 = io_reset ? _GEN_1 : queueReg_0_address; // @[prefetchModule.scala 137:17 prefetchModule.scala 56:25]
  wire [31:0] _GEN_44 = io_reset ? _GEN_2 : queueReg_0_stride; // @[prefetchModule.scala 137:17 prefetchModule.scala 56:25]
  wire [31:0] _GEN_45 = io_reset ? _GEN_3 : queueReg_0_reliability; // @[prefetchModule.scala 137:17 prefetchModule.scala 56:25]
  wire [31:0] _GEN_46 = io_reset ? _GEN_4 : queueReg_0_timestamp; // @[prefetchModule.scala 137:17 prefetchModule.scala 56:25]
  wire [31:0] _GEN_47 = io_reset ? _GEN_5 : queueReg_1_pc; // @[prefetchModule.scala 137:17 prefetchModule.scala 56:25]
  wire [31:0] _GEN_48 = io_reset ? _GEN_6 : queueReg_1_address; // @[prefetchModule.scala 137:17 prefetchModule.scala 56:25]
  wire [31:0] _GEN_49 = io_reset ? _GEN_7 : queueReg_1_stride; // @[prefetchModule.scala 137:17 prefetchModule.scala 56:25]
  wire [31:0] _GEN_50 = io_reset ? _GEN_8 : queueReg_1_reliability; // @[prefetchModule.scala 137:17 prefetchModule.scala 56:25]
  wire [31:0] _GEN_51 = io_reset ? _GEN_9 : queueReg_1_timestamp; // @[prefetchModule.scala 137:17 prefetchModule.scala 56:25]
  wire [31:0] _GEN_52 = io_reset ? _GEN_10 : queueReg_2_pc; // @[prefetchModule.scala 137:17 prefetchModule.scala 56:25]
  wire [31:0] _GEN_53 = io_reset ? _GEN_11 : queueReg_2_address; // @[prefetchModule.scala 137:17 prefetchModule.scala 56:25]
  wire [31:0] _GEN_54 = io_reset ? _GEN_12 : queueReg_2_stride; // @[prefetchModule.scala 137:17 prefetchModule.scala 56:25]
  wire [31:0] _GEN_55 = io_reset ? _GEN_13 : queueReg_2_reliability; // @[prefetchModule.scala 137:17 prefetchModule.scala 56:25]
  wire [31:0] _GEN_56 = io_reset ? _GEN_14 : queueReg_2_timestamp; // @[prefetchModule.scala 137:17 prefetchModule.scala 56:25]
  wire [31:0] _GEN_57 = io_reset ? _GEN_15 : queueReg_3_pc; // @[prefetchModule.scala 137:17 prefetchModule.scala 56:25]
  wire [31:0] _GEN_58 = io_reset ? _GEN_16 : queueReg_3_address; // @[prefetchModule.scala 137:17 prefetchModule.scala 56:25]
  wire [31:0] _GEN_59 = io_reset ? _GEN_17 : queueReg_3_stride; // @[prefetchModule.scala 137:17 prefetchModule.scala 56:25]
  wire [31:0] _GEN_60 = io_reset ? _GEN_18 : queueReg_3_reliability; // @[prefetchModule.scala 137:17 prefetchModule.scala 56:25]
  wire [31:0] _GEN_61 = io_reset ? _GEN_19 : queueReg_3_timestamp; // @[prefetchModule.scala 137:17 prefetchModule.scala 56:25]
  wire [31:0] _GEN_62 = io_reset ? _GEN_20 : queueReg_4_pc; // @[prefetchModule.scala 137:17 prefetchModule.scala 56:25]
  wire [31:0] _GEN_63 = io_reset ? _GEN_21 : queueReg_4_address; // @[prefetchModule.scala 137:17 prefetchModule.scala 56:25]
  wire [31:0] _GEN_64 = io_reset ? _GEN_22 : queueReg_4_stride; // @[prefetchModule.scala 137:17 prefetchModule.scala 56:25]
  wire [31:0] _GEN_65 = io_reset ? _GEN_23 : queueReg_4_reliability; // @[prefetchModule.scala 137:17 prefetchModule.scala 56:25]
  wire [31:0] _GEN_66 = io_reset ? _GEN_24 : queueReg_4_timestamp; // @[prefetchModule.scala 137:17 prefetchModule.scala 56:25]
  wire [31:0] _GEN_67 = io_reset ? _GEN_25 : queueReg_5_pc; // @[prefetchModule.scala 137:17 prefetchModule.scala 56:25]
  wire [31:0] _GEN_68 = io_reset ? _GEN_26 : queueReg_5_address; // @[prefetchModule.scala 137:17 prefetchModule.scala 56:25]
  wire [31:0] _GEN_69 = io_reset ? _GEN_27 : queueReg_5_stride; // @[prefetchModule.scala 137:17 prefetchModule.scala 56:25]
  wire [31:0] _GEN_70 = io_reset ? _GEN_28 : queueReg_5_reliability; // @[prefetchModule.scala 137:17 prefetchModule.scala 56:25]
  wire [31:0] _GEN_71 = io_reset ? _GEN_29 : queueReg_5_timestamp; // @[prefetchModule.scala 137:17 prefetchModule.scala 56:25]
  wire [31:0] _GEN_72 = io_reset ? _GEN_30 : queueReg_6_pc; // @[prefetchModule.scala 137:17 prefetchModule.scala 56:25]
  wire [31:0] _GEN_73 = io_reset ? _GEN_31 : queueReg_6_address; // @[prefetchModule.scala 137:17 prefetchModule.scala 56:25]
  wire [31:0] _GEN_74 = io_reset ? _GEN_32 : queueReg_6_stride; // @[prefetchModule.scala 137:17 prefetchModule.scala 56:25]
  wire [31:0] _GEN_75 = io_reset ? _GEN_33 : queueReg_6_reliability; // @[prefetchModule.scala 137:17 prefetchModule.scala 56:25]
  wire [31:0] _GEN_76 = io_reset ? _GEN_34 : queueReg_6_timestamp; // @[prefetchModule.scala 137:17 prefetchModule.scala 56:25]
  wire [31:0] _GEN_77 = io_reset ? _GEN_35 : queueReg_7_pc; // @[prefetchModule.scala 137:17 prefetchModule.scala 56:25]
  wire [31:0] _GEN_78 = io_reset ? _GEN_36 : queueReg_7_address; // @[prefetchModule.scala 137:17 prefetchModule.scala 56:25]
  wire [31:0] _GEN_79 = io_reset ? _GEN_37 : queueReg_7_stride; // @[prefetchModule.scala 137:17 prefetchModule.scala 56:25]
  wire [31:0] _GEN_80 = io_reset ? _GEN_38 : queueReg_7_reliability; // @[prefetchModule.scala 137:17 prefetchModule.scala 56:25]
  wire [31:0] _GEN_81 = io_reset ? _GEN_39 : queueReg_7_timestamp; // @[prefetchModule.scala 137:17 prefetchModule.scala 56:25]
  wire  _GEN_83 = io_reset & _GEN_41; // @[prefetchModule.scala 137:17 prefetchModule.scala 143:11]
  reg  enable_REG; // @[prefetchModule.scala 147:36]
  wire  enable = io_enable & ~enable_REG; // @[prefetchModule.scala 147:26]
  wire  p_check = queueReg_0_pc == io_pc; // @[prefetchModule.scala 75:32]
  wire [3:0] _p_T = p_check ? 4'h0 : 4'h8; // @[prefetchModule.scala 76:12]
  wire  p_check_1 = queueReg_1_pc == io_pc; // @[prefetchModule.scala 75:32]
  wire [3:0] _p_T_1 = p_check_1 ? 4'h1 : _p_T; // @[prefetchModule.scala 76:12]
  wire  p_check_2 = queueReg_2_pc == io_pc; // @[prefetchModule.scala 75:32]
  wire [3:0] _p_T_2 = p_check_2 ? 4'h2 : _p_T_1; // @[prefetchModule.scala 76:12]
  wire  p_check_3 = queueReg_3_pc == io_pc; // @[prefetchModule.scala 75:32]
  wire [3:0] _p_T_3 = p_check_3 ? 4'h3 : _p_T_2; // @[prefetchModule.scala 76:12]
  wire  p_check_4 = queueReg_4_pc == io_pc; // @[prefetchModule.scala 75:32]
  wire [3:0] _p_T_4 = p_check_4 ? 4'h4 : _p_T_3; // @[prefetchModule.scala 76:12]
  wire  p_check_5 = queueReg_5_pc == io_pc; // @[prefetchModule.scala 75:32]
  wire [3:0] _p_T_5 = p_check_5 ? 4'h5 : _p_T_4; // @[prefetchModule.scala 76:12]
  wire  p_check_6 = queueReg_6_pc == io_pc; // @[prefetchModule.scala 75:32]
  wire [3:0] _p_T_6 = p_check_6 ? 4'h6 : _p_T_5; // @[prefetchModule.scala 76:12]
  wire  p_check_7 = queueReg_7_pc == io_pc; // @[prefetchModule.scala 75:32]
  wire [3:0] p = p_check_7 ? 4'h7 : _p_T_6; // @[prefetchModule.scala 76:12]
  wire  found = p != 4'h8; // @[prefetchModule.scala 163:19]
  wire [31:0] _GEN_90 = 3'h1 == p[2:0] ? queueReg_1_address : queueReg_0_address; // @[prefetchModule.scala 166:31 prefetchModule.scala 166:31]
  wire [31:0] _GEN_92 = 3'h1 == p[2:0] ? queueReg_1_stride : queueReg_0_stride; // @[prefetchModule.scala 166:31 prefetchModule.scala 166:31]
  wire [31:0] _GEN_93 = 3'h1 == p[2:0] ? queueReg_1_reliability : queueReg_0_reliability; // @[prefetchModule.scala 166:31 prefetchModule.scala 166:31]
  wire [31:0] _GEN_95 = 3'h2 == p[2:0] ? queueReg_2_address : _GEN_90; // @[prefetchModule.scala 166:31 prefetchModule.scala 166:31]
  wire [31:0] _GEN_97 = 3'h2 == p[2:0] ? queueReg_2_stride : _GEN_92; // @[prefetchModule.scala 166:31 prefetchModule.scala 166:31]
  wire [31:0] _GEN_98 = 3'h2 == p[2:0] ? queueReg_2_reliability : _GEN_93; // @[prefetchModule.scala 166:31 prefetchModule.scala 166:31]
  wire [31:0] _GEN_100 = 3'h3 == p[2:0] ? queueReg_3_address : _GEN_95; // @[prefetchModule.scala 166:31 prefetchModule.scala 166:31]
  wire [31:0] _GEN_102 = 3'h3 == p[2:0] ? queueReg_3_stride : _GEN_97; // @[prefetchModule.scala 166:31 prefetchModule.scala 166:31]
  wire [31:0] _GEN_103 = 3'h3 == p[2:0] ? queueReg_3_reliability : _GEN_98; // @[prefetchModule.scala 166:31 prefetchModule.scala 166:31]
  wire [31:0] _GEN_105 = 3'h4 == p[2:0] ? queueReg_4_address : _GEN_100; // @[prefetchModule.scala 166:31 prefetchModule.scala 166:31]
  wire [31:0] _GEN_107 = 3'h4 == p[2:0] ? queueReg_4_stride : _GEN_102; // @[prefetchModule.scala 166:31 prefetchModule.scala 166:31]
  wire [31:0] _GEN_108 = 3'h4 == p[2:0] ? queueReg_4_reliability : _GEN_103; // @[prefetchModule.scala 166:31 prefetchModule.scala 166:31]
  wire [31:0] _GEN_110 = 3'h5 == p[2:0] ? queueReg_5_address : _GEN_105; // @[prefetchModule.scala 166:31 prefetchModule.scala 166:31]
  wire [31:0] _GEN_112 = 3'h5 == p[2:0] ? queueReg_5_stride : _GEN_107; // @[prefetchModule.scala 166:31 prefetchModule.scala 166:31]
  wire [31:0] _GEN_113 = 3'h5 == p[2:0] ? queueReg_5_reliability : _GEN_108; // @[prefetchModule.scala 166:31 prefetchModule.scala 166:31]
  wire [31:0] _GEN_115 = 3'h6 == p[2:0] ? queueReg_6_address : _GEN_110; // @[prefetchModule.scala 166:31 prefetchModule.scala 166:31]
  wire [31:0] _GEN_117 = 3'h6 == p[2:0] ? queueReg_6_stride : _GEN_112; // @[prefetchModule.scala 166:31 prefetchModule.scala 166:31]
  wire [31:0] _GEN_118 = 3'h6 == p[2:0] ? queueReg_6_reliability : _GEN_113; // @[prefetchModule.scala 166:31 prefetchModule.scala 166:31]
  wire [31:0] _GEN_120 = 3'h7 == p[2:0] ? queueReg_7_address : _GEN_115; // @[prefetchModule.scala 166:31 prefetchModule.scala 166:31]
  wire [31:0] _GEN_122 = 3'h7 == p[2:0] ? queueReg_7_stride : _GEN_117; // @[prefetchModule.scala 166:31 prefetchModule.scala 166:31]
  wire [31:0] _GEN_123 = 3'h7 == p[2:0] ? queueReg_7_reliability : _GEN_118; // @[prefetchModule.scala 166:31 prefetchModule.scala 166:31]
  wire [31:0] newStride = io_address - _GEN_120; // @[prefetchModule.scala 166:31]
  wire  reliability_same = _GEN_122 == newStride; // @[prefetchModule.scala 130:21]
  wire [31:0] _reliability_ans_T_1 = _GEN_123 + 32'h1; // @[prefetchModule.scala 131:33]
  wire [31:0] reliability = reliability_same ? _reliability_ans_T_1 : {{1'd0}, _GEN_123[31:1]}; // @[prefetchModule.scala 131:16]
  wire  replace = reliability == 32'h0; // @[prefetchModule.scala 169:31]
  wire [31:0] stride = replace ? newStride : _GEN_122; // @[prefetchModule.scala 171:21]
  wire [31:0] w_reliability = replace ? 32'h1 : reliability; // @[prefetchModule.scala 172:28]
  wire  valid = w_reliability > 32'h1; // @[prefetchModule.scala 173:30]
  wire [31:0] _prefetch_address_T_1 = io_address + stride; // @[prefetchModule.scala 175:45]
  wire  select_1 = p_check ? 1'h0 : p_check_1; // @[prefetchModule.scala 92:21]
  wire  _T_3 = select_1 | p_check; // @[prefetchModule.scala 93:16]
  wire  select_2 = _T_3 ? 1'h0 : p_check_2; // @[prefetchModule.scala 92:21]
  wire  _T_5 = select_2 | (select_1 | p_check); // @[prefetchModule.scala 93:16]
  wire [1:0] _T_6 = select_2 ? 2'h2 : {{1'd0}, select_1}; // @[prefetchModule.scala 94:12]
  wire  select_3 = _T_5 ? 1'h0 : p_check_3; // @[prefetchModule.scala 92:21]
  wire  _T_7 = select_3 | (select_2 | (select_1 | p_check)); // @[prefetchModule.scala 93:16]
  wire [1:0] _T_8 = select_3 ? 2'h3 : _T_6; // @[prefetchModule.scala 94:12]
  wire  select_4 = _T_7 ? 1'h0 : p_check_4; // @[prefetchModule.scala 92:21]
  wire  _T_9 = select_4 | (select_3 | (select_2 | (select_1 | p_check))); // @[prefetchModule.scala 93:16]
  wire [2:0] _T_10 = select_4 ? 3'h4 : {{1'd0}, _T_8}; // @[prefetchModule.scala 94:12]
  wire  select_5 = _T_9 ? 1'h0 : p_check_5; // @[prefetchModule.scala 92:21]
  wire  _T_11 = select_5 | (select_4 | (select_3 | (select_2 | (select_1 | p_check)))); // @[prefetchModule.scala 93:16]
  wire [2:0] _T_12 = select_5 ? 3'h5 : _T_10; // @[prefetchModule.scala 94:12]
  wire  select_6 = _T_11 ? 1'h0 : p_check_6; // @[prefetchModule.scala 92:21]
  wire  _T_13 = select_6 | (select_5 | (select_4 | (select_3 | (select_2 | (select_1 | p_check))))); // @[prefetchModule.scala 93:16]
  wire [2:0] _T_14 = select_6 ? 3'h6 : _T_12; // @[prefetchModule.scala 94:12]
  wire  select_7 = _T_13 ? 1'h0 : p_check_7; // @[prefetchModule.scala 92:21]
  wire  _T_15 = select_7 | (select_6 | (select_5 | (select_4 | (select_3 | (select_2 | (select_1 | p_check)))))); // @[prefetchModule.scala 93:16]
  wire [2:0] _T_16 = select_7 ? 3'h7 : _T_14; // @[prefetchModule.scala 94:12]
  wire  check_8 = queueReg_0_pc == 32'h0; // @[prefetchModule.scala 99:32]
  wire  select_8 = _T_15 ? 1'h0 : check_8; // @[prefetchModule.scala 103:21]
  wire  _T_17 = select_8 | _T_15; // @[prefetchModule.scala 104:16]
  wire [2:0] _T_18 = select_8 ? 3'h0 : _T_16; // @[prefetchModule.scala 105:12]
  wire  check_9 = queueReg_1_pc == 32'h0; // @[prefetchModule.scala 99:32]
  wire  select_9 = _T_17 ? 1'h0 : check_9; // @[prefetchModule.scala 103:21]
  wire  _T_19 = select_9 | (select_8 | _T_15); // @[prefetchModule.scala 104:16]
  wire [2:0] _T_20 = select_9 ? 3'h1 : _T_18; // @[prefetchModule.scala 105:12]
  wire  check_10 = queueReg_2_pc == 32'h0; // @[prefetchModule.scala 99:32]
  wire  select_10 = _T_19 ? 1'h0 : check_10; // @[prefetchModule.scala 103:21]
  wire  _T_21 = select_10 | (select_9 | (select_8 | _T_15)); // @[prefetchModule.scala 104:16]
  wire [2:0] _T_22 = select_10 ? 3'h2 : _T_20; // @[prefetchModule.scala 105:12]
  wire  check_11 = queueReg_3_pc == 32'h0; // @[prefetchModule.scala 99:32]
  wire  select_11 = _T_21 ? 1'h0 : check_11; // @[prefetchModule.scala 103:21]
  wire  _T_23 = select_11 | (select_10 | (select_9 | (select_8 | _T_15))); // @[prefetchModule.scala 104:16]
  wire [2:0] _T_24 = select_11 ? 3'h3 : _T_22; // @[prefetchModule.scala 105:12]
  wire  check_12 = queueReg_4_pc == 32'h0; // @[prefetchModule.scala 99:32]
  wire  select_12 = _T_23 ? 1'h0 : check_12; // @[prefetchModule.scala 103:21]
  wire  _T_25 = select_12 | (select_11 | (select_10 | (select_9 | (select_8 | _T_15)))); // @[prefetchModule.scala 104:16]
  wire [2:0] _T_26 = select_12 ? 3'h4 : _T_24; // @[prefetchModule.scala 105:12]
  wire  check_13 = queueReg_5_pc == 32'h0; // @[prefetchModule.scala 99:32]
  wire  select_13 = _T_25 ? 1'h0 : check_13; // @[prefetchModule.scala 103:21]
  wire  _T_27 = select_13 | (select_12 | (select_11 | (select_10 | (select_9 | (select_8 | _T_15))))); // @[prefetchModule.scala 104:16]
  wire [2:0] _T_28 = select_13 ? 3'h5 : _T_26; // @[prefetchModule.scala 105:12]
  wire  check_14 = queueReg_6_pc == 32'h0; // @[prefetchModule.scala 99:32]
  wire  select_14 = _T_27 ? 1'h0 : check_14; // @[prefetchModule.scala 103:21]
  wire  _T_29 = select_14 | (select_13 | (select_12 | (select_11 | (select_10 | (select_9 | (select_8 | _T_15)))))); // @[prefetchModule.scala 104:16]
  wire [2:0] _T_30 = select_14 ? 3'h6 : _T_28; // @[prefetchModule.scala 105:12]
  wire  check_15 = queueReg_7_pc == 32'h0; // @[prefetchModule.scala 99:32]
  wire  select_15 = _T_29 ? 1'h0 : check_15; // @[prefetchModule.scala 103:21]
  wire  _T_31 = select_15 | (select_14 | (select_13 | (select_12 | (select_11 | (select_10 | (select_9 | (select_8 |
    _T_15))))))); // @[prefetchModule.scala 104:16]
  wire [2:0] _T_32 = select_15 ? 3'h7 : _T_30; // @[prefetchModule.scala 105:12]
  wire [31:0] _check_T_1 = dfn - queueReg_0_timestamp; // @[prefetchModule.scala 109:21]
  wire [31:0] _GEN_251 = 3'h1 == _T_32 ? queueReg_1_timestamp : queueReg_0_timestamp; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_256 = 3'h2 == _T_32 ? queueReg_2_timestamp : _GEN_251; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_261 = 3'h3 == _T_32 ? queueReg_3_timestamp : _GEN_256; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_266 = 3'h4 == _T_32 ? queueReg_4_timestamp : _GEN_261; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_271 = 3'h5 == _T_32 ? queueReg_5_timestamp : _GEN_266; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_276 = 3'h6 == _T_32 ? queueReg_6_timestamp : _GEN_271; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_281 = 3'h7 == _T_32 ? queueReg_7_timestamp : _GEN_276; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _check_T_3 = dfn - _GEN_281; // @[prefetchModule.scala 109:47]
  wire  check_16 = _check_T_1 > _check_T_3; // @[prefetchModule.scala 109:43]
  wire  select_16 = _T_31 ? 1'h0 : check_16; // @[prefetchModule.scala 113:21]
  wire [2:0] _T_33 = select_16 ? 3'h0 : _T_32; // @[prefetchModule.scala 114:12]
  wire [31:0] _check_T_5 = dfn - queueReg_1_timestamp; // @[prefetchModule.scala 109:21]
  wire [31:0] _GEN_291 = 3'h1 == _T_33 ? queueReg_1_timestamp : queueReg_0_timestamp; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_296 = 3'h2 == _T_33 ? queueReg_2_timestamp : _GEN_291; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_301 = 3'h3 == _T_33 ? queueReg_3_timestamp : _GEN_296; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_306 = 3'h4 == _T_33 ? queueReg_4_timestamp : _GEN_301; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_311 = 3'h5 == _T_33 ? queueReg_5_timestamp : _GEN_306; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_316 = 3'h6 == _T_33 ? queueReg_6_timestamp : _GEN_311; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_321 = 3'h7 == _T_33 ? queueReg_7_timestamp : _GEN_316; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _check_T_7 = dfn - _GEN_321; // @[prefetchModule.scala 109:47]
  wire  check_17 = _check_T_5 > _check_T_7; // @[prefetchModule.scala 109:43]
  wire  select_17 = _T_31 ? 1'h0 : check_17; // @[prefetchModule.scala 113:21]
  wire [2:0] _T_34 = select_17 ? 3'h1 : _T_33; // @[prefetchModule.scala 114:12]
  wire [31:0] _check_T_9 = dfn - queueReg_2_timestamp; // @[prefetchModule.scala 109:21]
  wire [31:0] _GEN_331 = 3'h1 == _T_34 ? queueReg_1_timestamp : queueReg_0_timestamp; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_336 = 3'h2 == _T_34 ? queueReg_2_timestamp : _GEN_331; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_341 = 3'h3 == _T_34 ? queueReg_3_timestamp : _GEN_336; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_346 = 3'h4 == _T_34 ? queueReg_4_timestamp : _GEN_341; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_351 = 3'h5 == _T_34 ? queueReg_5_timestamp : _GEN_346; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_356 = 3'h6 == _T_34 ? queueReg_6_timestamp : _GEN_351; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_361 = 3'h7 == _T_34 ? queueReg_7_timestamp : _GEN_356; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _check_T_11 = dfn - _GEN_361; // @[prefetchModule.scala 109:47]
  wire  check_18 = _check_T_9 > _check_T_11; // @[prefetchModule.scala 109:43]
  wire  select_18 = _T_31 ? 1'h0 : check_18; // @[prefetchModule.scala 113:21]
  wire [2:0] _T_35 = select_18 ? 3'h2 : _T_34; // @[prefetchModule.scala 114:12]
  wire [31:0] _check_T_13 = dfn - queueReg_3_timestamp; // @[prefetchModule.scala 109:21]
  wire [31:0] _GEN_371 = 3'h1 == _T_35 ? queueReg_1_timestamp : queueReg_0_timestamp; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_376 = 3'h2 == _T_35 ? queueReg_2_timestamp : _GEN_371; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_381 = 3'h3 == _T_35 ? queueReg_3_timestamp : _GEN_376; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_386 = 3'h4 == _T_35 ? queueReg_4_timestamp : _GEN_381; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_391 = 3'h5 == _T_35 ? queueReg_5_timestamp : _GEN_386; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_396 = 3'h6 == _T_35 ? queueReg_6_timestamp : _GEN_391; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_401 = 3'h7 == _T_35 ? queueReg_7_timestamp : _GEN_396; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _check_T_15 = dfn - _GEN_401; // @[prefetchModule.scala 109:47]
  wire  check_19 = _check_T_13 > _check_T_15; // @[prefetchModule.scala 109:43]
  wire  select_19 = _T_31 ? 1'h0 : check_19; // @[prefetchModule.scala 113:21]
  wire [2:0] _T_36 = select_19 ? 3'h3 : _T_35; // @[prefetchModule.scala 114:12]
  wire [31:0] _check_T_17 = dfn - queueReg_4_timestamp; // @[prefetchModule.scala 109:21]
  wire [31:0] _GEN_411 = 3'h1 == _T_36 ? queueReg_1_timestamp : queueReg_0_timestamp; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_416 = 3'h2 == _T_36 ? queueReg_2_timestamp : _GEN_411; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_421 = 3'h3 == _T_36 ? queueReg_3_timestamp : _GEN_416; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_426 = 3'h4 == _T_36 ? queueReg_4_timestamp : _GEN_421; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_431 = 3'h5 == _T_36 ? queueReg_5_timestamp : _GEN_426; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_436 = 3'h6 == _T_36 ? queueReg_6_timestamp : _GEN_431; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_441 = 3'h7 == _T_36 ? queueReg_7_timestamp : _GEN_436; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _check_T_19 = dfn - _GEN_441; // @[prefetchModule.scala 109:47]
  wire  check_20 = _check_T_17 > _check_T_19; // @[prefetchModule.scala 109:43]
  wire  select_20 = _T_31 ? 1'h0 : check_20; // @[prefetchModule.scala 113:21]
  wire [2:0] _T_37 = select_20 ? 3'h4 : _T_36; // @[prefetchModule.scala 114:12]
  wire [31:0] _check_T_21 = dfn - queueReg_5_timestamp; // @[prefetchModule.scala 109:21]
  wire [31:0] _GEN_451 = 3'h1 == _T_37 ? queueReg_1_timestamp : queueReg_0_timestamp; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_456 = 3'h2 == _T_37 ? queueReg_2_timestamp : _GEN_451; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_461 = 3'h3 == _T_37 ? queueReg_3_timestamp : _GEN_456; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_466 = 3'h4 == _T_37 ? queueReg_4_timestamp : _GEN_461; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_471 = 3'h5 == _T_37 ? queueReg_5_timestamp : _GEN_466; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_476 = 3'h6 == _T_37 ? queueReg_6_timestamp : _GEN_471; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_481 = 3'h7 == _T_37 ? queueReg_7_timestamp : _GEN_476; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _check_T_23 = dfn - _GEN_481; // @[prefetchModule.scala 109:47]
  wire  check_21 = _check_T_21 > _check_T_23; // @[prefetchModule.scala 109:43]
  wire  select_21 = _T_31 ? 1'h0 : check_21; // @[prefetchModule.scala 113:21]
  wire [2:0] _T_38 = select_21 ? 3'h5 : _T_37; // @[prefetchModule.scala 114:12]
  wire [31:0] _check_T_25 = dfn - queueReg_6_timestamp; // @[prefetchModule.scala 109:21]
  wire [31:0] _GEN_491 = 3'h1 == _T_38 ? queueReg_1_timestamp : queueReg_0_timestamp; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_496 = 3'h2 == _T_38 ? queueReg_2_timestamp : _GEN_491; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_501 = 3'h3 == _T_38 ? queueReg_3_timestamp : _GEN_496; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_506 = 3'h4 == _T_38 ? queueReg_4_timestamp : _GEN_501; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_511 = 3'h5 == _T_38 ? queueReg_5_timestamp : _GEN_506; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_516 = 3'h6 == _T_38 ? queueReg_6_timestamp : _GEN_511; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_521 = 3'h7 == _T_38 ? queueReg_7_timestamp : _GEN_516; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _check_T_27 = dfn - _GEN_521; // @[prefetchModule.scala 109:47]
  wire  check_22 = _check_T_25 > _check_T_27; // @[prefetchModule.scala 109:43]
  wire  select_22 = _T_31 ? 1'h0 : check_22; // @[prefetchModule.scala 113:21]
  wire [2:0] _T_39 = select_22 ? 3'h6 : _T_38; // @[prefetchModule.scala 114:12]
  wire [31:0] _check_T_29 = dfn - queueReg_7_timestamp; // @[prefetchModule.scala 109:21]
  wire [31:0] _GEN_531 = 3'h1 == _T_39 ? queueReg_1_timestamp : queueReg_0_timestamp; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_536 = 3'h2 == _T_39 ? queueReg_2_timestamp : _GEN_531; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_541 = 3'h3 == _T_39 ? queueReg_3_timestamp : _GEN_536; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_546 = 3'h4 == _T_39 ? queueReg_4_timestamp : _GEN_541; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_551 = 3'h5 == _T_39 ? queueReg_5_timestamp : _GEN_546; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_556 = 3'h6 == _T_39 ? queueReg_6_timestamp : _GEN_551; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _GEN_561 = 3'h7 == _T_39 ? queueReg_7_timestamp : _GEN_556; // @[prefetchModule.scala 109:47 prefetchModule.scala 109:47]
  wire [31:0] _check_T_31 = dfn - _GEN_561; // @[prefetchModule.scala 109:47]
  wire  check_23 = _check_T_29 > _check_T_31; // @[prefetchModule.scala 109:43]
  wire  select_23 = _T_31 ? 1'h0 : check_23; // @[prefetchModule.scala 113:21]
  wire [2:0] _T_40 = select_23 ? 3'h7 : _T_39; // @[prefetchModule.scala 114:12]
  wire [31:0] _GEN_564 = 3'h0 == _T_40 ? io_pc : _GEN_42; // @[prefetchModule.scala 119:19 prefetchModule.scala 119:19]
  wire [31:0] _GEN_565 = 3'h1 == _T_40 ? io_pc : _GEN_47; // @[prefetchModule.scala 119:19 prefetchModule.scala 119:19]
  wire [31:0] _GEN_566 = 3'h2 == _T_40 ? io_pc : _GEN_52; // @[prefetchModule.scala 119:19 prefetchModule.scala 119:19]
  wire [31:0] _GEN_567 = 3'h3 == _T_40 ? io_pc : _GEN_57; // @[prefetchModule.scala 119:19 prefetchModule.scala 119:19]
  wire [31:0] _GEN_568 = 3'h4 == _T_40 ? io_pc : _GEN_62; // @[prefetchModule.scala 119:19 prefetchModule.scala 119:19]
  wire [31:0] _GEN_569 = 3'h5 == _T_40 ? io_pc : _GEN_67; // @[prefetchModule.scala 119:19 prefetchModule.scala 119:19]
  wire [31:0] _GEN_570 = 3'h6 == _T_40 ? io_pc : _GEN_72; // @[prefetchModule.scala 119:19 prefetchModule.scala 119:19]
  wire [31:0] _GEN_571 = 3'h7 == _T_40 ? io_pc : _GEN_77; // @[prefetchModule.scala 119:19 prefetchModule.scala 119:19]
  wire [31:0] _GEN_572 = 3'h0 == _T_40 ? io_address : _GEN_43; // @[prefetchModule.scala 120:24 prefetchModule.scala 120:24]
  wire [31:0] _GEN_573 = 3'h1 == _T_40 ? io_address : _GEN_48; // @[prefetchModule.scala 120:24 prefetchModule.scala 120:24]
  wire [31:0] _GEN_574 = 3'h2 == _T_40 ? io_address : _GEN_53; // @[prefetchModule.scala 120:24 prefetchModule.scala 120:24]
  wire [31:0] _GEN_575 = 3'h3 == _T_40 ? io_address : _GEN_58; // @[prefetchModule.scala 120:24 prefetchModule.scala 120:24]
  wire [31:0] _GEN_576 = 3'h4 == _T_40 ? io_address : _GEN_63; // @[prefetchModule.scala 120:24 prefetchModule.scala 120:24]
  wire [31:0] _GEN_577 = 3'h5 == _T_40 ? io_address : _GEN_68; // @[prefetchModule.scala 120:24 prefetchModule.scala 120:24]
  wire [31:0] _GEN_578 = 3'h6 == _T_40 ? io_address : _GEN_73; // @[prefetchModule.scala 120:24 prefetchModule.scala 120:24]
  wire [31:0] _GEN_579 = 3'h7 == _T_40 ? io_address : _GEN_78; // @[prefetchModule.scala 120:24 prefetchModule.scala 120:24]
  wire [31:0] _dfn_T_1 = dfn + 32'h1; // @[prefetchModule.scala 124:13]
  wire [31:0] _GEN_596 = 3'h0 == _T_40 ? dfn : _GEN_46; // @[prefetchModule.scala 125:26 prefetchModule.scala 125:26]
  wire [31:0] _GEN_597 = 3'h1 == _T_40 ? dfn : _GEN_51; // @[prefetchModule.scala 125:26 prefetchModule.scala 125:26]
  wire [31:0] _GEN_598 = 3'h2 == _T_40 ? dfn : _GEN_56; // @[prefetchModule.scala 125:26 prefetchModule.scala 125:26]
  wire [31:0] _GEN_599 = 3'h3 == _T_40 ? dfn : _GEN_61; // @[prefetchModule.scala 125:26 prefetchModule.scala 125:26]
  wire [31:0] _GEN_600 = 3'h4 == _T_40 ? dfn : _GEN_66; // @[prefetchModule.scala 125:26 prefetchModule.scala 125:26]
  wire [31:0] _GEN_601 = 3'h5 == _T_40 ? dfn : _GEN_71; // @[prefetchModule.scala 125:26 prefetchModule.scala 125:26]
  wire [31:0] _GEN_602 = 3'h6 == _T_40 ? dfn : _GEN_76; // @[prefetchModule.scala 125:26 prefetchModule.scala 125:26]
  wire [31:0] _GEN_603 = 3'h7 == _T_40 ? dfn : _GEN_81; // @[prefetchModule.scala 125:26 prefetchModule.scala 125:26]
  wire  _GEN_964 = found & valid; // @[prefetchModule.scala 165:16 prefetchModule.scala 174:21 prefetchModule.scala 180:21]
  reg  io_ready_REG; // @[prefetchModule.scala 188:20]
  assign io_prefetch_address = prefetch_address; // @[prefetchModule.scala 190:22]
  assign io_prefetch_valid = prefetch_valid; // @[prefetchModule.scala 189:20]
  assign io_ready = io_ready_REG; // @[prefetchModule.scala 188:11]
  assign io_inited = inited; // @[prefetchModule.scala 145:12]
  always @(posedge clock) begin
    if (reset) begin // @[prefetchModule.scala 35:20]
      dfn <= 32'h0; // @[prefetchModule.scala 35:20]
    end else if (enable) begin // @[prefetchModule.scala 160:15]
      if (found) begin // @[prefetchModule.scala 165:16]
        dfn <= _dfn_T_1; // @[prefetchModule.scala 124:8]
      end else begin
        dfn <= _dfn_T_1; // @[prefetchModule.scala 124:8]
      end
    end else if (io_reset) begin // @[prefetchModule.scala 137:17]
      if (~REG) begin // @[prefetchModule.scala 138:29]
        dfn <= 32'h0; // @[prefetchModule.scala 69:8]
      end
    end
    if (reset) begin // @[prefetchModule.scala 37:31]
      prefetch_valid <= 1'h0; // @[prefetchModule.scala 37:31]
    end else if (enable) begin // @[prefetchModule.scala 160:15]
      prefetch_valid <= _GEN_964;
    end
    if (reset) begin // @[prefetchModule.scala 38:33]
      prefetch_address <= 32'h0; // @[prefetchModule.scala 38:33]
    end else if (enable) begin // @[prefetchModule.scala 160:15]
      if (found) begin // @[prefetchModule.scala 165:16]
        if (valid) begin // @[prefetchModule.scala 175:28]
          prefetch_address <= _prefetch_address_T_1;
        end else begin
          prefetch_address <= 32'h0;
        end
      end else begin
        prefetch_address <= 32'h0; // @[prefetchModule.scala 179:23]
      end
    end
    if (reset) begin // @[prefetchModule.scala 39:22]
      ready <= 1'h0; // @[prefetchModule.scala 39:22]
    end else begin
      ready <= io_enable; // @[prefetchModule.scala 187:8]
    end
    if (reset) begin // @[prefetchModule.scala 40:23]
      inited <= 1'h0; // @[prefetchModule.scala 40:23]
    end else begin
      inited <= _GEN_83;
    end
    if (reset) begin // @[prefetchModule.scala 56:25]
      queueReg_0_pc <= 32'h0; // @[prefetchModule.scala 56:25]
    end else if (enable) begin // @[prefetchModule.scala 160:15]
      if (found) begin // @[prefetchModule.scala 165:16]
        queueReg_0_pc <= _GEN_564;
      end else begin
        queueReg_0_pc <= _GEN_564;
      end
    end else begin
      queueReg_0_pc <= _GEN_42;
    end
    if (reset) begin // @[prefetchModule.scala 56:25]
      queueReg_0_address <= 32'h0; // @[prefetchModule.scala 56:25]
    end else if (enable) begin // @[prefetchModule.scala 160:15]
      if (found) begin // @[prefetchModule.scala 165:16]
        queueReg_0_address <= _GEN_572;
      end else begin
        queueReg_0_address <= _GEN_572;
      end
    end else begin
      queueReg_0_address <= _GEN_43;
    end
    if (reset) begin // @[prefetchModule.scala 56:25]
      queueReg_0_timestamp <= 32'h0; // @[prefetchModule.scala 56:25]
    end else if (enable) begin // @[prefetchModule.scala 160:15]
      if (found) begin // @[prefetchModule.scala 165:16]
        queueReg_0_timestamp <= _GEN_596;
      end else begin
        queueReg_0_timestamp <= _GEN_596;
      end
    end else begin
      queueReg_0_timestamp <= _GEN_46;
    end
    if (reset) begin // @[prefetchModule.scala 56:25]
      queueReg_0_stride <= 32'h0; // @[prefetchModule.scala 56:25]
    end else if (enable) begin // @[prefetchModule.scala 160:15]
      if (found) begin // @[prefetchModule.scala 165:16]
        if (3'h0 == _T_40) begin // @[prefetchModule.scala 121:23]
          queueReg_0_stride <= stride; // @[prefetchModule.scala 121:23]
        end else begin
          queueReg_0_stride <= _GEN_44;
        end
      end else if (3'h0 == _T_40) begin // @[prefetchModule.scala 121:23]
        queueReg_0_stride <= 32'h0; // @[prefetchModule.scala 121:23]
      end else begin
        queueReg_0_stride <= _GEN_44;
      end
    end else begin
      queueReg_0_stride <= _GEN_44;
    end
    if (reset) begin // @[prefetchModule.scala 56:25]
      queueReg_0_reliability <= 32'h0; // @[prefetchModule.scala 56:25]
    end else if (enable) begin // @[prefetchModule.scala 160:15]
      if (found) begin // @[prefetchModule.scala 165:16]
        if (3'h0 == _T_40) begin // @[prefetchModule.scala 123:28]
          queueReg_0_reliability <= w_reliability; // @[prefetchModule.scala 123:28]
        end else begin
          queueReg_0_reliability <= _GEN_45;
        end
      end else if (3'h0 == _T_40) begin // @[prefetchModule.scala 123:28]
        queueReg_0_reliability <= 32'h0; // @[prefetchModule.scala 123:28]
      end else begin
        queueReg_0_reliability <= _GEN_45;
      end
    end else begin
      queueReg_0_reliability <= _GEN_45;
    end
    if (reset) begin // @[prefetchModule.scala 56:25]
      queueReg_1_pc <= 32'h0; // @[prefetchModule.scala 56:25]
    end else if (enable) begin // @[prefetchModule.scala 160:15]
      if (found) begin // @[prefetchModule.scala 165:16]
        queueReg_1_pc <= _GEN_565;
      end else begin
        queueReg_1_pc <= _GEN_565;
      end
    end else begin
      queueReg_1_pc <= _GEN_47;
    end
    if (reset) begin // @[prefetchModule.scala 56:25]
      queueReg_1_address <= 32'h0; // @[prefetchModule.scala 56:25]
    end else if (enable) begin // @[prefetchModule.scala 160:15]
      if (found) begin // @[prefetchModule.scala 165:16]
        queueReg_1_address <= _GEN_573;
      end else begin
        queueReg_1_address <= _GEN_573;
      end
    end else begin
      queueReg_1_address <= _GEN_48;
    end
    if (reset) begin // @[prefetchModule.scala 56:25]
      queueReg_1_timestamp <= 32'h0; // @[prefetchModule.scala 56:25]
    end else if (enable) begin // @[prefetchModule.scala 160:15]
      if (found) begin // @[prefetchModule.scala 165:16]
        queueReg_1_timestamp <= _GEN_597;
      end else begin
        queueReg_1_timestamp <= _GEN_597;
      end
    end else begin
      queueReg_1_timestamp <= _GEN_51;
    end
    if (reset) begin // @[prefetchModule.scala 56:25]
      queueReg_1_stride <= 32'h0; // @[prefetchModule.scala 56:25]
    end else if (enable) begin // @[prefetchModule.scala 160:15]
      if (found) begin // @[prefetchModule.scala 165:16]
        if (3'h1 == _T_40) begin // @[prefetchModule.scala 121:23]
          queueReg_1_stride <= stride; // @[prefetchModule.scala 121:23]
        end else begin
          queueReg_1_stride <= _GEN_49;
        end
      end else if (3'h1 == _T_40) begin // @[prefetchModule.scala 121:23]
        queueReg_1_stride <= 32'h0; // @[prefetchModule.scala 121:23]
      end else begin
        queueReg_1_stride <= _GEN_49;
      end
    end else begin
      queueReg_1_stride <= _GEN_49;
    end
    if (reset) begin // @[prefetchModule.scala 56:25]
      queueReg_1_reliability <= 32'h0; // @[prefetchModule.scala 56:25]
    end else if (enable) begin // @[prefetchModule.scala 160:15]
      if (found) begin // @[prefetchModule.scala 165:16]
        if (3'h1 == _T_40) begin // @[prefetchModule.scala 123:28]
          queueReg_1_reliability <= w_reliability; // @[prefetchModule.scala 123:28]
        end else begin
          queueReg_1_reliability <= _GEN_50;
        end
      end else if (3'h1 == _T_40) begin // @[prefetchModule.scala 123:28]
        queueReg_1_reliability <= 32'h0; // @[prefetchModule.scala 123:28]
      end else begin
        queueReg_1_reliability <= _GEN_50;
      end
    end else begin
      queueReg_1_reliability <= _GEN_50;
    end
    if (reset) begin // @[prefetchModule.scala 56:25]
      queueReg_2_pc <= 32'h0; // @[prefetchModule.scala 56:25]
    end else if (enable) begin // @[prefetchModule.scala 160:15]
      if (found) begin // @[prefetchModule.scala 165:16]
        queueReg_2_pc <= _GEN_566;
      end else begin
        queueReg_2_pc <= _GEN_566;
      end
    end else begin
      queueReg_2_pc <= _GEN_52;
    end
    if (reset) begin // @[prefetchModule.scala 56:25]
      queueReg_2_address <= 32'h0; // @[prefetchModule.scala 56:25]
    end else if (enable) begin // @[prefetchModule.scala 160:15]
      if (found) begin // @[prefetchModule.scala 165:16]
        queueReg_2_address <= _GEN_574;
      end else begin
        queueReg_2_address <= _GEN_574;
      end
    end else begin
      queueReg_2_address <= _GEN_53;
    end
    if (reset) begin // @[prefetchModule.scala 56:25]
      queueReg_2_timestamp <= 32'h0; // @[prefetchModule.scala 56:25]
    end else if (enable) begin // @[prefetchModule.scala 160:15]
      if (found) begin // @[prefetchModule.scala 165:16]
        queueReg_2_timestamp <= _GEN_598;
      end else begin
        queueReg_2_timestamp <= _GEN_598;
      end
    end else begin
      queueReg_2_timestamp <= _GEN_56;
    end
    if (reset) begin // @[prefetchModule.scala 56:25]
      queueReg_2_stride <= 32'h0; // @[prefetchModule.scala 56:25]
    end else if (enable) begin // @[prefetchModule.scala 160:15]
      if (found) begin // @[prefetchModule.scala 165:16]
        if (3'h2 == _T_40) begin // @[prefetchModule.scala 121:23]
          queueReg_2_stride <= stride; // @[prefetchModule.scala 121:23]
        end else begin
          queueReg_2_stride <= _GEN_54;
        end
      end else if (3'h2 == _T_40) begin // @[prefetchModule.scala 121:23]
        queueReg_2_stride <= 32'h0; // @[prefetchModule.scala 121:23]
      end else begin
        queueReg_2_stride <= _GEN_54;
      end
    end else begin
      queueReg_2_stride <= _GEN_54;
    end
    if (reset) begin // @[prefetchModule.scala 56:25]
      queueReg_2_reliability <= 32'h0; // @[prefetchModule.scala 56:25]
    end else if (enable) begin // @[prefetchModule.scala 160:15]
      if (found) begin // @[prefetchModule.scala 165:16]
        if (3'h2 == _T_40) begin // @[prefetchModule.scala 123:28]
          queueReg_2_reliability <= w_reliability; // @[prefetchModule.scala 123:28]
        end else begin
          queueReg_2_reliability <= _GEN_55;
        end
      end else if (3'h2 == _T_40) begin // @[prefetchModule.scala 123:28]
        queueReg_2_reliability <= 32'h0; // @[prefetchModule.scala 123:28]
      end else begin
        queueReg_2_reliability <= _GEN_55;
      end
    end else begin
      queueReg_2_reliability <= _GEN_55;
    end
    if (reset) begin // @[prefetchModule.scala 56:25]
      queueReg_3_pc <= 32'h0; // @[prefetchModule.scala 56:25]
    end else if (enable) begin // @[prefetchModule.scala 160:15]
      if (found) begin // @[prefetchModule.scala 165:16]
        queueReg_3_pc <= _GEN_567;
      end else begin
        queueReg_3_pc <= _GEN_567;
      end
    end else begin
      queueReg_3_pc <= _GEN_57;
    end
    if (reset) begin // @[prefetchModule.scala 56:25]
      queueReg_3_address <= 32'h0; // @[prefetchModule.scala 56:25]
    end else if (enable) begin // @[prefetchModule.scala 160:15]
      if (found) begin // @[prefetchModule.scala 165:16]
        queueReg_3_address <= _GEN_575;
      end else begin
        queueReg_3_address <= _GEN_575;
      end
    end else begin
      queueReg_3_address <= _GEN_58;
    end
    if (reset) begin // @[prefetchModule.scala 56:25]
      queueReg_3_timestamp <= 32'h0; // @[prefetchModule.scala 56:25]
    end else if (enable) begin // @[prefetchModule.scala 160:15]
      if (found) begin // @[prefetchModule.scala 165:16]
        queueReg_3_timestamp <= _GEN_599;
      end else begin
        queueReg_3_timestamp <= _GEN_599;
      end
    end else begin
      queueReg_3_timestamp <= _GEN_61;
    end
    if (reset) begin // @[prefetchModule.scala 56:25]
      queueReg_3_stride <= 32'h0; // @[prefetchModule.scala 56:25]
    end else if (enable) begin // @[prefetchModule.scala 160:15]
      if (found) begin // @[prefetchModule.scala 165:16]
        if (3'h3 == _T_40) begin // @[prefetchModule.scala 121:23]
          queueReg_3_stride <= stride; // @[prefetchModule.scala 121:23]
        end else begin
          queueReg_3_stride <= _GEN_59;
        end
      end else if (3'h3 == _T_40) begin // @[prefetchModule.scala 121:23]
        queueReg_3_stride <= 32'h0; // @[prefetchModule.scala 121:23]
      end else begin
        queueReg_3_stride <= _GEN_59;
      end
    end else begin
      queueReg_3_stride <= _GEN_59;
    end
    if (reset) begin // @[prefetchModule.scala 56:25]
      queueReg_3_reliability <= 32'h0; // @[prefetchModule.scala 56:25]
    end else if (enable) begin // @[prefetchModule.scala 160:15]
      if (found) begin // @[prefetchModule.scala 165:16]
        if (3'h3 == _T_40) begin // @[prefetchModule.scala 123:28]
          queueReg_3_reliability <= w_reliability; // @[prefetchModule.scala 123:28]
        end else begin
          queueReg_3_reliability <= _GEN_60;
        end
      end else if (3'h3 == _T_40) begin // @[prefetchModule.scala 123:28]
        queueReg_3_reliability <= 32'h0; // @[prefetchModule.scala 123:28]
      end else begin
        queueReg_3_reliability <= _GEN_60;
      end
    end else begin
      queueReg_3_reliability <= _GEN_60;
    end
    if (reset) begin // @[prefetchModule.scala 56:25]
      queueReg_4_pc <= 32'h0; // @[prefetchModule.scala 56:25]
    end else if (enable) begin // @[prefetchModule.scala 160:15]
      if (found) begin // @[prefetchModule.scala 165:16]
        queueReg_4_pc <= _GEN_568;
      end else begin
        queueReg_4_pc <= _GEN_568;
      end
    end else begin
      queueReg_4_pc <= _GEN_62;
    end
    if (reset) begin // @[prefetchModule.scala 56:25]
      queueReg_4_address <= 32'h0; // @[prefetchModule.scala 56:25]
    end else if (enable) begin // @[prefetchModule.scala 160:15]
      if (found) begin // @[prefetchModule.scala 165:16]
        queueReg_4_address <= _GEN_576;
      end else begin
        queueReg_4_address <= _GEN_576;
      end
    end else begin
      queueReg_4_address <= _GEN_63;
    end
    if (reset) begin // @[prefetchModule.scala 56:25]
      queueReg_4_timestamp <= 32'h0; // @[prefetchModule.scala 56:25]
    end else if (enable) begin // @[prefetchModule.scala 160:15]
      if (found) begin // @[prefetchModule.scala 165:16]
        queueReg_4_timestamp <= _GEN_600;
      end else begin
        queueReg_4_timestamp <= _GEN_600;
      end
    end else begin
      queueReg_4_timestamp <= _GEN_66;
    end
    if (reset) begin // @[prefetchModule.scala 56:25]
      queueReg_4_stride <= 32'h0; // @[prefetchModule.scala 56:25]
    end else if (enable) begin // @[prefetchModule.scala 160:15]
      if (found) begin // @[prefetchModule.scala 165:16]
        if (3'h4 == _T_40) begin // @[prefetchModule.scala 121:23]
          queueReg_4_stride <= stride; // @[prefetchModule.scala 121:23]
        end else begin
          queueReg_4_stride <= _GEN_64;
        end
      end else if (3'h4 == _T_40) begin // @[prefetchModule.scala 121:23]
        queueReg_4_stride <= 32'h0; // @[prefetchModule.scala 121:23]
      end else begin
        queueReg_4_stride <= _GEN_64;
      end
    end else begin
      queueReg_4_stride <= _GEN_64;
    end
    if (reset) begin // @[prefetchModule.scala 56:25]
      queueReg_4_reliability <= 32'h0; // @[prefetchModule.scala 56:25]
    end else if (enable) begin // @[prefetchModule.scala 160:15]
      if (found) begin // @[prefetchModule.scala 165:16]
        if (3'h4 == _T_40) begin // @[prefetchModule.scala 123:28]
          queueReg_4_reliability <= w_reliability; // @[prefetchModule.scala 123:28]
        end else begin
          queueReg_4_reliability <= _GEN_65;
        end
      end else if (3'h4 == _T_40) begin // @[prefetchModule.scala 123:28]
        queueReg_4_reliability <= 32'h0; // @[prefetchModule.scala 123:28]
      end else begin
        queueReg_4_reliability <= _GEN_65;
      end
    end else begin
      queueReg_4_reliability <= _GEN_65;
    end
    if (reset) begin // @[prefetchModule.scala 56:25]
      queueReg_5_pc <= 32'h0; // @[prefetchModule.scala 56:25]
    end else if (enable) begin // @[prefetchModule.scala 160:15]
      if (found) begin // @[prefetchModule.scala 165:16]
        queueReg_5_pc <= _GEN_569;
      end else begin
        queueReg_5_pc <= _GEN_569;
      end
    end else begin
      queueReg_5_pc <= _GEN_67;
    end
    if (reset) begin // @[prefetchModule.scala 56:25]
      queueReg_5_address <= 32'h0; // @[prefetchModule.scala 56:25]
    end else if (enable) begin // @[prefetchModule.scala 160:15]
      if (found) begin // @[prefetchModule.scala 165:16]
        queueReg_5_address <= _GEN_577;
      end else begin
        queueReg_5_address <= _GEN_577;
      end
    end else begin
      queueReg_5_address <= _GEN_68;
    end
    if (reset) begin // @[prefetchModule.scala 56:25]
      queueReg_5_timestamp <= 32'h0; // @[prefetchModule.scala 56:25]
    end else if (enable) begin // @[prefetchModule.scala 160:15]
      if (found) begin // @[prefetchModule.scala 165:16]
        queueReg_5_timestamp <= _GEN_601;
      end else begin
        queueReg_5_timestamp <= _GEN_601;
      end
    end else begin
      queueReg_5_timestamp <= _GEN_71;
    end
    if (reset) begin // @[prefetchModule.scala 56:25]
      queueReg_5_stride <= 32'h0; // @[prefetchModule.scala 56:25]
    end else if (enable) begin // @[prefetchModule.scala 160:15]
      if (found) begin // @[prefetchModule.scala 165:16]
        if (3'h5 == _T_40) begin // @[prefetchModule.scala 121:23]
          queueReg_5_stride <= stride; // @[prefetchModule.scala 121:23]
        end else begin
          queueReg_5_stride <= _GEN_69;
        end
      end else if (3'h5 == _T_40) begin // @[prefetchModule.scala 121:23]
        queueReg_5_stride <= 32'h0; // @[prefetchModule.scala 121:23]
      end else begin
        queueReg_5_stride <= _GEN_69;
      end
    end else begin
      queueReg_5_stride <= _GEN_69;
    end
    if (reset) begin // @[prefetchModule.scala 56:25]
      queueReg_5_reliability <= 32'h0; // @[prefetchModule.scala 56:25]
    end else if (enable) begin // @[prefetchModule.scala 160:15]
      if (found) begin // @[prefetchModule.scala 165:16]
        if (3'h5 == _T_40) begin // @[prefetchModule.scala 123:28]
          queueReg_5_reliability <= w_reliability; // @[prefetchModule.scala 123:28]
        end else begin
          queueReg_5_reliability <= _GEN_70;
        end
      end else if (3'h5 == _T_40) begin // @[prefetchModule.scala 123:28]
        queueReg_5_reliability <= 32'h0; // @[prefetchModule.scala 123:28]
      end else begin
        queueReg_5_reliability <= _GEN_70;
      end
    end else begin
      queueReg_5_reliability <= _GEN_70;
    end
    if (reset) begin // @[prefetchModule.scala 56:25]
      queueReg_6_pc <= 32'h0; // @[prefetchModule.scala 56:25]
    end else if (enable) begin // @[prefetchModule.scala 160:15]
      if (found) begin // @[prefetchModule.scala 165:16]
        queueReg_6_pc <= _GEN_570;
      end else begin
        queueReg_6_pc <= _GEN_570;
      end
    end else begin
      queueReg_6_pc <= _GEN_72;
    end
    if (reset) begin // @[prefetchModule.scala 56:25]
      queueReg_6_address <= 32'h0; // @[prefetchModule.scala 56:25]
    end else if (enable) begin // @[prefetchModule.scala 160:15]
      if (found) begin // @[prefetchModule.scala 165:16]
        queueReg_6_address <= _GEN_578;
      end else begin
        queueReg_6_address <= _GEN_578;
      end
    end else begin
      queueReg_6_address <= _GEN_73;
    end
    if (reset) begin // @[prefetchModule.scala 56:25]
      queueReg_6_timestamp <= 32'h0; // @[prefetchModule.scala 56:25]
    end else if (enable) begin // @[prefetchModule.scala 160:15]
      if (found) begin // @[prefetchModule.scala 165:16]
        queueReg_6_timestamp <= _GEN_602;
      end else begin
        queueReg_6_timestamp <= _GEN_602;
      end
    end else begin
      queueReg_6_timestamp <= _GEN_76;
    end
    if (reset) begin // @[prefetchModule.scala 56:25]
      queueReg_6_stride <= 32'h0; // @[prefetchModule.scala 56:25]
    end else if (enable) begin // @[prefetchModule.scala 160:15]
      if (found) begin // @[prefetchModule.scala 165:16]
        if (3'h6 == _T_40) begin // @[prefetchModule.scala 121:23]
          queueReg_6_stride <= stride; // @[prefetchModule.scala 121:23]
        end else begin
          queueReg_6_stride <= _GEN_74;
        end
      end else if (3'h6 == _T_40) begin // @[prefetchModule.scala 121:23]
        queueReg_6_stride <= 32'h0; // @[prefetchModule.scala 121:23]
      end else begin
        queueReg_6_stride <= _GEN_74;
      end
    end else begin
      queueReg_6_stride <= _GEN_74;
    end
    if (reset) begin // @[prefetchModule.scala 56:25]
      queueReg_6_reliability <= 32'h0; // @[prefetchModule.scala 56:25]
    end else if (enable) begin // @[prefetchModule.scala 160:15]
      if (found) begin // @[prefetchModule.scala 165:16]
        if (3'h6 == _T_40) begin // @[prefetchModule.scala 123:28]
          queueReg_6_reliability <= w_reliability; // @[prefetchModule.scala 123:28]
        end else begin
          queueReg_6_reliability <= _GEN_75;
        end
      end else if (3'h6 == _T_40) begin // @[prefetchModule.scala 123:28]
        queueReg_6_reliability <= 32'h0; // @[prefetchModule.scala 123:28]
      end else begin
        queueReg_6_reliability <= _GEN_75;
      end
    end else begin
      queueReg_6_reliability <= _GEN_75;
    end
    if (reset) begin // @[prefetchModule.scala 56:25]
      queueReg_7_pc <= 32'h0; // @[prefetchModule.scala 56:25]
    end else if (enable) begin // @[prefetchModule.scala 160:15]
      if (found) begin // @[prefetchModule.scala 165:16]
        queueReg_7_pc <= _GEN_571;
      end else begin
        queueReg_7_pc <= _GEN_571;
      end
    end else begin
      queueReg_7_pc <= _GEN_77;
    end
    if (reset) begin // @[prefetchModule.scala 56:25]
      queueReg_7_address <= 32'h0; // @[prefetchModule.scala 56:25]
    end else if (enable) begin // @[prefetchModule.scala 160:15]
      if (found) begin // @[prefetchModule.scala 165:16]
        queueReg_7_address <= _GEN_579;
      end else begin
        queueReg_7_address <= _GEN_579;
      end
    end else begin
      queueReg_7_address <= _GEN_78;
    end
    if (reset) begin // @[prefetchModule.scala 56:25]
      queueReg_7_timestamp <= 32'h0; // @[prefetchModule.scala 56:25]
    end else if (enable) begin // @[prefetchModule.scala 160:15]
      if (found) begin // @[prefetchModule.scala 165:16]
        queueReg_7_timestamp <= _GEN_603;
      end else begin
        queueReg_7_timestamp <= _GEN_603;
      end
    end else begin
      queueReg_7_timestamp <= _GEN_81;
    end
    if (reset) begin // @[prefetchModule.scala 56:25]
      queueReg_7_stride <= 32'h0; // @[prefetchModule.scala 56:25]
    end else if (enable) begin // @[prefetchModule.scala 160:15]
      if (found) begin // @[prefetchModule.scala 165:16]
        if (3'h7 == _T_40) begin // @[prefetchModule.scala 121:23]
          queueReg_7_stride <= stride; // @[prefetchModule.scala 121:23]
        end else begin
          queueReg_7_stride <= _GEN_79;
        end
      end else if (3'h7 == _T_40) begin // @[prefetchModule.scala 121:23]
        queueReg_7_stride <= 32'h0; // @[prefetchModule.scala 121:23]
      end else begin
        queueReg_7_stride <= _GEN_79;
      end
    end else begin
      queueReg_7_stride <= _GEN_79;
    end
    if (reset) begin // @[prefetchModule.scala 56:25]
      queueReg_7_reliability <= 32'h0; // @[prefetchModule.scala 56:25]
    end else if (enable) begin // @[prefetchModule.scala 160:15]
      if (found) begin // @[prefetchModule.scala 165:16]
        if (3'h7 == _T_40) begin // @[prefetchModule.scala 123:28]
          queueReg_7_reliability <= w_reliability; // @[prefetchModule.scala 123:28]
        end else begin
          queueReg_7_reliability <= _GEN_80;
        end
      end else if (3'h7 == _T_40) begin // @[prefetchModule.scala 123:28]
        queueReg_7_reliability <= 32'h0; // @[prefetchModule.scala 123:28]
      end else begin
        queueReg_7_reliability <= _GEN_80;
      end
    end else begin
      queueReg_7_reliability <= _GEN_80;
    end
    REG <= io_reset; // @[prefetchModule.scala 138:18]
    enable_REG <= io_enable; // @[prefetchModule.scala 147:36]
    io_ready_REG <= ready; // @[prefetchModule.scala 188:20]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  dfn = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  prefetch_valid = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  prefetch_address = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  ready = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  inited = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  queueReg_0_pc = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  queueReg_0_address = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  queueReg_0_timestamp = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  queueReg_0_stride = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  queueReg_0_reliability = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  queueReg_1_pc = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  queueReg_1_address = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  queueReg_1_timestamp = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  queueReg_1_stride = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  queueReg_1_reliability = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  queueReg_2_pc = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  queueReg_2_address = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  queueReg_2_timestamp = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  queueReg_2_stride = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  queueReg_2_reliability = _RAND_19[31:0];
  _RAND_20 = {1{`RANDOM}};
  queueReg_3_pc = _RAND_20[31:0];
  _RAND_21 = {1{`RANDOM}};
  queueReg_3_address = _RAND_21[31:0];
  _RAND_22 = {1{`RANDOM}};
  queueReg_3_timestamp = _RAND_22[31:0];
  _RAND_23 = {1{`RANDOM}};
  queueReg_3_stride = _RAND_23[31:0];
  _RAND_24 = {1{`RANDOM}};
  queueReg_3_reliability = _RAND_24[31:0];
  _RAND_25 = {1{`RANDOM}};
  queueReg_4_pc = _RAND_25[31:0];
  _RAND_26 = {1{`RANDOM}};
  queueReg_4_address = _RAND_26[31:0];
  _RAND_27 = {1{`RANDOM}};
  queueReg_4_timestamp = _RAND_27[31:0];
  _RAND_28 = {1{`RANDOM}};
  queueReg_4_stride = _RAND_28[31:0];
  _RAND_29 = {1{`RANDOM}};
  queueReg_4_reliability = _RAND_29[31:0];
  _RAND_30 = {1{`RANDOM}};
  queueReg_5_pc = _RAND_30[31:0];
  _RAND_31 = {1{`RANDOM}};
  queueReg_5_address = _RAND_31[31:0];
  _RAND_32 = {1{`RANDOM}};
  queueReg_5_timestamp = _RAND_32[31:0];
  _RAND_33 = {1{`RANDOM}};
  queueReg_5_stride = _RAND_33[31:0];
  _RAND_34 = {1{`RANDOM}};
  queueReg_5_reliability = _RAND_34[31:0];
  _RAND_35 = {1{`RANDOM}};
  queueReg_6_pc = _RAND_35[31:0];
  _RAND_36 = {1{`RANDOM}};
  queueReg_6_address = _RAND_36[31:0];
  _RAND_37 = {1{`RANDOM}};
  queueReg_6_timestamp = _RAND_37[31:0];
  _RAND_38 = {1{`RANDOM}};
  queueReg_6_stride = _RAND_38[31:0];
  _RAND_39 = {1{`RANDOM}};
  queueReg_6_reliability = _RAND_39[31:0];
  _RAND_40 = {1{`RANDOM}};
  queueReg_7_pc = _RAND_40[31:0];
  _RAND_41 = {1{`RANDOM}};
  queueReg_7_address = _RAND_41[31:0];
  _RAND_42 = {1{`RANDOM}};
  queueReg_7_timestamp = _RAND_42[31:0];
  _RAND_43 = {1{`RANDOM}};
  queueReg_7_stride = _RAND_43[31:0];
  _RAND_44 = {1{`RANDOM}};
  queueReg_7_reliability = _RAND_44[31:0];
  _RAND_45 = {1{`RANDOM}};
  REG = _RAND_45[0:0];
  _RAND_46 = {1{`RANDOM}};
  enable_REG = _RAND_46[0:0];
  _RAND_47 = {1{`RANDOM}};
  io_ready_REG = _RAND_47[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule