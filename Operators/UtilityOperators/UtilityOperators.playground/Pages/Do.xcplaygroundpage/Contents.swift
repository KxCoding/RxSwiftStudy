//: [Previous -  Delay Operator](@previous)
/*:
 # Do
 
 특정 이벤트가 발생될 때마다 실행할 콜백을 구현할 때 활용한다. 특히, side effect를 추가할 수 있어서 유용하다.
 
 옵저버블이 emit 한 이벤트는 변경하지 않으며 다음 연산자로 그대로 전달한다.
 
 
 */


import Foundation
import RxSwift

let bag = DisposeBag()
let o = Observable<Int>.from([1, 2, 3, 4, 5])
o.do(onNext: { item in
   print("onNext: \(item)")
}, onError: { error in
   print("onError: \(error.localizedDescription)")
}, onCompleted: {
   print("onCompleted")
}, onSubscribe: {
   print("onSubscribe")
}, onSubscribed: {
   print("onSubscribed")
}, onDispose: {
   print("onDispose")
}).subscribe().disposed(by: bag)



//: [Next - Timeout Operator](@next)
