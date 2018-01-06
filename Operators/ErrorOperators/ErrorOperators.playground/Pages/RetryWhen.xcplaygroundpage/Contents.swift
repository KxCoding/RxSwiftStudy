//: [Previous - retry(_:)](@previous)
/*:
 # retryWhen(_:)
 
 오류 발생시 재시도 시점을 지정할 수 있다.
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

var retryCount = 5

RxAlamofire.requestString(.get, url)
   .debug("RetryWhen", trimOutput: true)
   .retryWhen { (errors: Observable<Error>) in
      return errors.flatMapWithIndex { (e, attempts) -> Observable<Int64> in
         if attempts >= retryCount {
            return Observable.error(e)
         }
         print("Error: delay server call retry by \(attempts * 2) second(s)")
         return Observable<Int64>.timer(RxTimeInterval(attempts * 2), scheduler: MainScheduler.instance)
      }
   }
   .filter { 200..<300 ~= $0.0.statusCode }
   .map { $1.count }
   .catchErrorJustReturn(-1)
   .subscribe(onNext: { count in
      print(count)
   })
   .disposed(by: bag)


DispatchQueue.main.asyncAfter(deadline: .now() + 200) {
   PlaygroundPage.current.finishExecution()
}

