import Foundation
import PlaygroundSupport
import RxSwift

PlaygroundPage.current.needsIndefiniteExecution = true

/*:
 [Previous](@previous)
 
 # interval
 
 Observable.interval() 함수는 일정시간 간격으로 Int 이벤트를 무한히 발행합니다.
 첫번째 파라미터 period 만큼 쉬었다가 이벤트를 발행합니다.
 0부터 시작
 
 ![interval](interval.png)
 
 */

let intervalObservable = Observable<Int>.interval(1.0, scheduler: MainScheduler.instance)

intervalObservable.subscribe { event in
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
 next(5)
 next(6)
 next(7)
 next(8)
 next(9)
 next(10)
 next(11)
 next(12)
 ...무한
 ```
 
 [Next](@next)
 */
