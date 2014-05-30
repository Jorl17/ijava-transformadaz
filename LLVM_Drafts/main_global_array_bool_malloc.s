%struct.IntArray = type { i32, i8* }

@array = global %struct.IntArray zeroinitializer, align 8

define i32 @main() nounwind uwtable {
  store i32 40, i32* getelementptr inbounds (%struct.IntArray* @array, i32 0, i32 0), align 4 ;Guardar o tamanho do array
  %1 = load i32* getelementptr inbounds (%struct.IntArray* @array, i32 0, i32 0), align 4 ;Carregar o tamanho do array
  %2 = sext i32 %1 to i64 ;Nao vamos usar
  %3 = mul i64 %2, 4 ;Obter tamanho final do array
  %4 = call noalias i8* @malloc(i64 %3) nounwind
  store i8* %4, i8** getelementptr inbounds (%struct.IntArray* @array, i32 0, i32 1), align 8 ;Armazenar na estrutura o ponteiro para o array
  ret i32 0
}

declare noalias i8* @malloc(i64) nounwind
