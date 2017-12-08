import RxSwift

/*:
 [Previous](@previous)
 
 # filter
 
 - predicate 클로저가 각각의 원소에 적용되어 조건이 true가 되는 원소만을 통과
 
 */

example("filter") {
  
  let disposeBag = DisposeBag()
  
  Observable.of(1, 2, 3, 4, 5, 6)
    .filter { integer in
      integer % 2 == 0
    }
    .subscribe(onNext: {
      print($0)
    })
    .disposed(by: disposeBag)
  
}



/*:
 
 [Next](single)
 */

