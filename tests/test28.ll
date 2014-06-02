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
%.array.a2 = getelementptr inbounds %.IntArray* %a2, i32 0, i32 0
store i32 0, i32* %.array.a2, align 4
%..array.a2 = getelementptr inbounds %.IntArray* %a2, i32 0, i32 1
store i32* null, i32** %..array.a2, align 8
%b2 = alloca %.BoolArray, align 8
%.array.b2 = getelementptr inbounds %.BoolArray* %b2, i32 0, i32 0
store i32 0, i32* %.array.b2, align 4
%..array.b2 = getelementptr inbounds %.BoolArray* %b2, i32 0, i32 1
store i1* null, i1** %..array.b2, align 8

%1 = add i32 0, 3
%2 = alloca %.IntArray, align 8
%.array.2 = getelementptr inbounds %.IntArray* %2, i32 0, i32 0
store i32 0, i32* %.array.2, align 4
%..array.2 = getelementptr inbounds %.IntArray* %2, i32 0, i32 1
store i32* null, i32** %..array.2, align 8
%3 = getelementptr inbounds %.IntArray* %2, i32 0, i32 0
store i32 %1, i32* %3, align 4
%4 = call noalias i8* @calloc(i32 %1, i32 4) nounwind
%5 = bitcast i8* %4 to i32*
%6 = getelementptr inbounds %.IntArray* %2, i32 0, i32 1
store i32* %5, i32** %6, align 8
%7 = load %.IntArray* %2
store %.IntArray %7, %.IntArray* @a1
%8 = load %.IntArray* @a1
%9 = add i32 0, 0
%10 = add i32 0, 1
%11 = sub i32 0, %10
%12 = extractvalue %.IntArray %8, 1
%13 = getelementptr i32* %12, i32 %9
store i32 %11, i32* %13
%14 = load %.IntArray* @a1
%15 = add i32 0, 1
%16 = add i32 0, 0
%17 = extractvalue %.IntArray %14, 1
%18 = getelementptr i32* %17, i32 %15
store i32 %16, i32* %18
%19 = load %.IntArray* @a1
%20 = add i32 0, 2
%21 = add i32 0, 1
%22 = extractvalue %.IntArray %19, 1
%23 = getelementptr i32* %22, i32 %20
store i32 %21, i32* %23
%24 = add i32 0, 3
%25 = alloca %.IntArray, align 8
%.array.25 = getelementptr inbounds %.IntArray* %25, i32 0, i32 0
store i32 0, i32* %.array.25, align 4
%..array.25 = getelementptr inbounds %.IntArray* %25, i32 0, i32 1
store i32* null, i32** %..array.25, align 8
%26 = getelementptr inbounds %.IntArray* %25, i32 0, i32 0
store i32 %24, i32* %26, align 4
%27 = call noalias i8* @calloc(i32 %24, i32 4) nounwind
%28 = bitcast i8* %27 to i32*
%29 = getelementptr inbounds %.IntArray* %25, i32 0, i32 1
store i32* %28, i32** %29, align 8
%30 = load %.IntArray* %25
store %.IntArray %30, %.IntArray* %a2
%31 = load %.IntArray* %a2
%32 = add i32 0, 0
%33 = add i32 0, 2
%34 = sub i32 0, %33
%35 = extractvalue %.IntArray %31, 1
%36 = getelementptr i32* %35, i32 %32
store i32 %34, i32* %36
%37 = load %.IntArray* %a2
%38 = add i32 0, 1
%39 = add i32 0, 0
%40 = extractvalue %.IntArray %37, 1
%41 = getelementptr i32* %40, i32 %38
store i32 %39, i32* %41
%42 = load %.IntArray* %a2
%43 = add i32 0, 2
%44 = add i32 0, 2
%45 = extractvalue %.IntArray %42, 1
%46 = getelementptr i32* %45, i32 %43
store i32 %44, i32* %46
%47 = add i32 0, 4
%48 = alloca %.BoolArray, align 8
%.array.48 = getelementptr inbounds %.BoolArray* %48, i32 0, i32 0
store i32 0, i32* %.array.48, align 4
%..array.48 = getelementptr inbounds %.BoolArray* %48, i32 0, i32 1
store i1* null, i1** %..array.48, align 8
%49 = getelementptr inbounds %.BoolArray* %48, i32 0, i32 0
store i32 %47, i32* %49, align 4
%50 = call noalias i8* @calloc(i32 %47, i32 1) nounwind
%51 = bitcast i8* %50 to i1*
%52 = getelementptr inbounds %.BoolArray* %48, i32 0, i32 1
store i1* %51, i1** %52, align 8
%53 = load %.BoolArray* %48
store %.BoolArray %53, %.BoolArray* @b1
%54 = load %.BoolArray* @b1
%55 = add i32 0, 0
%56 = add i1 0, 0
%57 = extractvalue %.BoolArray %54, 1
%58 = getelementptr i1* %57, i32 %55
store i1 %56, i1* %58
%59 = load %.BoolArray* @b1
%60 = add i32 0, 1
%61 = add i1 0, 1
%62 = extractvalue %.BoolArray %59, 1
%63 = getelementptr i1* %62, i32 %60
store i1 %61, i1* %63
%64 = load %.BoolArray* @b1
%65 = add i32 0, 2
%66 = add i1 0, 0
%67 = extractvalue %.BoolArray %64, 1
%68 = getelementptr i1* %67, i32 %65
store i1 %66, i1* %68
%69 = load %.BoolArray* @b1
%70 = add i32 0, 3
%71 = add i1 0, 1
%72 = extractvalue %.BoolArray %69, 1
%73 = getelementptr i1* %72, i32 %70
store i1 %71, i1* %73
%74 = add i32 0, 4
%75 = alloca %.BoolArray, align 8
%.array.75 = getelementptr inbounds %.BoolArray* %75, i32 0, i32 0
store i32 0, i32* %.array.75, align 4
%..array.75 = getelementptr inbounds %.BoolArray* %75, i32 0, i32 1
store i1* null, i1** %..array.75, align 8
%76 = getelementptr inbounds %.BoolArray* %75, i32 0, i32 0
store i32 %74, i32* %76, align 4
%77 = call noalias i8* @calloc(i32 %74, i32 1) nounwind
%78 = bitcast i8* %77 to i1*
%79 = getelementptr inbounds %.BoolArray* %75, i32 0, i32 1
store i1* %78, i1** %79, align 8
%80 = load %.BoolArray* %75
store %.BoolArray %80, %.BoolArray* %b2
%81 = load %.BoolArray* %b2
%82 = add i32 0, 0
%83 = add i1 0, 0
%84 = extractvalue %.BoolArray %81, 1
%85 = getelementptr i1* %84, i32 %82
store i1 %83, i1* %85
%86 = load %.BoolArray* %b2
%87 = add i32 0, 1
%88 = add i1 0, 1
%89 = extractvalue %.BoolArray %86, 1
%90 = getelementptr i1* %89, i32 %87
store i1 %88, i1* %90
%91 = load %.BoolArray* %b2
%92 = add i32 0, 2
%93 = add i1 0, 0
%94 = extractvalue %.BoolArray %91, 1
%95 = getelementptr i1* %94, i32 %92
store i1 %93, i1* %95
%96 = load %.BoolArray* %b2
%97 = add i32 0, 3
%98 = add i1 0, 1
%99 = extractvalue %.BoolArray %96, 1
%100 = getelementptr i1* %99, i32 %97
store i1 %98, i1* %100
%101 = load %.IntArray* @a1
%102 = add i32 0, 0
%103 = extractvalue %.IntArray %101, 1
%104 = getelementptr i32* %103, i32 %102
%105 = load i32* %104
%106 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %105)
%107 = load %.IntArray* @a1
%108 = add i32 0, 1
%109 = extractvalue %.IntArray %107, 1
%110 = getelementptr i32* %109, i32 %108
%111 = load i32* %110
%112 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %111)
%113 = load %.IntArray* @a1
%114 = add i32 0, 2
%115 = extractvalue %.IntArray %113, 1
%116 = getelementptr i32* %115, i32 %114
%117 = load i32* %116
%118 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %117)
%119 = load %.IntArray* %a2
%120 = add i32 0, 0
%121 = extractvalue %.IntArray %119, 1
%122 = getelementptr i32* %121, i32 %120
%123 = load i32* %122
%124 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %123)
%125 = load %.IntArray* %a2
%126 = add i32 0, 1
%127 = extractvalue %.IntArray %125, 1
%128 = getelementptr i32* %127, i32 %126
%129 = load i32* %128
%130 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %129)
%131 = load %.IntArray* %a2
%132 = add i32 0, 2
%133 = extractvalue %.IntArray %131, 1
%134 = getelementptr i32* %133, i32 %132
%135 = load i32* %134
%136 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %135)
%137 = load %.BoolArray* @b1
%138 = add i32 0, 0
%139 = extractvalue %.BoolArray %137, 1
%140 = getelementptr i1* %139, i32 %138
%141 = load i1* %140
%142 = zext i1 %141 to i32
%143 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %142
%144 = load i8** %143
%145 = call i32 (i8*, ...)* @printf(i8* %144)
%146 = load %.BoolArray* @b1
%147 = add i32 0, 1
%148 = extractvalue %.BoolArray %146, 1
%149 = getelementptr i1* %148, i32 %147
%150 = load i1* %149
%151 = zext i1 %150 to i32
%152 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %151
%153 = load i8** %152
%154 = call i32 (i8*, ...)* @printf(i8* %153)
%155 = load %.BoolArray* @b1
%156 = add i32 0, 2
%157 = extractvalue %.BoolArray %155, 1
%158 = getelementptr i1* %157, i32 %156
%159 = load i1* %158
%160 = zext i1 %159 to i32
%161 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %160
%162 = load i8** %161
%163 = call i32 (i8*, ...)* @printf(i8* %162)
%164 = load %.BoolArray* @b1
%165 = add i32 0, 3
%166 = extractvalue %.BoolArray %164, 1
%167 = getelementptr i1* %166, i32 %165
%168 = load i1* %167
%169 = zext i1 %168 to i32
%170 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %169
%171 = load i8** %170
%172 = call i32 (i8*, ...)* @printf(i8* %171)
%173 = load %.BoolArray* %b2
%174 = add i32 0, 0
%175 = extractvalue %.BoolArray %173, 1
%176 = getelementptr i1* %175, i32 %174
%177 = load i1* %176
%178 = zext i1 %177 to i32
%179 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %178
%180 = load i8** %179
%181 = call i32 (i8*, ...)* @printf(i8* %180)
%182 = load %.BoolArray* %b2
%183 = add i32 0, 1
%184 = extractvalue %.BoolArray %182, 1
%185 = getelementptr i1* %184, i32 %183
%186 = load i1* %185
%187 = zext i1 %186 to i32
%188 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %187
%189 = load i8** %188
%190 = call i32 (i8*, ...)* @printf(i8* %189)
%191 = load %.BoolArray* %b2
%192 = add i32 0, 2
%193 = extractvalue %.BoolArray %191, 1
%194 = getelementptr i1* %193, i32 %192
%195 = load i1* %194
%196 = zext i1 %195 to i32
%197 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %196
%198 = load i8** %197
%199 = call i32 (i8*, ...)* @printf(i8* %198)
%200 = load %.BoolArray* %b2
%201 = add i32 0, 3
%202 = extractvalue %.BoolArray %200, 1
%203 = getelementptr i1* %202, i32 %201
%204 = load i1* %203
%205 = zext i1 %204 to i32
%206 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %205
%207 = load i8** %206
%208 = call i32 (i8*, ...)* @printf(i8* %207)

br label %.return1
.return1:
%.return_final = load i32* %return
ret i32 %.return_final
}


