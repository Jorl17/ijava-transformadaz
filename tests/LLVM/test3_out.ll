@k = common global i32 0, align 4	;Global variable, already initialized with the C-default value (0)
@.str = private unnamed_addr constant [16 x i8] c"Hello World %d\0A\00", align 1

define i32 @main() nounwind uwtable {
  %1 = alloca i32, align 4			  ;Return value
  %i = alloca i32, align 4			  ;Allocate space for the i variable
  store i32 0, i32* %1 				    ;Return value...
  store i32 0, i32* @k, align 4	  ;Store the value of the k variable
  %2 = load i32* @k, align 4 		  ;Load the value of the k variable
  %3 = add nsw i32 %2, 1 			    ;Compute the sum of i: i = k + 1. The nsw is just telling that we might have an overflow or cause an 		                  						  unexcepted behaviour
  store i32 %3, i32* %i, align 4  ;Store the value of the sum in the i variable, finish the i = k + 1 command
  %4 = load i32* %i, align 4 		  ;Load the value of the i variable
  %5 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([16 x i8]* @.str, i32 0, i32 0), i32 %4)	;Print stuff
  ret i32 0 						          ;Return the function
}

declare i32 @printf(i8*, ...)
