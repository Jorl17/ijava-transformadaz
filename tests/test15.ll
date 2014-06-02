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
%2 = add i32 0, 15
%3 = add i32 %1, %2
%4 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %3)
%5 = add i32 0, 15
%6 = add i32 0, 1
%7 = sub i32 0, %6
%8 = sub i32 %5, %7
%9 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %8)
%10 = add i32 0, 7
%11 = sub i32 0, %10
%12 = add i32 0, 1
%13 = add i32 %11, %12
%14 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %13)
%15 = add i32 0, 33
%16 = sub i32 0, %15
%17 = add i32 0, 7
%18 = sub i32 %16, %17
%19 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %18)
%20 = add i32 0, 1
%21 = add i32 0, 13
%22 = mul i32 %20, %21
%23 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %22)
%24 = add i32 0, 1
%25 = add i32 0, 13
%26 = mul i32 %24, %25
%27 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %26)
%28 = add i32 0, 1
%29 = add i32 0, 7
%30 = mul i32 %28, %29
%31 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %30)
%32 = add i32 0, 7
%33 = add i32 0, 3
%34 = mul i32 %32, %33
%35 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %34)
%36 = add i32 0, 8
%37 = add i32 0, 2
%38 = sub i32 0, %37
%39 = mul i32 %36, %38
%40 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %39)
%41 = add i32 0, 4
%42 = sub i32 0, %41
%43 = add i32 0, 2
%44 = mul i32 %42, %43
%45 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %44)
%46 = add i32 0, 3
%47 = sub i32 0, %46
%48 = add i32 0, 3
%49 = mul i32 %47, %48
%50 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %49)
%51 = add i32 0, 3
%52 = add i32 0, 3
%53 = sdiv i32 %51, %52
%54 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %53)
%55 = add i32 0, 3
%56 = add i32 0, 2
%57 = sdiv i32 %55, %56
%58 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %57)
%59 = add i32 0, 3
%60 = add i32 0, 4
%61 = sdiv i32 %59, %60
%62 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %61)
%63 = add i32 0, 3
%64 = sub i32 0, %63
%65 = add i32 0, 3
%66 = sdiv i32 %64, %65
%67 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %66)
%68 = add i32 0, 3
%69 = add i32 0, 2
%70 = sub i32 0, %69
%71 = sdiv i32 %68, %70
%72 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %71)
%73 = add i32 0, 3
%74 = add i32 0, 4
%75 = sdiv i32 %73, %74
%76 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %75)
%77 = add i32 0, 5
%78 = add i32 0, 7
%79 = sdiv i32 %77, %78
%80 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %79)
%81 = add i32 0, 100
%82 = add i32 0, 50
%83 = sdiv i32 %81, %82
%84 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %83)
%85 = add i32 0, 3
%86 = add i32 0, 3
%87 = srem i32 %85, %86
%88 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %87)
%89 = add i32 0, 3
%90 = add i32 0, 2
%91 = srem i32 %89, %90
%92 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %91)
%93 = add i32 0, 3
%94 = add i32 0, 4
%95 = srem i32 %93, %94
%96 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %95)
%97 = add i32 0, 3
%98 = sub i32 0, %97
%99 = add i32 0, 3
%100 = srem i32 %98, %99
%101 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %100)
%102 = add i32 0, 3
%103 = add i32 0, 2
%104 = sub i32 0, %103
%105 = srem i32 %102, %104
%106 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %105)
%107 = add i32 0, 3
%108 = add i32 0, 4
%109 = srem i32 %107, %108
%110 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %109)
%111 = add i32 0, 5
%112 = add i32 0, 7
%113 = srem i32 %111, %112
%114 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %113)
%115 = add i32 0, 100
%116 = add i32 0, 50
%117 = srem i32 %115, %116
%118 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @str.printf_callstr, i32 0, i32 0), i32 %117)
%119 = alloca i1, align 4
store i1 0, i1* %119
%120 = add i32 0, 3
%121 = add i32 0, 2
%122 = icmp slt i32 %120, %121
store i1 %122, i1* %119
%123 = load i1* %119
%124 = zext i1 %123 to i32
%125 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %124
%126 = load i8** %125
%127 = call i32 (i8*, ...)* @printf(i8* %126)
%128 = alloca i1, align 4
store i1 0, i1* %128
%129 = add i32 0, 2
%130 = add i32 0, 3
%131 = icmp slt i32 %129, %130
store i1 %131, i1* %128
%132 = load i1* %128
%133 = zext i1 %132 to i32
%134 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %133
%135 = load i8** %134
%136 = call i32 (i8*, ...)* @printf(i8* %135)
%137 = alloca i1, align 4
store i1 0, i1* %137
%138 = add i32 0, 1
%139 = add i32 0, 1
%140 = icmp slt i32 %138, %139
store i1 %140, i1* %137
%141 = load i1* %137
%142 = zext i1 %141 to i32
%143 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %142
%144 = load i8** %143
%145 = call i32 (i8*, ...)* @printf(i8* %144)
%146 = alloca i1, align 4
store i1 0, i1* %146
%147 = add i32 0, 3
%148 = sub i32 0, %147
%149 = add i32 0, 2
%150 = icmp slt i32 %148, %149
store i1 %150, i1* %146
%151 = load i1* %146
%152 = zext i1 %151 to i32
%153 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %152
%154 = load i8** %153
%155 = call i32 (i8*, ...)* @printf(i8* %154)
%156 = alloca i1, align 4
store i1 0, i1* %156
%157 = add i32 0, 2
%158 = sub i32 0, %157
%159 = add i32 0, 3
%160 = sub i32 0, %159
%161 = icmp slt i32 %158, %160
store i1 %161, i1* %156
%162 = load i1* %156
%163 = zext i1 %162 to i32
%164 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %163
%165 = load i8** %164
%166 = call i32 (i8*, ...)* @printf(i8* %165)
%167 = alloca i1, align 4
store i1 0, i1* %167
%168 = add i32 0, 3
%169 = sub i32 0, %168
%170 = add i32 0, 3
%171 = sub i32 0, %170
%172 = icmp slt i32 %169, %171
store i1 %172, i1* %167
%173 = load i1* %167
%174 = zext i1 %173 to i32
%175 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %174
%176 = load i8** %175
%177 = call i32 (i8*, ...)* @printf(i8* %176)
%178 = alloca i1, align 4
store i1 0, i1* %178
%179 = add i32 0, 3
%180 = add i32 0, 2
%181 = icmp sle i32 %179, %180
store i1 %181, i1* %178
%182 = load i1* %178
%183 = zext i1 %182 to i32
%184 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %183
%185 = load i8** %184
%186 = call i32 (i8*, ...)* @printf(i8* %185)
%187 = alloca i1, align 4
store i1 0, i1* %187
%188 = add i32 0, 2
%189 = add i32 0, 3
%190 = icmp sle i32 %188, %189
store i1 %190, i1* %187
%191 = load i1* %187
%192 = zext i1 %191 to i32
%193 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %192
%194 = load i8** %193
%195 = call i32 (i8*, ...)* @printf(i8* %194)
%196 = alloca i1, align 4
store i1 0, i1* %196
%197 = add i32 0, 1
%198 = add i32 0, 1
%199 = icmp sle i32 %197, %198
store i1 %199, i1* %196
%200 = load i1* %196
%201 = zext i1 %200 to i32
%202 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %201
%203 = load i8** %202
%204 = call i32 (i8*, ...)* @printf(i8* %203)
%205 = alloca i1, align 4
store i1 0, i1* %205
%206 = add i32 0, 3
%207 = sub i32 0, %206
%208 = add i32 0, 2
%209 = icmp sle i32 %207, %208
store i1 %209, i1* %205
%210 = load i1* %205
%211 = zext i1 %210 to i32
%212 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %211
%213 = load i8** %212
%214 = call i32 (i8*, ...)* @printf(i8* %213)
%215 = alloca i1, align 4
store i1 0, i1* %215
%216 = add i32 0, 2
%217 = sub i32 0, %216
%218 = add i32 0, 3
%219 = sub i32 0, %218
%220 = icmp sle i32 %217, %219
store i1 %220, i1* %215
%221 = load i1* %215
%222 = zext i1 %221 to i32
%223 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %222
%224 = load i8** %223
%225 = call i32 (i8*, ...)* @printf(i8* %224)
%226 = alloca i1, align 4
store i1 0, i1* %226
%227 = add i32 0, 3
%228 = sub i32 0, %227
%229 = add i32 0, 3
%230 = sub i32 0, %229
%231 = icmp sle i32 %228, %230
store i1 %231, i1* %226
%232 = load i1* %226
%233 = zext i1 %232 to i32
%234 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %233
%235 = load i8** %234
%236 = call i32 (i8*, ...)* @printf(i8* %235)
%237 = alloca i1, align 4
store i1 0, i1* %237
%238 = add i32 0, 3
%239 = add i32 0, 2
%240 = icmp sgt i32 %238, %239
store i1 %240, i1* %237
%241 = load i1* %237
%242 = zext i1 %241 to i32
%243 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %242
%244 = load i8** %243
%245 = call i32 (i8*, ...)* @printf(i8* %244)
%246 = alloca i1, align 4
store i1 0, i1* %246
%247 = add i32 0, 2
%248 = add i32 0, 3
%249 = icmp sgt i32 %247, %248
store i1 %249, i1* %246
%250 = load i1* %246
%251 = zext i1 %250 to i32
%252 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %251
%253 = load i8** %252
%254 = call i32 (i8*, ...)* @printf(i8* %253)
%255 = alloca i1, align 4
store i1 0, i1* %255
%256 = add i32 0, 1
%257 = add i32 0, 1
%258 = icmp sgt i32 %256, %257
store i1 %258, i1* %255
%259 = load i1* %255
%260 = zext i1 %259 to i32
%261 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %260
%262 = load i8** %261
%263 = call i32 (i8*, ...)* @printf(i8* %262)
%264 = alloca i1, align 4
store i1 0, i1* %264
%265 = add i32 0, 3
%266 = sub i32 0, %265
%267 = add i32 0, 2
%268 = icmp sgt i32 %266, %267
store i1 %268, i1* %264
%269 = load i1* %264
%270 = zext i1 %269 to i32
%271 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %270
%272 = load i8** %271
%273 = call i32 (i8*, ...)* @printf(i8* %272)
%274 = alloca i1, align 4
store i1 0, i1* %274
%275 = add i32 0, 2
%276 = sub i32 0, %275
%277 = add i32 0, 3
%278 = sub i32 0, %277
%279 = icmp sgt i32 %276, %278
store i1 %279, i1* %274
%280 = load i1* %274
%281 = zext i1 %280 to i32
%282 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %281
%283 = load i8** %282
%284 = call i32 (i8*, ...)* @printf(i8* %283)
%285 = alloca i1, align 4
store i1 0, i1* %285
%286 = add i32 0, 3
%287 = sub i32 0, %286
%288 = add i32 0, 3
%289 = sub i32 0, %288
%290 = icmp sgt i32 %287, %289
store i1 %290, i1* %285
%291 = load i1* %285
%292 = zext i1 %291 to i32
%293 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %292
%294 = load i8** %293
%295 = call i32 (i8*, ...)* @printf(i8* %294)
%296 = alloca i1, align 4
store i1 0, i1* %296
%297 = add i32 0, 3
%298 = add i32 0, 2
%299 = icmp sge i32 %297, %298
store i1 %299, i1* %296
%300 = load i1* %296
%301 = zext i1 %300 to i32
%302 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %301
%303 = load i8** %302
%304 = call i32 (i8*, ...)* @printf(i8* %303)
%305 = alloca i1, align 4
store i1 0, i1* %305
%306 = add i32 0, 2
%307 = add i32 0, 3
%308 = icmp sge i32 %306, %307
store i1 %308, i1* %305
%309 = load i1* %305
%310 = zext i1 %309 to i32
%311 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %310
%312 = load i8** %311
%313 = call i32 (i8*, ...)* @printf(i8* %312)
%314 = alloca i1, align 4
store i1 0, i1* %314
%315 = add i32 0, 1
%316 = add i32 0, 1
%317 = icmp sge i32 %315, %316
store i1 %317, i1* %314
%318 = load i1* %314
%319 = zext i1 %318 to i32
%320 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %319
%321 = load i8** %320
%322 = call i32 (i8*, ...)* @printf(i8* %321)
%323 = alloca i1, align 4
store i1 0, i1* %323
%324 = add i32 0, 3
%325 = sub i32 0, %324
%326 = add i32 0, 2
%327 = icmp sge i32 %325, %326
store i1 %327, i1* %323
%328 = load i1* %323
%329 = zext i1 %328 to i32
%330 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %329
%331 = load i8** %330
%332 = call i32 (i8*, ...)* @printf(i8* %331)
%333 = alloca i1, align 4
store i1 0, i1* %333
%334 = add i32 0, 2
%335 = sub i32 0, %334
%336 = add i32 0, 3
%337 = sub i32 0, %336
%338 = icmp sge i32 %335, %337
store i1 %338, i1* %333
%339 = load i1* %333
%340 = zext i1 %339 to i32
%341 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %340
%342 = load i8** %341
%343 = call i32 (i8*, ...)* @printf(i8* %342)
%344 = alloca i1, align 4
store i1 0, i1* %344
%345 = add i32 0, 3
%346 = sub i32 0, %345
%347 = add i32 0, 3
%348 = sub i32 0, %347
%349 = icmp sge i32 %346, %348
store i1 %349, i1* %344
%350 = load i1* %344
%351 = zext i1 %350 to i32
%352 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %351
%353 = load i8** %352
%354 = call i32 (i8*, ...)* @printf(i8* %353)
%355 = alloca i1, align 4
store i1 0, i1* %355
%356 = add i32 0, 3
%357 = add i32 0, 2
%358 = icmp ne i32 %356, %357
store i1 %358, i1* %355
%359 = load i1* %355
%360 = zext i1 %359 to i32
%361 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %360
%362 = load i8** %361
%363 = call i32 (i8*, ...)* @printf(i8* %362)
%364 = alloca i1, align 4
store i1 0, i1* %364
%365 = add i32 0, 2
%366 = add i32 0, 3
%367 = icmp ne i32 %365, %366
store i1 %367, i1* %364
%368 = load i1* %364
%369 = zext i1 %368 to i32
%370 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %369
%371 = load i8** %370
%372 = call i32 (i8*, ...)* @printf(i8* %371)
%373 = alloca i1, align 4
store i1 0, i1* %373
%374 = add i32 0, 1
%375 = add i32 0, 1
%376 = icmp ne i32 %374, %375
store i1 %376, i1* %373
%377 = load i1* %373
%378 = zext i1 %377 to i32
%379 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %378
%380 = load i8** %379
%381 = call i32 (i8*, ...)* @printf(i8* %380)
%382 = alloca i1, align 4
store i1 0, i1* %382
%383 = add i32 0, 3
%384 = sub i32 0, %383
%385 = add i32 0, 2
%386 = icmp ne i32 %384, %385
store i1 %386, i1* %382
%387 = load i1* %382
%388 = zext i1 %387 to i32
%389 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %388
%390 = load i8** %389
%391 = call i32 (i8*, ...)* @printf(i8* %390)
%392 = alloca i1, align 4
store i1 0, i1* %392
%393 = add i32 0, 2
%394 = sub i32 0, %393
%395 = add i32 0, 3
%396 = sub i32 0, %395
%397 = icmp ne i32 %394, %396
store i1 %397, i1* %392
%398 = load i1* %392
%399 = zext i1 %398 to i32
%400 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %399
%401 = load i8** %400
%402 = call i32 (i8*, ...)* @printf(i8* %401)
%403 = alloca i1, align 4
store i1 0, i1* %403
%404 = add i32 0, 3
%405 = sub i32 0, %404
%406 = add i32 0, 3
%407 = sub i32 0, %406
%408 = icmp ne i32 %405, %407
store i1 %408, i1* %403
%409 = load i1* %403
%410 = zext i1 %409 to i32
%411 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %410
%412 = load i8** %411
%413 = call i32 (i8*, ...)* @printf(i8* %412)
%414 = alloca i1, align 4
store i1 0, i1* %414
%415 = add i32 0, 3
%416 = add i32 0, 2
%417 = icmp eq i32 %415, %416
store i1 %417, i1* %414
%418 = load i1* %414
%419 = zext i1 %418 to i32
%420 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %419
%421 = load i8** %420
%422 = call i32 (i8*, ...)* @printf(i8* %421)
%423 = alloca i1, align 4
store i1 0, i1* %423
%424 = add i32 0, 2
%425 = add i32 0, 3
%426 = icmp eq i32 %424, %425
store i1 %426, i1* %423
%427 = load i1* %423
%428 = zext i1 %427 to i32
%429 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %428
%430 = load i8** %429
%431 = call i32 (i8*, ...)* @printf(i8* %430)
%432 = alloca i1, align 4
store i1 0, i1* %432
%433 = add i32 0, 1
%434 = add i32 0, 1
%435 = icmp eq i32 %433, %434
store i1 %435, i1* %432
%436 = load i1* %432
%437 = zext i1 %436 to i32
%438 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %437
%439 = load i8** %438
%440 = call i32 (i8*, ...)* @printf(i8* %439)
%441 = alloca i1, align 4
store i1 0, i1* %441
%442 = add i32 0, 3
%443 = sub i32 0, %442
%444 = add i32 0, 2
%445 = icmp eq i32 %443, %444
store i1 %445, i1* %441
%446 = load i1* %441
%447 = zext i1 %446 to i32
%448 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %447
%449 = load i8** %448
%450 = call i32 (i8*, ...)* @printf(i8* %449)
%451 = alloca i1, align 4
store i1 0, i1* %451
%452 = add i32 0, 2
%453 = sub i32 0, %452
%454 = add i32 0, 3
%455 = sub i32 0, %454
%456 = icmp eq i32 %453, %455
store i1 %456, i1* %451
%457 = load i1* %451
%458 = zext i1 %457 to i32
%459 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %458
%460 = load i8** %459
%461 = call i32 (i8*, ...)* @printf(i8* %460)
%462 = alloca i1, align 4
store i1 0, i1* %462
%463 = add i32 0, 3
%464 = sub i32 0, %463
%465 = add i32 0, 3
%466 = sub i32 0, %465
%467 = icmp eq i32 %464, %466
store i1 %467, i1* %462
%468 = load i1* %462
%469 = zext i1 %468 to i32
%470 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %469
%471 = load i8** %470
%472 = call i32 (i8*, ...)* @printf(i8* %471)
%473 = alloca i1, align 4
store i1 0, i1* %473
%474 = add i1 0, 1
store i1 %474, i1* %473
%475 = load i1* %473
br i1 %475, label %.label1, label %.label2
.label1:
%476 = add i1 0, 1
store i1 %476, i1* %473
br label %.label2
.label2:
%477 = load i1* %473
%478 = zext i1 %477 to i32
%479 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %478
%480 = load i8** %479
%481 = call i32 (i8*, ...)* @printf(i8* %480)
%482 = alloca i1, align 4
store i1 0, i1* %482
%483 = add i1 0, 1
store i1 %483, i1* %482
%484 = load i1* %482
br i1 %484, label %.label3, label %.label4
.label3:
%485 = add i1 0, 0
store i1 %485, i1* %482
br label %.label4
.label4:
%486 = load i1* %482
%487 = zext i1 %486 to i32
%488 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %487
%489 = load i8** %488
%490 = call i32 (i8*, ...)* @printf(i8* %489)
%491 = alloca i1, align 4
store i1 0, i1* %491
%492 = add i1 0, 0
store i1 %492, i1* %491
%493 = load i1* %491
br i1 %493, label %.label5, label %.label6
.label5:
%494 = add i1 0, 1
store i1 %494, i1* %491
br label %.label6
.label6:
%495 = load i1* %491
%496 = zext i1 %495 to i32
%497 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %496
%498 = load i8** %497
%499 = call i32 (i8*, ...)* @printf(i8* %498)
%500 = alloca i1, align 4
store i1 0, i1* %500
%501 = add i1 0, 0
store i1 %501, i1* %500
%502 = load i1* %500
br i1 %502, label %.label7, label %.label8
.label7:
%503 = add i1 0, 0
store i1 %503, i1* %500
br label %.label8
.label8:
%504 = load i1* %500
%505 = zext i1 %504 to i32
%506 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %505
%507 = load i8** %506
%508 = call i32 (i8*, ...)* @printf(i8* %507)
%509 = alloca i1, align 4
store i1 0, i1* %509
%510 = add i1 0, 1
store i1 %510, i1* %509
%511 = load i1* %509
%512 = xor i1 %511, true
br i1 %512, label %.label9, label %.label10
.label9:
%513 = add i1 0, 1
store i1 %513, i1* %509
br label %.label10
.label10:
%514 = load i1* %509
%515 = zext i1 %514 to i32
%516 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %515
%517 = load i8** %516
%518 = call i32 (i8*, ...)* @printf(i8* %517)
%519 = alloca i1, align 4
store i1 0, i1* %519
%520 = add i1 0, 1
store i1 %520, i1* %519
%521 = load i1* %519
%522 = xor i1 %521, true
br i1 %522, label %.label11, label %.label12
.label11:
%523 = add i1 0, 0
store i1 %523, i1* %519
br label %.label12
.label12:
%524 = load i1* %519
%525 = zext i1 %524 to i32
%526 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %525
%527 = load i8** %526
%528 = call i32 (i8*, ...)* @printf(i8* %527)
%529 = alloca i1, align 4
store i1 0, i1* %529
%530 = add i1 0, 0
store i1 %530, i1* %529
%531 = load i1* %529
%532 = xor i1 %531, true
br i1 %532, label %.label13, label %.label14
.label13:
%533 = add i1 0, 1
store i1 %533, i1* %529
br label %.label14
.label14:
%534 = load i1* %529
%535 = zext i1 %534 to i32
%536 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %535
%537 = load i8** %536
%538 = call i32 (i8*, ...)* @printf(i8* %537)
%539 = alloca i1, align 4
store i1 0, i1* %539
%540 = add i1 0, 0
store i1 %540, i1* %539
%541 = load i1* %539
%542 = xor i1 %541, true
br i1 %542, label %.label15, label %.label16
.label15:
%543 = add i1 0, 0
store i1 %543, i1* %539
br label %.label16
.label16:
%544 = load i1* %539
%545 = zext i1 %544 to i32
%546 = getelementptr inbounds [2 x i8*]* @str.bools_array, i32 0, i32 %545
%547 = load i8** %546
%548 = call i32 (i8*, ...)* @printf(i8* %547)

br label %.return1
.return1:
%.return_final = load i32* %return
ret i32 %.return_final
}


