%struct.IntArray = type { i32, i8* }

define i32 @main() nounwind uwtable {
  %array = alloca %struct.IntArray, align 8
  %1 = getelementptr inbounds %struct.IntArray* %array, i32 0, i32 0
  store i32 40, i32* %1, align 4 ;Guardar o tamanho do array na estrutura
  %2 = getelementptr inbounds %struct.IntArray* %array, i32 0, i32 0 ;Obter ponteiro para o tamanho do array
  %3 = load i32* %2, align 4 ;Carregar o valor do tamanho do array
  %4 = sext i32 %3 to i64 ;Nao vamos usar
  %5 = mul i64 %4, 1 ;Obter tamanho final do array
  %6 = call noalias i8* @malloc(i64 %5) nounwind
  %7 = getelementptr inbounds %struct.IntArray* %array, i32 0, i32 1
  store i8* %6, i8** %7, align 8 ;Guardar o ponteiro para o array na estrutura
  ret i32 0
}

declare noalias i8* @malloc(i64) nounwind
