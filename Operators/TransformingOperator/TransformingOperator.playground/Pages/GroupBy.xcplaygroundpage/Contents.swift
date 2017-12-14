/*:
 [Previous](@previous)
 
 # GroupBy
 - Observable을 그룹들로(각 그룹을 key로 구분함) 나누는 연산.
 
 
 ## function prototype
 
 - ### public func groupBy<K: Hashable>(keySelector: @escaping (E) throws -> K)
 - ### -> Observable<GroupedObservable<K,E>>
 
 
 ## parameters
 - ### keySelector: (E) throws -> K
 - : Observable이 속할 그룹의 key를 계산.
 
 
 ## return
 - ### 그룹화된 Observable
 
 */
import Foundation
import RxSwift


private enum IntegerCase {
    case odd
    case even
    case other
}


private extension Int {
    var integerCase: IntegerCase {
        return self % 2 == 0 ? .even : .odd
    }
}


example("GroupBy 예제") {
    print("- inputs : 1, 2, 3")
    print("- expected : [홀수] 1, [짝수] 2, [홀수] 3 \n")
    
    let disposeBag = DisposeBag()
    let subject = PublishSubject<Int>()
    subject.groupBy(keySelector: { (int) -> IntegerCase in
        return int.integerCase
    }).subscribe(onNext: { (groupedObservable) in
        switch groupedObservable.key {
        case .odd:
            groupedObservable.asObservable().subscribe(onNext: {
                print("[홀수] \($0)")
            }, onDisposed: {
                print("[홀수] group disposed")
            }).disposed(by: disposeBag)
            break
        case .even:
            groupedObservable.asObservable().subscribe(onNext: {
                print("[짝수] \($0)")
            }, onDisposed: {
                print("[짝수] group disposed")
            }).disposed(by: disposeBag)
            break
        default:
            break
        }
        
    }, onDisposed: {
        print("disposed")
    }).disposed(by: disposeBag)
    
    subject.onNext(1)
    subject.onNext(2)
    subject.onNext(3)
    subject.onCompleted()
}
//메모리 체크 확인햅괴
/*:
 [Next](@next)
 */

