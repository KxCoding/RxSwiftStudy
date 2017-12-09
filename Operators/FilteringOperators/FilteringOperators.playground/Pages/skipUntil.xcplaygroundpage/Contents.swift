import RxSwift

/*:
 [Previous](@previous)
 
 # skipUntil
 
 - skipUntil 은 trigger subject가 .next 이벤트를 emit할 때까지 계속 skip한다.
 
 ![skipUntil](skipUntil.png)
 
 */

example("skipUntil") {
  
  let disposeBag = DisposeBag()
  
  let subject = PublishSubject<String>()
  let trigger = PublishSubject<String>()
  
  //trigger subject가 .next 이벤트를 emit할 때까지 subject의 이벤트를 skip하기
  subject
    .skipUntil(trigger)
    .subscribe(onNext: {
      print($0)
    })
    .disposed(by: disposeBag)
  
  subject.onNext("A")
  subject.onNext("B")
  //subject가 .next 이벤트를 두개 emit하더라고 skip하므로 아무것도 출력하지 않는다
  
  //trigger.onNext("X")
  
  //subject.onNext("C")
}



/*:
 
 [Next](@next)
 */




