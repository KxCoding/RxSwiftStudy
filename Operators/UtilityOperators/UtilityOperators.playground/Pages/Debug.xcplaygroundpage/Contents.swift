//: [Previous - Timeout Operator](@previous)
/*:
 Debug
 
 Observable에서 발생하는 이벤트에 대한 로그를 출력한다.
 */
import Foundation
import RxSwift

enum MyError: Error {
   case unknownError
}

let bag = DisposeBag()
let o = PublishSubject<String>()

o.debug().subscribe().disposed(by: bag)
o.debug("**TRIM**", trimOutput: true).subscribe().disposed(by: bag)
o.debug("**FULL**", trimOutput: false).subscribe().disposed(by: bag)

print(String(repeating: "-", count: 60))
o.onNext("first")

print(String(repeating: "-", count: 60))
o.onNext("second")

print(String(repeating: "-", count: 60))
o.onNext("third - Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")

//print(String(repeating: "-", count: 60))
//o.onError(MyError.unknownError)

print(String(repeating: "-", count: 60))
o.onCompleted()

