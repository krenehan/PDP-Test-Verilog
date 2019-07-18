# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
create_project -in_memory -part xc7k160tffg676-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir /u5/krenehan/vivado/pdp_test_proj/pdp_test_proj.cache/wt [current_project]
set_property parent.project_path /u5/krenehan/vivado/pdp_test_proj/pdp_test_proj.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo /u5/krenehan/vivado/pdp_test_proj/pdp_test_proj.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib {
  /u5/krenehan/vivado/pdp_test_proj/pdp_test_proj.srcs/sources_1/new/core.v
  /u5/krenehan/vivado/pdp_test_proj/pdp_test_proj.srcs/sources_1/new/debouncer.v
  /u5/krenehan/vivado/pdp_test_proj/pdp_test_proj.srcs/sources_1/new/decoder_fast_32b.v
  /u5/krenehan/vivado/pdp_test_proj/pdp_test_proj.srcs/sources_1/new/encoder_fast_32b.v
  /u5/krenehan/vivado/pdp_test_proj/pdp_test_proj.srcs/sources_1/imports/Vivado/okCoreHarness.v
  /u5/krenehan/vivado/FrontPanelHDL/XEM7360-K160T/Vivado/okLibrary.v
  /u5/krenehan/vivado/pdp_test_proj/pdp_test_proj.srcs/sources_1/imports/Vivado/okPipeIn.v
  /u5/krenehan/vivado/pdp_test_proj/pdp_test_proj.srcs/sources_1/imports/Vivado/okPipeOut.v
  /u5/krenehan/vivado/pdp_test_proj/pdp_test_proj.srcs/sources_1/imports/Vivado/okWireIn.v
  /u5/krenehan/vivado/pdp_test_proj/pdp_test_proj.srcs/sources_1/imports/Vivado/okWireOut.v
  /u5/krenehan/vivado/pdp_test_proj/pdp_test_proj.srcs/sources_1/new/overThresholdDetector.v
  /u5/krenehan/vivado/pdp_test_proj/pdp_test_proj.srcs/sources_1/new/relay_clock_generator_no_reset.v
  /u5/krenehan/vivado/pdp_test_proj/pdp_test_proj.srcs/sources_1/new/relay_controller.v
  /u5/krenehan/vivado/pdp_test_proj/pdp_test_proj.srcs/sources_1/new/relay_shift_register.v
  /u5/krenehan/vivado/pdp_test_proj/pdp_test_proj.srcs/sources_1/new/sync_counter.v
  /u5/krenehan/vivado/pdp_test_proj/pdp_test_proj.srcs/sources_1/new/top.v
}
read_ip -quiet /u5/krenehan/vivado/pdp_test_proj/pdp_test_proj.srcs/sources_1/ip/fifo_generator_fpgatopc/fifo_generator_fpgatopc.xci
set_property used_in_implementation false [get_files -all /u5/krenehan/vivado/pdp_test_proj/pdp_test_proj.srcs/sources_1/ip/fifo_generator_fpgatopc/fifo_generator_fpgatopc.xdc]
set_property used_in_implementation false [get_files -all /u5/krenehan/vivado/pdp_test_proj/pdp_test_proj.srcs/sources_1/ip/fifo_generator_fpgatopc/fifo_generator_fpgatopc_clocks.xdc]
set_property used_in_implementation false [get_files -all /u5/krenehan/vivado/pdp_test_proj/pdp_test_proj.srcs/sources_1/ip/fifo_generator_fpgatopc/fifo_generator_fpgatopc_ooc.xdc]

read_ip -quiet /u5/krenehan/vivado/pdp_test_proj/pdp_test_proj.srcs/sources_1/ip/fifo_generator_pctofpga/fifo_generator_pctofpga.xci
set_property used_in_implementation false [get_files -all /u5/krenehan/vivado/pdp_test_proj/pdp_test_proj.srcs/sources_1/ip/fifo_generator_pctofpga/fifo_generator_pctofpga.xdc]
set_property used_in_implementation false [get_files -all /u5/krenehan/vivado/pdp_test_proj/pdp_test_proj.srcs/sources_1/ip/fifo_generator_pctofpga/fifo_generator_pctofpga_clocks.xdc]
set_property used_in_implementation false [get_files -all /u5/krenehan/vivado/pdp_test_proj/pdp_test_proj.srcs/sources_1/ip/fifo_generator_pctofpga/fifo_generator_pctofpga_ooc.xdc]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc /u5/krenehan/vivado/pdp_test_proj/pdp_test_proj.srcs/constrs_1/imports/Downloads/xem7360.xdc
set_property used_in_implementation false [get_files /u5/krenehan/vivado/pdp_test_proj/pdp_test_proj.srcs/constrs_1/imports/Downloads/xem7360.xdc]

set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top top -part xc7k160tffg676-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef top.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file top_utilization_synth.rpt -pb top_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
