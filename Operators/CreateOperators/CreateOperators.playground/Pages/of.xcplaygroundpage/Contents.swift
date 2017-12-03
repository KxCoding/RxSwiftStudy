import RxSwift

/*:
 [Previous](@previous)
 
 # of
 
 Observable.of() 함수는 고정된 개수의 요소로부터 Observable을 생성합니다.
 
 */

let ofObservable = Observable<Int>.of(1, 2, 3, 4, 5)

ofObservable.subscribe { event in
  print(event)
}

print("")

/*:
 
 결과
 ```
 next(1)
 next(2)
 next(3)
 next(4)
 next(5)
 completed
 ```
 
 */

let ofObservable2 = Observable<String>.of("A", "B", "C", "D", "E", "F")

ofObservable2.subscribe { event in
  print(event)
}

/*:
 
 결과
 ```
 next(A)
 next(B)
 next(C)
 next(D)
 next(E)
 next(F)
 completed
 ```
 
 [Next](@next)
 */
