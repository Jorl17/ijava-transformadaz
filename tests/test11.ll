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
@e = global i32 0, align 4


define i32 @main(i32 %args.length, i8** %args) {
%return = alloca i32, align 4
store i32 0, i32* %return
%f = alloca i32, align 4
store i32 0, i32* %f
%g = alloca i32, align 4
store i32 0, i32* %g
%h = alloca i32, align 4
store i32 0, i32* %h
%i = alloca i32, align 4
store i32 0, i32* %i
%j = alloca i32, align 4
store i32 0, i32* %j

%1 = add i32 0, 0
%2 = add i32 %1, 1
%3= getelementptr inbounds i8** %args, i32 %2
%4 = load i8** %3
%5 = call i32 @atoi(i8* %4) nounwind readonly
store i32 %5, i32* @a
%6 = add i32 0, 1
%7 = add i32 %6, 1
%8= getelementptr inbounds i8** %args, i32 %7
%9 = load i8** %8
%10 = call i32 @atoi(i8* %9) nounwind readonly
store i32 %10, i32* @b
%11 = add i32 0, 2
%12 = add i32 %11, 1
%13= getelementptr inbounds i8** %args, i32 %12
%14 = load i8** %13
%15 = call i32 @atoi(i8* %14) nounwind readonly
store i32 %15, i32* @c
%16 = add i32 0, 3
%17 = add i32 %16, 1
%18= getelementptr inbounds i8** %args, i32 %17
%19 = load i8** %18
%20 = call i32 @atoi(i8* %19) nounwind readonly
store i32 %20, i32* @d
%21 = add i32 0, 4
%22 = add i32 %21, 1
%23= getelementptr inbounds i8** %args, i32 %22
%24 = load i8** %23
%25 = call i32 @atoi(i8* %24) nounwind readonly
store i32 %25, i32* @e
%26 = add i32 0, 5
%27 = add i32 %26, 1
%28= getelementptr inbounds i8** %args, i32 %27
%29 = load i8** %28
%30 = call i32 @atoi(i8* %29) nounwind readonly
store i32 %30, i32* %f
%31 = add i32 0, 6
%32 = add i32 %31, 1
%33= getelementptr inbounds i8** %args, i32 %32
%34 = load i8** %33
%35 = call i32 @atoi(i8* %34) nounwind readonly
store i32 %35, i32* %g
%36 = add i32 0, 7
%37 = add i32 %36, 1
%38= getelementptr inbounds i8** %args, i32 %37
%39 = load i8** %38
%40 = call i32 @atoi(i8* %39) nounwind readonly
store i32 %40, i32* %h
%41 = add i32 0, 8
%42 = add i32 %41, 1
%43= getelementptr inbounds i8** %args, i32 %42
%44 = load i8** %43
%45 = call i32 @atoi(i8* %44) nounwind readonly
store i32 %45, i32* %i
%46 = add i32 0, 9
%47 = add i32 %46, 1
%48= getelementptr inbounds i8** %args, i32 %47
%49 = load i8** %48
%50 = call i32 @atoi(i8* %49) nounwind readonly
store i32 %50, i32* %j
%51 = load i32* @a
%52 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %51)
%53 = load i32* @b
%54 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %53)
%55 = load i32* @c
%56 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %55)
%57 = load i32* @d
%58 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %57)
%59 = load i32* @e
%60 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %59)
%61 = load i32* %f
%62 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %61)
%63 = load i32* %g
%64 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %63)
%65 = load i32* %h
%66 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %65)
%67 = load i32* %i
%68 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %67)
%69 = load i32* %j
%70 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %69)

br label %.return1
.return1:
%.return_final = load i32* %return
ret i32 %.return_final
}


