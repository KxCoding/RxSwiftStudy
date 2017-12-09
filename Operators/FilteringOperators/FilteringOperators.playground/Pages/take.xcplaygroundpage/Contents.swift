import RxSwift

/*:
 [Previous](@previous)
 
 # take
 
 - take 연산자는 스킵과 반대이다. 즉 앞에서부터 몇개의 원소를 통과시킬 것인지 결정한다
 
 ![take](take.png)
 
 */

example("take") {
  
  let disposeBag = DisposeBag()
  
  Observable.of(1, 2, 3, 4, 5, 6)
    .take(3)
    .subscribe(onNext: {
      print($0)
    })
    .disposed(by: disposeBag)
}

/*:
 
 # takeLast
 
 - takeLast 연산자는 뒤에서부터 몇개의 원소를 통과시킬 것인지 결정한다
 
 */

example("takeLast") {
  let disposeBag = DisposeBag()
  
  Observable.of("🐱", "🐰", "🐶", "🐸", "🐷", "🐵")
    .takeLast(3)
    .subscribe(onNext: { print($0) })
    .disposed(by: disposeBag)
}

/*:
 
 [Next](@next)
 */





