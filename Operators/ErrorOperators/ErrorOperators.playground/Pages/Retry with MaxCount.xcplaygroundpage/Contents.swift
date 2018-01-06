//: [Previous - retry()](@previous)
/*:
 # retry(_:)
 
 retry()와 동일하지만 재시도 횟수를 직접 지정할 수 있다.
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
   .retry(3)
   .filter { 200..<300 ~= $0.0.statusCode }
   .map { $1.count }
   .catchErrorJustReturn(-1)
   .subscribe(onNext: { count in
      print(count)
   })
   .disposed(by: bag)


DispatchQueue.main.asyncAfter(deadline: .now() + 20) {
   PlaygroundPage.current.finishExecution()
}


//: [Next - retryWhen(_:)](@next)

