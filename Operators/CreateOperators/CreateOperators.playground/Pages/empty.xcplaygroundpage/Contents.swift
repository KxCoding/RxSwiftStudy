import RxSwift

/*:
 [Previous](@previous)
 
 # empty
 
 Observable.empty() 함수는 아이템을 발행하지 않고 정상적으로 종료되는 Observable을 생성합니다.
 
 ![empty](empty.png)
 
 */

let emptyObservable = Observable<Int>.empty()

emptyObservable.subscribe { event in
  print(event)
}

/*:
 
 결과
 ```
 completed
 ```
 
 [Next](@next)
 */
