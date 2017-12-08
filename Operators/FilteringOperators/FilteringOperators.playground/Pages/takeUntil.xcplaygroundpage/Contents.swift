import RxSwift
import RxCocoa

/*:
 [Previous](@previous)
 
 # takeUntil
 
- takeUntil 연산자도 skipUntil 연산자와 비슷하다. triggerSubject가 .next 이벤트를 emit 할 때까지 계속 이벤트를 통과하고 trigger가 next 이벤트를 emit 하면 더이상 통과시키지 않는다
- disposeBag 사용 없이 구독을 해제하고 싶을 때 사용할수 있다
 
 */

example("takeUntil") {
  
  let disposeBag = DisposeBag()
  
  let subject = PublishSubject<String>()
  let trigger = PublishSubject<String>()
  
  subject
    .takeUntil(trigger)
    .subscribe(onNext: {
      print($0)
    })
    .disposed(by: disposeBag)
  
  subject.onNext("1")
  subject.onNext("2")
  
//  trigger.onNext("X")
//  subject.onNext("3")
  //trigger가 emit한 이후로는 더이상 출력하지 않는다
  
  
  //takeUntil 연산자는 disposeBag 없이 구독 해제에도 사용될수 있다
  //이전 코드의 trigger를 self의 해제로 대체했다.
  
  //  Observable.of("A", "A", "B", "B", "A")
  //    .takeUntil(self.rx.deallocated)
  //    .subscribe(onNext: {
  //      print($0)
  //    })
}


/*:
 
 [Next](@next)
 */







