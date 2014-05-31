
%struct.IntArray = type { i32, i32* }

@array = common global %struct.IntArray zeroinitializer, align 8

define i32 @main() nounwind uwtable {
  %1 = alloca i32, align 4
  store i32 0, i32* %1
  store i32 40, i32* getelementptr inbounds (%struct.IntArray* @array, i32 0, i32 0), align 4
  %2 = load i32* getelementptr inbounds (%struct.IntArray* @array, i32 0, i32 0), align 4
  %3 = sext i32 %2 to i64
  %4 = call noalias i8* @calloc(i64 %3, i64 4) nounwind
  %5 = bitcast i8* %4 to i32*
  store i32* %5, i32** getelementptr inbounds (%struct.IntArray* @array, i32 0, i32 1), align 8
  ret i32 0
}

declare noalias i8* @calloc(i64, i64) nounwind
