import RxSwift

/*:
 [Previous](filter)
 
 # single
 
 - 조건을 만족하는 첫번째 원소만 통과. 조건을 만족하는 것이 1개를 초과하는 순간 에러이벤트 발생
 
 */

example("single") {
  let disposeBag = DisposeBag()
  
  Observable.of("A", "A", "B", "B", "A")
    .single()
    .subscribe(onNext: { print($0) })
    .disposed(by: disposeBag)
}



example("single with conditions") {
  let disposeBag = DisposeBag()
  
  Observable.of("A", "A", "B", "B", "B")
    .single { $0 == "B" }
    .subscribe { print($0) }
    .disposed(by: disposeBag)
  
  Observable.of("A", "A", "B", "A", "A")
    .single { $0 == "B" }
    .subscribe { print($0) }
    .disposed(by: disposeBag)
  
}



/*:
 
 [Next](skip)
 */


