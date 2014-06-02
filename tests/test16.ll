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
%b = alloca i1, align 4
store i1 0, i1* %b
%i = alloca i32, align 4
store i32 0, i32* %i
%r = alloca i32, align 4
store i32 0, i32* %r
%lim = alloca i32, align 4
store i32 0, i32* %lim

%1 = add i32 0, 1
store i32 %1, i32* %i
%2 = add i32 0, 0
store i32 %2, i32* %r
%3 = add i32 0, 0
%4 = add i32 %3, 1
%5= getelementptr inbounds i8** %args, i32 %4
%6 = load i8** %5
%7 = call i32 @atoi(i8* %6) nounwind readonly
store i32 %7, i32* %lim
br label %.label1
.label1:
%8 = alloca i1, align 4
store i1 0, i1* %8
%9 = load i32* %i
%10 = load i32* %lim
%11 = icmp sle i32 %9, %10
store i1 %11, i1* %8
%12 = load i1* %8
br i1 %12, label %.label2, label %.label3
.label2:
%13 = load i32* %r
%14 = load i32* %i
%15 = add i32 %13, %14
store i32 %15, i32* %r
%16 = load i32* %i
%17 = add i32 0, 1
%18 = add i32 %16, %17
store i32 %18, i32* %i
br label %.label1
.label3:
%19 = load i32* %r
%20 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %19)
%21 = add i1 0, 0
store i1 %21, i1* %b
br label %.label4
.label4:
%22 = load i1* %b
br i1 %22, label %.label5, label %.label6
.label5:
br label %.label4
.label6:

br label %.return1
.return1:
%.return_final = load i32* %return
ret i32 %.return_final
}


