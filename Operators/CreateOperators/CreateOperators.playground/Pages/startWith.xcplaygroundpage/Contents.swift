import RxSwift

/*:
 [Previous](@previous)
 
 # startWith
 
 Observable.startWith() 함수는 아이템을 발행하기전에 특정 아이템을 먼저 발행하는 Observable을 생성합니다.
 
 ![startWith](startWith.png)
 
 */

let startObservable = Observable<Int>.of(1, 2, 3).startWith(4, 5, 6).startWith(7)

startObservable.subscribe { event in
  print(event)
}

/*:
 
 결과
 ```
 next(7)
 next(4)
 next(5)
 next(6)
 next(1)
 next(2)
 next(3)
 completed
 ```
 
 [Next](@next)
 */
