%.IntArray = type { i32, i32* }
%.BoolArray = type { i32, i1* }
declare i32 @printf(i8*, ...)
declare i32 @atoi(i8*) nounwind readonly
declare noalias i8* @malloc(i32) nounwind
declare noalias i8* @calloc(i32, i32) nounwind@str.printf_callstr = private unnamed_addr constant [4 x i8] c"%d\0A\00"
@str.false_str = private unnamed_addr constant [7 x i8] c"false\0A\00"
@str.true_str = private unnamed_addr constant [7 x i8] c"true\0A\00\00"
@str.bools_array = global [2 x i8*] [i8* getelementptr inbounds ([7 x i8]* @str.false_str, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8]* @str.true_str, i32 0, i32 0)]


@i = global i32 0, align 4
@b = global i1 0, align 4


define i32 @main(i32 %args.length, i8** %args) {
%return = alloca i32, align 4
store i32 0, i32* %return
%j = alloca i32, align 4
store i32 0, i32* %j

%1 = add i32 0, 0
store i32 %1, i32* @i
br label %.label1
.label1:
%2 = alloca i1, align 4
store i1 0, i1* %2
%3 = load i32* @i
%4 = add i32 0, 100
%5 = icmp sle i32 %3, %4
store i1 %5, i1* %2
%6 = load i1* %2
br i1 %6, label %.label2, label %.label3
.label2:
%7 = alloca i1, align 4
store i1 0, i1* %7
%8 = alloca i1, align 4
store i1 0, i1* %8
%9 = load i32* @i
%10 = add i32 0, 10
%11 = icmp sgt i32 %9, %10
store i1 %11, i1* %8
%12 = load i1* %8
store i1 %12, i1* %7
%13 = load i1* %7
br i1 %13, label %.label7, label %.label8
.label7:
%14 = call i1 ()* @test1()
store i1 %14, i1* %7
br label %.label8
.label8:
%15 = load i1* %7
br i1 %15, label %.label4, label %.label5
.label4:
br label %.label6
.label5:
br label %.label6
.label6:
%16 = add i32 0, 0
store i32 %16, i32* %j
br label %.label9
.label9:
%17 = alloca i1, align 4
store i1 0, i1* %17
%18 = load i32* %j
%19 = add i32 0, 10
%20 = icmp sle i32 %18, %19
store i1 %20, i1* %17
%21 = load i1* %17
br i1 %21, label %.label10, label %.label11
.label10:
%22 = load i32* %j
%23 = add i32 0, 1
%24 = add i32 %22, %23
store i32 %24, i32* %j
br label %.label9
.label11:
%25 = load i1* @b
%26 = xor i1 true, %25
br i1 %26, label %.label12, label %.label13
.label12:
br label %.label14
.label13:
%27 = sub i32 %args.length, 1
%28 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %27)
br label %.label14
.label14:
%29 = load i32* @i
%30 = add i32 0, 1
%31 = add i32 %29, %30
store i32 %31, i32* @i
br label %.label1
.label3:

br label %.return1
.return1:
%.return_final = load i32* %return
ret i32 %.return_final
}


define i1 @test1() {
%return = alloca i1, align 4
store i1 0, i1* %return

%1 = load i32* @i
%2 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %1)
%3 = alloca i1, align 4
store i1 0, i1* %3
%4 = load i32* @i
%5 = add i32 0, 50
%6 = icmp sge i32 %4, %5
store i1 %6, i1* %3
%7 = load i1* %3
br i1 %7, label %.label15, label %.label16
.label15:
%8 = add i1 0, 1
store i1 %8, i1* @b
%9 = add i1 0, 1
store i1 %9, i1* %return
br label %.return2
.label18:
br label %.label17
.label16:
%10 = add i1 0, 0
store i1 %10, i1* @b
%11 = add i1 0, 0
store i1 %11, i1* %return
br label %.return2
.label19:
br label %.label17
.label17:

br label %.return2
.return2:
%.return_final = load i1* %return
ret i1 %.return_final
}


