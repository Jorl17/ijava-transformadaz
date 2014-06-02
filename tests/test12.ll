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
@k = global i1 0, align 4
@l = global i1 0, align 4
@m = global i1 0, align 4
@n = global i1 0, align 4


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

%1 = add i32 0, 1
store i32 %1, i32* @a
%2 = add i32 0, 2
store i32 %2, i32* @b
%3 = add i32 0, 3
store i32 %3, i32* @c
%4 = add i32 0, 4
store i32 %4, i32* @d
%5 = add i32 0, 5
store i32 %5, i32* @e
%6 = add i32 0, 6
store i32 %6, i32* %f
%7 = add i32 0, 7
store i32 %7, i32* %g
%8 = add i32 0, 8
store i32 %8, i32* %h
%9 = add i32 0, 9
store i32 %9, i32* %i
%10 = add i32 0, 10
store i32 %10, i32* %j
%11 = add i1 0, 0
store i1 %11, i1* @k
%12 = add i1 0, 1
store i1 %12, i1* @l
%13 = add i1 0, 0
store i1 %13, i1* @m
%14 = add i1 0, 1
store i1 %14, i1* @n
%15 = add i32 0, 1
%16 = sub i32 0, %15
store i32 %16, i32* @a
%17 = add i32 0, 2
%18 = sub i32 0, %17
store i32 %18, i32* @b
%19 = add i32 0, 3
%20 = sub i32 0, %19
store i32 %20, i32* @c
%21 = add i32 0, 4
%22 = sub i32 0, %21
store i32 %22, i32* @d
%23 = add i32 0, 5
%24 = sub i32 0, %23
store i32 %24, i32* @e
%25 = add i32 0, 6
%26 = sub i32 0, %25
store i32 %26, i32* %f
%27 = add i32 0, 7
%28 = sub i32 0, %27
store i32 %28, i32* %g
%29 = add i32 0, 8
%30 = sub i32 0, %29
store i32 %30, i32* %h
%31 = add i32 0, 9
%32 = sub i32 0, %31
store i32 %32, i32* %i
%33 = add i32 0, 10
%34 = sub i32 0, %33
store i32 %34, i32* %j
%35 = add i1 0, 1
store i1 %35, i1* @k
%36 = add i1 0, 0
store i1 %36, i1* @l
%37 = add i1 0, 1
store i1 %37, i1* @m
%38 = add i1 0, 0
store i1 %38, i1* @n
%39 = load i32* @a
%40 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %39)
%41 = load i32* @b
%42 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %41)
%43 = load i32* @c
%44 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %43)
%45 = load i32* @d
%46 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %45)
%47 = load i32* @e
%48 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %47)
%49 = load i32* %f
%50 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %49)
%51 = load i32* %g
%52 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %51)
%53 = load i32* %h
%54 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %53)
%55 = load i32* %i
%56 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %55)
%57 = load i32* %j
%58 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %57)
%59 = load i1* @k
%60 = zext i1 %59 to i32
%61 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %60
%62 = load i8** %61
%63 = call i32 (i8*, ...)* @printf(i8* %62)
%64 = load i1* @l
%65 = zext i1 %64 to i32
%66 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %65
%67 = load i8** %66
%68 = call i32 (i8*, ...)* @printf(i8* %67)
%69 = load i1* @m
%70 = zext i1 %69 to i32
%71 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %70
%72 = load i8** %71
%73 = call i32 (i8*, ...)* @printf(i8* %72)
%74 = load i1* @n
%75 = zext i1 %74 to i32
%76 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %75
%77 = load i8** %76
%78 = call i32 (i8*, ...)* @printf(i8* %77)

br label %.return1
.return1:
%.return_final = load i32* %return
ret i32 %.return_final
}


