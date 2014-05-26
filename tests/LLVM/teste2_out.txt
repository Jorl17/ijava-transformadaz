@.str = private unnamed_addr constant [16 x i8] c"Hello World %d\0A\00", align 1

;The align at the end of the commands may not be needed
define i32 @main() nounwind uwtable {
  %1 = alloca i32, align 4 	;Return value -- again, not needed
  %i = alloca i32, align 4 	;Allocate space for the i variable
  store i32 0, i32* %1 		;Store the default return value of the function. Again, not needed in main method
  store i32 99, i32* %i, align 4 	;Store the value of the "i" variable
  %2 = load i32* %i, align 4 		;Load the value of the "i" variable to a local variable
  %3 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([16 x i8]* @.str, i32 0, i32 0), i32 %2)
  ret i32 0
}

declare i32 @printf(i8*, ...)
