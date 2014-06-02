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

%1 = add i32 0, 0
%2 = add i32 %1, 1
%3= getelementptr inbounds i8** %args, i32 %2
%4 = load i8** %3
%5 = call i32 @atoi(i8* %4) nounwind readonly
%6 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %5)
%7 = add i32 0, 1
%8 = add i32 %7, 1
%9= getelementptr inbounds i8** %args, i32 %8
%10 = load i8** %9
%11 = call i32 @atoi(i8* %10) nounwind readonly
%12 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %11)
%13 = add i32 0, 2
%14 = add i32 %13, 1
%15= getelementptr inbounds i8** %args, i32 %14
%16 = load i8** %15
%17 = call i32 @atoi(i8* %16) nounwind readonly
%18 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %17)
%19 = add i32 0, 3
%20 = add i32 %19, 1
%21= getelementptr inbounds i8** %args, i32 %20
%22 = load i8** %21
%23 = call i32 @atoi(i8* %22) nounwind readonly
%24 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %23)
%25 = add i32 0, 4
%26 = add i32 %25, 1
%27= getelementptr inbounds i8** %args, i32 %26
%28 = load i8** %27
%29 = call i32 @atoi(i8* %28) nounwind readonly
%30 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %29)
%31 = add i32 0, 5
%32 = add i32 %31, 1
%33= getelementptr inbounds i8** %args, i32 %32
%34 = load i8** %33
%35 = call i32 @atoi(i8* %34) nounwind readonly
%36 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %35)
%37 = add i32 0, 6
%38 = add i32 %37, 1
%39= getelementptr inbounds i8** %args, i32 %38
%40 = load i8** %39
%41 = call i32 @atoi(i8* %40) nounwind readonly
%42 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %41)
%43 = add i32 0, 7
%44 = add i32 %43, 1
%45= getelementptr inbounds i8** %args, i32 %44
%46 = load i8** %45
%47 = call i32 @atoi(i8* %46) nounwind readonly
%48 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %47)
%49 = add i32 0, 8
%50 = add i32 %49, 1
%51= getelementptr inbounds i8** %args, i32 %50
%52 = load i8** %51
%53 = call i32 @atoi(i8* %52) nounwind readonly
%54 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %53)
%55 = add i32 0, 9
%56 = add i32 %55, 1
%57= getelementptr inbounds i8** %args, i32 %56
%58 = load i8** %57
%59 = call i32 @atoi(i8* %58) nounwind readonly
%60 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %59)

br label %.return1
.return1:
%.return_final = load i32* %return
ret i32 %.return_final
}


