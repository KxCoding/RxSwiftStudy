import RxSwift

/*:
 [Previous](@previous)
 
 # skipWhile
 
 - predicate 조건이 false가 나올때까지 계속 skip하고 만약 false가 되어 통과하면 그 이후로는 skip하지 않는다.
 
 
 ![skipWhile](skipWhile.png)
 
 */

example("skipWhile") {
  
  let disposeBag = DisposeBag()
  
  Observable.of(2, 2, 3, 4, 4)
    
    //짝수가 아닌 수가 나올때까지 계속 skip
    .skipWhile { integer in
      integer % 2 == 0
    }
    .subscribe(onNext: {
      print($0)
    })
    .disposed(by: disposeBag)
  
}


/*:
 
 # skipWhileWithIndex
 
 - skipWhileWithIndex 연산자는 predicate를 만족하지 않는 값이 나올 때까지 계속 skip.
 - skipWhileWithIndex 는 predicate에 index값을 사용할 수 있다.
 
 */

example("skipWhileWithIndex") {
  let disposeBag = DisposeBag()
  
  Observable.of("🐱", "🐰", "🐶", "🐸", "🐷", "🐵")
    .skipWhileWithIndex { element, index in
      index < 3
    }
    .subscribe(onNext: { print($0) })
    .disposed(by: disposeBag)
}

/*:
 
 [Next](@next)
 */



