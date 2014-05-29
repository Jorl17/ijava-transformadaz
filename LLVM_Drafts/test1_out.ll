@.str = private unnamed_addr constant [13 x i8] c"Hello World\0A\00"

;Note that in iJava our main method can only return void and in LLVM, like in C, the main function cannot return void
;However, this is not a problem, since we can make our main method return 0 and off we go!
define i32 @main() nounwind uwtable {
  %1 = alloca i32, align 4 	;In this case we do not need to do this because we have a constant return value
  							;I will just leave it here for copy-paste, in case we need it
  store i32 0, i32* %1 		;Same as in the last line
  %2 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str, i32 0, i32 0))
  ret i32 0
}

declare i32 @printf(i8*, ...)
