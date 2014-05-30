%struct.IntArray = type { i32, i32* }

@array = common global %struct.IntArray zeroinitializer, align 8

define i32 @main() nounwind uwtable {
  store i32 40, i32* getelementptr inbounds (%struct.IntArray* @array, i32 0, i32 0), align 4
  store i32* null, i32** getelementptr inbounds (%struct.IntArray* @array, i32 0, i32 1), align 8
  ret i32 0
}
