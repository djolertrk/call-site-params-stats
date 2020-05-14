; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -mtriple=x86_64-unknown-linux -slp-vectorizer -S -mcpu=corei7 | FileCheck %s

define i32 @main() {
; CHECK-LABEL: define {{[^@]+}}@main(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[T:%.*]] = alloca <8 x i32>, align 32
; CHECK-NEXT:    [[T1:%.*]] = bitcast <8 x i32>* [[T]] to [8 x i32]*
; CHECK-NEXT:    [[T2:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[T3:%.*]] = bitcast <8 x i32>* [[T]] to i8*
; CHECK-NEXT:    [[T4:%.*]] = getelementptr inbounds <8 x i32>, <8 x i32>* [[T]], i64 0, i64 0
; CHECK-NEXT:    [[T5:%.*]] = getelementptr inbounds [8 x i32], [8 x i32]* [[T1]], i64 0, i64 1
; CHECK-NEXT:    [[T6:%.*]] = getelementptr inbounds [8 x i32], [8 x i32]* [[T1]], i64 0, i64 2
; CHECK-NEXT:    [[T7:%.*]] = getelementptr inbounds [8 x i32], [8 x i32]* [[T1]], i64 0, i64 3
; CHECK-NEXT:    [[T8:%.*]] = getelementptr inbounds [8 x i32], [8 x i32]* [[T1]], i64 0, i64 4
; CHECK-NEXT:    [[T9:%.*]] = getelementptr inbounds [8 x i32], [8 x i32]* [[T1]], i64 0, i64 6
; CHECK-NEXT:    [[T10:%.*]] = getelementptr inbounds [8 x i32], [8 x i32]* [[T1]], i64 0, i64 5
; CHECK-NEXT:    [[T11:%.*]] = getelementptr inbounds [8 x i32], [8 x i32]* [[T1]], i64 0, i64 7
; CHECK-NEXT:    store <8 x i32> <i32 -221320154, i32 -756426931, i32 563883532, i32 382683935, i32 144890241, i32 -1052877364, i32 -1052877364, i32 -1016007675>, <8 x i32>* [[T]], align 32
; CHECK-NEXT:    [[T12:%.*]] = bitcast i32* [[T2]] to i8*
; CHECK-NEXT:    [[T13:%.*]] = load i32, i32* [[T4]], align 32
; CHECK-NEXT:    [[T14:%.*]] = load i32, i32* [[T5]], align 4
; CHECK-NEXT:    [[T15:%.*]] = icmp slt i32 [[T14]], [[T13]]
; CHECK-NEXT:    [[T16:%.*]] = select i1 [[T15]], i32 [[T14]], i32 [[T13]]
; CHECK-NEXT:    [[T17:%.*]] = zext i1 [[T15]] to i32
; CHECK-NEXT:    [[T18:%.*]] = load i32, i32* [[T6]], align 8
; CHECK-NEXT:    [[T19:%.*]] = icmp slt i32 [[T18]], [[T16]]
; CHECK-NEXT:    [[T20:%.*]] = select i1 [[T19]], i32 [[T18]], i32 [[T16]]
; CHECK-NEXT:    [[T21:%.*]] = select i1 [[T19]], i32 2, i32 [[T16]]
; CHECK-NEXT:    [[T22:%.*]] = load i32, i32* [[T7]], align 4
; CHECK-NEXT:    [[T23:%.*]] = icmp slt i32 [[T22]], [[T20]]
; CHECK-NEXT:    [[T24:%.*]] = select i1 [[T23]], i32 [[T22]], i32 [[T20]]
; CHECK-NEXT:    [[T25:%.*]] = select i1 [[T23]], i32 3, i32 [[T21]]
; CHECK-NEXT:    [[T26:%.*]] = load i32, i32* [[T8]], align 16
; CHECK-NEXT:    [[T27:%.*]] = icmp slt i32 [[T26]], [[T24]]
; CHECK-NEXT:    [[T28:%.*]] = select i1 [[T27]], i32 [[T26]], i32 [[T24]]
; CHECK-NEXT:    [[T29:%.*]] = select i1 [[T27]], i32 4, i32 [[T25]]
; CHECK-NEXT:    [[T30:%.*]] = load i32, i32* [[T10]], align 4
; CHECK-NEXT:    [[T31:%.*]] = icmp slt i32 [[T30]], [[T28]]
; CHECK-NEXT:    [[T32:%.*]] = select i1 [[T31]], i32 [[T30]], i32 [[T28]]
; CHECK-NEXT:    [[T33:%.*]] = select i1 [[T31]], i32 5, i32 [[T29]]
; CHECK-NEXT:    [[T34:%.*]] = load i32, i32* [[T9]], align 8
; CHECK-NEXT:    [[T35:%.*]] = icmp slt i32 [[T34]], [[T32]]
; CHECK-NEXT:    [[T36:%.*]] = select i1 [[T35]], i32 [[T34]], i32 [[T32]]
; CHECK-NEXT:    [[T37:%.*]] = select i1 [[T35]], i32 6, i32 [[T33]]
; CHECK-NEXT:    [[T38:%.*]] = load i32, i32* [[T11]], align 4
; CHECK-NEXT:    [[T39:%.*]] = icmp slt i32 [[T38]], [[T36]]
; CHECK-NEXT:    [[T40:%.*]] = select i1 [[T39]], i32 7, i32 [[T37]]
; CHECK-NEXT:    store i32 [[T40]], i32* [[T2]], align 4
; CHECK-NEXT:    ret i32 0
;
bb:
  %t = alloca <8 x i32>, align 32
  %t1 = bitcast <8 x i32>* %t to [8 x i32]*
  %t2 = alloca i32, align 4
  %t3 = bitcast <8 x i32>* %t to i8*
  %t4 = getelementptr inbounds <8 x i32>, <8 x i32>* %t, i64 0, i64 0
  %t5 = getelementptr inbounds [8 x i32], [8 x i32]* %t1, i64 0, i64 1
  %t6 = getelementptr inbounds [8 x i32], [8 x i32]* %t1, i64 0, i64 2
  %t7 = getelementptr inbounds [8 x i32], [8 x i32]* %t1, i64 0, i64 3
  %t8 = getelementptr inbounds [8 x i32], [8 x i32]* %t1, i64 0, i64 4
  %t9 = getelementptr inbounds [8 x i32], [8 x i32]* %t1, i64 0, i64 6
  %t10 = getelementptr inbounds [8 x i32], [8 x i32]* %t1, i64 0, i64 5
  %t11 = getelementptr inbounds [8 x i32], [8 x i32]* %t1, i64 0, i64 7
  store <8 x i32> <i32 -221320154, i32 -756426931, i32 563883532, i32 382683935, i32 144890241, i32 -1052877364, i32 -1052877364, i32 -1016007675>, <8 x i32>* %t, align 32
  %t12 = bitcast i32* %t2 to i8*
  %t13 = load i32, i32* %t4, align 32
  %t14 = load i32, i32* %t5, align 4
  %t15 = icmp slt i32 %t14, %t13
  %t16 = select i1 %t15, i32 %t14, i32 %t13
  %t17 = zext i1 %t15 to i32
  %t18 = load i32, i32* %t6, align 8
  %t19 = icmp slt i32 %t18, %t16
  %t20 = select i1 %t19, i32 %t18, i32 %t16
  %t21 = select i1 %t19, i32 2, i32 %t16
  %t22 = load i32, i32* %t7, align 4
  %t23 = icmp slt i32 %t22, %t20
  %t24 = select i1 %t23, i32 %t22, i32 %t20
  %t25 = select i1 %t23, i32 3, i32 %t21
  %t26 = load i32, i32* %t8, align 16
  %t27 = icmp slt i32 %t26, %t24
  %t28 = select i1 %t27, i32 %t26, i32 %t24
  %t29 = select i1 %t27, i32 4, i32 %t25
  %t30 = load i32, i32* %t10, align 4
  %t31 = icmp slt i32 %t30, %t28
  %t32 = select i1 %t31, i32 %t30, i32 %t28
  %t33 = select i1 %t31, i32 5, i32 %t29
  %t34 = load i32, i32* %t9, align 8
  %t35 = icmp slt i32 %t34, %t32
  %t36 = select i1 %t35, i32 %t34, i32 %t32
  %t37 = select i1 %t35, i32 6, i32 %t33
  %t38 = load i32, i32* %t11, align 4
  %t39 = icmp slt i32 %t38, %t36
  %t40 = select i1 %t39, i32 7, i32 %t37
  store i32 %t40, i32* %t2, align 4
  ret i32 0
}
