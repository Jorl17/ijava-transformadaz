%struct.IntArray = type { i32, i32* }

@array = common global %struct.IntArray zeroinitializer, align 8

define i32 @main() nounwind uwtable {
  store i32 40, i32* getelementptr inbounds (%struct.IntArray* @array, i32 0, i32 0), align 4
  %1 = load i32* getelementptr inbounds (%struct.IntArray* @array, i32 0, i32 0), align 4
  %2 = sext i32 %1 to i64
  %3 = mul i64 %2, 4
  %4 = call noalias i8* @malloc(i64 %3) nounwind
  %5 = bitcast i8* %4 to i32*
  store i32* %4, i32** getelementptr inbounds (%struct.IntArray* @array, i32 0, i32 1), align 8
  ret i32 0
}

declare noalias i8* @malloc(i64) nounwind
