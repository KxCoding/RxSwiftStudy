//: [Previous - catchErrorJustReturn(_:)](@previous)
/*:
 # retry
 
 Error가 emit된 경우 새로운 next 이벤트가 emit 될 때까지 반복적으로 Observable을 재구독한다.
 하지만 반복적으로 재구독을 시도하는 동안 많은 리소스를 사용하기 때문에 retry(_:)를 통해 재시도 횟수를 지정하는 것이 좋다.
 */

import Foundation
import RxSwift
import PlaygroundSupport
import RxAlamofire

PlaygroundPage.current.needsIndefiniteExecution = true

enum MyError: Error {
   case error
}

let bag = DisposeBag()

let url = URL(string: "https://www.apple.com")!

RxAlamofire.requestString(.get, url)
   .debug("Retry", trimOutput: true)
   .retry()
   .filter { 200..<300 ~= $0.0.statusCode }
   .map { $1.count }
   .subscribe(onNext: { count in
      print(count)
   })
   .disposed(by: bag)


DispatchQueue.main.asyncAfter(deadline: .now() + 20) {
   PlaygroundPage.current.finishExecution()
}


//: [Next - retry(_:)](@next)
