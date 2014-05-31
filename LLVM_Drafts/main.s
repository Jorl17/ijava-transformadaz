%struct.IntArray = type { i32, i8* }

define i32 @main() nounwind uwtable {
  %1 = alloca i32, align 4
  %array = alloca %struct.IntArray, align 8
  store i32 0, i32* %1
  %2 = getelementptr inbounds %struct.IntArray* %array, i32 0, i32 0
  store i32 40, i32* %2, align 4
  %3 = getelementptr inbounds %struct.IntArray* %array, i32 0, i32 0
  %4 = load i32* %3, align 4
  %5 = sext i32 %4 to i64
  %6 = call noalias i8* @calloc(i64 %5, i64 1) nounwind
  %7 = getelementptr inbounds %struct.IntArray* %array, i32 0, i32 1
  store i8* %6, i8** %7, align 8
  ret i32 0
}

declare noalias i8* @calloc(i64, i64) nounwind
