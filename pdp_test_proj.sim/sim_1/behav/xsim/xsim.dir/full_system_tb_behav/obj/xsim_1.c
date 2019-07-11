/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/


#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/


#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
typedef void (*funcp)(char *, char *);
extern void execute_2(char*, char *);
extern void execute_3(char*, char *);
extern void execute_4(char*, char *);
extern void execute_207(char*, char *);
extern void execute_208(char*, char *);
extern void execute_209(char*, char *);
extern void execute_210(char*, char *);
extern void execute_211(char*, char *);
extern void execute_212(char*, char *);
extern void execute_213(char*, char *);
extern void execute_214(char*, char *);
extern void execute_215(char*, char *);
extern void execute_216(char*, char *);
extern void execute_217(char*, char *);
extern void vlog_simple_process_execute_0_fast_no_reg_no_agg(char*, char*, char*);
extern void execute_1113(char*, char *);
extern void execute_1114(char*, char *);
extern void execute_1115(char*, char *);
extern void execute_1116(char*, char *);
extern void execute_1117(char*, char *);
extern void execute_1118(char*, char *);
extern void execute_1119(char*, char *);
extern void execute_1120(char*, char *);
extern void execute_1121(char*, char *);
extern void execute_1122(char*, char *);
extern void execute_1123(char*, char *);
extern void execute_1124(char*, char *);
extern void execute_1125(char*, char *);
extern void execute_1126(char*, char *);
extern void execute_1127(char*, char *);
extern void execute_1128(char*, char *);
extern void execute_1129(char*, char *);
extern void execute_1130(char*, char *);
extern void execute_1131(char*, char *);
extern void execute_1132(char*, char *);
extern void execute_1133(char*, char *);
extern void execute_1134(char*, char *);
extern void execute_1135(char*, char *);
extern void execute_1136(char*, char *);
extern void execute_1137(char*, char *);
extern void execute_1138(char*, char *);
extern void execute_1139(char*, char *);
extern void execute_1140(char*, char *);
extern void execute_1141(char*, char *);
extern void execute_1142(char*, char *);
extern void execute_1143(char*, char *);
extern void execute_1144(char*, char *);
extern void execute_1145(char*, char *);
extern void execute_1146(char*, char *);
extern void execute_1147(char*, char *);
extern void execute_1148(char*, char *);
extern void execute_1149(char*, char *);
extern void execute_1150(char*, char *);
extern void execute_1151(char*, char *);
extern void execute_1152(char*, char *);
extern void execute_7(char*, char *);
extern void execute_8(char*, char *);
extern void execute_9(char*, char *);
extern void execute_11(char*, char *);
extern void vlog_const_rhs_process_execute_0_fast_no_reg_no_agg(char*, char*, char*);
extern void execute_568(char*, char *);
extern void execute_569(char*, char *);
extern void execute_570(char*, char *);
extern void execute_571(char*, char *);
extern void execute_572(char*, char *);
extern void execute_573(char*, char *);
extern void execute_584(char*, char *);
extern void execute_585(char*, char *);
extern void execute_586(char*, char *);
extern void execute_587(char*, char *);
extern void execute_589(char*, char *);
extern void execute_590(char*, char *);
extern void execute_591(char*, char *);
extern void execute_592(char*, char *);
extern void execute_596(char*, char *);
extern void execute_597(char*, char *);
extern void execute_605(char*, char *);
extern void execute_609(char*, char *);
extern void execute_610(char*, char *);
extern void execute_611(char*, char *);
extern void execute_612(char*, char *);
extern void execute_614(char*, char *);
extern void execute_615(char*, char *);
extern void execute_616(char*, char *);
extern void execute_617(char*, char *);
extern void execute_623(char*, char *);
extern void execute_624(char*, char *);
extern void execute_629(char*, char *);
extern void execute_635(char*, char *);
extern void execute_639(char*, char *);
extern void execute_640(char*, char *);
extern void execute_643(char*, char *);
extern void execute_644(char*, char *);
extern void execute_647(char*, char *);
extern void execute_648(char*, char *);
extern void execute_651(char*, char *);
extern void execute_652(char*, char *);
extern void execute_655(char*, char *);
extern void execute_656(char*, char *);
extern void execute_659(char*, char *);
extern void execute_660(char*, char *);
extern void execute_220(char*, char *);
extern void execute_90(char*, char *);
extern void vlog_simple_process_execute_1_fast_no_reg_no_agg(char*, char*, char*);
extern void execute_549(char*, char *);
extern void execute_552(char*, char *);
extern void execute_553(char*, char *);
extern void execute_554(char*, char *);
extern void execute_557(char*, char *);
extern void execute_558(char*, char *);
extern void execute_559(char*, char *);
extern void execute_560(char*, char *);
extern void execute_561(char*, char *);
extern void execute_16(char*, char *);
extern void execute_17(char*, char *);
extern void execute_18(char*, char *);
extern void execute_19(char*, char *);
extern void execute_20(char*, char *);
extern void execute_21(char*, char *);
extern void execute_22(char*, char *);
extern void execute_23(char*, char *);
extern void execute_24(char*, char *);
extern void execute_25(char*, char *);
extern void execute_26(char*, char *);
extern void execute_27(char*, char *);
extern void execute_28(char*, char *);
extern void execute_29(char*, char *);
extern void execute_30(char*, char *);
extern void execute_31(char*, char *);
extern void execute_79(char*, char *);
extern void execute_80(char*, char *);
extern void execute_81(char*, char *);
extern void execute_82(char*, char *);
extern void execute_83(char*, char *);
extern void execute_84(char*, char *);
extern void execute_85(char*, char *);
extern void execute_86(char*, char *);
extern void execute_87(char*, char *);
extern void execute_88(char*, char *);
extern void execute_89(char*, char *);
extern void execute_452(char*, char *);
extern void execute_453(char*, char *);
extern void execute_456(char*, char *);
extern void execute_499(char*, char *);
extern void execute_500(char*, char *);
extern void execute_501(char*, char *);
extern void execute_504(char*, char *);
extern void execute_508(char*, char *);
extern void execute_521(char*, char *);
extern void execute_522(char*, char *);
extern void execute_523(char*, char *);
extern void execute_524(char*, char *);
extern void execute_528(char*, char *);
extern void execute_529(char*, char *);
extern void execute_531(char*, char *);
extern void execute_532(char*, char *);
extern void execute_533(char*, char *);
extern void execute_534(char*, char *);
extern void execute_535(char*, char *);
extern void execute_536(char*, char *);
extern void execute_537(char*, char *);
extern void execute_538(char*, char *);
extern void execute_539(char*, char *);
extern void execute_540(char*, char *);
extern void execute_541(char*, char *);
extern void execute_542(char*, char *);
extern void execute_543(char*, char *);
extern void execute_544(char*, char *);
extern void execute_545(char*, char *);
extern void execute_546(char*, char *);
extern void execute_33(char*, char *);
extern void execute_34(char*, char *);
extern void execute_35(char*, char *);
extern void execute_36(char*, char *);
extern void execute_37(char*, char *);
extern void execute_38(char*, char *);
extern void execute_42(char*, char *);
extern void execute_43(char*, char *);
extern void execute_44(char*, char *);
extern void execute_63(char*, char *);
extern void execute_64(char*, char *);
extern void execute_66(char*, char *);
extern void execute_68(char*, char *);
extern void execute_69(char*, char *);
extern void execute_71(char*, char *);
extern void execute_73(char*, char *);
extern void execute_75(char*, char *);
extern void execute_77(char*, char *);
extern void execute_457(char*, char *);
extern void execute_458(char*, char *);
extern void execute_459(char*, char *);
extern void execute_460(char*, char *);
extern void execute_461(char*, char *);
extern void execute_462(char*, char *);
extern void execute_463(char*, char *);
extern void execute_464(char*, char *);
extern void execute_465(char*, char *);
extern void execute_466(char*, char *);
extern void execute_467(char*, char *);
extern void execute_468(char*, char *);
extern void execute_475(char*, char *);
extern void execute_476(char*, char *);
extern void execute_477(char*, char *);
extern void execute_478(char*, char *);
extern void execute_479(char*, char *);
extern void execute_480(char*, char *);
extern void execute_481(char*, char *);
extern void execute_482(char*, char *);
extern void execute_483(char*, char *);
extern void execute_484(char*, char *);
extern void execute_485(char*, char *);
extern void execute_488(char*, char *);
extern void execute_489(char*, char *);
extern void execute_490(char*, char *);
extern void execute_491(char*, char *);
extern void execute_492(char*, char *);
extern void execute_493(char*, char *);
extern void execute_494(char*, char *);
extern void execute_495(char*, char *);
extern void execute_46(char*, char *);
extern void execute_47(char*, char *);
extern void execute_1009(char*, char *);
extern void execute_1010(char*, char *);
extern void execute_1011(char*, char *);
extern void execute_1012(char*, char *);
extern void execute_1013(char*, char *);
extern void execute_1014(char*, char *);
extern void execute_1025(char*, char *);
extern void execute_1026(char*, char *);
extern void execute_1027(char*, char *);
extern void execute_1028(char*, char *);
extern void execute_1030(char*, char *);
extern void execute_1031(char*, char *);
extern void execute_1032(char*, char *);
extern void execute_1033(char*, char *);
extern void execute_1037(char*, char *);
extern void execute_1038(char*, char *);
extern void execute_1046(char*, char *);
extern void execute_1050(char*, char *);
extern void execute_1051(char*, char *);
extern void execute_1052(char*, char *);
extern void execute_1053(char*, char *);
extern void execute_1055(char*, char *);
extern void execute_1056(char*, char *);
extern void execute_1057(char*, char *);
extern void execute_1058(char*, char *);
extern void execute_1064(char*, char *);
extern void execute_1065(char*, char *);
extern void execute_1070(char*, char *);
extern void execute_1076(char*, char *);
extern void execute_1080(char*, char *);
extern void execute_1081(char*, char *);
extern void execute_1084(char*, char *);
extern void execute_1085(char*, char *);
extern void execute_1088(char*, char *);
extern void execute_1089(char*, char *);
extern void execute_1092(char*, char *);
extern void execute_1093(char*, char *);
extern void execute_1096(char*, char *);
extern void execute_1097(char*, char *);
extern void execute_1100(char*, char *);
extern void execute_1101(char*, char *);
extern void execute_171(char*, char *);
extern void execute_172(char*, char *);
extern void execute_173(char*, char *);
extern void execute_174(char*, char *);
extern void execute_175(char*, char *);
extern void execute_177(char*, char *);
extern void execute_178(char*, char *);
extern void execute_179(char*, char *);
extern void execute_180(char*, char *);
extern void execute_194(char*, char *);
extern void execute_195(char*, char *);
extern void execute_196(char*, char *);
extern void execute_197(char*, char *);
extern void execute_198(char*, char *);
extern void execute_1103(char*, char *);
extern void execute_1104(char*, char *);
extern void execute_1105(char*, char *);
extern void execute_1106(char*, char *);
extern void execute_1107(char*, char *);
extern void execute_1108(char*, char *);
extern void execute_1109(char*, char *);
extern void execute_183(char*, char *);
extern void execute_184(char*, char *);
extern void execute_185(char*, char *);
extern void execute_187(char*, char *);
extern void execute_188(char*, char *);
extern void execute_189(char*, char *);
extern void execute_190(char*, char *);
extern void execute_191(char*, char *);
extern void execute_192(char*, char *);
extern void execute_193(char*, char *);
extern void execute_1102(char*, char *);
extern void execute_200(char*, char *);
extern void execute_201(char*, char *);
extern void execute_202(char*, char *);
extern void execute_204(char*, char *);
extern void execute_205(char*, char *);
extern void execute_206(char*, char *);
extern void execute_1153(char*, char *);
extern void execute_1154(char*, char *);
extern void execute_1155(char*, char *);
extern void execute_1156(char*, char *);
extern void execute_1157(char*, char *);
extern void vlog_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
extern void transaction_24(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_61(char*, char*, unsigned, unsigned, unsigned);
funcp funcTab[308] = {(funcp)execute_2, (funcp)execute_3, (funcp)execute_4, (funcp)execute_207, (funcp)execute_208, (funcp)execute_209, (funcp)execute_210, (funcp)execute_211, (funcp)execute_212, (funcp)execute_213, (funcp)execute_214, (funcp)execute_215, (funcp)execute_216, (funcp)execute_217, (funcp)vlog_simple_process_execute_0_fast_no_reg_no_agg, (funcp)execute_1113, (funcp)execute_1114, (funcp)execute_1115, (funcp)execute_1116, (funcp)execute_1117, (funcp)execute_1118, (funcp)execute_1119, (funcp)execute_1120, (funcp)execute_1121, (funcp)execute_1122, (funcp)execute_1123, (funcp)execute_1124, (funcp)execute_1125, (funcp)execute_1126, (funcp)execute_1127, (funcp)execute_1128, (funcp)execute_1129, (funcp)execute_1130, (funcp)execute_1131, (funcp)execute_1132, (funcp)execute_1133, (funcp)execute_1134, (funcp)execute_1135, (funcp)execute_1136, (funcp)execute_1137, (funcp)execute_1138, (funcp)execute_1139, (funcp)execute_1140, (funcp)execute_1141, (funcp)execute_1142, (funcp)execute_1143, (funcp)execute_1144, (funcp)execute_1145, (funcp)execute_1146, (funcp)execute_1147, (funcp)execute_1148, (funcp)execute_1149, (funcp)execute_1150, (funcp)execute_1151, (funcp)execute_1152, (funcp)execute_7, (funcp)execute_8, (funcp)execute_9, (funcp)execute_11, (funcp)vlog_const_rhs_process_execute_0_fast_no_reg_no_agg, (funcp)execute_568, (funcp)execute_569, (funcp)execute_570, (funcp)execute_571, (funcp)execute_572, (funcp)execute_573, (funcp)execute_584, (funcp)execute_585, (funcp)execute_586, (funcp)execute_587, (funcp)execute_589, (funcp)execute_590, (funcp)execute_591, (funcp)execute_592, (funcp)execute_596, (funcp)execute_597, (funcp)execute_605, (funcp)execute_609, (funcp)execute_610, (funcp)execute_611, (funcp)execute_612, (funcp)execute_614, (funcp)execute_615, (funcp)execute_616, (funcp)execute_617, (funcp)execute_623, (funcp)execute_624, (funcp)execute_629, (funcp)execute_635, (funcp)execute_639, (funcp)execute_640, (funcp)execute_643, (funcp)execute_644, (funcp)execute_647, (funcp)execute_648, (funcp)execute_651, (funcp)execute_652, (funcp)execute_655, (funcp)execute_656, (funcp)execute_659, (funcp)execute_660, (funcp)execute_220, (funcp)execute_90, (funcp)vlog_simple_process_execute_1_fast_no_reg_no_agg, (funcp)execute_549, (funcp)execute_552, (funcp)execute_553, (funcp)execute_554, (funcp)execute_557, (funcp)execute_558, (funcp)execute_559, (funcp)execute_560, (funcp)execute_561, (funcp)execute_16, (funcp)execute_17, (funcp)execute_18, (funcp)execute_19, (funcp)execute_20, (funcp)execute_21, (funcp)execute_22, (funcp)execute_23, (funcp)execute_24, (funcp)execute_25, (funcp)execute_26, (funcp)execute_27, (funcp)execute_28, (funcp)execute_29, (funcp)execute_30, (funcp)execute_31, (funcp)execute_79, (funcp)execute_80, (funcp)execute_81, (funcp)execute_82, (funcp)execute_83, (funcp)execute_84, (funcp)execute_85, (funcp)execute_86, (funcp)execute_87, (funcp)execute_88, (funcp)execute_89, (funcp)execute_452, (funcp)execute_453, (funcp)execute_456, (funcp)execute_499, (funcp)execute_500, (funcp)execute_501, (funcp)execute_504, (funcp)execute_508, (funcp)execute_521, (funcp)execute_522, (funcp)execute_523, (funcp)execute_524, (funcp)execute_528, (funcp)execute_529, (funcp)execute_531, (funcp)execute_532, (funcp)execute_533, (funcp)execute_534, (funcp)execute_535, (funcp)execute_536, (funcp)execute_537, (funcp)execute_538, (funcp)execute_539, (funcp)execute_540, (funcp)execute_541, (funcp)execute_542, (funcp)execute_543, (funcp)execute_544, (funcp)execute_545, (funcp)execute_546, (funcp)execute_33, (funcp)execute_34, (funcp)execute_35, (funcp)execute_36, (funcp)execute_37, (funcp)execute_38, (funcp)execute_42, (funcp)execute_43, (funcp)execute_44, (funcp)execute_63, (funcp)execute_64, (funcp)execute_66, (funcp)execute_68, (funcp)execute_69, (funcp)execute_71, (funcp)execute_73, (funcp)execute_75, (funcp)execute_77, (funcp)execute_457, (funcp)execute_458, (funcp)execute_459, (funcp)execute_460, (funcp)execute_461, (funcp)execute_462, (funcp)execute_463, (funcp)execute_464, (funcp)execute_465, (funcp)execute_466, (funcp)execute_467, (funcp)execute_468, (funcp)execute_475, (funcp)execute_476, (funcp)execute_477, (funcp)execute_478, (funcp)execute_479, (funcp)execute_480, (funcp)execute_481, (funcp)execute_482, (funcp)execute_483, (funcp)execute_484, (funcp)execute_485, (funcp)execute_488, (funcp)execute_489, (funcp)execute_490, (funcp)execute_491, (funcp)execute_492, (funcp)execute_493, (funcp)execute_494, (funcp)execute_495, (funcp)execute_46, (funcp)execute_47, (funcp)execute_1009, (funcp)execute_1010, (funcp)execute_1011, (funcp)execute_1012, (funcp)execute_1013, (funcp)execute_1014, (funcp)execute_1025, (funcp)execute_1026, (funcp)execute_1027, (funcp)execute_1028, (funcp)execute_1030, (funcp)execute_1031, (funcp)execute_1032, (funcp)execute_1033, (funcp)execute_1037, (funcp)execute_1038, (funcp)execute_1046, (funcp)execute_1050, (funcp)execute_1051, (funcp)execute_1052, (funcp)execute_1053, (funcp)execute_1055, (funcp)execute_1056, (funcp)execute_1057, (funcp)execute_1058, (funcp)execute_1064, (funcp)execute_1065, (funcp)execute_1070, (funcp)execute_1076, (funcp)execute_1080, (funcp)execute_1081, (funcp)execute_1084, (funcp)execute_1085, (funcp)execute_1088, (funcp)execute_1089, (funcp)execute_1092, (funcp)execute_1093, (funcp)execute_1096, (funcp)execute_1097, (funcp)execute_1100, (funcp)execute_1101, (funcp)execute_171, (funcp)execute_172, (funcp)execute_173, (funcp)execute_174, (funcp)execute_175, (funcp)execute_177, (funcp)execute_178, (funcp)execute_179, (funcp)execute_180, (funcp)execute_194, (funcp)execute_195, (funcp)execute_196, (funcp)execute_197, (funcp)execute_198, (funcp)execute_1103, (funcp)execute_1104, (funcp)execute_1105, (funcp)execute_1106, (funcp)execute_1107, (funcp)execute_1108, (funcp)execute_1109, (funcp)execute_183, (funcp)execute_184, (funcp)execute_185, (funcp)execute_187, (funcp)execute_188, (funcp)execute_189, (funcp)execute_190, (funcp)execute_191, (funcp)execute_192, (funcp)execute_193, (funcp)execute_1102, (funcp)execute_200, (funcp)execute_201, (funcp)execute_202, (funcp)execute_204, (funcp)execute_205, (funcp)execute_206, (funcp)execute_1153, (funcp)execute_1154, (funcp)execute_1155, (funcp)execute_1156, (funcp)execute_1157, (funcp)vlog_transfunc_eventcallback, (funcp)transaction_24, (funcp)transaction_61};
const int NumRelocateId= 308;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/full_system_tb_behav/xsim.reloc",  (void **)funcTab, 308);

	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/full_system_tb_behav/xsim.reloc");
}

	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net

void wrapper_func_0(char *dp)

{

}

void simulate(char *dp)
{
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/full_system_tb_behav/xsim.reloc");
	wrapper_func_0(dp);

	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
void relocate(char *);

void sensitize(char *);

void simulate(char *);

extern SYSTEMCLIB_IMP_DLLSPEC void local_register_implicit_channel(int, char*);
extern void implicit_HDL_SCinstatiate();

extern SYSTEMCLIB_IMP_DLLSPEC int xsim_argc_copy ;
extern SYSTEMCLIB_IMP_DLLSPEC char** xsim_argv_copy ;

int main(int argc, char **argv)
{
    iki_heap_initialize("ms", "isimmm", 0, 2147483648) ;
    iki_set_sv_type_file_path_name("xsim.dir/full_system_tb_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/full_system_tb_behav/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/full_system_tb_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
