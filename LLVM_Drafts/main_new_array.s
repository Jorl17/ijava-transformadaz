%struct.IntArray = type { i32, i32* }

define i32 @main() nounwind uwtable {
  %array = alloca %struct.IntArray, align 8
  %1 = getelementptr inbounds %struct.IntArray* %array, i32 0, i32 0
  store i32 0, i32* %1, align 4
  %2 = getelementptr inbounds %struct.IntArray* %array, i32 0, i32 0
  %3 = load i32* %2, align 4
  %4 = mul nsw i32 %3, 4
  %5 = sext i32 %4 to i64
  %6 = call noalias i8* @malloc(i64 %5) nounwind
  %7 = bitcast i8* %6 to i32*
  %8 = getelementptr inbounds %struct.IntArray* %array, i32 0, i32 1
  store i32* %7, i32** %8, align 8
  ret i32 0
}

declare noalias i8* @malloc(i64) nounwind
