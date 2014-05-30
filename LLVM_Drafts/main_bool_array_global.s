%struct.IntArray = type { i32, i8* }

@array = global %struct.IntArray zeroinitializer, align 8

define i32 @main() nounwind uwtable {
  store i32 40, i32* getelementptr inbounds (%struct.IntArray* @array, i32 0, i32 0), align 4
  store i8* null, i8** getelementptr inbounds (%struct.IntArray* @array, i32 0, i32 1), align 8
  ret i32 0
}
