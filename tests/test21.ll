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
%a = alloca i32, align 4
store i32 0, i32* %a
%b = alloca i32, align 4
store i32 0, i32* %b
%c = alloca i1, align 4
store i1 0, i1* %c
%d = alloca i1, align 4
store i1 0, i1* %d

%1 = alloca i1, align 4
store i1 0, i1* %1
%2 = add i1 0, 1
store i1 %2, i1* %1
%3 = load i1* %1
br i1 %3, label %.label1, label %.label2
.label1:
%4 = call i1 ()* @test1()
store i1 %4, i1* %1
br label %.label2
.label2:
%5 = load i1* %1
store i1 %5, i1* %c
%6 = alloca i1, align 4
store i1 0, i1* %6
%7 = add i1 0, 0
store i1 %7, i1* %6
%8 = load i1* %6
br i1 %8, label %.label3, label %.label4
.label3:
%9 = call i1 ()* @test1()
store i1 %9, i1* %6
br label %.label4
.label4:
%10 = load i1* %6
store i1 %10, i1* %d
%11 = alloca i1, align 4
store i1 0, i1* %11
%12 = add i1 0, 1
store i1 %12, i1* %11
%13 = load i1* %11
br i1 %13, label %.label5, label %.label6
.label5:
%14 = call i1 ()* @test2()
store i1 %14, i1* %11
br label %.label6
.label6:
%15 = load i1* %11
store i1 %15, i1* %c
%16 = alloca i1, align 4
store i1 0, i1* %16
%17 = add i1 0, 0
store i1 %17, i1* %16
%18 = load i1* %16
br i1 %18, label %.label7, label %.label8
.label7:
%19 = call i1 ()* @test2()
store i1 %19, i1* %16
br label %.label8
.label8:
%20 = load i1* %16
store i1 %20, i1* %d
%21 = alloca i1, align 4
store i1 0, i1* %21
%22 = add i1 0, 0
store i1 %22, i1* %21
%23 = load i1* %21
br i1 %23, label %.label9, label %.label10
.label9:
%24 = call i1 ()* @test1()
store i1 %24, i1* %21
br label %.label10
.label10:
%25 = load i1* %21
store i1 %25, i1* %c
%26 = alloca i1, align 4
store i1 0, i1* %26
%27 = add i1 0, 1
store i1 %27, i1* %26
%28 = load i1* %26
br i1 %28, label %.label11, label %.label12
.label11:
%29 = call i1 ()* @test1()
store i1 %29, i1* %26
br label %.label12
.label12:
%30 = load i1* %26
store i1 %30, i1* %d
%31 = alloca i1, align 4
store i1 0, i1* %31
%32 = add i1 0, 0
store i1 %32, i1* %31
%33 = load i1* %31
br i1 %33, label %.label13, label %.label14
.label13:
%34 = call i1 ()* @test2()
store i1 %34, i1* %31
br label %.label14
.label14:
%35 = load i1* %31
store i1 %35, i1* %c
%36 = alloca i1, align 4
store i1 0, i1* %36
%37 = add i1 0, 1
store i1 %37, i1* %36
%38 = load i1* %36
br i1 %38, label %.label15, label %.label16
.label15:
%39 = call i1 ()* @test2()
store i1 %39, i1* %36
br label %.label16
.label16:
%40 = load i1* %36
store i1 %40, i1* %d

br label %.return1
.return1:
%.return_final = load i32* %return
ret i32 %.return_final
}


define i1 @test1() {
%return = alloca i1, align 4
store i1 0, i1* %return

%1 = add i32 0, 1
%2 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %1)
%3 = add i1 0, 1
store i1 %3, i1* %return
br label %.return2
.label17:

br label %.return2
.return2:
%.return_final = load i1* %return
ret i1 %.return_final
}


define i1 @test2() {
%return = alloca i1, align 4
store i1 0, i1* %return

%1 = add i32 0, 2
%2 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %1)
%3 = add i1 0, 0
store i1 %3, i1* %return
br label %.return3
.label18:

br label %.return3
.return3:
%.return_final = load i1* %return
ret i1 %.return_final
}


