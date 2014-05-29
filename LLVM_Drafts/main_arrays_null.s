; ModuleID = 'main_arrays_null.cpp'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.IntArray = type { i32, i8* }

define i32 @main() nounwind uwtable {
  %1 = alloca i32, align 4
  %array = alloca %struct.IntArray, align 8
  store i32 0, i32* %1
  %2 = getelementptr inbounds %struct.IntArray* %array, i32 0, i32 0
  store i32 40, i32* %2, align 4
  %3 = getelementptr inbounds %struct.IntArray* %array, i32 0, i32 1
  store i8* null, i8** %3, align 8
  ret i32 0
}
