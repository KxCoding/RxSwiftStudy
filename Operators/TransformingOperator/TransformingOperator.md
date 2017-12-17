# Transforming Operator

## 1. Intro
: Transforming Operator는 Observable에서 보낸 데이터들을 변경하는 연산이다. 보통, Observable에서 보내진 데이터를 Subscriber가 활용할 수 있도록 데이터를 가공하는 용도로 사용한다.

## 2. Operators
[CocoaPods](http://http://reactivex.io/) 문서에 있는 Transforming Operator는 총 6개로, 아래와 같다.
* Buffer
* GroupBy
* Scan
* Window
* Map
* FlatMap

## 2-1. buffer
![Buffer](https://github.com/KxCoding/RxSwiftStudy/blob/master/Operators/TransformingOperator/Images/Buffer.png)

: Buffer가 꽉 차거나, Timeout이 되면 Buffer안의 데이터들을 Subscriber에게 보낸다. Error가 발생하면, Buffer안의 데이터들은 무시하고, Error만 전달한다.

1) Function Prototype
```swift
public func buffer(timeSpan: RxTimeInterval, count: Int, scheduler: SchedulerType)
-> RxSwift.Observable<[Self.E]>

// ## Parameter
// timeSpan : Timeout 값
// count : Buffer 크기
// scheduler : 스케줄러
//
// ## Return
// Sequence Observable
```

2) Example Code
```swift
let disposeBag = DisposeBag()
let subject = PublishSubject<String>()
subject
    .buffer(timeSpan: 2.0, count: 2, scheduler: MainScheduler.instance)
    .asObservable()
    .subscribe(onNext: { (strings) in
        print(strings)
    }).disposed(by: disposeBag)

subject.onNext("1")
subject.onNext("2")
subject.onNext("3")
```

* console의 출력 결과는, ["1", "2"]가 먼저 출력되고 2초 뒤 ["3"]가 출력된다.


## 2-2. groupBy
![groupBy](https://github.com/KxCoding/RxSwiftStudy/blob/master/Operators/TransformingOperator/Images/GroupBy.png)

: 받은 데이터들에 대해 key를 생성하고, 이 key에 대응하는 Observable을 생성하여 받은 데이터들을 보낸다.

1) Function Prototype
```swift
public func groupBy<K: Hashable>(keySelector: @escaping (E) throws -> K)
-> Observable<GroupedObservable<K,E>>

// ## Parameter
// keySelector : 데이터에 대한 key를 계산하는 closure
//
// ## Return
// group으로 나누어진 Observable
```

2) Example Code
```swift
extension Int {
    var integerCase: IntegerCase {
        return self % 2 == 0 ? .even : .odd
    }
}

let disposeBag = DisposeBag()
let subject = PublishSubject<Int>()
subject.groupBy(keySelector: { (int) -> IntegerCase in
    return int.integerCase
}).subscribe(onNext: { (groupedObservable) in
    switch groupedObservable.key {
    case .odd:
        groupedObservable.asObservable().subscribe(onNext: {
            print("[홀수] \($0)")
        }, onDisposed: {
            print("[홀수] group disposed")
        }).disposed(by: disposeBag)
        break
    case .even:
        groupedObservable.asObservable().subscribe(onNext: {
            print("[짝수] \($0)")
        }, onDisposed: {
            print("[짝수] group disposed")
        }).disposed(by: disposeBag)
        break
    default:
        break
    }

}, onDisposed: {
    print("disposed")
}).disposed(by: disposeBag)

subject.onNext(1)
subject.onNext(2)
subject.onNext(3)
```

* console의 출력 결과는 [홀수] 1, [짝수] 2, [홀수] 3 이다.
