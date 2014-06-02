%.IntArray = type { i32, i32* }
%.BoolArray = type { i32, i1* }
declare i32 @printf(i8*, ...)
declare i32 @atoi(i8*) nounwind readonly
declare noalias i8* @malloc(i32) nounwind
declare noalias i8* @calloc(i32, i32) nounwind@str.printf_callstr = private unnamed_addr constant [4 x i8] c"%d\0A\00"
@str.false_str = private unnamed_addr constant [7 x i8] c"false\0A\00"
@str.true_str = private unnamed_addr constant [7 x i8] c"true\0A\00\00"
@str.bools_array = global [2 x i8*] [i8* getelementptr inbounds ([7 x i8]* @str.false_str, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8]* @str.true_str, i32 0, i32 0)]


@a1 = global %.IntArray zeroinitializer, align 8
@a2 = global %.IntArray zeroinitializer, align 8
@b1 = global %.BoolArray zeroinitializer, align 8
@b2 = global %.BoolArray zeroinitializer, align 8


define i32 @main(i32 %args.length, i8** %args) {
%return = alloca i32, align 4
store i32 0, i32* %return

%1 = load %.IntArray* @a2
store %.IntArray %1, %.IntArray* @a1
%2 = load %.IntArray* @a1
store %.IntArray %2, %.IntArray* @a2
%3 = load %.BoolArray* @b2
store %.BoolArray %3, %.BoolArray* @b1
%4 = load %.BoolArray* @b1
store %.BoolArray %4, %.BoolArray* @b2

br label %.return1
.return1:
%.return_final = load i32* %return
ret i32 %.return_final
}


