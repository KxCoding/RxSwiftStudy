import RxSwift

/*:
 [Previous](@previous)
 
 # never
 
 Observable.never() 함수는 아이템을 발행하지 않고 종료되지 않는 Observable을 생성합니다.
 
 ![never](never.png)
 
 */

let neverObservable = Observable<Int>.never()

neverObservable.subscribe { event in
  print("안찍힘")
}

/*:
 
 결과
 ```
 아이템을 발행하지 않고 종료되지 않아서 결과없음
 ```
 
 [Next](@next)
 */
