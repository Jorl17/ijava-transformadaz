%.IntArray = type { i32, i32* }
%.BoolArray = type { i32, i1* }
declare i32 @printf(i8*, ...)
declare i32 @atoi(i8*) nounwind readonly
declare noalias i8* @malloc(i32) nounwind
declare noalias i8* @calloc(i32, i32) nounwind@str.printf_callstr = private unnamed_addr constant [4 x i8] c"%d\0A\00"
@str.false_str = private unnamed_addr constant [7 x i8] c"false\0A\00"
@str.true_str = private unnamed_addr constant [7 x i8] c"true\0A\00\00"
@str.bools_array = global [2 x i8*] [i8* getelementptr inbounds ([7 x i8]* @str.false_str, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8]* @str.true_str, i32 0, i32 0)]


@a1 = global i32 0, align 4
@a2 = global i32 0, align 4
@a3 = global i32 0, align 4
@a4 = global i32 0, align 4
@a5 = global i32 0, align 4
@a6 = global i32 0, align 4
@a7 = global i32 0, align 4
@a8 = global i32 0, align 4
@a9 = global i32 0, align 4
@a10 = global i32 0, align 4
@a11 = global i32 0, align 4
@a12 = global i32 0, align 4
@a13 = global i32 0, align 4
@a14 = global i32 0, align 4
@a15 = global i1 0, align 4
@a16 = global i1 0, align 4


define i32 @main(i32 %args.length, i8** %args) {
%return = alloca i32, align 4
store i32 0, i32* %return

%1 = add i32 0, 1
%2 = sub i32 0, %1
store i32 %2, i32* @a1
%3 = add i32 0, 0
store i32 %3, i32* @a2
%4 = add i32 0, 1
store i32 %4, i32* @a3
%5 = add i32 0, 7
store i32 %5, i32* @a4
%6 = add i32 0, 7
%7 = sub i32 0, %6
store i32 %7, i32* @a5
%8 = add i32 0, 8
store i32 %8, i32* @a6
%9 = add i32 0, 0
store i32 %9, i32* @a7
%10 = add i32 0, 15
%11 = sub i32 0, %10
store i32 %11, i32* @a8
%12 = add i32 0, 15
%13 = sub i32 0, %12
store i32 %13, i32* @a9
%14 = add i32 0, 0
store i32 %14, i32* @a10
%15 = add i32 0, 1
store i32 %15, i32* @a11
%16 = add i32 0, 9
store i32 %16, i32* @a12
%17 = add i32 0, 10
store i32 %17, i32* @a13
%18 = add i32 0, 16
store i32 %18, i32* @a14
%19 = add i1 0, 0
store i1 %19, i1* @a15
%20 = add i1 0, 1
store i1 %20, i1* @a16

br label %.return1
.return1:
%.return_final = load i32* %return
ret i32 %.return_final
}


