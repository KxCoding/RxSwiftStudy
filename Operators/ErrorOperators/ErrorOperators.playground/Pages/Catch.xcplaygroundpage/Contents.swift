/*:
 # Catch
 
 Observable에서 error가 emit된 경우 바로 종료하지 않고, 새로운 Observable을 리턴하여 복구(recover)한 후 종료한다.
 
 오류 복구 로직이 복잡한 경우에 사용한다. 복구 로직이 단순히 기본값을 리턴하는 것이라면 catchErrorJustReturn(_:)을 사용한다.
 */
import UIKit
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

o.debug()
   .catchError { error in
      return Observable.just(0)
   }
   .subscribe { print($0) }
   .disposed(by: bag)

//: [Next - catchErrorJustReturn(_:)](@next)
