/*:
 [Previous](@previous)
 
 # Scan
 - 누산기를 생각하면 됨. Accumulator.
 - 초기 데이터가 있으며, 이 데이터를 시작으로 누산 시작.
 - 누산된 데이터과 새로 받은 데이터를 이용하여 연산을 취한 결과가, 새로운 누산된 데이터가 됨.
 
 
 ## function prototype
 
 - ### public func scan<A>(_ seed: A, accumulator: @escaping (A, E) throws -> A)
 - ### -> Observable<A>
 
 
 ## parameters
 - ### seed: A
 - : 초기 데이터
 
 - ### accumulator: @escaping (A, E) throws -> A
 - : 누산된 데이터와 새로 받은 데이터로 누산을 함.
 
 
 ## return
 - ### 누산된 데이터들의 Observable.
 
 */
import Foundation
import RxSwift

example("Scan 예제") {
    print("- inputs : 1, 2, 3, 4, 5")
    print("- expected : 1, 3, 6, 10, 15\n")
    
    let disposeBag = DisposeBag()
    let subject = PublishSubject<Int>()
    subject
        .scan(0, accumulator: { (accumulatedData, newData) -> Int in
            return accumulatedData + newData
        })
        .subscribe(onNext: { (accumulatedData) in
            print(accumulatedData)
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

