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
%b1 = alloca i1, align 4
store i1 0, i1* %b1
%b2 = alloca i1, align 4
store i1 0, i1* %b2
%a = alloca i32, align 4
store i32 0, i32* %a
%b = alloca i32, align 4
store i32 0, i32* %b
%c = alloca i32, align 4
store i32 0, i32* %c
%d = alloca i32, align 4
store i32 0, i32* %d
%e = alloca i32, align 4
store i32 0, i32* %e
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
%k = alloca i32, align 4
store i32 0, i32* %k
%l = alloca i32, align 4
store i32 0, i32* %l

%1 = add i1 0, 0
store i1 %1, i1* %b1
%2 = add i1 0, 1
store i1 %2, i1* %b2
%3 = add i32 0, 1
%4 = sub i32 0, %3
store i32 %4, i32* %a
%5 = add i32 0, 1
store i32 %5, i32* %b
%6 = add i32 0, 0
store i32 %6, i32* %c
%7 = add i32 0, 1
%8 = sub i32 0, %7
store i32 %8, i32* %d
%9 = add i32 0, 1
store i32 %9, i32* %e
%10 = add i32 0, 0
store i32 %10, i32* %f
%11 = add i32 0, 1
%12 = sub i32 0, %11
store i32 %12, i32* %g
%13 = add i32 0, 1
store i32 %13, i32* %h
%14 = add i32 0, 0
store i32 %14, i32* %i
%15 = load i32* %a
%16 = sub i32 0, %15
%17 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %16)
%18 = load i32* %b
%19 = sub i32 0, %18
%20 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %19)
%21 = load i32* %c
%22 = sub i32 0, %21
%23 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %22)
%24 = load i32* %a
%25 = add i32 0, %24
%26 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %25)
%27 = load i32* %b
%28 = add i32 0, %27
%29 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %28)
%30 = load i32* %c
%31 = add i32 0, %30
%32 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %31)
%33 = load i32* %d
%34 = sub i32 0, %33
%35 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %34)
%36 = load i32* %e
%37 = sub i32 0, %36
%38 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %37)
%39 = load i32* %f
%40 = sub i32 0, %39
%41 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %40)
%42 = load i32* %d
%43 = add i32 0, %42
%44 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %43)
%45 = load i32* %e
%46 = add i32 0, %45
%47 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %46)
%48 = load i32* %f
%49 = add i32 0, %48
%50 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %49)
%51 = load i32* %g
%52 = sub i32 0, %51
%53 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %52)
%54 = load i32* %h
%55 = sub i32 0, %54
%56 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %55)
%57 = load i32* %i
%58 = sub i32 0, %57
%59 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %58)
%60 = load i32* %g
%61 = add i32 0, %60
%62 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %61)
%63 = load i32* %h
%64 = add i32 0, %63
%65 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %64)
%66 = load i32* %i
%67 = add i32 0, %66
%68 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %67)
%69 = load i1* %b1
%70 = xor i1 true, %69
%71 = zext i1 %70 to i32
%72 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %71
%73 = load i8** %72
%74 = call i32 (i8*, ...)* @printf(i8* %73)
%75 = load i1* %b2
%76 = xor i1 true, %75
%77 = zext i1 %76 to i32
%78 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %77
%79 = load i8** %78
%80 = call i32 (i8*, ...)* @printf(i8* %79)

br label %.return1
.return1:
%.return_final = load i32* %return
ret i32 %.return_final
}


