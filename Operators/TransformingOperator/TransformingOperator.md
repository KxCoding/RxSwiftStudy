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


## 2-3. Scan
![Scan](https://github.com/KxCoding/RxSwiftStudy/blob/master/Operators/TransformingOperator/Images/Scan.png)

: 초기 데이터가 있고, 이 데이터를 시작으로 누산을 한다.

1) Function Prototype
```swift
public func scan<A>(_ seed: A, accumulator: @escaping (A, E) throws -> A)
-> Observable<A>

// ## Parameter
// seed : 초기 데이터
// accumulator : 들어온 데이터와 현재까지 누산된 데이터로 연산을 하여, 새 누산 데이터로 갱신함
//
// ## Return
// group으로 나누어진 Observable
```

2) Example Code
```swift
let disposeBag = DisposeBag()
let subject = PublishSubject<Int>()
subject
    .scan(0, accumulator: { (accumulatedData, newData) -> Int in
        return accumulatedData + newData
    })
    .subscribe(onNext: { (accumulatedData) in
        print(accumulatedData)
    }).disposed(by: disposeBag)

subject.onNext(1)
subject.onNext(2)
subject.onNext(3)
subject.onNext(4)
subject.onNext(5)
```

* console의 출력 결과는 1, 3, 6, 10, 15 이다.


## 2-4. Window
![Window](https://github.com/KxCoding/RxSwiftStudy/blob/master/Operators/TransformingOperator/Images/Window.png)

: Buffer와 유사하나, Window는 Subscriber에게 Observable을 보낸다.

1) Function Prototype
```swift
public func window(timeSpan: RxTimeInterval, count: Int, scheduler: SchedulerType)
-> Observable<Observable<E>>

// ## Parameter
// timeSpan : Timeout 값
// count : Window 크기
// scheduler : 스케줄러
//
// ## Return
// Observable의 Observable
```

2) Example Code
```swift
let disposeBag = DisposeBag()
let subject = PublishSubject<Int>()
subject
    .window(timeSpan: 2, count: 2, scheduler: MainScheduler.instance)
    .subscribe(onNext: { (window) in
        window.asObservable().subscribe(onNext: { (int) in
            print(int)
        }, onDisposed: {
            print("disposed")
        }).disposed(by: disposeBag)
    }).disposed(by: disposeBag)

subject.onNext(1)
subject.onNext(2)
subject.onNext(3)
subject.onNext(4)
subject.onNext(5)
```

* console의 출력 결과는 (1, 2, disposed), (3, 4, disposed), (5, disposed) 이다.
(5, disposed)는 timeout이 발생하여, 5만 출력된 것이다.


## 2-5. Map
![Map](https://github.com/KxCoding/RxSwiftStudy/blob/master/Operators/TransformingOperator/Images/Map.png)

: Observable에서 받은 데이터들을 다른 형태로 변환.

1) Function Prototype
```swift
public func map<R>(_ transform: @escaping (E) throws -> R) -> Observable<R>

// ## Parameter
// transform : 데이터를 변환하는 closure
//
// ## Return
// 변환된 데이터들의 Observable
```

2) Example Code
```swift
let disposeBag = DisposeBag()
let subject = PublishSubject<Int>()
subject
    .map({ (int) -> Int in
        return int * 2
    })
    .subscribe(onNext: { (int) in
        print(int)
    }).disposed(by: disposeBag)

subject.onNext(1)
subject.onNext(2)
subject.onNext(3)
subject.onNext(4)
subject.onNext(5)
subject.onCompleted()
```

* console의 출력 결과는 2, 4, 6, 8, 10 이다.


## 2-5. FlatMap
![FlatMap](https://github.com/KxCoding/RxSwiftStudy/blob/master/Operators/TransformingOperator/Images/FlatMap.png)

: Observable에서 받은 데이터들로 다른 Observable 생성

1) Function Prototype
```swift
public func flatMap<O: ObservableConvertibleType>(_ selector: @escaping (E) throws -> O)
-> Observable<O.E>

// ## Parameter
// transform : 데이터를 변환하는 closure
//
// ## Return
// 변환된 데이터들의 Observable
```

2) Example Code
```swift
let disposeBag = DisposeBag()
let subject = PublishSubject<Int>()
subject
    .map({ (int) -> Int in
        return int * 2
    })
    .subscribe(onNext: { (int) in
        print(int)
    }).disposed(by: disposeBag)

subject.onNext(1)
subject.onNext(2)
subject.onNext(3)
subject.onNext(4)
subject.onNext(5)
subject.onCompleted()
```

* console의 출력 결과는 2, 4, 6, 8, 10 이다.
