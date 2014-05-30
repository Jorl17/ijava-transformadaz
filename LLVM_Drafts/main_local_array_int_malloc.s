%struct.IntArray = type { i32, i32* }

define i32 @main() nounwind uwtable {
  %array = alloca %struct.IntArray, align 8
  %1 = getelementptr inbounds %struct.IntArray* %array, i32 0, i32 0 ;Ponteiro para array.size
  store i32 40, i32* %1, align 4 ;array.size = 40
  %2 = getelementptr inbounds %struct.IntArray* %array, i32 0, i32 0 ;Ponteiro para array.size
  %3 = load i32* %2, align 4 ;%3 = array.size
  %4 = sext i32 %3 to i64 ;Extend to type i64 - Going to need this?
  %5 = mul i64 %4, 4 ;array.size*sizeof(int)
  %6 = call noalias i8* @malloc(i64 %5) nounwind
  %7 = bitcast i8* %6 to i32* ;malloc devolve i8*, temos que passar para i32*
  %8 = getelementptr inbounds %struct.IntArray* %array, i32 0, i32 1 ;Guardar o array
  store i32* %7, i32** %8, align 8
  ret i32 0
}

declare noalias i8* @malloc(i64) nounwind
