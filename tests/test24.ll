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
%a1 = alloca %.IntArray, align 8
%.array.a1 = getelementptr inbounds %.IntArray* %a1, i32 0, i32 0
store i32 0, i32* %.array.a1, align 4
%..array.a1 = getelementptr inbounds %.IntArray* %a1, i32 0, i32 1
store i32* null, i32** %..array.a1, align 8
%a2 = alloca %.IntArray, align 8
%.array.a2 = getelementptr inbounds %.IntArray* %a2, i32 0, i32 0
store i32 0, i32* %.array.a2, align 4
%..array.a2 = getelementptr inbounds %.IntArray* %a2, i32 0, i32 1
store i32* null, i32** %..array.a2, align 8
%b1 = alloca %.BoolArray, align 8
%.array.b1 = getelementptr inbounds %.BoolArray* %b1, i32 0, i32 0
store i32 0, i32* %.array.b1, align 4
%..array.b1 = getelementptr inbounds %.BoolArray* %b1, i32 0, i32 1
store i1* null, i1** %..array.b1, align 8
%b2 = alloca %.BoolArray, align 8
%.array.b2 = getelementptr inbounds %.BoolArray* %b2, i32 0, i32 0
store i32 0, i32* %.array.b2, align 4
%..array.b2 = getelementptr inbounds %.BoolArray* %b2, i32 0, i32 1
store i1* null, i1** %..array.b2, align 8

%1 = add i32 0, 3
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
store %.IntArray %7, %.IntArray* %a1
%8 = add i32 0, 0
%9 = alloca %.IntArray, align 8
%.array.9 = getelementptr inbounds %.IntArray* %9, i32 0, i32 0
store i32 0, i32* %.array.9, align 4
%..array.9 = getelementptr inbounds %.IntArray* %9, i32 0, i32 1
store i32* null, i32** %..array.9, align 8
%10 = getelementptr inbounds %.IntArray* %9, i32 0, i32 0
store i32 %8, i32* %10, align 4
%11 = call noalias i8* @calloc(i32 %8, i32 4) nounwind
%12 = bitcast i8* %11 to i32*
%13 = getelementptr inbounds %.IntArray* %9, i32 0, i32 1
store i32* %12, i32** %13, align 8
%14 = load %.IntArray* %9
store %.IntArray %14, %.IntArray* %a2
%15 = add i32 0, 4
%16 = alloca %.BoolArray, align 8
%.array.16 = getelementptr inbounds %.BoolArray* %16, i32 0, i32 0
store i32 0, i32* %.array.16, align 4
%..array.16 = getelementptr inbounds %.BoolArray* %16, i32 0, i32 1
store i1* null, i1** %..array.16, align 8
%17 = getelementptr inbounds %.BoolArray* %16, i32 0, i32 0
store i32 %15, i32* %17, align 4
%18 = call noalias i8* @calloc(i32 %15, i32 1) nounwind
%19 = bitcast i8* %18 to i1*
%20 = getelementptr inbounds %.BoolArray* %16, i32 0, i32 1
store i1* %19, i1** %20, align 8
%21 = load %.BoolArray* %16
store %.BoolArray %21, %.BoolArray* %b1
%22 = add i32 0, 0
%23 = alloca %.BoolArray, align 8
%.array.23 = getelementptr inbounds %.BoolArray* %23, i32 0, i32 0
store i32 0, i32* %.array.23, align 4
%..array.23 = getelementptr inbounds %.BoolArray* %23, i32 0, i32 1
store i1* null, i1** %..array.23, align 8
%24 = getelementptr inbounds %.BoolArray* %23, i32 0, i32 0
store i32 %22, i32* %24, align 4
%25 = call noalias i8* @calloc(i32 %22, i32 1) nounwind
%26 = bitcast i8* %25 to i1*
%27 = getelementptr inbounds %.BoolArray* %23, i32 0, i32 1
store i1* %26, i1** %27, align 8
%28 = load %.BoolArray* %23
store %.BoolArray %28, %.BoolArray* %b2

br label %.return1
.return1:
%.return_final = load i32* %return
ret i32 %.return_final
}


