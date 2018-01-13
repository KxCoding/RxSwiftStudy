//: [Previous](@previous)

/*:
 ![observeOn, subscribeOn](os.jpg)
 
 # observeOn
 
 - 이어지는 연산자를 실행할 스케쥴러를 지정한다.
 - 명시적으로 스케쥴러를 지정하지 않으면 요소가 emit된 CurrentScheduler에서 실행된다.
 
 
 # subscribeOn
 
 - 시퀀스의 생성과 해제가 실행되는 스케쥴러를 지정한다.
 - 실제로 이벤트를 emit하는 코드를 실행할 스케쥴러를 지정한다.
 - 명시적으로 지정하지 않으면 subscribe가 호출된 스케쥴러에서 실행된다.
 - 호출 시점에 관계없이 적용된다.
 - 옵저버블이 옵저버에 의해 구독이 시작되는 시점에 사용되는 스레드에만 영향을 준다. 
 
 */

import RxSwift

let globalScheduler = ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global())
let mainScheduler = MainScheduler.instance

let o = Observable.of(1, 2, 3, 4, 5, 6, 7, 8, 9)

o
   .filter {
      print("filter#1 : \(Thread.isMainThread)")
      return $0 > 0
   }
   .observeOn(globalScheduler)
   .filter {
      print("filter#2 : \(Thread.isMainThread)")
      return $0 % 2 == 0
   }
   .subscribeOn(mainScheduler)
   .subscribe {
      print("subscribe : \(Thread.isMainThread)", $0)
}

RunLoop.main.run(until: Date(timeIntervalSinceNow: 30))



