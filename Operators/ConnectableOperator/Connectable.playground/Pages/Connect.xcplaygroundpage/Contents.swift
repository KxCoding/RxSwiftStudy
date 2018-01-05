//: [Previous](@previous)

/*:
 ## Connect
 
 Connectable Observable에게 구독자에게 항목을 보내기 시작하도록 지시합니다.
 
 ![publishConnect](publishConnect.png)
 
 Connectable Observable은 Observable과 비슷하지만, 구독할 때 항목을 내보내지 않고 Connect 연산자가 적용된 경우에만 예외입니다. Observable이 항목을 방출하기 전에 의도된 모든 옵저버가 Observable을 구독할 때까지 기다릴 수 있습니다.
 */

import RxSwift

playgroundTimeLimit(seconds: 15.0)

let disposeBag: DisposeBag = DisposeBag()

let interval: ConnectableObservable = Observable<Int>.interval(1, scheduler: MainScheduler.instance).publish()

_ = interval
    .subscribe(onNext: { print("Subscription: 1, Event: \($0)") }).disposed(by: disposeBag)

delay(5) {
    print("Starting Second Subscription at 5 seconds")
    _ = interval
        .subscribe(onNext: { print("Subscription: 2, Event: \($0)") })
}

interval.connect()

//: [Next](@next)
