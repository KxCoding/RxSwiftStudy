//: [Previous](@previous)

/*:
 ## Refcount
 
 Connectable Observable 을 보통 Observable처럼 행동하게 만든다.
 
 ![publishRefCount](publishRefCount.png)
 
 Connectable Observable은 Observable과 비슷하지만, 구독할 때 항목을 내보내지 않고 Connect 연산자가 적용된 경우에만 예외입니다. 이 방법으로 Observable이 선택한 시간에 항목을 내보내도록 요청할 수 있습니다.
 
 RefCount 연산자는 Connectable Observable에 연결하고 연결 해제하는 프로세스를 자동화합니다. Connectable Observable에서 작동하고 일반 Observable을 반환합니다. 첫 번째 옵저버가 이 Observable에 가입하면 RefCount는 기본 Connectable Observable에 연결됩니다. 그런 다음 RefCount는 다른 옵저버가 얼마나 많은 옵서버를 구독했는지 추적하며 마지막 옵저버가 그렇게 할 때까지 기본 Connectable Observable에서 연결을 끊지 않습니다.
 */

import RxSwift

playgroundTimeLimit(seconds: 20.0)

let disposeBag: DisposeBag = DisposeBag()

print("Starting at 0 seconds")
let myObservable = Observable<Int>.interval(1, scheduler: MainScheduler.instance).publish().refCount()

let subScribe = myObservable.subscribe(onNext: { print("1. event = \($0)") })

delay(3.0) {
    print("Disposing at 3 seconds")
    subScribe.dispose()
}

delay(6.0) {
    print("Subscribing again at 6 seconds")
    myObservable.subscribe(onNext: { print("2. event = \($0)") })
        .disposed(by: disposeBag)
}


//: [Next](@next)
