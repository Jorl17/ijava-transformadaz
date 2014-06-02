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
@b1 = global %.BoolArray zeroinitializer, align 8


define i32 @main(i32 %args.length, i8** %args) {
%return = alloca i32, align 4
store i32 0, i32* %return
%a2 = alloca %.IntArray, align 8
%.a2 = getelementptr inbounds %.IntArray* %a2, i32 0, i32 0
store i32 0, i32* %.a2, align 4
%..a2 = getelementptr inbounds %.IntArray* %a2, i32 0, i32 1
store i32* null, i32** %..a2, align 8
%b2 = alloca %.BoolArray, align 8
%.b2 = getelementptr inbounds %.BoolArray* %b2, i32 0, i32 0
store i32 0, i32* %.b2, align 4
%..b2 = getelementptr inbounds %.BoolArray* %b2, i32 0, i32 1
store i1* null, i1** %..b2, align 8

%1 = add i32 0, 3
%2 = alloca %.IntArray, align 8
%.2 = getelementptr inbounds %.IntArray* %2, i32 0, i32 0
store i32 0, i32* %.2, align 4
%..2 = getelementptr inbounds %.IntArray* %2, i32 0, i32 1
store i32* null, i32** %..2, align 8
%3 = getelementptr inbounds %.IntArray* %2, i32 0, i32 0
store i32 %1, i32* %3, align 4
%4 = call noalias i8* @calloc(i32 %1, i32 4) nounwind
%5 = bitcast i8* %4 to i32*
%6 = getelementptr inbounds %.IntArray* %2, i32 0, i32 1
store i32* %5, i32** %6, align 8
%7 = load %.IntArray* %2
store %.IntArray %7, %.IntArray* @a1
%8 = add i32 0, 3
%9 = alloca %.IntArray, align 8
%.9 = getelementptr inbounds %.IntArray* %9, i32 0, i32 0
store i32 0, i32* %.9, align 4
%..9 = getelementptr inbounds %.IntArray* %9, i32 0, i32 1
store i32* null, i32** %..9, align 8
%10 = getelementptr inbounds %.IntArray* %9, i32 0, i32 0
store i32 %8, i32* %10, align 4
%11 = call noalias i8* @calloc(i32 %8, i32 4) nounwind
%12 = bitcast i8* %11 to i32*
%13 = getelementptr inbounds %.IntArray* %9, i32 0, i32 1
store i32* %12, i32** %13, align 8
%14 = load %.IntArray* %9
store %.IntArray %14, %.IntArray* %a2
%15 = add i32 0, 4
%16 = alloca %.BoolArray, align 8
%.16 = getelementptr inbounds %.BoolArray* %16, i32 0, i32 0
store i32 0, i32* %.16, align 4
%..16 = getelementptr inbounds %.BoolArray* %16, i32 0, i32 1
store i1* null, i1** %..16, align 8
%17 = getelementptr inbounds %.BoolArray* %16, i32 0, i32 0
store i32 %15, i32* %17, align 4
%18 = call noalias i8* @calloc(i32 %15, i32 1) nounwind
%19 = bitcast i8* %18 to i1*
%20 = getelementptr inbounds %.BoolArray* %16, i32 0, i32 1
store i1* %19, i1** %20, align 8
%21 = load %.BoolArray* %16
store %.BoolArray %21, %.BoolArray* @b1
%22 = add i32 0, 4
%23 = alloca %.BoolArray, align 8
%.23 = getelementptr inbounds %.BoolArray* %23, i32 0, i32 0
store i32 0, i32* %.23, align 4
%..23 = getelementptr inbounds %.BoolArray* %23, i32 0, i32 1
store i1* null, i1** %..23, align 8
%24 = getelementptr inbounds %.BoolArray* %23, i32 0, i32 0
store i32 %22, i32* %24, align 4
%25 = call noalias i8* @calloc(i32 %22, i32 1) nounwind
%26 = bitcast i8* %25 to i1*
%27 = getelementptr inbounds %.BoolArray* %23, i32 0, i32 1
store i1* %26, i1** %27, align 8
%28 = load %.BoolArray* %23
store %.BoolArray %28, %.BoolArray* %b2
%29 = load %.IntArray* @a1
%30 = add i32 0, 0
%31 = extractvalue %.IntArray %29, 1
%32 = getelementptr i32* %31, i32 %30
%33 = load i32* %32
%34 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %33)
%35 = load %.IntArray* @a1
%36 = add i32 0, 1
%37 = extractvalue %.IntArray %35, 1
%38 = getelementptr i32* %37, i32 %36
%39 = load i32* %38
%40 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %39)
%41 = load %.IntArray* @a1
%42 = add i32 0, 2
%43 = extractvalue %.IntArray %41, 1
%44 = getelementptr i32* %43, i32 %42
%45 = load i32* %44
%46 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %45)
%47 = load %.IntArray* %a2
%48 = add i32 0, 0
%49 = extractvalue %.IntArray %47, 1
%50 = getelementptr i32* %49, i32 %48
%51 = load i32* %50
%52 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %51)
%53 = load %.IntArray* %a2
%54 = add i32 0, 1
%55 = extractvalue %.IntArray %53, 1
%56 = getelementptr i32* %55, i32 %54
%57 = load i32* %56
%58 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %57)
%59 = load %.IntArray* %a2
%60 = add i32 0, 2
%61 = extractvalue %.IntArray %59, 1
%62 = getelementptr i32* %61, i32 %60
%63 = load i32* %62
%64 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %63)
%65 = load %.BoolArray* @b1
%66 = add i32 0, 0
%67 = extractvalue %.BoolArray %65, 1
%68 = getelementptr i1* %67, i32 %66
%69 = load i1* %68
%70 = zext i1 %69 to i32
%71 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %70
%72 = load i8** %71
%73 = call i32 (i8*, ...)* @printf(i8* %72)
%74 = load %.BoolArray* @b1
%75 = add i32 0, 1
%76 = extractvalue %.BoolArray %74, 1
%77 = getelementptr i1* %76, i32 %75
%78 = load i1* %77
%79 = zext i1 %78 to i32
%80 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %79
%81 = load i8** %80
%82 = call i32 (i8*, ...)* @printf(i8* %81)
%83 = load %.BoolArray* @b1
%84 = add i32 0, 2
%85 = extractvalue %.BoolArray %83, 1
%86 = getelementptr i1* %85, i32 %84
%87 = load i1* %86
%88 = zext i1 %87 to i32
%89 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %88
%90 = load i8** %89
%91 = call i32 (i8*, ...)* @printf(i8* %90)
%92 = load %.BoolArray* @b1
%93 = add i32 0, 3
%94 = extractvalue %.BoolArray %92, 1
%95 = getelementptr i1* %94, i32 %93
%96 = load i1* %95
%97 = zext i1 %96 to i32
%98 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %97
%99 = load i8** %98
%100 = call i32 (i8*, ...)* @printf(i8* %99)
%101 = load %.BoolArray* %b2
%102 = add i32 0, 0
%103 = extractvalue %.BoolArray %101, 1
%104 = getelementptr i1* %103, i32 %102
%105 = load i1* %104
%106 = zext i1 %105 to i32
%107 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %106
%108 = load i8** %107
%109 = call i32 (i8*, ...)* @printf(i8* %108)
%110 = load %.BoolArray* %b2
%111 = add i32 0, 1
%112 = extractvalue %.BoolArray %110, 1
%113 = getelementptr i1* %112, i32 %111
%114 = load i1* %113
%115 = zext i1 %114 to i32
%116 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %115
%117 = load i8** %116
%118 = call i32 (i8*, ...)* @printf(i8* %117)
%119 = load %.BoolArray* %b2
%120 = add i32 0, 2
%121 = extractvalue %.BoolArray %119, 1
%122 = getelementptr i1* %121, i32 %120
%123 = load i1* %122
%124 = zext i1 %123 to i32
%125 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %124
%126 = load i8** %125
%127 = call i32 (i8*, ...)* @printf(i8* %126)
%128 = load %.BoolArray* %b2
%129 = add i32 0, 3
%130 = extractvalue %.BoolArray %128, 1
%131 = getelementptr i1* %130, i32 %129
%132 = load i1* %131
%133 = zext i1 %132 to i32
%134 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %133
%135 = load i8** %134
%136 = call i32 (i8*, ...)* @printf(i8* %135)

br label %.return1
.return1:
%.return_final = load i32* %return
ret i32 %.return_final
}


