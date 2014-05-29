@.str = private unnamed_addr constant [14 x i8] c"Hello World!\0A\00", align 1
@.str2 = private unnamed_addr constant [16 x i8] c"Goodbye World!\0A\00", align 1

define i32 @main() nounwind uwtable {
	%1 = alloca i32, align 4			  ;Return value
	%a = alloca i32, align 4			  ;Allocate space for the a variable
	%k = alloca i32, align 4			  ;Allocate space for the k variable
	store i32 0, i32* %1 				  ;Return value...
	store i32 2, i32* %a 			 	  ;Store the value of the a variable
	%v2 = add i32 0, 2 					  ;We did not needed to create this variable, but FFS let's keep it
	%2 = load i32* %a, align 4 			  ;Load the variable a
	%ifcond = icmp eq i32 %2, %v2
	br i1 %ifcond, label %then, label %else 	;This is how we do the if

then:
	%3 = load i32* %a, align 4 			  ;Load the value of the a variable
	%4 = add i32 %3, 1 				  	  ;a++
	store i32 %4, i32* %a 				  ;Store the value in a
	%5 = load i32* %a, align 4 			  ;Load the value of the a variable
	%6 = mul i32 %5, 2 					  ; a * 2
	store i32 %6, i32* %k 				  ;Store a * 2 in k
	%7 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @.str, i32 0, i32 0))	;Print stuff
	br label %ifcont

else:
	%8 = load i32* %a, align 4 			  ;Load the value of the a variable
	%9 = sub i32 %8, 1 				  	  ;a--
	store i32 %9, i32* %a 				  ;Store the value in a
	%10 = load i32* %a, align 4 		  ;Load the value of the a variable
	%11 = udiv i32 %10, 2 				  ; a / 2
	store i32 %11, i32* %k 				  ;Store a / 2 in k
	%12 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([16 x i8]* @.str2, i32 0, i32 0))	;Print stuff
	br label %ifcont

ifcont:
	ret i32 0 							  ;Return the function
}

declare i32 @printf(i8*, ...)