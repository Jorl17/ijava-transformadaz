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
%e = alloca i32, align 4
store i32 0, i32* %e
%b = alloca %.IntArray, align 8
%.b = getelementptr inbounds %.IntArray* %b, i32 0, i32 0
store i32 0, i32* %.b, align 4
%..b = getelementptr inbounds %.IntArray* %b, i32 0, i32 1
store i32* null, i32** %..b, align 8
%c = alloca i1, align 4
store i1 0, i1* %c
%d = alloca %.BoolArray, align 8
%.d = getelementptr inbounds %.BoolArray* %d, i32 0, i32 0
store i32 0, i32* %.d, align 4
%..d = getelementptr inbounds %.BoolArray* %d, i32 0, i32 1
store i1* null, i1** %..d, align 8

%1 = add i32 0, 1
store i32 %1, i32* %a
%2 = add i32 0, 2
%3 = alloca %.IntArray, align 8
%.3 = getelementptr inbounds %.IntArray* %3, i32 0, i32 0
store i32 0, i32* %.3, align 4
%..3 = getelementptr inbounds %.IntArray* %3, i32 0, i32 1
store i32* null, i32** %..3, align 8
%4 = getelementptr inbounds %.IntArray* %3, i32 0, i32 0
store i32 %2, i32* %4, align 4
%5 = call noalias i8* @calloc(i32 %2, i32 4) nounwind
%6 = bitcast i8* %5 to i32*
%7 = getelementptr inbounds %.IntArray* %3, i32 0, i32 1
store i32* %6, i32** %7, align 8
%8 = load %.IntArray* %3
store %.IntArray %8, %.IntArray* %b
%9 = load %.IntArray* %b
%10 = add i32 0, 0
%11 = add i32 0, 1
%12 = sub i32 0, %11
%13 = extractvalue %.IntArray %9, 1
%14 = getelementptr i32* %13, i32 %10
store i32 %12, i32* %14
%15 = load %.IntArray* %b
%16 = add i32 0, 1
%17 = add i32 0, 1
%18 = extractvalue %.IntArray %15, 1
%19 = getelementptr i32* %18, i32 %16
store i32 %17, i32* %19
%20 = add i1 0, 1
store i1 %20, i1* %c
%21 = add i32 0, 2
%22 = alloca %.BoolArray, align 8
%.22 = getelementptr inbounds %.BoolArray* %22, i32 0, i32 0
store i32 0, i32* %.22, align 4
%..22 = getelementptr inbounds %.BoolArray* %22, i32 0, i32 1
store i1* null, i1** %..22, align 8
%23 = getelementptr inbounds %.BoolArray* %22, i32 0, i32 0
store i32 %21, i32* %23, align 4
%24 = call noalias i8* @calloc(i32 %21, i32 1) nounwind
%25 = bitcast i8* %24 to i1*
%26 = getelementptr inbounds %.BoolArray* %22, i32 0, i32 1
store i1* %25, i1** %26, align 8
%27 = load %.BoolArray* %22
store %.BoolArray %27, %.BoolArray* %d
%28 = load %.BoolArray* %d
%29 = add i32 0, 0
%30 = add i1 0, 0
%31 = extractvalue %.BoolArray %28, 1
%32 = getelementptr i1* %31, i32 %29
store i1 %30, i1* %32
%33 = load %.BoolArray* %d
%34 = add i32 0, 1
%35 = add i1 0, 1
%36 = extractvalue %.BoolArray %33, 1
%37 = getelementptr i1* %36, i32 %34
store i1 %35, i1* %37
%38 = load i32* %a
%39 = load %.IntArray* %b
%40 = load i1* %c
%41 = load %.BoolArray* %d
%42 = call i32 (i32, %.IntArray, i1, %.BoolArray)* @test1(i32 %38, %.IntArray %39, i1 %40, %.BoolArray %41)
store i32 %42, i32* %e

br label %.return1
.return1:
%.return_final = load i32* %return
ret i32 %.return_final
}


define i32 @test1(i32 %.a, %.IntArray %.b, i1 %.c, %.BoolArray %.d) {
%return = alloca i32, align 4
store i32 0, i32* %return
%a = alloca i32, align 4
store i32 0, i32* %a
store i32 %.a, i32* %a
%b = alloca %.IntArray, align 8
%.b = getelementptr inbounds %.IntArray* %b, i32 0, i32 0
store i32 0, i32* %.b, align 4
%..b = getelementptr inbounds %.IntArray* %b, i32 0, i32 1
store i32* null, i32** %..b, align 8
store %.IntArray %.b, %.IntArray* %b
%c = alloca i1, align 4
store i1 0, i1* %c
store i1 %.c, i1* %c
%d = alloca %.BoolArray, align 8
%.d = getelementptr inbounds %.BoolArray* %d, i32 0, i32 0
store i32 0, i32* %.d, align 4
%..d = getelementptr inbounds %.BoolArray* %d, i32 0, i32 1
store i1* null, i1** %..d, align 8
store %.BoolArray %.d, %.BoolArray* %d

%1 = load i32* %a
%2 = sub i32 0, %1
store i32 %2, i32* %a
%3 = add i32 0, 2
%4 = alloca %.IntArray, align 8
%.4 = getelementptr inbounds %.IntArray* %4, i32 0, i32 0
store i32 0, i32* %.4, align 4
%..4 = getelementptr inbounds %.IntArray* %4, i32 0, i32 1
store i32* null, i32** %..4, align 8
%5 = getelementptr inbounds %.IntArray* %4, i32 0, i32 0
store i32 %3, i32* %5, align 4
%6 = call noalias i8* @calloc(i32 %3, i32 4) nounwind
%7 = bitcast i8* %6 to i32*
%8 = getelementptr inbounds %.IntArray* %4, i32 0, i32 1
store i32* %7, i32** %8, align 8
%9 = load %.IntArray* %4
store %.IntArray %9, %.IntArray* %b
%10 = load i1* %c
%11 = xor i1 true, %10
store i1 %11, i1* %c
%12 = add i32 0, 2
%13 = alloca %.BoolArray, align 8
%.13 = getelementptr inbounds %.BoolArray* %13, i32 0, i32 0
store i32 0, i32* %.13, align 4
%..13 = getelementptr inbounds %.BoolArray* %13, i32 0, i32 1
store i1* null, i1** %..13, align 8
%14 = getelementptr inbounds %.BoolArray* %13, i32 0, i32 0
store i32 %12, i32* %14, align 4
%15 = call noalias i8* @calloc(i32 %12, i32 1) nounwind
%16 = bitcast i8* %15 to i1*
%17 = getelementptr inbounds %.BoolArray* %13, i32 0, i32 1
store i1* %16, i1** %17, align 8
%18 = load %.BoolArray* %13
store %.BoolArray %18, %.BoolArray* %d
%19 = add i32 0, 0
store i32 %19, i32* %return
br label %.return2
.label1:

br label %.return2
.return2:
%.return_final = load i32* %return
ret i32 %.return_final
}


