; ModuleID = 'C:/Users/flaud/Documents/GitHub/LiveTelemetry/FPGA/CAN_Decoder_Hardware/CAN_decoder/CAN_decoder/hls/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

%struct.can_message_t = type { %"struct.ap_uint<29>", %"struct.ap_int<64>" }
%"struct.ap_uint<29>" = type { %"struct.ap_int_base<29, false>" }
%"struct.ap_int_base<29, false>" = type { %"struct.ssdm_int<29, false>" }
%"struct.ssdm_int<29, false>" = type { i29 }
%"struct.ap_int<64>" = type { %"struct.ap_int_base<64, true>" }
%"struct.ap_int_base<64, true>" = type { %"struct.ssdm_int<64, true>" }
%"struct.ssdm_int<64, true>" = type { i64 }
%struct.decoded_signal_t = type { %"struct.ap_uint<11>", %"struct.ap_uint<32>" }
%"struct.ap_uint<11>" = type { %"struct.ap_int_base<11, false>" }
%"struct.ap_int_base<11, false>" = type { %"struct.ssdm_int<11, false>" }
%"struct.ssdm_int<11, false>" = type { i11 }
%"struct.ap_uint<32>" = type { %"struct.ap_int_base<32, false>" }
%"struct.ap_int_base<32, false>" = type { %"struct.ssdm_int<32, false>" }
%"struct.ssdm_int<32, false>" = type { i32 }
%struct.HashEntry = type { %"struct.ap_uint<29>", i32, %struct.SignalAccumulator }
%struct.SignalAccumulator = type { [68 x %"struct.ap_int<64>"], %"struct.ap_uint<32>" }
%"struct.ap_uint<56>" = type { %"struct.ap_int_base<56, false>" }
%"struct.ap_int_base<56, false>" = type { %"struct.ssdm_int<56, false>" }
%"struct.ssdm_int<56, false>" = type { i56 }
%"struct.ap_uint<80>" = type { %"struct.ap_int_base<80, false>" }
%"struct.ap_int_base<80, false>" = type { %"struct.ssdm_int<80, false>" }
%"struct.ssdm_int<80, false>" = type { i80 }

; Function Attrs: noinline
define void @apatb_decode_can_message_ir(%struct.can_message_t* nocapture readonly %message, %struct.decoded_signal_t* noalias nocapture nonnull "fpga.decayed.dim.hint"="68" %decoded_signals, i32* noalias nocapture nonnull %num_decoded_signals, %struct.HashEntry* noalias nocapture nonnull "fpga.decayed.dim.hint"="512" %hash_table, %"struct.ap_uint<56>"* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="512" %msg_lut, %"struct.ap_uint<80>"* noalias nonnull "fpga.decayed.dim.hint"="512" %signal_def_mem) local_unnamed_addr #0 {
entry:
  %decoded_signals_copy = alloca [68 x i43], align 512
  %num_decoded_signals_copy = alloca i32, align 512
  %malloccall.0 = call i8* @malloc(i64 2048)
  %hash_table_copy.0 = bitcast i8* %malloccall.0 to [512 x i29]*
  %malloccall.1 = call i8* @malloc(i64 2048)
  %hash_table_copy.1 = bitcast i8* %malloccall.1 to [512 x i32]*
  %malloccall.2.0 = call i8* @malloc(i64 278528)
  %hash_table_copy.2.0 = bitcast i8* %malloccall.2.0 to [512 x [68 x i64]]*
  %malloccall.2.1 = call i8* @malloc(i64 2048)
  %hash_table_copy.2.1 = bitcast i8* %malloccall.2.1 to [512 x i32]*
  %malloccall1 = call i8* @malloc(i64 4096)
  %msg_lut_copy = bitcast i8* %malloccall1 to [512 x i56]*
  %malloccall2 = call i8* @malloc(i64 8192)
  %signal_def_mem_copy = bitcast i8* %malloccall2 to [512 x i80]*
  %0 = bitcast %struct.decoded_signal_t* %decoded_signals to [68 x %struct.decoded_signal_t]*
  %1 = bitcast %struct.HashEntry* %hash_table to [512 x %struct.HashEntry]*
  %2 = bitcast %"struct.ap_uint<56>"* %msg_lut to [512 x %"struct.ap_uint<56>"]*
  %3 = bitcast %"struct.ap_uint<80>"* %signal_def_mem to [512 x %"struct.ap_uint<80>"]*
  call fastcc void @copy_in([68 x %struct.decoded_signal_t]* nonnull %0, [68 x i43]* nonnull align 512 %decoded_signals_copy, i32* nonnull %num_decoded_signals, i32* nonnull align 512 %num_decoded_signals_copy, [512 x %struct.HashEntry]* nonnull %1, [512 x i29]* %hash_table_copy.0, [512 x i32]* %hash_table_copy.1, [512 x [68 x i64]]* %hash_table_copy.2.0, [512 x i32]* %hash_table_copy.2.1, [512 x %"struct.ap_uint<56>"]* nonnull %2, [512 x i56]* %msg_lut_copy, [512 x %"struct.ap_uint<80>"]* nonnull %3, [512 x i80]* %signal_def_mem_copy)
  call void @apatb_decode_can_message_hw(%struct.can_message_t* %message, [68 x i43]* %decoded_signals_copy, i32* %num_decoded_signals_copy, [512 x i29]* %hash_table_copy.0, [512 x i32]* %hash_table_copy.1, [512 x [68 x i64]]* %hash_table_copy.2.0, [512 x i32]* %hash_table_copy.2.1, [512 x i56]* %msg_lut_copy, [512 x i80]* %signal_def_mem_copy)
  call void @copy_back([68 x %struct.decoded_signal_t]* %0, [68 x i43]* %decoded_signals_copy, i32* %num_decoded_signals, i32* %num_decoded_signals_copy, [512 x %struct.HashEntry]* %1, [512 x i29]* %hash_table_copy.0, [512 x i32]* %hash_table_copy.1, [512 x [68 x i64]]* %hash_table_copy.2.0, [512 x i32]* %hash_table_copy.2.1, [512 x %"struct.ap_uint<56>"]* %2, [512 x i56]* %msg_lut_copy, [512 x %"struct.ap_uint<80>"]* %3, [512 x i80]* %signal_def_mem_copy)
  call void @free(i8* %malloccall.0)
  call void @free(i8* %malloccall.1)
  call void @free(i8* %malloccall.2.0)
  call void @free(i8* %malloccall.2.1)
  call void @free(i8* %malloccall1)
  call void @free(i8* %malloccall2)
  ret void
}

declare noalias i8* @malloc(i64) local_unnamed_addr

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_in([68 x %struct.decoded_signal_t]* noalias readonly "unpacked"="0", [68 x i43]* noalias align 512 "unpacked"="1", i32* noalias readonly "unpacked"="2", i32* noalias align 512 "unpacked"="3", [512 x %struct.HashEntry]* noalias readonly "unpacked"="4", [512 x i29]* noalias nocapture "unpacked"="5.0.0" %.0, [512 x i32]* noalias nocapture "unpacked"="5.1" %.1, [512 x [68 x i64]]* noalias "unpacked"="5.2.0" %.2.0, [512 x i32]* noalias nocapture "unpacked"="5.2.1.0" %.2.1, [512 x %"struct.ap_uint<56>"]* noalias readonly "unpacked"="6", [512 x i56]* noalias nocapture "unpacked"="7.0", [512 x %"struct.ap_uint<80>"]* noalias readonly "unpacked"="8", [512 x i80]* noalias nocapture "unpacked"="9.0") unnamed_addr #1 {
entry:
  call fastcc void @onebyonecpy_hls.p0a68struct.decoded_signal_t.97([68 x i43]* align 512 %1, [68 x %struct.decoded_signal_t]* %0)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %3, i32* %2)
  call fastcc void @onebyonecpy_hls.p0a512struct.HashEntry([512 x i29]* %.0, [512 x i32]* %.1, [512 x [68 x i64]]* %.2.0, [512 x i32]* %.2.1, [512 x %struct.HashEntry]* %4)
  call fastcc void @"onebyonecpy_hls.p0a512struct.ap_uint<56>.44"([512 x i56]* %6, [512 x %"struct.ap_uint<56>"]* %5)
  call fastcc void @"onebyonecpy_hls.p0a512struct.ap_uint<80>"([512 x i80]* %8, [512 x %"struct.ap_uint<80>"]* %7)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0a68struct.decoded_signal_t([68 x %struct.decoded_signal_t]* noalias %dst, [68 x i43]* noalias readonly align 512 %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [68 x %struct.decoded_signal_t]* %dst, null
  %1 = icmp eq [68 x i43]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a68struct.decoded_signal_t([68 x %struct.decoded_signal_t]* nonnull %dst, [68 x i43]* nonnull %src, i64 68)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a68struct.decoded_signal_t([68 x %struct.decoded_signal_t]* %dst, [68 x i43]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [68 x i43]* %src, null
  %1 = icmp eq [68 x %struct.decoded_signal_t]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond17 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond17, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx18 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %3 = getelementptr [68 x i43], [68 x i43]* %src, i64 0, i64 %for.loop.idx18
  %dst.addr.0.0.0.08 = getelementptr [68 x %struct.decoded_signal_t], [68 x %struct.decoded_signal_t]* %dst, i64 0, i64 %for.loop.idx18, i32 0, i32 0, i32 0, i32 0
  %4 = bitcast i43* %3 to i48*
  %5 = load i48, i48* %4
  %6 = trunc i48 %5 to i43
  %.partselect1 = trunc i43 %6 to i11
  store i11 %.partselect1, i11* %dst.addr.0.0.0.08, align 2
  %dst.addr.1.0.0.016 = getelementptr [68 x %struct.decoded_signal_t], [68 x %struct.decoded_signal_t]* %dst, i64 0, i64 %for.loop.idx18, i32 1, i32 0, i32 0, i32 0
  %7 = bitcast i43* %3 to i48*
  %8 = load i48, i48* %7
  %9 = trunc i48 %8 to i43
  %10 = lshr i43 %9, 11
  %.partselect = trunc i43 %10 to i32
  store i32 %.partselect, i32* %dst.addr.1.0.0.016, align 4
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx18, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0i32(i32* noalias align 512 %dst, i32* noalias readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq i32* %dst, null
  %1 = icmp eq i32* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %3 = load i32, i32* %src, align 4
  store i32 %3, i32* %dst, align 512
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a68struct.ap_int<64>"([68 x i64]* %dst, [68 x %"struct.ap_int<64>"]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [68 x %"struct.ap_int<64>"]* %src, null
  %1 = icmp eq [68 x i64]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond7 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond7, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx8 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.05 = getelementptr [68 x %"struct.ap_int<64>"], [68 x %"struct.ap_int<64>"]* %src, i64 0, i64 %for.loop.idx8, i32 0, i32 0, i32 0
  %3 = getelementptr [68 x i64], [68 x i64]* %dst, i64 0, i64 %for.loop.idx8
  %4 = load i64, i64* %src.addr.0.0.05, align 8
  store i64 %4, i64* %3, align 8
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx8, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0a512struct.ap_uint<56>"([512 x %"struct.ap_uint<56>"]* noalias "unpacked"="0" %dst, [512 x i56]* noalias nocapture readonly "unpacked"="1.0" %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [512 x %"struct.ap_uint<56>"]* %dst, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a512struct.ap_uint<56>"([512 x %"struct.ap_uint<56>"]* nonnull %dst, [512 x i56]* %src, i64 512)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a512struct.ap_uint<56>"([512 x %"struct.ap_uint<56>"]* "unpacked"="0" %dst, [512 x i56]* nocapture readonly "unpacked"="1.0" %src, i64 "unpacked"="2" %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [512 x %"struct.ap_uint<56>"]* %dst, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.05 = getelementptr [512 x i56], [512 x i56]* %src, i64 0, i64 %for.loop.idx2
  %dst.addr.0.0.06 = getelementptr [512 x %"struct.ap_uint<56>"], [512 x %"struct.ap_uint<56>"]* %dst, i64 0, i64 %for.loop.idx2, i32 0, i32 0, i32 0
  %1 = load i56, i56* %src.addr.0.0.05, align 8
  store i56 %1, i56* %dst.addr.0.0.06, align 8
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0a512struct.ap_uint<80>"([512 x i80]* noalias nocapture "unpacked"="0.0" %dst, [512 x %"struct.ap_uint<80>"]* noalias readonly "unpacked"="1" %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [512 x %"struct.ap_uint<80>"]* %src, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a512struct.ap_uint<80>"([512 x i80]* %dst, [512 x %"struct.ap_uint<80>"]* nonnull %src, i64 512)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a512struct.ap_uint<80>"([512 x i80]* nocapture "unpacked"="0.0" %dst, [512 x %"struct.ap_uint<80>"]* readonly "unpacked"="1" %src, i64 "unpacked"="2" %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [512 x %"struct.ap_uint<80>"]* %src, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.05 = getelementptr [512 x %"struct.ap_uint<80>"], [512 x %"struct.ap_uint<80>"]* %src, i64 0, i64 %for.loop.idx2, i32 0, i32 0, i32 0
  %dst.addr.0.0.06 = getelementptr [512 x i80], [512 x i80]* %dst, i64 0, i64 %for.loop.idx2
  %1 = load i80, i80* %src.addr.0.0.05, align 16
  store i80 %1, i80* %dst.addr.0.0.06, align 16
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_out([68 x %struct.decoded_signal_t]* noalias "unpacked"="0", [68 x i43]* noalias readonly align 512 "unpacked"="1", i32* noalias "unpacked"="2", i32* noalias readonly align 512 "unpacked"="3", [512 x %struct.HashEntry]* noalias "unpacked"="4", [512 x i29]* noalias nocapture readonly "unpacked"="5.0.0" %.0, [512 x i32]* noalias nocapture readonly "unpacked"="5.1" %.1, [512 x [68 x i64]]* noalias readonly "unpacked"="5.2.0" %.2.0, [512 x i32]* noalias nocapture readonly "unpacked"="5.2.1.0" %.2.1, [512 x %"struct.ap_uint<56>"]* noalias "unpacked"="6", [512 x i56]* noalias nocapture readonly "unpacked"="7.0", [512 x %"struct.ap_uint<80>"]* noalias "unpacked"="8", [512 x i80]* noalias nocapture readonly "unpacked"="9.0") unnamed_addr #4 {
entry:
  call fastcc void @onebyonecpy_hls.p0a68struct.decoded_signal_t([68 x %struct.decoded_signal_t]* %0, [68 x i43]* align 512 %1)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %2, i32* align 512 %3)
  call fastcc void @onebyonecpy_hls.p0a512struct.HashEntry.8([512 x %struct.HashEntry]* %4, [512 x i29]* %.0, [512 x i32]* %.1, [512 x [68 x i64]]* %.2.0, [512 x i32]* %.2.1)
  call fastcc void @"onebyonecpy_hls.p0a512struct.ap_uint<56>"([512 x %"struct.ap_uint<56>"]* %5, [512 x i56]* %6)
  call fastcc void @"onebyonecpy_hls.p0a512struct.ap_uint<80>.33"([512 x %"struct.ap_uint<80>"]* %7, [512 x i80]* %8)
  ret void
}

declare void @free(i8*) local_unnamed_addr

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0a512struct.ap_uint<80>.33"([512 x %"struct.ap_uint<80>"]* noalias "unpacked"="0" %dst, [512 x i80]* noalias nocapture readonly "unpacked"="1.0" %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [512 x %"struct.ap_uint<80>"]* %dst, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a512struct.ap_uint<80>.36"([512 x %"struct.ap_uint<80>"]* nonnull %dst, [512 x i80]* %src, i64 512)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a512struct.ap_uint<80>.36"([512 x %"struct.ap_uint<80>"]* "unpacked"="0" %dst, [512 x i80]* nocapture readonly "unpacked"="1.0" %src, i64 "unpacked"="2" %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [512 x %"struct.ap_uint<80>"]* %dst, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.05 = getelementptr [512 x i80], [512 x i80]* %src, i64 0, i64 %for.loop.idx2
  %dst.addr.0.0.06 = getelementptr [512 x %"struct.ap_uint<80>"], [512 x %"struct.ap_uint<80>"]* %dst, i64 0, i64 %for.loop.idx2, i32 0, i32 0, i32 0
  %1 = load i80, i80* %src.addr.0.0.05, align 16
  store i80 %1, i80* %dst.addr.0.0.06, align 16
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0a512struct.ap_uint<56>.44"([512 x i56]* noalias nocapture "unpacked"="0.0" %dst, [512 x %"struct.ap_uint<56>"]* noalias readonly "unpacked"="1" %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [512 x %"struct.ap_uint<56>"]* %src, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a512struct.ap_uint<56>.47"([512 x i56]* %dst, [512 x %"struct.ap_uint<56>"]* nonnull %src, i64 512)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a512struct.ap_uint<56>.47"([512 x i56]* nocapture "unpacked"="0.0" %dst, [512 x %"struct.ap_uint<56>"]* readonly "unpacked"="1" %src, i64 "unpacked"="2" %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [512 x %"struct.ap_uint<56>"]* %src, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.05 = getelementptr [512 x %"struct.ap_uint<56>"], [512 x %"struct.ap_uint<56>"]* %src, i64 0, i64 %for.loop.idx2, i32 0, i32 0, i32 0
  %dst.addr.0.0.06 = getelementptr [512 x i56], [512 x i56]* %dst, i64 0, i64 %for.loop.idx2
  %1 = load i56, i56* %src.addr.0.0.05, align 8
  store i56 %1, i56* %dst.addr.0.0.06, align 8
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0a512struct.HashEntry([512 x i29]* noalias nocapture "unpacked"="0.0.0" %dst.0, [512 x i32]* noalias nocapture "unpacked"="0.1" %dst.1, [512 x [68 x i64]]* noalias "unpacked"="0.2.0" %dst.2.0, [512 x i32]* noalias nocapture "unpacked"="0.2.1.0" %dst.2.1, [512 x %struct.HashEntry]* noalias readonly "unpacked"="1" %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [512 x %struct.HashEntry]* %src, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a512struct.HashEntry.21.65.73([512 x i29]* %dst.0, [512 x i32]* %dst.1, [512 x [68 x i64]]* %dst.2.0, [512 x i32]* %dst.2.1, [512 x %struct.HashEntry]* nonnull %src, i64 512)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a512struct.HashEntry.21.65.73([512 x i29]* nocapture "unpacked"="0.0.0" %dst.0, [512 x i32]* nocapture "unpacked"="0.1" %dst.1, [512 x [68 x i64]]* "unpacked"="0.2.0" %dst.2.0, [512 x i32]* nocapture "unpacked"="0.2.1.0" %dst.2.1, [512 x %struct.HashEntry]* readonly "unpacked"="1" %src, i64 "unpacked"="2" %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [512 x %struct.HashEntry]* %src, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.0.07 = getelementptr [512 x %struct.HashEntry], [512 x %struct.HashEntry]* %src, i64 0, i64 %for.loop.idx2, i32 0, i32 0, i32 0, i32 0
  %dst.addr.0.0.0.08 = getelementptr [512 x i29], [512 x i29]* %dst.0, i64 0, i64 %for.loop.idx2
  %1 = bitcast i29* %src.addr.0.0.0.07 to i32*
  %2 = load i32, i32* %1
  %3 = trunc i32 %2 to i29
  store i29 %3, i29* %dst.addr.0.0.0.08, align 4
  %src.addr.19 = getelementptr [512 x %struct.HashEntry], [512 x %struct.HashEntry]* %src, i64 0, i64 %for.loop.idx2, i32 1
  %dst.addr.110 = getelementptr [512 x i32], [512 x i32]* %dst.1, i64 0, i64 %for.loop.idx2
  %4 = load i32, i32* %src.addr.19, align 4
  store i32 %4, i32* %dst.addr.110, align 4
  %src.addr.2.013 = getelementptr [512 x %struct.HashEntry], [512 x %struct.HashEntry]* %src, i64 0, i64 %for.loop.idx2, i32 2, i32 0
  %5 = getelementptr [512 x [68 x i64]], [512 x [68 x i64]]* %dst.2.0, i64 0, i64 %for.loop.idx2
  call void @"arraycpy_hls.p0a68struct.ap_int<64>"([68 x i64]* %5, [68 x %"struct.ap_int<64>"]* %src.addr.2.013, i64 68)
  %src.addr.2.1.0.0.021 = getelementptr [512 x %struct.HashEntry], [512 x %struct.HashEntry]* %src, i64 0, i64 %for.loop.idx2, i32 2, i32 1, i32 0, i32 0, i32 0
  %dst.addr.2.1.0.0.022 = getelementptr [512 x i32], [512 x i32]* %dst.2.1, i64 0, i64 %for.loop.idx2
  %6 = load i32, i32* %src.addr.2.1.0.0.021, align 4
  store i32 %6, i32* %dst.addr.2.1.0.0.022, align 4
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0a512struct.HashEntry.8([512 x %struct.HashEntry]* noalias "unpacked"="0" %dst, [512 x i29]* noalias nocapture readonly "unpacked"="1.0.0" %src.0, [512 x i32]* noalias nocapture readonly "unpacked"="1.1" %src.1, [512 x [68 x i64]]* noalias readonly "unpacked"="1.2.0" %src.2.0, [512 x i32]* noalias nocapture readonly "unpacked"="1.2.1.0" %src.2.1) unnamed_addr #2 {
entry:
  %0 = icmp eq [512 x %struct.HashEntry]* %dst, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a512struct.HashEntry.11.28.58.80([512 x %struct.HashEntry]* nonnull %dst, [512 x i29]* %src.0, [512 x i32]* %src.1, [512 x [68 x i64]]* %src.2.0, [512 x i32]* %src.2.1, i64 512)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a512struct.HashEntry.11.28.58.80([512 x %struct.HashEntry]* "unpacked"="0" %dst, [512 x i29]* nocapture readonly "unpacked"="1.0.0" %src.0, [512 x i32]* nocapture readonly "unpacked"="1.1" %src.1, [512 x [68 x i64]]* readonly "unpacked"="1.2.0" %src.2.0, [512 x i32]* nocapture readonly "unpacked"="1.2.1.0" %src.2.1, i64 "unpacked"="2" %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [512 x %struct.HashEntry]* %dst, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.0.07 = getelementptr [512 x i29], [512 x i29]* %src.0, i64 0, i64 %for.loop.idx2
  %dst.addr.0.0.0.08 = getelementptr [512 x %struct.HashEntry], [512 x %struct.HashEntry]* %dst, i64 0, i64 %for.loop.idx2, i32 0, i32 0, i32 0, i32 0
  %1 = bitcast i29* %src.addr.0.0.0.07 to i32*
  %2 = load i32, i32* %1
  %3 = trunc i32 %2 to i29
  store i29 %3, i29* %dst.addr.0.0.0.08, align 4
  %src.addr.19 = getelementptr [512 x i32], [512 x i32]* %src.1, i64 0, i64 %for.loop.idx2
  %dst.addr.110 = getelementptr [512 x %struct.HashEntry], [512 x %struct.HashEntry]* %dst, i64 0, i64 %for.loop.idx2, i32 1
  %4 = load i32, i32* %src.addr.19, align 4
  store i32 %4, i32* %dst.addr.110, align 4
  %5 = getelementptr [512 x [68 x i64]], [512 x [68 x i64]]* %src.2.0, i64 0, i64 %for.loop.idx2
  %dst.addr.2.014 = getelementptr [512 x %struct.HashEntry], [512 x %struct.HashEntry]* %dst, i64 0, i64 %for.loop.idx2, i32 2, i32 0
  call void @"arraycpy_hls.p0a68struct.ap_int<64>.89"([68 x %"struct.ap_int<64>"]* %dst.addr.2.014, [68 x i64]* %5, i64 68)
  %src.addr.2.1.0.0.021 = getelementptr [512 x i32], [512 x i32]* %src.2.1, i64 0, i64 %for.loop.idx2
  %dst.addr.2.1.0.0.022 = getelementptr [512 x %struct.HashEntry], [512 x %struct.HashEntry]* %dst, i64 0, i64 %for.loop.idx2, i32 2, i32 1, i32 0, i32 0, i32 0
  %6 = load i32, i32* %src.addr.2.1.0.0.021, align 4
  store i32 %6, i32* %dst.addr.2.1.0.0.022, align 4
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a68struct.ap_int<64>.89"([68 x %"struct.ap_int<64>"]* %dst, [68 x i64]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [68 x i64]* %src, null
  %1 = icmp eq [68 x %"struct.ap_int<64>"]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond7 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond7, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx8 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %3 = getelementptr [68 x i64], [68 x i64]* %src, i64 0, i64 %for.loop.idx8
  %dst.addr.0.0.06 = getelementptr [68 x %"struct.ap_int<64>"], [68 x %"struct.ap_int<64>"]* %dst, i64 0, i64 %for.loop.idx8, i32 0, i32 0, i32 0
  %4 = load i64, i64* %3, align 8
  store i64 %4, i64* %dst.addr.0.0.06, align 8
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx8, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0a68struct.decoded_signal_t.97([68 x i43]* noalias align 512 %dst, [68 x %struct.decoded_signal_t]* noalias readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [68 x i43]* %dst, null
  %1 = icmp eq [68 x %struct.decoded_signal_t]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a68struct.decoded_signal_t.100([68 x i43]* nonnull %dst, [68 x %struct.decoded_signal_t]* nonnull %src, i64 68)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a68struct.decoded_signal_t.100([68 x i43]* %dst, [68 x %struct.decoded_signal_t]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [68 x %struct.decoded_signal_t]* %src, null
  %1 = icmp eq [68 x i43]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond17 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond17, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx18 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.0.07 = getelementptr [68 x %struct.decoded_signal_t], [68 x %struct.decoded_signal_t]* %src, i64 0, i64 %for.loop.idx18, i32 0, i32 0, i32 0, i32 0
  %3 = getelementptr [68 x i43], [68 x i43]* %dst, i64 0, i64 %for.loop.idx18
  %4 = bitcast i11* %src.addr.0.0.0.07 to i16*
  %5 = load i16, i16* %4
  %6 = trunc i16 %5 to i11
  %7 = bitcast i43* %3 to i48*
  %8 = load i48, i48* %7
  %9 = trunc i48 %8 to i43
  %10 = zext i11 %6 to i43
  %11 = and i43 %9, -2048
  %.partset1 = or i43 %11, %10
  store i43 %.partset1, i43* %3, align 2
  %src.addr.1.0.0.015 = getelementptr [68 x %struct.decoded_signal_t], [68 x %struct.decoded_signal_t]* %src, i64 0, i64 %for.loop.idx18, i32 1, i32 0, i32 0, i32 0
  %12 = load i32, i32* %src.addr.1.0.0.015, align 4
  %13 = zext i32 %12 to i43
  %14 = shl i43 %13, 11
  %.partset = or i43 %14, %10
  store i43 %.partset, i43* %3, align 4
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx18, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

declare void @apatb_decode_can_message_hw(%struct.can_message_t*, [68 x i43]*, i32*, [512 x i29]*, [512 x i32]*, [512 x [68 x i64]]*, [512 x i32]*, [512 x i56]*, [512 x i80]*)

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_back([68 x %struct.decoded_signal_t]* noalias "unpacked"="0", [68 x i43]* noalias readonly align 512 "unpacked"="1", i32* noalias "unpacked"="2", i32* noalias readonly align 512 "unpacked"="3", [512 x %struct.HashEntry]* noalias "unpacked"="4", [512 x i29]* noalias nocapture readonly "unpacked"="5.0.0" %.0, [512 x i32]* noalias nocapture readonly "unpacked"="5.1" %.1, [512 x [68 x i64]]* noalias readonly "unpacked"="5.2.0" %.2.0, [512 x i32]* noalias nocapture readonly "unpacked"="5.2.1.0" %.2.1, [512 x %"struct.ap_uint<56>"]* noalias "unpacked"="6", [512 x i56]* noalias nocapture readonly "unpacked"="7.0", [512 x %"struct.ap_uint<80>"]* noalias "unpacked"="8", [512 x i80]* noalias nocapture readonly "unpacked"="9.0") unnamed_addr #4 {
entry:
  call fastcc void @onebyonecpy_hls.p0a68struct.decoded_signal_t([68 x %struct.decoded_signal_t]* %0, [68 x i43]* align 512 %1)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %2, i32* align 512 %3)
  call fastcc void @onebyonecpy_hls.p0a512struct.HashEntry.8([512 x %struct.HashEntry]* %4, [512 x i29]* %.0, [512 x i32]* %.1, [512 x [68 x i64]]* %.2.0, [512 x i32]* %.2.1)
  call fastcc void @"onebyonecpy_hls.p0a512struct.ap_uint<80>.33"([512 x %"struct.ap_uint<80>"]* %7, [512 x i80]* %8)
  ret void
}

define void @decode_can_message_hw_stub_wrapper(%struct.can_message_t*, [68 x i43]*, i32*, [512 x i29]*, [512 x i32]*, [512 x [68 x i64]]*, [512 x i32]*, [512 x i56]*, [512 x i80]*) #5 {
entry:
  %9 = alloca [68 x %struct.decoded_signal_t]
  %malloccall = tail call i8* @malloc(i64 286720)
  %10 = bitcast i8* %malloccall to [512 x %struct.HashEntry]*
  %malloccall1 = tail call i8* @malloc(i64 4096)
  %11 = bitcast i8* %malloccall1 to [512 x %"struct.ap_uint<56>"]*
  %malloccall2 = tail call i8* @malloc(i64 8192)
  %12 = bitcast i8* %malloccall2 to [512 x %"struct.ap_uint<80>"]*
  call void @copy_out([68 x %struct.decoded_signal_t]* %9, [68 x i43]* %1, i32* null, i32* %2, [512 x %struct.HashEntry]* %10, [512 x i29]* %3, [512 x i32]* %4, [512 x [68 x i64]]* %5, [512 x i32]* %6, [512 x %"struct.ap_uint<56>"]* %11, [512 x i56]* %7, [512 x %"struct.ap_uint<80>"]* %12, [512 x i80]* %8)
  %13 = bitcast [68 x %struct.decoded_signal_t]* %9 to %struct.decoded_signal_t*
  %14 = bitcast [512 x %struct.HashEntry]* %10 to %struct.HashEntry*
  %15 = bitcast [512 x %"struct.ap_uint<56>"]* %11 to %"struct.ap_uint<56>"*
  %16 = bitcast [512 x %"struct.ap_uint<80>"]* %12 to %"struct.ap_uint<80>"*
  call void @decode_can_message_hw_stub(%struct.can_message_t* %0, %struct.decoded_signal_t* %13, i32* %2, %struct.HashEntry* %14, %"struct.ap_uint<56>"* %15, %"struct.ap_uint<80>"* %16)
  call void @copy_in([68 x %struct.decoded_signal_t]* %9, [68 x i43]* %1, i32* null, i32* %2, [512 x %struct.HashEntry]* %10, [512 x i29]* %3, [512 x i32]* %4, [512 x [68 x i64]]* %5, [512 x i32]* %6, [512 x %"struct.ap_uint<56>"]* %11, [512 x i56]* %7, [512 x %"struct.ap_uint<80>"]* %12, [512 x i80]* %8)
  ret void
}

declare void @decode_can_message_hw_stub(%struct.can_message_t* nocapture readonly, %struct.decoded_signal_t* noalias nocapture nonnull, i32* noalias nocapture nonnull, %struct.HashEntry* noalias nocapture nonnull, %"struct.ap_uint<56>"* noalias nocapture nonnull readonly, %"struct.ap_uint<80>"* noalias nonnull)

attributes #0 = { noinline "fpga.wrapper.func"="wrapper" }
attributes #1 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyin" }
attributes #2 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="onebyonecpy_hls" }
attributes #3 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="arraycpy_hls" }
attributes #4 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyout" }
attributes #5 = { "fpga.wrapper.func"="stub" }

!llvm.dbg.cu = !{}
!llvm.ident = !{!0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0}
!llvm.module.flags = !{!1, !2, !3}
!blackbox_cfg = !{!4}

!0 = !{!"clang version 7.0.0 "}
!1 = !{i32 2, !"Dwarf Version", i32 4}
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{}
