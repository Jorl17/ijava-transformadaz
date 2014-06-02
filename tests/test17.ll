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

%1 = add i1 0, 1
store i1 %1, i1* %b1
%2 = add i1 0, 0
store i1 %2, i1* %b2
%3 = load i1* %b1
br i1 %3, label %.label1, label %.label2
.label1:
%4 = add i32 0, 0
%5 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %4)
br label %.label3
.label2:
br label %.label3
.label3:
%6 = load i1* %b2
br i1 %6, label %.label4, label %.label5
.label4:
%7 = add i32 0, 1
%8 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %7)
br label %.label6
.label5:
br label %.label6
.label6:
%9 = load i1* %b1
br i1 %9, label %.label7, label %.label8
.label7:
%10 = add i32 0, 2
%11 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %10)
br label %.label9
.label8:
%12 = add i32 0, 3
%13 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %12)
br label %.label9
.label9:
%14 = load i1* %b2
br i1 %14, label %.label10, label %.label11
.label10:
%15 = add i32 0, 4
%16 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %15)
br label %.label12
.label11:
%17 = add i32 0, 5
%18 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %17)
br label %.label12
.label12:
%19 = load i1* %b1
br i1 %19, label %.label13, label %.label14
.label13:
br label %.label15
.label14:
br label %.label15
.label15:
%20 = load i1* %b2
br i1 %20, label %.label16, label %.label17
.label16:
br label %.label18
.label17:
br label %.label18
.label18:
%21 = load i1* %b1
br i1 %21, label %.label19, label %.label20
.label19:
br label %.label21
.label20:
br label %.label21
.label21:
%22 = load i1* %b2
br i1 %22, label %.label22, label %.label23
.label22:
br label %.label24
.label23:
br label %.label24
.label24:
%23 = load i1* %b1
br i1 %23, label %.label25, label %.label26
.label25:
%24 = add i32 0, 6
%25 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %24)
br label %.label27
.label26:
br label %.label27
.label27:
%26 = load i1* %b2
br i1 %26, label %.label28, label %.label29
.label28:
%27 = add i32 0, 7
%28 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %27)
br label %.label30
.label29:
br label %.label30
.label30:
%29 = load i1* %b1
br i1 %29, label %.label31, label %.label32
.label31:
br label %.label33
.label32:
%30 = add i32 0, 8
%31 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %30)
br label %.label33
.label33:
%32 = load i1* %b2
br i1 %32, label %.label34, label %.label35
.label34:
br label %.label36
.label35:
%33 = add i32 0, 9
%34 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %33)
br label %.label36
.label36:

br label %.return1
.return1:
%.return_final = load i32* %return
ret i32 %.return_final
}


