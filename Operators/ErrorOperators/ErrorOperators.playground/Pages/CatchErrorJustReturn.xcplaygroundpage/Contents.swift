//: [Previous - catch(_:)](@previous)
/*:
 # CatchErrorJustReturn
 */

import Foundation
import RxSwift

enum MyError: Error {
   case error
}

let bag = DisposeBag()

let o = Observable<Int>.create { observer in
   for num in 1...5 {
      observer.onNext(num)
   }
   
   observer.onError(MyError.error)
   
   return Disposables.create { }
}

o.catchErrorJustReturn(0)
   .subscribe { print($0) }
   .disposed(by: bag)

//: [Next - retry(_:)](@next)
