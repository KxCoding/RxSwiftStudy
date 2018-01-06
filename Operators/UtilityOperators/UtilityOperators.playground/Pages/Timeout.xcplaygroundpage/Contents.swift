//: [Previous - Do Operator](@previous)
/*:
 # Timeout
 
 Observable이 emit한 item을 Subscriber에 그대로 전달하지만, 지정된 시간 동안 emit 된 item이 없으면 error를 emit 한다.
 */
import Foundation
import RxSwift
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let bag = DisposeBag()
let timeoutInSecs = RxTimeInterval(3)

let o = Observable<Int>.interval(1, scheduler: MainScheduler.instance).filter { $0 < 7 }
o
   //.debug()
   .timeout(timeoutInSecs, scheduler: MainScheduler.instance)
   .subscribe { print($0) }.disposed(by: bag)


DispatchQueue.main.asyncAfter(deadline: .now() + 20) {
   print("Done")
   PlaygroundPage.current.finishExecution()
}


//: [Next - Debug Operator](@next)
