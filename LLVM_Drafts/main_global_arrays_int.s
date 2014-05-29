; ModuleID = 'main.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.IntArray = type { i32, i32* }

@array = common global %struct.IntArray zeroinitializer, align 8

define i32 @main() nounwind uwtable {
  %1 = alloca i32, align 4
  store i32 0, i32* %1
  store i32 40, i32* getelementptr inbounds (%struct.IntArray* @array, i32 0, i32 0), align 4
  store i32* null, i32** getelementptr inbounds (%struct.IntArray* @array, i32 0, i32 1), align 8
  ret i32 0
}
