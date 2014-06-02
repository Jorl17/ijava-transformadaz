%.IntArray = type { i32, i32* }
%.BoolArray = type { i32, i1* }
declare i32 @printf(i8*, ...)
declare i32 @atoi(i8*) nounwind readonly
declare noalias i8* @malloc(i32) nounwind
declare noalias i8* @calloc(i32, i32) nounwind@str.printf_callstr = private unnamed_addr constant [4 x i8] c"%d\0A\00"
@str.false_str = private unnamed_addr constant [7 x i8] c"false\0A\00"
@str.true_str = private unnamed_addr constant [7 x i8] c"true\0A\00\00"
@str.bools_array = global [2 x i8*] [i8* getelementptr inbounds ([7 x i8]* @str.false_str, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8]* @str.true_str, i32 0, i32 0)]


@isNegative = global %.BoolArray zeroinitializer, align 8


define i32 @main(i32 %args.length, i8** %args) {
%return = alloca i32, align 4
store i32 0, i32* %return
%i = alloca i32, align 4
store i32 0, i32* %i
%sum = alloca i32, align 4
store i32 0, i32* %sum
%fib = alloca i32, align 4
store i32 0, i32* %fib
%parsedArgs = alloca %.IntArray, align 8
%.parsedArgs = getelementptr inbounds %.IntArray* %parsedArgs, i32 0, i32 0
store i32 0, i32* %.parsedArgs, align 4
%..parsedArgs = getelementptr inbounds %.IntArray* %parsedArgs, i32 0, i32 1
store i32* null, i32** %..parsedArgs, align 8
%aux = alloca %.IntArray, align 8
%.aux = getelementptr inbounds %.IntArray* %aux, i32 0, i32 0
store i32 0, i32* %.aux, align 4
%..aux = getelementptr inbounds %.IntArray* %aux, i32 0, i32 1
store i32* null, i32** %..aux, align 8

%1 = add i32 0, 0
store i32 %1, i32* %i
%2 = sub i32 %args.length, 1
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
store %.IntArray %8, %.IntArray* %parsedArgs
br label %.label1
.label1:
%9 = alloca i1, align 4
store i1 0, i1* %9
%10 = load i32* %i
%11 = sub i32 %args.length, 1
%12 = icmp slt i32 %10, %11
store i1 %12, i1* %9
%13 = load i1* %9
br i1 %13, label %.label2, label %.label3
.label2:
%14 = load %.IntArray* %parsedArgs
%15 = load i32* %i
%16 = load i32* %i
%17 = add i32 %16, 1
%18= getelementptr inbounds i8** %args, i32 %17
%19 = load i8** %18
%20 = call i32 @atoi(i8* %19) nounwind readonly
%21 = extractvalue %.IntArray %14, 1
%22 = getelementptr i32* %21, i32 %15
store i32 %20, i32* %22
%23 = load i32* %i
%24 = add i32 0, 1
%25 = add i32 %23, %24
store i32 %25, i32* %i
br label %.label1
.label3:
%26 = load %.IntArray* %parsedArgs
%27 = call %.IntArray (%.IntArray)* @change(%.IntArray %26)
store %.IntArray %27, %.IntArray* %aux
%28 = load %.IntArray* %aux
%29 = call i32 (%.IntArray)* %sum(%.IntArray %28)
store i32 %29, i32* %sum
%30 = load i32* %sum
%31 = call i32 (i32)* @fibonacci(i32 %30)
store i32 %31, i32* %fib
%32 = load i32* %fib
%33 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %32)

br label %.return1
.return1:
%.return_final = load i32* %return
ret i32 %.return_final
}


define %.IntArray @change(%.IntArray %.array) {
%return = alloca %.IntArray, align 8
%.return = getelementptr inbounds %.IntArray* %return, i32 0, i32 0
store i32 0, i32* %.return, align 4
%..return = getelementptr inbounds %.IntArray* %return, i32 0, i32 1
store i32* null, i32** %..return, align 8
%array = alloca %.IntArray, align 8
%.array = getelementptr inbounds %.IntArray* %array, i32 0, i32 0
store i32 0, i32* %.array, align 4
%..array = getelementptr inbounds %.IntArray* %array, i32 0, i32 1
store i32* null, i32** %..array, align 8
store %.IntArray %.array, %.IntArray* %array
%i = alloca i32, align 4
store i32 0, i32* %i

%1 = add i32 0, 0
store i32 %1, i32* %i
%2 = load %.IntArray* %array
%3 = extractvalue %.IntArray %2, 0
%4 = alloca %.BoolArray, align 8
%.4 = getelementptr inbounds %.BoolArray* %4, i32 0, i32 0
store i32 0, i32* %.4, align 4
%..4 = getelementptr inbounds %.BoolArray* %4, i32 0, i32 1
store i1* null, i1** %..4, align 8
%5 = getelementptr inbounds %.BoolArray* %4, i32 0, i32 0
store i32 %3, i32* %5, align 4
%6 = call noalias i8* @calloc(i32 %3, i32 1) nounwind
%7 = bitcast i8* %6 to i1*
%8 = getelementptr inbounds %.BoolArray* %4, i32 0, i32 1
store i1* %7, i1** %8, align 8
%9 = load %.BoolArray* %4
store %.BoolArray %9, %.BoolArray* @isNegative
br label %.label4
.label4:
%10 = alloca i1, align 4
store i1 0, i1* %10
%11 = load i32* %i
%12 = load %.IntArray* %array
%13 = extractvalue %.IntArray %12, 0
%14 = icmp slt i32 %11, %13
store i1 %14, i1* %10
%15 = load i1* %10
br i1 %15, label %.label5, label %.label6
.label5:
%16 = alloca i1, align 4
store i1 0, i1* %16
%17 = load %.IntArray* %array
%18 = load i32* %i
%19 = extractvalue %.IntArray %17, 1
%20 = getelementptr i32* %19, i32 %18
%21 = load i32* %20
%22 = add i32 0, 0
%23 = icmp slt i32 %21, %22
store i1 %23, i1* %16
%24 = load i1* %16
br i1 %24, label %.label7, label %.label8
.label7:
%25 = load %.BoolArray* @isNegative
%26 = load i32* %i
%27 = add i1 0, 1
%28 = extractvalue %.BoolArray %25, 1
%29 = getelementptr i1* %28, i32 %26
store i1 %27, i1* %29
%30 = load %.IntArray* %array
%31 = load i32* %i
%32 = load %.IntArray* %array
%33 = load i32* %i
%34 = extractvalue %.IntArray %32, 1
%35 = getelementptr i32* %34, i32 %33
%36 = load i32* %35
%37 = add i32 0, 1
%38 = add i32 %36, %37
%39 = extractvalue %.IntArray %30, 1
%40 = getelementptr i32* %39, i32 %31
store i32 %38, i32* %40
br label %.label9
.label8:
%41 = alloca i1, align 4
store i1 0, i1* %41
%42 = load %.IntArray* %array
%43 = load i32* %i
%44 = extractvalue %.IntArray %42, 1
%45 = getelementptr i32* %44, i32 %43
%46 = load i32* %45
%47 = add i32 0, 0
%48 = icmp sgt i32 %46, %47
store i1 %48, i1* %41
%49 = load i1* %41
br i1 %49, label %.label10, label %.label11
.label10:
%50 = load %.BoolArray* @isNegative
%51 = load i32* %i
%52 = add i1 0, 0
%53 = extractvalue %.BoolArray %50, 1
%54 = getelementptr i1* %53, i32 %51
store i1 %52, i1* %54
%55 = load %.IntArray* %array
%56 = load i32* %i
%57 = load %.IntArray* %array
%58 = load i32* %i
%59 = extractvalue %.IntArray %57, 1
%60 = getelementptr i32* %59, i32 %58
%61 = load i32* %60
%62 = add i32 0, 1
%63 = sub i32 %61, %62
%64 = extractvalue %.IntArray %55, 1
%65 = getelementptr i32* %64, i32 %56
store i32 %63, i32* %65
br label %.label12
.label11:
br label %.label12
.label12:
br label %.label9
.label9:
%66 = load i32* %i
%67 = add i32 0, 1
%68 = add i32 %66, %67
store i32 %68, i32* %i
br label %.label4
.label6:
%69 = load %.IntArray* %array
store %.IntArray %69, %.IntArray* %return
br label %.return2
.label13:

br label %.return2
.return2:
%.return_final = load %.IntArray* %return
ret %.IntArray %.return_final
}


define i32 @sum(%.IntArray %.array) {
%return = alloca i32, align 4
store i32 0, i32* %return
%array = alloca %.IntArray, align 8
%.array = getelementptr inbounds %.IntArray* %array, i32 0, i32 0
store i32 0, i32* %.array, align 4
%..array = getelementptr inbounds %.IntArray* %array, i32 0, i32 1
store i32* null, i32** %..array, align 8
store %.IntArray %.array, %.IntArray* %array
%i = alloca i32, align 4
store i32 0, i32* %i
%sum = alloca i32, align 4
store i32 0, i32* %sum

%1 = add i32 0, 0
store i32 %1, i32* %i
%2 = add i32 0, 0
store i32 %2, i32* %sum
br label %.label14
.label14:
%3 = alloca i1, align 4
store i1 0, i1* %3
%4 = load i32* %i
%5 = load %.IntArray* %array
%6 = extractvalue %.IntArray %5, 0
%7 = icmp slt i32 %4, %6
store i1 %7, i1* %3
%8 = load i1* %3
br i1 %8, label %.label15, label %.label16
.label15:
%9 = load i32* %sum
%10 = load %.IntArray* %array
%11 = load i32* %i
%12 = extractvalue %.IntArray %10, 1
%13 = getelementptr i32* %12, i32 %11
%14 = load i32* %13
%15 = add i32 %9, %14
store i32 %15, i32* %sum
%16 = load i32* %i
%17 = add i32 0, 1
%18 = add i32 %16, %17
store i32 %18, i32* %i
br label %.label14
.label16:
%19 = load i32* %sum
store i32 %19, i32* %return
br label %.return3
.label17:

br label %.return3
.return3:
%.return_final = load i32* %return
ret i32 %.return_final
}


define i32 @fibonacci(i32 %.n) {
%return = alloca i32, align 4
store i32 0, i32* %return
%n = alloca i32, align 4
store i32 0, i32* %n
store i32 %.n, i32* %n

%1 = alloca i1, align 4
store i1 0, i1* %1
%2 = load i32* %n
%3 = add i32 0, 1
%4 = icmp sle i32 %2, %3
store i1 %4, i1* %1
%5 = load i1* %1
br i1 %5, label %.label18, label %.label19
.label18:
%6 = add i32 0, 1
store i32 %6, i32* %return
br label %.return4
.label21:
br label %.label20
.label19:
%7 = load i32* %n
%8 = add i32 0, 1
%9 = sub i32 %7, %8
%10 = call i32 (i32)* @fibonacci(i32 %9)
%11 = load i32* %n
%12 = add i32 0, 2
%13 = sub i32 %11, %12
%14 = call i32 (i32)* @fibonacci(i32 %13)
%15 = add i32 %10, %14
store i32 %15, i32* %return
br label %.return4
.label22:
br label %.label20
.label20:

br label %.return4
.return4:
%.return_final = load i32* %return
ret i32 %.return_final
}


