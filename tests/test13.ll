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

%1 = add i32 0, 1
%2 = sub i32 0, %1
%3 = sub i32 0, %2
%4 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %3)
%5 = add i32 0, 1
%6 = sub i32 0, %5
%7 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %6)
%8 = add i32 0, 0
%9 = sub i32 0, %8
%10 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %9)
%11 = add i32 0, 1
%12 = sub i32 0, %11
%13 = add i32 0, %12
%14 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %13)
%15 = add i32 0, 1
%16 = add i32 0, %15
%17 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %16)
%18 = add i32 0, 0
%19 = add i32 0, %18
%20 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %19)
%21 = add i32 0, 1
%22 = sub i32 0, %21
%23 = sub i32 0, %22
%24 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %23)
%25 = add i32 0, 1
%26 = sub i32 0, %25
%27 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %26)
%28 = add i32 0, 0
%29 = sub i32 0, %28
%30 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %29)
%31 = add i32 0, 1
%32 = sub i32 0, %31
%33 = add i32 0, %32
%34 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %33)
%35 = add i32 0, 1
%36 = add i32 0, %35
%37 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %36)
%38 = add i32 0, 0
%39 = add i32 0, %38
%40 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %39)
%41 = add i32 0, 1
%42 = sub i32 0, %41
%43 = sub i32 0, %42
%44 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %43)
%45 = add i32 0, 1
%46 = sub i32 0, %45
%47 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %46)
%48 = add i32 0, 0
%49 = sub i32 0, %48
%50 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %49)
%51 = add i32 0, 1
%52 = sub i32 0, %51
%53 = add i32 0, %52
%54 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %53)
%55 = add i32 0, 1
%56 = add i32 0, %55
%57 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %56)
%58 = add i32 0, 0
%59 = add i32 0, %58
%60 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %59)
%61 = add i1 0, 0
%62 = xor i1 true, %61
%63 = zext i1 %62 to i32
%64 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %63
%65 = load i8** %64
%66 = call i32 (i8*, ...)* @printf(i8* %65)
%67 = add i1 0, 1
%68 = xor i1 true, %67
%69 = zext i1 %68 to i32
%70 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %69
%71 = load i8** %70
%72 = call i32 (i8*, ...)* @printf(i8* %71)

br label %.return1
.return1:
%.return_final = load i32* %return
ret i32 %.return_final
}


