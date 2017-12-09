import RxSwift

/*:
 [Previous](single)
 
 # skip
 
 - 첫번째 원소부터 시작해서 원하는 갯수만큼의 원소를 걸러낼 때 사용한다
 
 
 ![skip](skip.png)
 
 */

example("skip") {
  
  let disposeBag = DisposeBag()
  
  Observable.of("A", "B", "C", "D", "E", "F")
    .skip(3)
    .subscribe(onNext: {
      print($0)
    })
    .disposed(by: disposeBag)
  
}



/*:
 
 [Next](@next)
 */


