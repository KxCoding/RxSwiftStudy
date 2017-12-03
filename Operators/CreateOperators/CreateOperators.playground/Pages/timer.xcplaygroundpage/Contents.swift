import PlaygroundSupport
import RxSwift

PlaygroundPage.current.needsIndefiniteExecution = true

/*:
 [Previous](@previous)
 
 # timer
 
 Observable.timer() 함수는 지정된 시간이 지나고 난 후 항목을 하나 배출하는 Observable을 생성합니다.
 
 ![timer](timer.png)
 
 */

// interval() 함수와 유사하지만 한번만 실행하는 함수입니다.
let timerObservable = Observable<Int>.timer(3.0, scheduler: MainScheduler.instance)

timerObservable.subscribe { event in
  print(event)
}

/*:
 
 결과
 ```
 next(0)
 completed
 ```
 */

// dueTime 후에 period 마다 아이템 발행
//let timerObservable2 = Observable<Int>.timer(5, period: 2, scheduler: MainScheduler.instance)
//
//timerObservable2.subscribe { event in
//  print(event)
//}

/*:
 
 결과
 ```
 next(0)
 next(1)
 next(2)
 next(3)
 next(4)
 next(5)
 next(6)
 next(7)
 next(8)
 next(9)
 ...무한
 ```
 
 */
