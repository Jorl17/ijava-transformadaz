%.IntArray = type { i32, i32* }
%.BoolArray = type { i32, i1* }
declare i32 @printf(i8*, ...)
declare i32 @atoi(i8*) nounwind readonly
declare noalias i8* @malloc(i32) nounwind
declare noalias i8* @calloc(i32, i32) nounwind@str.printf_callstr = private unnamed_addr constant [4 x i8] c"%d\0A\00"
@str.false_str = private unnamed_addr constant [7 x i8] c"false\0A\00"
@str.true_str = private unnamed_addr constant [7 x i8] c"true\0A\00\00"
@str.bools_array = global [2 x i8*] [i8* getelementptr inbounds ([7 x i8]* @str.false_str, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8]* @str.true_str, i32 0, i32 0)]




define i32 @main(i32 %args.length, i8** %args) {
%return = alloca i32, align 4
store i32 0, i32* %return

%1 = add i32 0, 1
%2 = sub i32 0, %1
%3 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %2)
%4 = add i32 0, 0
%5 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %4)
%6 = add i32 0, 0
%7 = sub i32 0, %6
%8 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %7)
%9 = add i32 0, 1
%10 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %9)
%11 = add i32 0, 7
%12 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %11)
%13 = add i32 0, 7
%14 = sub i32 0, %13
%15 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %14)
%16 = add i32 0, 8
%17 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %16)
%18 = add i32 0, 0
%19 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %18)
%20 = add i32 0, 15
%21 = sub i32 0, %20
%22 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %21)
%23 = add i32 0, 15
%24 = sub i32 0, %23
%25 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %24)
%26 = add i32 0, 0
%27 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %26)
%28 = add i32 0, 1
%29 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %28)
%30 = add i32 0, 9
%31 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %30)
%32 = add i32 0, 10
%33 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %32)
%34 = add i32 0, 16
%35 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %34)
%36 = add i1 0, 0
%37 = zext i1 %36 to i32
%38 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %37
%39 = load i8** %38
%40 = call i32 (i8*, ...)* @printf(i8* %39)
%41 = add i1 0, 1
%42 = zext i1 %41 to i32
%43 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %42
%44 = load i8** %43
%45 = call i32 (i8*, ...)* @printf(i8* %44)

br label %.return1
.return1:
%.return_final = load i32* %return
ret i32 %.return_final
}


