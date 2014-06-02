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
@d = global i1 0, align 4
@e = global i1 0, align 4
@f = global %.IntArray zeroinitializer, align 8
@g = global %.IntArray zeroinitializer, align 8
@h = global %.BoolArray zeroinitializer, align 8
@i = global %.BoolArray zeroinitializer, align 8
@j = global %.BoolArray zeroinitializer, align 8


define i32 @main(i32 %args.length, i8** %args) {
%return = alloca i32, align 4
store i32 0, i32* %return
%a = alloca i32, align 4
store i32 0, i32* %a

%1 = add i32 0, 0
store i32 %1, i32* %a
%2 = add i32 0, 9
%3 = alloca %.BoolArray, align 8
%.array.3 = getelementptr inbounds %.BoolArray* %3, i32 0, i32 0
store i32 0, i32* %.array.3, align 4
%..array.3 = getelementptr inbounds %.BoolArray* %3, i32 0, i32 1
store i1* null, i1** %..array.3, align 8
%4 = getelementptr inbounds %.BoolArray* %3, i32 0, i32 0
store i32 %2, i32* %4, align 4
%5 = call noalias i8* @calloc(i32 %2, i32 1) nounwind
%6 = bitcast i8* %5 to i1*
%7 = getelementptr inbounds %.BoolArray* %3, i32 0, i32 1
store i1* %6, i1** %7, align 8
%8 = load %.BoolArray* %3
store %.BoolArray %8, %.BoolArray* @h
%9 = add i32 0, 3
%10 = alloca %.IntArray, align 8
%.array.10 = getelementptr inbounds %.IntArray* %10, i32 0, i32 0
store i32 0, i32* %.array.10, align 4
%..array.10 = getelementptr inbounds %.IntArray* %10, i32 0, i32 1
store i32* null, i32** %..array.10, align 8
%11 = getelementptr inbounds %.IntArray* %10, i32 0, i32 0
store i32 %9, i32* %11, align 4
%12 = call noalias i8* @calloc(i32 %9, i32 4) nounwind
%13 = bitcast i8* %12 to i32*
%14 = getelementptr inbounds %.IntArray* %10, i32 0, i32 1
store i32* %13, i32** %14, align 8
%15 = load %.IntArray* %10
store %.IntArray %15, %.IntArray* @g
br label %.label1
.label1:
%16 = alloca i1, align 4
store i1 0, i1* %16
%17 = load i32* %a
%18 = sub i32 %args.length, 1
%19 = icmp slt i32 %17, %18
store i1 %19, i1* %16
%20 = load i1* %16
br i1 %20, label %.label2, label %.label3
.label2:
%21 = load i32* %a
%22 = add i32 %21, 1
%23= getelementptr inbounds i8** %args, i32 %22
%24 = load i8** %23
%25 = call i32 @atoi(i8* %24) nounwind readonly
%26 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %25)
%27 = load i32* %a
%28 = add i32 0, 1
%29 = add i32 %27, %28
store i32 %29, i32* %a
br label %.label1
.label3:
%30 = load %.IntArray* @g
%31 = load %.IntArray* @g
%32 = load %.IntArray* @g
%33 = add i32 0, 2
%34 = extractvalue %.IntArray %32, 1
%35 = getelementptr i32* %34, i32 %33
%36 = load i32* %35
%37 = extractvalue %.IntArray %31, 1
%38 = getelementptr i32* %37, i32 %36
%39 = load i32* %38
%40 = add i32 0, 2
%41 = extractvalue %.IntArray %30, 1
%42 = getelementptr i32* %41, i32 %39
store i32 %40, i32* %42
%43 = add i32 0, 4
%44 = alloca %.IntArray, align 8
%.array.44 = getelementptr inbounds %.IntArray* %44, i32 0, i32 0
store i32 0, i32* %.array.44, align 4
%..array.44 = getelementptr inbounds %.IntArray* %44, i32 0, i32 1
store i32* null, i32** %..array.44, align 8
%45 = getelementptr inbounds %.IntArray* %44, i32 0, i32 0
store i32 %43, i32* %45, align 4
%46 = call noalias i8* @calloc(i32 %43, i32 4) nounwind
%47 = bitcast i8* %46 to i32*
%48 = getelementptr inbounds %.IntArray* %44, i32 0, i32 1
store i32* %47, i32** %48, align 8
%49 = load %.IntArray* %44
store %.IntArray %49, %.IntArray* @f
%50 = load %.IntArray* @f
%51 = add i32 0, 3
%52 = add i32 0, 3
%53 = extractvalue %.IntArray %50, 1
%54 = getelementptr i32* %53, i32 %51
store i32 %52, i32* %54
%55 = load %.IntArray* @f
%56 = add i32 0, 1
%57 = extractvalue %.IntArray %55, 1
%58 = getelementptr i32* %57, i32 %56
%59 = load i32* %58
store i32 %59, i32* %a
%60 = add i32 0, 3
%61 = call %.IntArray (i32)* @banana(i32 %60)
store %.IntArray %61, %.IntArray* @g
%62 = load %.IntArray* @f
%63 = add i32 0, 0
%64 = load %.IntArray* @g
%65 = add i32 0, 2
%66 = extractvalue %.IntArray %64, 1
%67 = getelementptr i32* %66, i32 %65
%68 = load i32* %67
%69 = extractvalue %.IntArray %62, 1
%70 = getelementptr i32* %69, i32 %63
store i32 %68, i32* %70
br label %.return1
.label4:

br label %.return1
.return1:
%.return_final = load i32* %return
ret i32 %.return_final
}


define %.IntArray @banana(i32 %.a) {
%return = alloca %.IntArray, align 8
%.array.return = getelementptr inbounds %.IntArray* %return, i32 0, i32 0
store i32 0, i32* %.array.return, align 4
%..array.return = getelementptr inbounds %.IntArray* %return, i32 0, i32 1
store i32* null, i32** %..array.return, align 8
%a = alloca i32, align 4
store i32 0, i32* %a
store i32 %.a, i32* %a
%f2 = alloca %.IntArray, align 8
%.array.f2 = getelementptr inbounds %.IntArray* %f2, i32 0, i32 0
store i32 0, i32* %.array.f2, align 4
%..array.f2 = getelementptr inbounds %.IntArray* %f2, i32 0, i32 1
store i32* null, i32** %..array.f2, align 8
%i = alloca i32, align 4
store i32 0, i32* %i

%1 = load i32* %a
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
store %.IntArray %7, %.IntArray* %f2
%8 = alloca i1, align 4
store i1 0, i1* %8
%9 = load i32* %a
%10 = add i32 0, 7
%11 = icmp sgt i32 %9, %10
store i1 %11, i1* %8
%12 = load i1* %8
br i1 %12, label %.label5, label %.label6
.label5:
%13 = load %.BoolArray* @h
%14 = add i32 0, 8
%15 = add i1 0, 1
%16 = extractvalue %.BoolArray %13, 1
%17 = getelementptr i1* %16, i32 %14
store i1 %15, i1* %17
%18 = load %.IntArray* %f2
%19 = add i32 0, 3
%20 = add i32 0, 3
%21 = extractvalue %.IntArray %18, 1
%22 = getelementptr i32* %21, i32 %19
store i32 %20, i32* %22
br label %.label7
.label6:
%23 = load %.BoolArray* @h
%24 = add i32 0, 0
%25 = add i1 0, 0
%26 = extractvalue %.BoolArray %23, 1
%27 = getelementptr i1* %26, i32 %24
store i1 %25, i1* %27
%28 = add i32 0, 0
store i32 %28, i32* %i
br label %.label8
.label8:
%29 = alloca i1, align 4
store i1 0, i1* %29
%30 = load i32* %i
%31 = add i32 0, 9
%32 = icmp slt i32 %30, %31
store i1 %32, i1* %29
%33 = load i1* %29
br i1 %33, label %.label9, label %.label10
.label9:
%34 = alloca i1, align 4
store i1 0, i1* %34
%35 = load i32* %a
%36 = add i32 0, 2
%37 = srem i32 %35, %36
%38 = add i32 0, 0
%39 = icmp eq i32 %37, %38
store i1 %39, i1* %34
%40 = load i1* %34
br i1 %40, label %.label11, label %.label12
.label11:
%41 = load %.IntArray* %f2
%42 = load i32* %i
%43 = load i32* %a
%44 = add i32 0, 2
%45 = mul i32 %43, %44
%46 = load i32* %i
%47 = add i32 0, 7
%48 = mul i32 %46, %47
%49 = add i32 %45, %48
%50 = extractvalue %.IntArray %41, 1
%51 = getelementptr i32* %50, i32 %42
store i32 %49, i32* %51
br label %.label13
.label12:
br label %.label13
.label13:
%52 = load %.BoolArray* @h
%53 = load i32* %i
%54 = add i1 0, 1
%55 = extractvalue %.BoolArray %52, 1
%56 = getelementptr i1* %55, i32 %53
store i1 %54, i1* %56
%57 = load i32* %i
%58 = add i32 0, 1
%59 = add i32 %57, %58
store i32 %59, i32* %i
br label %.label8
.label10:
br label %.label7
.label7:
%60 = load %.IntArray* %f2
store %.IntArray %60, %.IntArray* %return
br label %.return2
.label14:

br label %.return2
.return2:
%.return_final = load %.IntArray* %return
ret %.IntArray %.return_final
}


