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
@d = global i32 0, align 4
@e = global i1 0, align 4
@f = global i1 0, align 4
@g = global i1 0, align 4
@h = global i1 0, align 4
@i = global i1 0, align 4
@j = global %.IntArray zeroinitializer, align 8
@k = global %.IntArray zeroinitializer, align 8
@l = global %.IntArray zeroinitializer, align 8
@m = global %.IntArray zeroinitializer, align 8
@n = global %.BoolArray zeroinitializer, align 8
@o = global %.BoolArray zeroinitializer, align 8
@p = global %.BoolArray zeroinitializer, align 8
@q = global %.BoolArray zeroinitializer, align 8


define i32 @main(i32 %args.length, i8** %args) {
%return = alloca i32, align 4
store i32 0, i32* %return


br label %.return1
.return1:
%.return_final = load i32* %return
ret i32 %.return_final
}


