; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -ppc-gpr-icmps=all -verify-machineinstrs < %s -mtriple=powerpc64-unknown-linux-gnu -mcpu=a2 -mattr=-crbits -disable-ppc-cmp-opt=0 | FileCheck %s
; RUN: llc -ppc-gpr-icmps=all -verify-machineinstrs < %s -mtriple=powerpc64-unknown-linux-gnu -mcpu=a2 -mattr=-crbits -disable-ppc-cmp-opt=0 -ppc-gen-isel=false | FileCheck --check-prefix=CHECK-NO-ISEL %s

target datalayout = "E-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-f128:128:128-v128:128:128-n32:64"
target triple = "powerpc64-unknown-linux-gnu"

define signext i32 @foo(i32 signext %a, i32 signext %b, i32* nocapture %c) #0 {
; CHECK-LABEL: foo:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpw 3, 4
; CHECK-NEXT:    isel 6, 3, 4, 1
; CHECK-NEXT:    subf 4, 4, 3
; CHECK-NEXT:    extsw 3, 6
; CHECK-NEXT:    stw 4, 0(5)
; CHECK-NEXT:    blr
;
; CHECK-NO-ISEL-LABEL: foo:
; CHECK-NO-ISEL:       # %bb.0: # %entry
; CHECK-NO-ISEL-NEXT:    cmpw 3, 4
; CHECK-NO-ISEL-NEXT:    bc 12, 1, .LBB0_2
; CHECK-NO-ISEL-NEXT:  # %bb.1: # %entry
; CHECK-NO-ISEL-NEXT:    ori 6, 4, 0
; CHECK-NO-ISEL-NEXT:    b .LBB0_3
; CHECK-NO-ISEL-NEXT:  .LBB0_2: # %entry
; CHECK-NO-ISEL-NEXT:    addi 6, 3, 0
; CHECK-NO-ISEL-NEXT:  .LBB0_3: # %entry
; CHECK-NO-ISEL-NEXT:    subf 4, 4, 3
; CHECK-NO-ISEL-NEXT:    extsw 3, 6
; CHECK-NO-ISEL-NEXT:    stw 4, 0(5)
; CHECK-NO-ISEL-NEXT:    blr
entry:
  %sub = sub nsw i32 %a, %b
  store i32 %sub, i32* %c, align 4
  %cmp = icmp sgt i32 %a, %b
  %cond = select i1 %cmp, i32 %a, i32 %b
  ret i32 %cond
}

define signext i32 @foo2(i32 signext %a, i32 signext %b, i32* nocapture %c) #0 {
; CHECK-LABEL: foo2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    slw 4, 3, 4
; CHECK-NEXT:    li 6, 0
; CHECK-NEXT:    li 3, 1
; CHECK-NEXT:    cmpwi 4, 0
; CHECK-NEXT:    stw 4, 0(5)
; CHECK-NEXT:    isel 3, 3, 6, 1
; CHECK-NEXT:    blr
;
; CHECK-NO-ISEL-LABEL: foo2:
; CHECK-NO-ISEL:       # %bb.0: # %entry
; CHECK-NO-ISEL-NEXT:    slw 4, 3, 4
; CHECK-NO-ISEL-NEXT:    li 6, 0
; CHECK-NO-ISEL-NEXT:    li 3, 1
; CHECK-NO-ISEL-NEXT:    cmpwi 4, 0
; CHECK-NO-ISEL-NEXT:    stw 4, 0(5)
; CHECK-NO-ISEL-NEXT:    bclr 12, 1, 0
; CHECK-NO-ISEL-NEXT:  # %bb.1: # %entry
; CHECK-NO-ISEL-NEXT:    ori 3, 6, 0
; CHECK-NO-ISEL-NEXT:    blr
entry:
  %shl = shl i32 %a, %b
  store i32 %shl, i32* %c, align 4
  %cmp = icmp sgt i32 %shl, 0
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}

define i64 @fool(i64 %a, i64 %b, i64* nocapture %c) #0 {
; CHECK-LABEL: fool:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    sub. 6, 3, 4
; CHECK-NEXT:    isel 3, 3, 4, 1
; CHECK-NEXT:    std 6, 0(5)
; CHECK-NEXT:    blr
;
; CHECK-NO-ISEL-LABEL: fool:
; CHECK-NO-ISEL:       # %bb.0: # %entry
; CHECK-NO-ISEL-NEXT:    sub. 6, 3, 4
; CHECK-NO-ISEL-NEXT:    bc 12, 1, .LBB2_2
; CHECK-NO-ISEL-NEXT:  # %bb.1: # %entry
; CHECK-NO-ISEL-NEXT:    ori 3, 4, 0
; CHECK-NO-ISEL-NEXT:    b .LBB2_2
; CHECK-NO-ISEL-NEXT:  .LBB2_2: # %entry
; CHECK-NO-ISEL-NEXT:    std 6, 0(5)
; CHECK-NO-ISEL-NEXT:    blr
entry:
  %sub = sub nsw i64 %a, %b
  store i64 %sub, i64* %c, align 8
  %cmp = icmp sgt i64 %a, %b
  %cond = select i1 %cmp, i64 %a, i64 %b
  ret i64 %cond
}

define i64 @foolb(i64 %a, i64 %b, i64* nocapture %c) #0 {
; CHECK-LABEL: foolb:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    sub. 6, 3, 4
; CHECK-NEXT:    isel 3, 4, 3, 1
; CHECK-NEXT:    std 6, 0(5)
; CHECK-NEXT:    blr
;
; CHECK-NO-ISEL-LABEL: foolb:
; CHECK-NO-ISEL:       # %bb.0: # %entry
; CHECK-NO-ISEL-NEXT:    sub. 6, 3, 4
; CHECK-NO-ISEL-NEXT:    bc 12, 1, .LBB3_1
; CHECK-NO-ISEL-NEXT:    b .LBB3_2
; CHECK-NO-ISEL-NEXT:  .LBB3_1: # %entry
; CHECK-NO-ISEL-NEXT:    addi 3, 4, 0
; CHECK-NO-ISEL-NEXT:  .LBB3_2: # %entry
; CHECK-NO-ISEL-NEXT:    std 6, 0(5)
; CHECK-NO-ISEL-NEXT:    blr
entry:
  %sub = sub nsw i64 %a, %b
  store i64 %sub, i64* %c, align 8
  %cmp = icmp sle i64 %a, %b
  %cond = select i1 %cmp, i64 %a, i64 %b
  ret i64 %cond
}

define i64 @foolc(i64 %a, i64 %b, i64* nocapture %c) #0 {
; CHECK-LABEL: foolc:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    sub. 6, 4, 3
; CHECK-NEXT:    isel 3, 3, 4, 0
; CHECK-NEXT:    std 6, 0(5)
; CHECK-NEXT:    blr
;
; CHECK-NO-ISEL-LABEL: foolc:
; CHECK-NO-ISEL:       # %bb.0: # %entry
; CHECK-NO-ISEL-NEXT:    sub. 6, 4, 3
; CHECK-NO-ISEL-NEXT:    bc 12, 0, .LBB4_2
; CHECK-NO-ISEL-NEXT:  # %bb.1: # %entry
; CHECK-NO-ISEL-NEXT:    ori 3, 4, 0
; CHECK-NO-ISEL-NEXT:    b .LBB4_2
; CHECK-NO-ISEL-NEXT:  .LBB4_2: # %entry
; CHECK-NO-ISEL-NEXT:    std 6, 0(5)
; CHECK-NO-ISEL-NEXT:    blr
entry:
  %sub = sub nsw i64 %b, %a
  store i64 %sub, i64* %c, align 8
  %cmp = icmp sgt i64 %a, %b
  %cond = select i1 %cmp, i64 %a, i64 %b
  ret i64 %cond
}

define i64 @foold(i64 %a, i64 %b, i64* nocapture %c) #0 {
; CHECK-LABEL: foold:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    sub. 6, 4, 3
; CHECK-NEXT:    isel 3, 3, 4, 1
; CHECK-NEXT:    std 6, 0(5)
; CHECK-NEXT:    blr
;
; CHECK-NO-ISEL-LABEL: foold:
; CHECK-NO-ISEL:       # %bb.0: # %entry
; CHECK-NO-ISEL-NEXT:    sub. 6, 4, 3
; CHECK-NO-ISEL-NEXT:    bc 12, 1, .LBB5_2
; CHECK-NO-ISEL-NEXT:  # %bb.1: # %entry
; CHECK-NO-ISEL-NEXT:    ori 3, 4, 0
; CHECK-NO-ISEL-NEXT:    b .LBB5_2
; CHECK-NO-ISEL-NEXT:  .LBB5_2: # %entry
; CHECK-NO-ISEL-NEXT:    std 6, 0(5)
; CHECK-NO-ISEL-NEXT:    blr
entry:
  %sub = sub nsw i64 %b, %a
  store i64 %sub, i64* %c, align 8
  %cmp = icmp slt i64 %a, %b
  %cond = select i1 %cmp, i64 %a, i64 %b
  ret i64 %cond
}

define i64 @foold2(i64 %a, i64 %b, i64* nocapture %c) #0 {
; CHECK-LABEL: foold2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    sub. 6, 3, 4
; CHECK-NEXT:    isel 3, 3, 4, 0
; CHECK-NEXT:    std 6, 0(5)
; CHECK-NEXT:    blr
;
; CHECK-NO-ISEL-LABEL: foold2:
; CHECK-NO-ISEL:       # %bb.0: # %entry
; CHECK-NO-ISEL-NEXT:    sub. 6, 3, 4
; CHECK-NO-ISEL-NEXT:    bc 12, 0, .LBB6_2
; CHECK-NO-ISEL-NEXT:  # %bb.1: # %entry
; CHECK-NO-ISEL-NEXT:    ori 3, 4, 0
; CHECK-NO-ISEL-NEXT:    b .LBB6_2
; CHECK-NO-ISEL-NEXT:  .LBB6_2: # %entry
; CHECK-NO-ISEL-NEXT:    std 6, 0(5)
; CHECK-NO-ISEL-NEXT:    blr
entry:
  %sub = sub nsw i64 %a, %b
  store i64 %sub, i64* %c, align 8
  %cmp = icmp slt i64 %a, %b
  %cond = select i1 %cmp, i64 %a, i64 %b
  ret i64 %cond
}

define i64 @foo2l(i64 %a, i64 %b, i64* nocapture %c) #0 {
; CHECK-LABEL: foo2l:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    sld 4, 3, 4
; CHECK-NEXT:    addi 3, 4, -1
; CHECK-NEXT:    std 4, 0(5)
; CHECK-NEXT:    nor 3, 3, 4
; CHECK-NEXT:    rldicl 3, 3, 1, 63
; CHECK-NEXT:    blr
;
; CHECK-NO-ISEL-LABEL: foo2l:
; CHECK-NO-ISEL:       # %bb.0: # %entry
; CHECK-NO-ISEL-NEXT:    sld 4, 3, 4
; CHECK-NO-ISEL-NEXT:    addi 3, 4, -1
; CHECK-NO-ISEL-NEXT:    std 4, 0(5)
; CHECK-NO-ISEL-NEXT:    nor 3, 3, 4
; CHECK-NO-ISEL-NEXT:    rldicl 3, 3, 1, 63
; CHECK-NO-ISEL-NEXT:    blr
entry:
  %shl = shl i64 %a, %b
  store i64 %shl, i64* %c, align 8
  %cmp = icmp sgt i64 %shl, 0
  %conv1 = zext i1 %cmp to i64
  ret i64 %conv1
}

define double @food(double %a, double %b, double* nocapture %c) #0 {
; CHECK-LABEL: food:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fsub 0, 1, 2
; CHECK-NEXT:    fcmpu 0, 1, 2
; CHECK-NEXT:    stfd 0, 0(5)
; CHECK-NEXT:    bgtlr 0
; CHECK-NEXT:  # %bb.1: # %entry
; CHECK-NEXT:    fmr 1, 2
; CHECK-NEXT:    blr
;
; CHECK-NO-ISEL-LABEL: food:
; CHECK-NO-ISEL:       # %bb.0: # %entry
; CHECK-NO-ISEL-NEXT:    fsub 0, 1, 2
; CHECK-NO-ISEL-NEXT:    fcmpu 0, 1, 2
; CHECK-NO-ISEL-NEXT:    stfd 0, 0(5)
; CHECK-NO-ISEL-NEXT:    bgtlr 0
; CHECK-NO-ISEL-NEXT:  # %bb.1: # %entry
; CHECK-NO-ISEL-NEXT:    fmr 1, 2
; CHECK-NO-ISEL-NEXT:    blr
entry:
  %sub = fsub double %a, %b
  store double %sub, double* %c, align 8
  %cmp = fcmp ogt double %a, %b
  %cond = select i1 %cmp, double %a, double %b
  ret double %cond
}

define float @foof(float %a, float %b, float* nocapture %c) #0 {
; CHECK-LABEL: foof:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fsubs 0, 1, 2
; CHECK-NEXT:    fcmpu 0, 1, 2
; CHECK-NEXT:    stfs 0, 0(5)
; CHECK-NEXT:    bgtlr 0
; CHECK-NEXT:  # %bb.1: # %entry
; CHECK-NEXT:    fmr 1, 2
; CHECK-NEXT:    blr
;
; CHECK-NO-ISEL-LABEL: foof:
; CHECK-NO-ISEL:       # %bb.0: # %entry
; CHECK-NO-ISEL-NEXT:    fsubs 0, 1, 2
; CHECK-NO-ISEL-NEXT:    fcmpu 0, 1, 2
; CHECK-NO-ISEL-NEXT:    stfs 0, 0(5)
; CHECK-NO-ISEL-NEXT:    bgtlr 0
; CHECK-NO-ISEL-NEXT:  # %bb.1: # %entry
; CHECK-NO-ISEL-NEXT:    fmr 1, 2
; CHECK-NO-ISEL-NEXT:    blr
entry:
  %sub = fsub float %a, %b
  store float %sub, float* %c, align 4
  %cmp = fcmp ogt float %a, %b
  %cond = select i1 %cmp, float %a, float %b
  ret float %cond
}

declare i64 @llvm.ctpop.i64(i64);

define signext i64 @fooct(i64 signext %a, i64 signext %b, i64* nocapture %c) #0 {
; CHECK-LABEL: fooct:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lis 6, 21845
; CHECK-NEXT:    sub 7, 3, 4
; CHECK-NEXT:    ori 6, 6, 21845
; CHECK-NEXT:    lis 9, 13107
; CHECK-NEXT:    rotldi 8, 7, 63
; CHECK-NEXT:    rldimi 6, 6, 32, 0
; CHECK-NEXT:    and 6, 8, 6
; CHECK-NEXT:    ori 8, 9, 13107
; CHECK-NEXT:    sub 6, 7, 6
; CHECK-NEXT:    rldimi 8, 8, 32, 0
; CHECK-NEXT:    lis 9, 257
; CHECK-NEXT:    rotldi 7, 6, 62
; CHECK-NEXT:    and 6, 6, 8
; CHECK-NEXT:    ori 9, 9, 257
; CHECK-NEXT:    and 7, 7, 8
; CHECK-NEXT:    lis 8, 3855
; CHECK-NEXT:    add 6, 6, 7
; CHECK-NEXT:    ori 7, 8, 3855
; CHECK-NEXT:    rldicl 8, 6, 60, 4
; CHECK-NEXT:    rldimi 7, 7, 32, 0
; CHECK-NEXT:    rldimi 9, 9, 32, 0
; CHECK-NEXT:    add 6, 6, 8
; CHECK-NEXT:    and 6, 6, 7
; CHECK-NEXT:    mulld 6, 6, 9
; CHECK-NEXT:    rldicl. 6, 6, 8, 56
; CHECK-NEXT:    isel 3, 3, 4, 1
; CHECK-NEXT:    std 6, 0(5)
; CHECK-NEXT:    blr
;
; CHECK-NO-ISEL-LABEL: fooct:
; CHECK-NO-ISEL:       # %bb.0: # %entry
; CHECK-NO-ISEL-NEXT:    lis 6, 21845
; CHECK-NO-ISEL-NEXT:    sub 7, 3, 4
; CHECK-NO-ISEL-NEXT:    ori 6, 6, 21845
; CHECK-NO-ISEL-NEXT:    lis 9, 13107
; CHECK-NO-ISEL-NEXT:    rotldi 8, 7, 63
; CHECK-NO-ISEL-NEXT:    rldimi 6, 6, 32, 0
; CHECK-NO-ISEL-NEXT:    and 6, 8, 6
; CHECK-NO-ISEL-NEXT:    ori 8, 9, 13107
; CHECK-NO-ISEL-NEXT:    sub 6, 7, 6
; CHECK-NO-ISEL-NEXT:    rldimi 8, 8, 32, 0
; CHECK-NO-ISEL-NEXT:    lis 9, 257
; CHECK-NO-ISEL-NEXT:    rotldi 7, 6, 62
; CHECK-NO-ISEL-NEXT:    and 6, 6, 8
; CHECK-NO-ISEL-NEXT:    ori 9, 9, 257
; CHECK-NO-ISEL-NEXT:    and 7, 7, 8
; CHECK-NO-ISEL-NEXT:    lis 8, 3855
; CHECK-NO-ISEL-NEXT:    add 6, 6, 7
; CHECK-NO-ISEL-NEXT:    ori 7, 8, 3855
; CHECK-NO-ISEL-NEXT:    rldicl 8, 6, 60, 4
; CHECK-NO-ISEL-NEXT:    rldimi 7, 7, 32, 0
; CHECK-NO-ISEL-NEXT:    rldimi 9, 9, 32, 0
; CHECK-NO-ISEL-NEXT:    add 6, 6, 8
; CHECK-NO-ISEL-NEXT:    and 6, 6, 7
; CHECK-NO-ISEL-NEXT:    mulld 6, 6, 9
; CHECK-NO-ISEL-NEXT:    rldicl. 6, 6, 8, 56
; CHECK-NO-ISEL-NEXT:    bc 12, 1, .LBB10_2
; CHECK-NO-ISEL-NEXT:  # %bb.1: # %entry
; CHECK-NO-ISEL-NEXT:    ori 3, 4, 0
; CHECK-NO-ISEL-NEXT:    b .LBB10_2
; CHECK-NO-ISEL-NEXT:  .LBB10_2: # %entry
; CHECK-NO-ISEL-NEXT:    std 6, 0(5)
; CHECK-NO-ISEL-NEXT:    blr
entry:
  %sub = sub nsw i64 %a, %b
  %subc = call i64 @llvm.ctpop.i64(i64 %sub)
  store i64 %subc, i64* %c, align 4
  %cmp = icmp sgt i64 %subc, 0
  %cond = select i1 %cmp, i64 %a, i64 %b
  ret i64 %cond
}
