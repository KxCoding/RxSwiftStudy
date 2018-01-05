//: [Previous](@previous)

/*:
 ## Replay
 
 Observable이 항목을 방출하기 시작한 후에 구독하는 경우에도 모든 옵저버가 동일한 순서로 표시된 항목을 보도록 해야합니다.
 
 ![replay](replay.png)
 
 Connectable Observable은 Observable과 비슷하지만, 구독할 때 항목을 내보내지 않고 Connect 연산자가 적용된 경우에만 예외입니다. 이 방법으로 Observable이 선택한 시간에 항목을 내보내도록 요청할 수 있습니다.
 
 Replay 연산자를 Connectable Observable로 변환하기 전에 Observable에 적용하면, 결과는 Connectable Observable은 항상 미래 옵저버, 심지어 Connectable Observable이 다른 등록 된 옵저버에게 항목을 방출하기 시작한 후에 등록하는 옵저버조차도 동일한 전체 시퀀스를 방출한다.
 */

import RxSwift

playgroundTimeLimit(seconds: 20.0)

func sampleWithReplayBuffer() {
    print(#function)
    
    let intSequence = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        .replay(5)
    
    _ = intSequence
        .subscribe(onNext: { print("Subscription 1:, Event: \($0)") })
    
    delay(2) { _ = intSequence.connect() }
    
    delay(4) {
        _ = intSequence
            .subscribe(onNext: { print("Subscription 2:, Event: \($0)") })
    }
    
    delay(8) {
        _ = intSequence
            .subscribe(onNext: { print("Subscription 3:, Event: \($0)") })
    }
}

//sampleWithReplayBuffer()





//: [Next](@next)
