import RxSwift

/*:
 [Previous](@previous)
 
 # ignoreElements

 - ignoreElements는 .next 이벤트를 차단한다. 하지만 stop 이벤트인 .complted 또는 .error 이벤트는 받는다.
 - completed 되는 시점만 알림받고 싶을 때 유용하다.
 
 
 ![ignoreElements](ignoreElements.png)
 
 */

example("ignoreElements") {
  
  enum TestError: Error {
    case test
  }
  
  let subject = PublishSubject<String>()
  
  let disposeBag = DisposeBag()
  
  subject
    .ignoreElements()
    .subscribe { _ in
      print("you're out")
    }
    .disposed(by: disposeBag)
  
//  subject.onNext("X")
//  subject.onNext("X")
//  subject.onNext("X")
  //위의 코드를 호출해도 아무것도 출력되지 않는다. 왜냐하면 .next 이벤트는 무시되기 때문이다.
  
//  subject.onCompleted()
//  subject.onError(TestError.test)
  
  //이제 구독자는 .completed 이벤트를 받고 출력을 한다

}



/*:
 
 [Next](@next)
 */
