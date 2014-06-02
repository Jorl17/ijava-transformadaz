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
%c = alloca i32, align 4
store i32 0, i32* %c
%d = alloca i32, align 4
store i32 0, i32* %d
%e = alloca i1, align 4
store i1 0, i1* %e
%f = alloca i1, align 4
store i1 0, i1* %f
%g = alloca i1, align 4
store i1 0, i1* %g
%h = alloca i1, align 4
store i1 0, i1* %h
%i = alloca i1, align 4
store i1 0, i1* %i
%j = alloca %.IntArray, align 8
%.j = getelementptr inbounds %.IntArray* %j, i32 0, i32 0
store i32 0, i32* %.j, align 4
%..j = getelementptr inbounds %.IntArray* %j, i32 0, i32 1
store i32* null, i32** %..j, align 8
%k = alloca %.IntArray, align 8
%.k = getelementptr inbounds %.IntArray* %k, i32 0, i32 0
store i32 0, i32* %.k, align 4
%..k = getelementptr inbounds %.IntArray* %k, i32 0, i32 1
store i32* null, i32** %..k, align 8
%l = alloca %.IntArray, align 8
%.l = getelementptr inbounds %.IntArray* %l, i32 0, i32 0
store i32 0, i32* %.l, align 4
%..l = getelementptr inbounds %.IntArray* %l, i32 0, i32 1
store i32* null, i32** %..l, align 8
%m = alloca %.IntArray, align 8
%.m = getelementptr inbounds %.IntArray* %m, i32 0, i32 0
store i32 0, i32* %.m, align 4
%..m = getelementptr inbounds %.IntArray* %m, i32 0, i32 1
store i32* null, i32** %..m, align 8
%n = alloca %.BoolArray, align 8
%.n = getelementptr inbounds %.BoolArray* %n, i32 0, i32 0
store i32 0, i32* %.n, align 4
%..n = getelementptr inbounds %.BoolArray* %n, i32 0, i32 1
store i1* null, i1** %..n, align 8
%o = alloca %.BoolArray, align 8
%.o = getelementptr inbounds %.BoolArray* %o, i32 0, i32 0
store i32 0, i32* %.o, align 4
%..o = getelementptr inbounds %.BoolArray* %o, i32 0, i32 1
store i1* null, i1** %..o, align 8
%p = alloca %.BoolArray, align 8
%.p = getelementptr inbounds %.BoolArray* %p, i32 0, i32 0
store i32 0, i32* %.p, align 4
%..p = getelementptr inbounds %.BoolArray* %p, i32 0, i32 1
store i1* null, i1** %..p, align 8
%q = alloca %.BoolArray, align 8
%.q = getelementptr inbounds %.BoolArray* %q, i32 0, i32 0
store i32 0, i32* %.q, align 4
%..q = getelementptr inbounds %.BoolArray* %q, i32 0, i32 1
store i1* null, i1** %..q, align 8


br label %.return1
.return1:
%.return_final = load i32* %return
ret i32 %.return_final
}


