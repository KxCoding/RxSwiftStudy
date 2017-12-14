/*:
 [Previous](@previous)
 
 # FlatMap
 - 받은 데이터들을 이용해서, 다른 Observable 생성.
 
 
 ## function prototype
 
 - ### public func flatMap<O: ObservableConvertibleType>(_ selector: @escaping (E) throws -> O)
 - ### -> Observable<O.E>
 
 
 ## parameters
 - ### selector: @escaping (E) throws -> O
 - : 받은 데이터를 이용해서, 새 Observable을 return 함.
 
 
 ## return
 - ### Observable
 
 */
import Foundation
import RxSwift


struct Repository {
    var stars: Variable<Int>
}


example("FlatMap 예제") {
    print("- inputs : 10000(초기값), += 1, += 1, += 1")
    print("- expected : 10000, 10001, 10002, 10003\n")

    let disposeBag = DisposeBag()
    let rxSwift = Repository(stars: Variable(10000))
    let repositories = PublishSubject<Repository>()
    repositories.asObservable()
        .flatMap({
            $0.stars.asObservable()
        })
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)
    
    repositories.onNext(rxSwift)
    rxSwift.stars.value += 1
    rxSwift.stars.value += 1
    rxSwift.stars.value += 1
}

/*:
 [Next](@next)
 */


