/*:
 [Previous](@previous)
 
 # Map
 - Observable에서 받은 데이터를 다른 형태로 변환
 
 
 ## function prototype
 
 - ### public func map<R>(_ transform: @escaping (E) throws -> R) -> Observable<R>
 
 
 ## parameters
 - ### transform: @escaping (E) throws -> R
 - : 데이터를 변환
 
 ## return
 - ### 변환된 데이터들의 Observable
 
 */
import Foundation
import RxSwift

example("Map 예제") {
    print("- inputs : 1, 2, 3, 4, 5")
    print("- expected : 2, 4, 6, 8, 10\n")
    
    let disposeBag = DisposeBag()
    let subject = PublishSubject<Int>()
    subject
        .map({ (int) -> Int in
            return int * 2
        })
        .subscribe(onNext: { (int) in
            print(int)
        }).disposed(by: disposeBag)
    
    subject.onNext(1)
    subject.onNext(2)
    subject.onNext(3)
    subject.onNext(4)
    subject.onNext(5)
    subject.onCompleted()
}

/*:
 [Next](@next)
 */
