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

%1 = sub i32 %args.length, 1
store i32 %1, i32* %a
%2 = load i32* %a
%3 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %2)

br label %.return1
.return1:
%.return_final = load i32* %return
ret i32 %.return_final
}


