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
br label %.label1
.label1:
%2 = alloca i1, align 4
store i1 0, i1* %2
%3 = load i32* %a
%4 = sub i32 %args.length, 1
%5 = icmp slt i32 %3, %4
store i1 %5, i1* %2
%6 = load i1* %2
br i1 %6, label %.label2, label %.label3
.label2:
%7 = load i32* %a
%8 = add i32 %7, 1
%9= getelementptr inbounds i8** %args, i32 %8
%10 = load i8** %9
%11 = call i32 @atoi(i8* %10) nounwind readonly
%12 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %11)
%13 = load i32* %a
%14 = add i32 0, 1
%15 = add i32 %13, %14
store i32 %15, i32* %a
br label %.label1
.label3:
%16 = add i32 0, 4
%17 = alloca %.IntArray, align 8
%.17 = getelementptr inbounds %.IntArray* %17, i32 0, i32 0
store i32 0, i32* %.17, align 4
%..17 = getelementptr inbounds %.IntArray* %17, i32 0, i32 1
store i32* null, i32** %..17, align 8
%18 = getelementptr inbounds %.IntArray* %17, i32 0, i32 0
store i32 %16, i32* %18, align 4
%19 = call noalias i8* @calloc(i32 %16, i32 4) nounwind
%20 = bitcast i8* %19 to i32*
%21 = getelementptr inbounds %.IntArray* %17, i32 0, i32 1
store i32* %20, i32** %21, align 8
%22 = load %.IntArray* %17
store %.IntArray %22, %.IntArray* @f
%23 = load %.IntArray* @f
%24 = add i32 0, 3
%25 = add i32 0, 3
%26 = extractvalue %.IntArray %23, 1
%27 = getelementptr i32* %26, i32 %24
store i32 %25, i32* %27
%28 = call %.IntArray ()* @banana()
store %.IntArray %28, %.IntArray* @g
%29 = load %.IntArray* @f
%30 = add i32 0, 0
%31 = load %.IntArray* @g
%32 = add i32 0, 2
%33 = extractvalue %.IntArray %31, 1
%34 = getelementptr i32* %33, i32 %32
%35 = load i32* %34
%36 = extractvalue %.IntArray %29, 1
%37 = getelementptr i32* %36, i32 %30
store i32 %35, i32* %37

br label %.return1
.return1:
%.return_final = load i32* %return
ret i32 %.return_final
}


define %.IntArray @banana() {
%return = alloca %.IntArray, align 8
%.return = getelementptr inbounds %.IntArray* %return, i32 0, i32 0
store i32 0, i32* %.return, align 4
%..return = getelementptr inbounds %.IntArray* %return, i32 0, i32 1
store i32* null, i32** %..return, align 8
%f2 = alloca %.IntArray, align 8
%.f2 = getelementptr inbounds %.IntArray* %f2, i32 0, i32 0
store i32 0, i32* %.f2, align 4
%..f2 = getelementptr inbounds %.IntArray* %f2, i32 0, i32 1
store i32* null, i32** %..f2, align 8

%1 = add i32 0, 4
%2 = alloca %.IntArray, align 8
%.2 = getelementptr inbounds %.IntArray* %2, i32 0, i32 0
store i32 0, i32* %.2, align 4
%..2 = getelementptr inbounds %.IntArray* %2, i32 0, i32 1
store i32* null, i32** %..2, align 8
%3 = getelementptr inbounds %.IntArray* %2, i32 0, i32 0
store i32 %1, i32* %3, align 4
%4 = call noalias i8* @calloc(i32 %1, i32 4) nounwind
%5 = bitcast i8* %4 to i32*
%6 = getelementptr inbounds %.IntArray* %2, i32 0, i32 1
store i32* %5, i32** %6, align 8
%7 = load %.IntArray* %2
store %.IntArray %7, %.IntArray* %f2
%8 = load %.IntArray* %f2
%9 = add i32 0, 3
%10 = add i32 0, 3
%11 = extractvalue %.IntArray %8, 1
%12 = getelementptr i32* %11, i32 %9
store i32 %10, i32* %12
%13 = load %.IntArray* %f2
store %.IntArray %13, %.IntArray* %return
br label %.return2
.label4:

br label %.return2
.return2:
%.return_final = load %.IntArray* %return
ret %.IntArray %.return_final
}


