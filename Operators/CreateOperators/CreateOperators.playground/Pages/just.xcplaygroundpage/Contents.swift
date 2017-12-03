import RxSwift

/*:
 [Previous](@previous)
 
 # just
 
 Observable.just() 함수는 단 하나의 이벤트를 발행하는 Observable을 생성합니다.
 
 ![just](just.png)
 
 */

let justObservable = Observable<String>.just("🔴")

justObservable.subscribe { event in
  print(event)
}

/*:
 
 결과
 ```
 next(🔴)
 completed
 ```
 
 [Next](@next)
 */
