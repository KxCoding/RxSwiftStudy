import RxSwift

/*:
 [Previous](@previous)
 
 # takeWhile
 
 - predicate 조건이 false가 나올때까지 계속 통과시키고 만약 false가 되어 skip하면 그 이후로는 통과하지 않는다.
 
 ![takeWhile](takeWhile.png)
 
 */

example("takeWhile") {
  let disposeBag = DisposeBag()
  
  Observable.of(1, 2, 3, 4, 3, 2)
    .takeWhile { $0 < 4 }
    .subscribe(onNext: { print($0) })
    .disposed(by: disposeBag)
}

/*:
 
 # takeWhileWithIndex
 
 - takeWhile과 비슷하다.  predicate를 만족하지 않는 값이 나올 때까지 계속 통과.
 - takeWhileWithIndex 는 predicate에 index값을 사용할 수 있다.
 
 */



example("takeWhileWithIndex") {
  
  let disposeBag = DisposeBag()
  
  Observable.of(2, 2, 4, 4, 2, 6)
    .takeWhileWithIndex { integer, index in
      integer % 2 == 0 && index < 3
    }
    .subscribe(onNext: {
      print($0)
    })
    .disposed(by: disposeBag)
}
/*:
 
 [Next](@next)
 */






