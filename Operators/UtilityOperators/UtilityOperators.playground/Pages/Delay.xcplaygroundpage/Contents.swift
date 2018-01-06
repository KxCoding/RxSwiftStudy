/*:
 # Delay
 
 새로운 item을 즉시 emit 하지 않고 지정된 시간(초)만큼 연기한다.
 */

import UIKit
import RxSwift
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let bag = DisposeBag()
let delayInSecs = 3

let regular = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
regular.subscribe(onNext: { num in
   print("R) \(num)", terminator: num < delayInSecs ? "\n": "         ")
}).disposed(by: bag)

let delayed = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
delayed.delaySubscription(RxTimeInterval(delayInSecs), scheduler: MainScheduler.instance)
   .subscribe(onNext: { num in
      print("D) \(num)")
   })
   .disposed(by: bag)


DispatchQueue.main.asyncAfter(deadline: .now() + 20) {
   print("Done")
   PlaygroundPage.current.finishExecution()
}

//: [Next - Do Operator](@next)
