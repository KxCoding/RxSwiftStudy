//: [Previous](@previous)

/*:
 ## Publish
 
 일반 Observable을 Connectable Observable로 변환
 
 ![publishConnect](publishConnect.png)
 
 Connectable Observable은 Observable과 비슷하지만, 구독할 때 항목을 내보내지 않고 Connect 연산자가 적용된 경우에만 예외입니다. 이 방법으로 Observable이 선택한 시간에 항목을 내보내도록 요청할 수 있습니다.
 */

import RxSwift

playgroundTimeLimit(seconds: 15.0)

let disposeBag: DisposeBag = DisposeBag()

let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance).publish()

_ = interval
    .subscribe(onNext: { print("Subscription: 1, Event: \($0)") })

delay(5) {
    print("Starting Second Subscription at 5 seconds")
    _ = interval
        .subscribe(onNext: { print("Subscription: 2, Event: \($0)") })
}


//: [Next](@next)
