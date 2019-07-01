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
extern void execute_807(char*, char *);
extern void execute_808(char*, char *);
extern void execute_809(char*, char *);
extern void execute_810(char*, char *);
extern void vlog_simple_process_execute_0_fast_no_reg_no_agg(char*, char*, char*);
extern void execute_816(char*, char *);
extern void execute_818(char*, char *);
extern void execute_1780(char*, char *);
extern void execute_1781(char*, char *);
extern void execute_1782(char*, char *);
extern void execute_1783(char*, char *);
extern void execute_1784(char*, char *);
extern void execute_1785(char*, char *);
extern void execute_1786(char*, char *);
extern void execute_1787(char*, char *);
extern void execute_10(char*, char *);
extern void execute_11(char*, char *);
extern void execute_15(char*, char *);
extern void execute_16(char*, char *);
extern void execute_36(char*, char *);
extern void execute_37(char*, char *);
extern void vlog_const_rhs_process_execute_0_fast_no_reg_no_agg(char*, char*, char*);
extern void execute_52(char*, char *);
extern void execute_53(char*, char *);
extern void execute_54(char*, char *);
extern void execute_829(char*, char *);
extern void execute_830(char*, char *);
extern void execute_831(char*, char *);
extern void execute_114(char*, char *);
extern void execute_869(char*, char *);
extern void execute_870(char*, char *);
extern void execute_871(char*, char *);
extern void execute_872(char*, char *);
extern void execute_873(char*, char *);
extern void execute_874(char*, char *);
extern void execute_875(char*, char *);
extern void execute_876(char*, char *);
extern void execute_868(char*, char *);
extern void execute_117(char*, char *);
extern void execute_878(char*, char *);
extern void execute_879(char*, char *);
extern void execute_880(char*, char *);
extern void execute_881(char*, char *);
extern void execute_877(char*, char *);
extern void execute_321(char*, char *);
extern void execute_322(char*, char *);
extern void execute_323(char*, char *);
extern void execute_1165(char*, char *);
extern void execute_1166(char*, char *);
extern void execute_1167(char*, char *);
extern void execute_1168(char*, char *);
extern void execute_331(char*, char *);
extern void execute_1176(char*, char *);
extern void execute_1177(char*, char *);
extern void execute_1175(char*, char *);
extern void execute_352(char*, char *);
extern void execute_353(char*, char *);
extern void execute_354(char*, char *);
extern void execute_1195(char*, char *);
extern void execute_1196(char*, char *);
extern void execute_1197(char*, char *);
extern void execute_1198(char*, char *);
extern void execute_527(char*, char *);
extern void execute_528(char*, char *);
extern void execute_1365(char*, char *);
extern void execute_1366(char*, char *);
extern void execute_1368(char*, char *);
extern void execute_1369(char*, char *);
extern void execute_1370(char*, char *);
extern void execute_1371(char*, char *);
extern void execute_1667(char*, char *);
extern void execute_721(char*, char *);
extern void execute_722(char*, char *);
extern void execute_723(char*, char *);
extern void execute_1668(char*, char *);
extern void execute_1669(char*, char *);
extern void execute_1670(char*, char *);
extern void execute_1671(char*, char *);
extern void execute_1714(char*, char *);
extern void execute_1735(char*, char *);
extern void execute_1756(char*, char *);
extern void execute_803(char*, char *);
extern void execute_804(char*, char *);
extern void execute_805(char*, char *);
extern void execute_806(char*, char *);
extern void execute_812(char*, char *);
extern void execute_813(char*, char *);
extern void execute_814(char*, char *);
extern void execute_1788(char*, char *);
extern void execute_1789(char*, char *);
extern void execute_1790(char*, char *);
extern void execute_1791(char*, char *);
extern void execute_1792(char*, char *);
extern void vlog_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
extern void transaction_399(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_403(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_407(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_411(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_415(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_419(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_423(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_427(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_431(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_435(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_439(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_443(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_479(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_483(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_487(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_491(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_495(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_499(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_528(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_532(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_536(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_540(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_544(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_548(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_605(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_609(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_613(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_617(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_621(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_625(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_629(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_633(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_637(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_641(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_645(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_649(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_685(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_689(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_693(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_697(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_701(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_705(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_734(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_738(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_742(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_746(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_750(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_754(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_775(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_780(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_823(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_828(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_833(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_838(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_843(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_848(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_853(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_858(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_863(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_868(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_873(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_878(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_908(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_913(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_919(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_960(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_965(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_970(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_975(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_980(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_985(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_990(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_995(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1000(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1005(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1010(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1015(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1020(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1025(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1030(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1035(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1040(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1045(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1207(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1212(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1217(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1222(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1227(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1232(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1237(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1242(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1247(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1252(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1257(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1262(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1267(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1272(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1277(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1282(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1287(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1292(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1297(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1302(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1307(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1312(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1317(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1322(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1327(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1332(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1337(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1342(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1347(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1352(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1357(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1362(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1395(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1400(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1410(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1415(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1420(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1425(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1430(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1439(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1444(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1454(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1468(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1481(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1486(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1491(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1504(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1508(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1512(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1516(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1529(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1533(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1537(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1541(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1550(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1555(char*, char*, unsigned, unsigned, unsigned);
funcp funcTab[233] = {(funcp)execute_807, (funcp)execute_808, (funcp)execute_809, (funcp)execute_810, (funcp)vlog_simple_process_execute_0_fast_no_reg_no_agg, (funcp)execute_816, (funcp)execute_818, (funcp)execute_1780, (funcp)execute_1781, (funcp)execute_1782, (funcp)execute_1783, (funcp)execute_1784, (funcp)execute_1785, (funcp)execute_1786, (funcp)execute_1787, (funcp)execute_10, (funcp)execute_11, (funcp)execute_15, (funcp)execute_16, (funcp)execute_36, (funcp)execute_37, (funcp)vlog_const_rhs_process_execute_0_fast_no_reg_no_agg, (funcp)execute_52, (funcp)execute_53, (funcp)execute_54, (funcp)execute_829, (funcp)execute_830, (funcp)execute_831, (funcp)execute_114, (funcp)execute_869, (funcp)execute_870, (funcp)execute_871, (funcp)execute_872, (funcp)execute_873, (funcp)execute_874, (funcp)execute_875, (funcp)execute_876, (funcp)execute_868, (funcp)execute_117, (funcp)execute_878, (funcp)execute_879, (funcp)execute_880, (funcp)execute_881, (funcp)execute_877, (funcp)execute_321, (funcp)execute_322, (funcp)execute_323, (funcp)execute_1165, (funcp)execute_1166, (funcp)execute_1167, (funcp)execute_1168, (funcp)execute_331, (funcp)execute_1176, (funcp)execute_1177, (funcp)execute_1175, (funcp)execute_352, (funcp)execute_353, (funcp)execute_354, (funcp)execute_1195, (funcp)execute_1196, (funcp)execute_1197, (funcp)execute_1198, (funcp)execute_527, (funcp)execute_528, (funcp)execute_1365, (funcp)execute_1366, (funcp)execute_1368, (funcp)execute_1369, (funcp)execute_1370, (funcp)execute_1371, (funcp)execute_1667, (funcp)execute_721, (funcp)execute_722, (funcp)execute_723, (funcp)execute_1668, (funcp)execute_1669, (funcp)execute_1670, (funcp)execute_1671, (funcp)execute_1714, (funcp)execute_1735, (funcp)execute_1756, (funcp)execute_803, (funcp)execute_804, (funcp)execute_805, (funcp)execute_806, (funcp)execute_812, (funcp)execute_813, (funcp)execute_814, (funcp)execute_1788, (funcp)execute_1789, (funcp)execute_1790, (funcp)execute_1791, (funcp)execute_1792, (funcp)vlog_transfunc_eventcallback, (funcp)transaction_399, (funcp)transaction_403, (funcp)transaction_407, (funcp)transaction_411, (funcp)transaction_415, (funcp)transaction_419, (funcp)transaction_423, (funcp)transaction_427, (funcp)transaction_431, (funcp)transaction_435, (funcp)transaction_439, (funcp)transaction_443, (funcp)transaction_479, (funcp)transaction_483, (funcp)transaction_487, (funcp)transaction_491, (funcp)transaction_495, (funcp)transaction_499, (funcp)transaction_528, (funcp)transaction_532, (funcp)transaction_536, (funcp)transaction_540, (funcp)transaction_544, (funcp)transaction_548, (funcp)transaction_605, (funcp)transaction_609, (funcp)transaction_613, (funcp)transaction_617, (funcp)transaction_621, (funcp)transaction_625, (funcp)transaction_629, (funcp)transaction_633, (funcp)transaction_637, (funcp)transaction_641, (funcp)transaction_645, (funcp)transaction_649, (funcp)transaction_685, (funcp)transaction_689, (funcp)transaction_693, (funcp)transaction_697, (funcp)transaction_701, (funcp)transaction_705, (funcp)transaction_734, (funcp)transaction_738, (funcp)transaction_742, (funcp)transaction_746, (funcp)transaction_750, (funcp)transaction_754, (funcp)transaction_775, (funcp)transaction_780, (funcp)transaction_823, (funcp)transaction_828, (funcp)transaction_833, (funcp)transaction_838, (funcp)transaction_843, (funcp)transaction_848, (funcp)transaction_853, (funcp)transaction_858, (funcp)transaction_863, (funcp)transaction_868, (funcp)transaction_873, (funcp)transaction_878, (funcp)transaction_908, (funcp)transaction_913, (funcp)transaction_919, (funcp)transaction_960, (funcp)transaction_965, (funcp)transaction_970, (funcp)transaction_975, (funcp)transaction_980, (funcp)transaction_985, (funcp)transaction_990, (funcp)transaction_995, (funcp)transaction_1000, (funcp)transaction_1005, (funcp)transaction_1010, (funcp)transaction_1015, (funcp)transaction_1020, (funcp)transaction_1025, (funcp)transaction_1030, (funcp)transaction_1035, (funcp)transaction_1040, (funcp)transaction_1045, (funcp)transaction_1207, (funcp)transaction_1212, (funcp)transaction_1217, (funcp)transaction_1222, (funcp)transaction_1227, (funcp)transaction_1232, (funcp)transaction_1237, (funcp)transaction_1242, (funcp)transaction_1247, (funcp)transaction_1252, (funcp)transaction_1257, (funcp)transaction_1262, (funcp)transaction_1267, (funcp)transaction_1272, (funcp)transaction_1277, (funcp)transaction_1282, (funcp)transaction_1287, (funcp)transaction_1292, (funcp)transaction_1297, (funcp)transaction_1302, (funcp)transaction_1307, (funcp)transaction_1312, (funcp)transaction_1317, (funcp)transaction_1322, (funcp)transaction_1327, (funcp)transaction_1332, (funcp)transaction_1337, (funcp)transaction_1342, (funcp)transaction_1347, (funcp)transaction_1352, (funcp)transaction_1357, (funcp)transaction_1362, (funcp)transaction_1395, (funcp)transaction_1400, (funcp)transaction_1410, (funcp)transaction_1415, (funcp)transaction_1420, (funcp)transaction_1425, (funcp)transaction_1430, (funcp)transaction_1439, (funcp)transaction_1444, (funcp)transaction_1454, (funcp)transaction_1468, (funcp)transaction_1481, (funcp)transaction_1486, (funcp)transaction_1491, (funcp)transaction_1504, (funcp)transaction_1508, (funcp)transaction_1512, (funcp)transaction_1516, (funcp)transaction_1529, (funcp)transaction_1533, (funcp)transaction_1537, (funcp)transaction_1541, (funcp)transaction_1550, (funcp)transaction_1555};
const int NumRelocateId= 233;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/decoder_fast_tb_func_impl/xsim.reloc",  (void **)funcTab, 233);

	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/decoder_fast_tb_func_impl/xsim.reloc");
}

	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net

void wrapper_func_0(char *dp)

{

}

void simulate(char *dp)
{
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/decoder_fast_tb_func_impl/xsim.reloc");
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
    iki_set_sv_type_file_path_name("xsim.dir/decoder_fast_tb_func_impl/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/decoder_fast_tb_func_impl/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/decoder_fast_tb_func_impl/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
