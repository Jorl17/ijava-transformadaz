%.IntArray = type { i32, i32* }
%.BoolArray = type { i32, i1* }
declare i32 @printf(i8*, ...)
declare i32 @atoi(i8*) nounwind readonly
declare noalias i8* @malloc(i32) nounwind
declare noalias i8* @calloc(i32, i32) nounwind@str.printf_callstr = private unnamed_addr constant [4 x i8] c"%d\0A\00"
@str.false_str = private unnamed_addr constant [7 x i8] c"false\0A\00"
@str.true_str = private unnamed_addr constant [7 x i8] c"true\0A\00\00"
@str.bools_array = global [2 x i8*] [i8* getelementptr inbounds ([7 x i8]* @str.false_str, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8]* @str.true_str, i32 0, i32 0)]


@a = global i32 0, align 4
@b = global i32 0, align 4
@c = global i32 0, align 4
@e = global i1 0, align 4
@f = global i1 0, align 4
@g = global i1 0, align 4


define i32 @main(i32 %args.length, i8** %args) {
%return = alloca i32, align 4
store i32 0, i32* %return
%a = alloca i32, align 4
store i32 0, i32* %a
%b = alloca i32, align 4
store i32 0, i32* %b
%e = alloca i1, align 4
store i1 0, i1* %e

%1 = add i32 0, 1
%2 = sub i32 0, %1
store i32 %2, i32* %a
%3 = add i32 0, 7
store i32 %3, i32* %b
%4 = add i1 0, 1
store i1 %4, i1* %e
%5 = load i32* %a
%6 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %5)
%7 = load i32* %b
%8 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %7)
%9 = load i32* @c
%10 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %9)
%11 = load i1* %e
%12 = zext i1 %11 to i32
%13 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %12
%14 = load i8** %13
%15 = call i32 (i8*, ...)* @printf(i8* %14)
%16 = load i1* @f
%17 = zext i1 %16 to i32
%18 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %17
%19 = load i8** %18
%20 = call i32 (i8*, ...)* @printf(i8* %19)
%21 = load i1* @g
%22 = zext i1 %21 to i32
%23 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %22
%24 = load i8** %23
%25 = call i32 (i8*, ...)* @printf(i8* %24)

br label %.return1
.return1:
%.return_final = load i32* %return
ret i32 %.return_final
}


