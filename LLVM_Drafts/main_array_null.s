%.IntArray = type { i32, i1* }

define i32 @main() nounwind uwtable {
  %array = alloca %.IntArray, align 8
  %.1 = getelementptr inbounds %.IntArray* %array, i32 0, i32 0
  store i32 40, i32* %.1, align 4
  %..1 = getelementptr inbounds %.IntArray* %array, i32 0, i32 1
  store i1* null, i1** %..1, align 8
  ret i32 0
}
