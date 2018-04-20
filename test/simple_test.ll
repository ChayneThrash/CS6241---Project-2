; ModuleID = 'simple_test.bc'
source_filename = "simple_test.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@temp = global i32 0, align 4

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %z = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  %0 = load i32, i32* @temp, align 4
  %cmp = icmp eq i32 %0, 1
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  store i32 1, i32* %x, align 4
  br label %if.end

if.else:                                          ; preds = %entry
  store i32 2, i32* %x, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %while.cond

while.cond:                                       ; preds = %while.body, %if.end
  %1 = load i32, i32* @temp, align 4
  %cmp1 = icmp eq i32 %1, 0
  br i1 %cmp1, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %2 = load i32, i32* @temp, align 4
  %inc = add nsw i32 %2, 1
  store i32 %inc, i32* @temp, align 4
  br label %while.cond

while.end:                                        ; preds = %while.cond
  store i32 0, i32* %y, align 4
  %3 = load i32, i32* @temp, align 4
  %cmp2 = icmp eq i32 %3, 1
  br i1 %cmp2, label %if.then3, label %if.else4

if.then3:                                         ; preds = %while.end
  store i32 1, i32* %y, align 4
  br label %if.end5

if.else4:                                         ; preds = %while.end
  store i32 2, i32* %y, align 4
  br label %if.end5

if.end5:                                          ; preds = %if.else4, %if.then3
  %4 = load i32, i32* %x, align 4
  %5 = load i32, i32* %x, align 4
  %add = add nsw i32 %4, %5
  store i32 1, i32* %z, align 4
  %6 = load i32, i32* @temp, align 4
  %cmp6 = icmp eq i32 %6, 3
  br i1 %cmp6, label %if.then7, label %if.else8

if.then7:                                         ; preds = %if.end5
  store i32 3, i32* %z, align 4
  br label %if.end9

if.else8:                                         ; preds = %if.end5
  store i32 4, i32* %z, align 4
  br label %if.end9

if.end9:                                          ; preds = %if.else8, %if.then7
  %7 = load i32, i32* %y, align 4
  %8 = load i32, i32* %y, align 4
  %add10 = add nsw i32 %7, %8
  ret i32 0
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.1 (tags/RELEASE_401/final)"}
