import RxSwift

/*:
 [Previous](@previous)
 
 # elementAt
 
 - 모든 .next 이벤트를 무시하는 것 말고 n번째 next 이벤트만 받고 싶을 때가 있다. 이 때 elementAt 연산자를 사용해서 받고 싶은 이벤트만 받고 나머지는 무시할 수 있다. 예를 들어 elementAt(1) 이라면 두번째 이벤트만 받고 나머지는 무시한다
 
 
 ![elementAt](elementAt.png)
 */

example("elementAt") {
  
  let strikes = PublishSubject<String>()
  
  let disposeBag = DisposeBag()
  
  strikes
    .elementAt(2)
    .subscribe(onNext: { _ in
      print("you're out")
    })
    .disposed(by: disposeBag)
  
  strikes.onNext("X")
  strikes.onNext("X")
//  strikes.onNext("X")
//  strikes.onNext("X")
  
  //세번째 이벤트만 받아서 출력한다
  
}



/*:
 
 [Next](@next)
 */
