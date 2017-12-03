import RxSwift

/*:
 [Previous](@previous)
 
 # range
 
 Observable.range() 함수는 n부터 m개의 Int 이벤트를 발행하는  Observable을 생성합니다.
 
 ![range](range.png)
 
 */

let rangeObservable = Observable<Int>.range(start: 0, count: 5)

rangeObservable.subscribe { event in
  print(event)
}

/*:
 
 결과
 ```
 next(0)
 next(1)
 next(2)
 next(3)
 next(4)
 completed
 ```
 
 [Next](@next)
 */
