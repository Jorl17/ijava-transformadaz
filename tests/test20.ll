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
%a2 = alloca %.IntArray, align 8
%.array.a2 = getelementptr inbounds %.IntArray* %a2, i32 0, i32 0
store i32 0, i32* %.array.a2, align 4
%..array.a2 = getelementptr inbounds %.IntArray* %a2, i32 0, i32 1
store i32* null, i32** %..array.a2, align 8
%b2 = alloca %.IntArray, align 8
%.array.b2 = getelementptr inbounds %.IntArray* %b2, i32 0, i32 0
store i32 0, i32* %.array.b2, align 4
%..array.b2 = getelementptr inbounds %.IntArray* %b2, i32 0, i32 1
store i32* null, i32** %..array.b2, align 8
%c = alloca i1, align 4
store i1 0, i1* %c
%d = alloca i1, align 4
store i1 0, i1* %d
%c2 = alloca %.BoolArray, align 8
%.array.c2 = getelementptr inbounds %.BoolArray* %c2, i32 0, i32 0
store i32 0, i32* %.array.c2, align 4
%..array.c2 = getelementptr inbounds %.BoolArray* %c2, i32 0, i32 1
store i1* null, i1** %..array.c2, align 8
%d2 = alloca %.BoolArray, align 8
%.array.d2 = getelementptr inbounds %.BoolArray* %d2, i32 0, i32 0
store i32 0, i32* %.array.d2, align 4
%..array.d2 = getelementptr inbounds %.BoolArray* %d2, i32 0, i32 1
store i1* null, i1** %..array.d2, align 8

%1 = call i32 ()* @test1()
store i32 %1, i32* %a
%2 = load i32* %a
%3 = add i32 0, 1
%4 = sub i32 0, %3
%5 = call i32 (i32, i32)* @test2(i32 %2, i32 %4)
store i32 %5, i32* %b
%6 = call i1 ()* @test3()
store i1 %6, i1* %c
%7 = call i1 ()* @test4()
store i1 %7, i1* %d
%8 = call %.IntArray ()* @test5()
store %.IntArray %8, %.IntArray* %a2
%9 = call %.IntArray ()* @test6()
store %.IntArray %9, %.IntArray* %b2
%10 = call %.BoolArray ()* @test7()
store %.BoolArray %10, %.BoolArray* %c2
%11 = call %.BoolArray ()* @test8()
store %.BoolArray %11, %.BoolArray* %d2
%12 = load i32* %a
%13 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %12)
%14 = load i32* %b
%15 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %14)
%16 = load i1* %c
%17 = zext i1 %16 to i32
%18 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %17
%19 = load i8** %18
%20 = call i32 (i8*, ...)* @printf(i8* %19)
%21 = load i1* %d
%22 = zext i1 %21 to i32
%23 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %22
%24 = load i8** %23
%25 = call i32 (i8*, ...)* @printf(i8* %24)
%26 = load %.IntArray* %b2
%27 = add i32 0, 0
%28 = extractvalue %.IntArray %26, 1
%29 = getelementptr i32* %28, i32 %27
%30 = load i32* %29
%31 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %30)
%32 = load %.BoolArray* %d2
%33 = add i32 0, 0
%34 = extractvalue %.BoolArray %32, 1
%35 = getelementptr i1* %34, i32 %33
%36 = load i1* %35
%37 = zext i1 %36 to i32
%38 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %37
%39 = load i8** %38
%40 = call i32 (i8*, ...)* @printf(i8* %39)
%41 = load %.BoolArray* %d2
%42 = add i32 0, 1
%43 = extractvalue %.BoolArray %41, 1
%44 = getelementptr i1* %43, i32 %42
%45 = load i1* %44
%46 = zext i1 %45 to i32
%47 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %46
%48 = load i8** %47
%49 = call i32 (i8*, ...)* @printf(i8* %48)

br label %.return1
.return1:
%.return_final = load i32* %return
ret i32 %.return_final
}


define i32 @test1() {
%return = alloca i32, align 4
store i32 0, i32* %return

%1 = add i32 0, 1
store i32 %1, i32* %return
br label %.return2
.label1:

br label %.return2
.return2:
%.return_final = load i32* %return
ret i32 %.return_final
}


define i32 @test2(i32 %.a, i32 %.b) {
%return = alloca i32, align 4
store i32 0, i32* %return
%a = alloca i32, align 4
store i32 0, i32* %a
store i32 %.a, i32* %a
%b = alloca i32, align 4
store i32 0, i32* %b
store i32 %.b, i32* %b

%1 = load i32* %a
%2 = load i32* %b
%3 = add i32 %1, %2
store i32 %3, i32* %return
br label %.return3
.label2:

br label %.return3
.return3:
%.return_final = load i32* %return
ret i32 %.return_final
}


define i1 @test3() {
%return = alloca i1, align 4
store i1 0, i1* %return

%1 = add i1 0, 1
store i1 %1, i1* %return
br label %.return4
.label3:

br label %.return4
.return4:
%.return_final = load i1* %return
ret i1 %.return_final
}


define i1 @test4() {
%return = alloca i1, align 4
store i1 0, i1* %return

%1 = add i1 0, 0
store i1 %1, i1* %return
br label %.return5
.label4:

br label %.return5
.return5:
%.return_final = load i1* %return
ret i1 %.return_final
}


define %.IntArray @test5() {
%return = alloca %.IntArray, align 8
%.array.return = getelementptr inbounds %.IntArray* %return, i32 0, i32 0
store i32 0, i32* %.array.return, align 4
%..array.return = getelementptr inbounds %.IntArray* %return, i32 0, i32 1
store i32* null, i32** %..array.return, align 8

%1 = add i32 0, 2
%2 = alloca %.IntArray, align 8
%.array.2 = getelementptr inbounds %.IntArray* %2, i32 0, i32 0
store i32 0, i32* %.array.2, align 4
%..array.2 = getelementptr inbounds %.IntArray* %2, i32 0, i32 1
store i32* null, i32** %..array.2, align 8
%3 = getelementptr inbounds %.IntArray* %2, i32 0, i32 0
store i32 %1, i32* %3, align 4
%4 = call noalias i8* @calloc(i32 %1, i32 4) nounwind
%5 = bitcast i8* %4 to i32*
%6 = getelementptr inbounds %.IntArray* %2, i32 0, i32 1
store i32* %5, i32** %6, align 8
%7 = load %.IntArray* %2
store %.IntArray %7, %.IntArray* %return
br label %.return6
.label5:

br label %.return6
.return6:
%.return_final = load %.IntArray* %return
ret %.IntArray %.return_final
}


define %.IntArray @test6() {
%return = alloca %.IntArray, align 8
%.array.return = getelementptr inbounds %.IntArray* %return, i32 0, i32 0
store i32 0, i32* %.array.return, align 4
%..array.return = getelementptr inbounds %.IntArray* %return, i32 0, i32 1
store i32* null, i32** %..array.return, align 8
%b = alloca %.IntArray, align 8
%.array.b = getelementptr inbounds %.IntArray* %b, i32 0, i32 0
store i32 0, i32* %.array.b, align 4
%..array.b = getelementptr inbounds %.IntArray* %b, i32 0, i32 1
store i32* null, i32** %..array.b, align 8

%1 = add i32 0, 1
%2 = alloca %.IntArray, align 8
%.array.2 = getelementptr inbounds %.IntArray* %2, i32 0, i32 0
store i32 0, i32* %.array.2, align 4
%..array.2 = getelementptr inbounds %.IntArray* %2, i32 0, i32 1
store i32* null, i32** %..array.2, align 8
%3 = getelementptr inbounds %.IntArray* %2, i32 0, i32 0
store i32 %1, i32* %3, align 4
%4 = call noalias i8* @calloc(i32 %1, i32 4) nounwind
%5 = bitcast i8* %4 to i32*
%6 = getelementptr inbounds %.IntArray* %2, i32 0, i32 1
store i32* %5, i32** %6, align 8
%7 = load %.IntArray* %2
store %.IntArray %7, %.IntArray* %b
%8 = load %.IntArray* %b
%9 = add i32 0, 0
%10 = add i32 0, 127
%11 = extractvalue %.IntArray %8, 1
%12 = getelementptr i32* %11, i32 %9
store i32 %10, i32* %12
%13 = load %.IntArray* %b
store %.IntArray %13, %.IntArray* %return
br label %.return7
.label6:

br label %.return7
.return7:
%.return_final = load %.IntArray* %return
ret %.IntArray %.return_final
}


define %.BoolArray @test7() {
%return = alloca %.BoolArray, align 8
%.array.return = getelementptr inbounds %.BoolArray* %return, i32 0, i32 0
store i32 0, i32* %.array.return, align 4
%..array.return = getelementptr inbounds %.BoolArray* %return, i32 0, i32 1
store i1* null, i1** %..array.return, align 8

%1 = add i32 0, 0
%2 = alloca %.BoolArray, align 8
%.array.2 = getelementptr inbounds %.BoolArray* %2, i32 0, i32 0
store i32 0, i32* %.array.2, align 4
%..array.2 = getelementptr inbounds %.BoolArray* %2, i32 0, i32 1
store i1* null, i1** %..array.2, align 8
%3 = getelementptr inbounds %.BoolArray* %2, i32 0, i32 0
store i32 %1, i32* %3, align 4
%4 = call noalias i8* @calloc(i32 %1, i32 1) nounwind
%5 = bitcast i8* %4 to i1*
%6 = getelementptr inbounds %.BoolArray* %2, i32 0, i32 1
store i1* %5, i1** %6, align 8
%7 = load %.BoolArray* %2
store %.BoolArray %7, %.BoolArray* %return
br label %.return8
.label7:

br label %.return8
.return8:
%.return_final = load %.BoolArray* %return
ret %.BoolArray %.return_final
}


define %.BoolArray @test8() {
%return = alloca %.BoolArray, align 8
%.array.return = getelementptr inbounds %.BoolArray* %return, i32 0, i32 0
store i32 0, i32* %.array.return, align 4
%..array.return = getelementptr inbounds %.BoolArray* %return, i32 0, i32 1
store i1* null, i1** %..array.return, align 8
%a = alloca %.BoolArray, align 8
%.array.a = getelementptr inbounds %.BoolArray* %a, i32 0, i32 0
store i32 0, i32* %.array.a, align 4
%..array.a = getelementptr inbounds %.BoolArray* %a, i32 0, i32 1
store i1* null, i1** %..array.a, align 8

%1 = add i32 0, 7
%2 = alloca %.BoolArray, align 8
%.array.2 = getelementptr inbounds %.BoolArray* %2, i32 0, i32 0
store i32 0, i32* %.array.2, align 4
%..array.2 = getelementptr inbounds %.BoolArray* %2, i32 0, i32 1
store i1* null, i1** %..array.2, align 8
%3 = getelementptr inbounds %.BoolArray* %2, i32 0, i32 0
store i32 %1, i32* %3, align 4
%4 = call noalias i8* @calloc(i32 %1, i32 1) nounwind
%5 = bitcast i8* %4 to i1*
%6 = getelementptr inbounds %.BoolArray* %2, i32 0, i32 1
store i1* %5, i1** %6, align 8
%7 = load %.BoolArray* %2
store %.BoolArray %7, %.BoolArray* %a
%8 = load %.BoolArray* %a
%9 = add i32 0, 0
%10 = add i1 0, 0
%11 = extractvalue %.BoolArray %8, 1
%12 = getelementptr i1* %11, i32 %9
store i1 %10, i1* %12
%13 = load %.BoolArray* %a
%14 = add i32 0, 1
%15 = add i1 0, 1
%16 = extractvalue %.BoolArray %13, 1
%17 = getelementptr i1* %16, i32 %14
store i1 %15, i1* %17
%18 = load %.BoolArray* %a
store %.BoolArray %18, %.BoolArray* %return
br label %.return9
.label8:

br label %.return9
.return9:
%.return_final = load %.BoolArray* %return
ret %.BoolArray %.return_final
}


