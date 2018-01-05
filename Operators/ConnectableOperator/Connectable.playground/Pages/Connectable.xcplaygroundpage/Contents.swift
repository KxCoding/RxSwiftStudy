
/*:
 # Connectable Operator
 
 더 정밀하게 제어되는 동적 구독을 보유한 전문 Observables.
 
 **Hot Observable**에 속한다.
 
 ### 종류
 
 * **Publish** - 일반 Observable을 Connectable Observable로 변환합니다.
 * **Connect** - Connectable Observable에게 구독자에게 항목을 보내기 시작하도록 지시합니다.
 * **RefCount** - Connectable Observable을 일반 Observable처럼 작동하게 합니다.
 * **Replay** - Observable이 항목을 방출하기 시작한 후에 구독하는 경우에도 모든 옵저버가 같은 순서로 표시된 항목을 보도록 합니다.

 
 ### 참고 자료
 
 - [ReactiveX Connectable Operators](http://reactivex.io/documentation/operators.html#connectable)
 - [Making a playground using RxSwift](https://medium.com/@_achou/making-a-playground-using-rxswift-81d8377bd239)
 - [Understanding Publish, Connect, RefCount and Share in RxSwift](http://www.tailec.com/blog/understanding-publish-connect-refcount-share)
 
 
 */

import RxSwift

var str = "Hello, playground"

let disposeBag: DisposeBag = DisposeBag()

public func delay(_ delay: Double, closure: @escaping () -> ()) {
    DispatchQueue.global().asyncAfter(deadline: .now() + delay) {
        closure()
    }
}


let myObservable: ConnectableObservable = Observable.just("Hello Connectable").publish()

print("Observable subscribe")
myObservable.subscribe(onNext: { msg in
    print("msg = \(msg)")

}, onError: { error in
    print("subscribe error = \(error)")
}, onCompleted: nil, onDisposed: nil)
.disposed(by: disposeBag)

myObservable.subscribe { event in
    
    print("event.element = \(event.element)")
}.disposed(by: disposeBag)

delay(2.0) {
    print("Calling connect after 2.0 seconds")
    myObservable.connect()
}

myObservable.connect()

//Observable.just("Hello Observavle")
//    .subscribe { event in
//        print("event.element = \(event.element)")
//        print("event = \(event)")
//}
//
//ConnectableObservable.just("Hello Connectable")
//    .subscribe { event in
//        print("event.element = \(event.element)")
//        print("event = \(event)")
//}

print("Starting at 0 seconds")
let myObservable2 = Observable<Int>.interval(1, scheduler: MainScheduler.instance).publish()
myObservable2.connect()

myObservable2.subscribe(onNext: {
    print("Next: \($0)")
}, onError: { error in
    print("error = \(error)")
}, onCompleted: nil, onDisposed: nil)

DispatchQueue.global(qos: .default).asyncAfter(deadline: DispatchTime.init(uptimeNanoseconds: 3)) {
    print("Calling connect after 3 seconds")
    myObservable2.connect()
}

DispatchQueue.global(qos: .default).asyncAfter(deadline: DispatchTime.init(uptimeNanoseconds: 6)) {
    print("Subscribing again at 6 seconds")
    myObservable2.subscribe(onNext: {
        print("Next: \($0)")
    }, onError: { error in
        print("error = \(error)")
    }, onCompleted: nil, onDisposed: nil)
}


//: [Next](@next)
