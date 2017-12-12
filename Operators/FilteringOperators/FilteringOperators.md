
# Filtering Operator(필터링 연산자)
`필터링 연산자`는 `.next` 이벤트에 적용되어 구독을 시작하기 전에 구독자가 원하는 원소만을 받을수 있다.

---

## 종류

### ignore 연산자

* [ignoreElements](ignoreElements)
* [elementAt](elementAt)
* [filter](filter)
* [single](single)

### skip 연산자

* [skip](skip)
* [skipWhile](skipWhile)
* [skipUntil](skipUntil)

### take 연산자

* [take](take)
* [takeWhile](takeWhile)
* [takeUntil](takeUntil)

### distinct 연산자

* [distinctUntilChanged](distinctUntilChanged)

### 시간에 기초한 필터링 연산자

* [take(_:scheduler:)](take_scheduler)
* [throttle(_:scheduler:)](throttle_scheduler)


# ignoreElements

- `ignoreElements`는 `.next` 이벤트를 차단한다. 하지만 `stop` 이벤트인 `.completed` 또는 `.error` 이벤트는 받는다.
- `completed` 되는 시점만 알림받고 싶을 때 유용하다.

![ignoreElements](https://github.com/KxCoding/RxSwiftStudy/blob/master/Operators/FilteringOperators/images/ignoreElements.png)


```swift
enum TestError: Error {
  case test
}

let subject = PublishSubject<String>()

let disposeBag = DisposeBag()

subject
  .ignoreElements()
  .subscribe { _ in
    print("you`re out")
  }
  .disposed(by: disposeBag)
  
subject.onNext("X")
subject.onNext("X")
subject.onNext("X")

// 위의 코드를 호출해도 아무것도 출력되지 않는다. 왜냐하면 .next 이벤트는 무시되기 때문이다.
subject.onCompleted() // or subject.onError(TestError.test)
// 이제 구독자는 .completed 이벤트를 받고 출력을 한다
```
# elementAt

- 모든 `.next` 이벤트를 무시하는 것 말고 n번째 `next` 이벤트만 받고 싶을 때가 있다. 이 때 `elementAt `연산자를 사용해서 받고 싶은 이벤트만 받고 나머지는 무시할 수 있다. 예를 들어 `elementAt(1)` 이라면 두번째 이벤트만 받고 나머지는 무시한다

![elementAt](https://github.com/KxCoding/RxSwiftStudy/blob/master/Operators/FilteringOperators/images/elementAt.png)

```swift
let strikes = PublishSubject<String>()

let disposeBag = DisposeBag()

strikes
  .elementAt(2)
  .subscribe(onNext: { _ in
    print("you`re out")
  })
  .disposed(by: disposeBag)
  
  strikes.onNext("X")
  strikes.onNext("X")
  strikes.onNext("X") // 세번째 이벤트만 받아서 출력한다
  strikes.onNext("X")
  strikes.onNext("X")
```
# filter
- `predicate` 클로저가 각각의 원소에 적용되어 조건이 `true`가 되는 원소만을 통과

![filter](https://github.com/KxCoding/RxSwiftStudy/blob/master/Operators/FilteringOperators/images/filter.png)

```swift
let disposeBag = DisposeBag()
Observable.of(1, 2, 3, 4, 5, 6)
  .filter { integer in
    integer % 2 == 0
  }
  .subscribe(onNext: {
    print($0)
  })
  .disposed(by: disposeBag)
```
결과
```
2
4
6
```

# single
- 조건을 만족하는 첫번째 원소만 통과. 조건을 만족하는 것이 1개를 초과하는 순간 에러이벤트 발생

![single](https://github.com/KxCoding/RxSwiftStudy/blob/master/Operators/FilteringOperators/images/single.png)

```swift
let disposeBag = DisposeBag()
  Observable.of("A", "A", "B", "B", "A")
    .single()
    .subscribe(onNext: { print($0) })
    .disposed(by: disposeBag)
```
결과
```
A
Unhandled error happened: Sequence contains more than one element.
subscription called from:
```
```swift
let disposeBag = DisposeBag()

Observable.of("A", "A", "B", "B", "B")
  .single { $0 == "B" }
  .subscribe { print($0) }
  .disposed(by: disposeBag)

Observable.of("A", "A", "B", "A", "A")
  .single { $0 == "B" }
  .subscribe { print($0) }
  .disposed(by: disposeBag)
```
결과
```
next(B)
error(Sequence contains more than one element.)
next(B)
completed
```

# skip

- 첫번째 원소부터 시작해서 원하는 갯수만큼의 원소를 걸러낼 때 사용한다

![skip](https://github.com/KxCoding/RxSwiftStudy/blob/master/Operators/FilteringOperators/images/skip.png)


```swift
Observable.of("A", "B", "C", "D", "E", "F")
  .skip(3)
  .subscribe(onNext: {
    print($0)
  })
  .disposed(by: disposeBag)
```
결과
```
D
E
F
```

# skipWhile

- `predicate` 조건이 `false`가 나올때까지 계속 `skip`하고 만약 `false`가 되어 통과하면 그 이후로는 `skip`하지 않는다.

![skipWhile](https://github.com/KxCoding/RxSwiftStudy/blob/master/Operators/FilteringOperators/images/skipWhile.png)

```swift
let disposeBag = DisposeBag()
Observable.of(2, 2, 3, 4, 4)
  .skipWhile { integer in
    integer % 2 == 0
  }
  .subscribe(onNext: {
    print($0)
  })
  .disposed(by: disposeBag)
```
결과
```
3
4
4
```
# skipWhileWithIndex

- `skipWhileWithIndex` 연산자는 `predicate`를 만족하지 않는 값이 나올 때까지 계속 `skip`.
- `skipWhileWithIndex` 는 `predicate`에 `index`값을 사용할 수 있다.

```swift
let disposeBag = DisposeBag()

Observable.of("🐱", "🐰", "🐶", "🐸", "🐷", "🐵")
  .skipWhileWithIndex { element, index -> Bool in
    return index < 3
  }
  .subscribe(onNext: { print($0) })
  .disposed(by: disposeBag)
```
결과
```
🐸
🐷
🐵
```

# skipUntil

- `skipUntil` 은 `trigger subject`가 `.next` 이벤트를 `emit`할 때까지 계속 `skip`한다.

![skipUntil](https://github.com/KxCoding/RxSwiftStudy/blob/master/Operators/FilteringOperators/images/skipUntil.png)

```swift
let disposeBag = DisposeBag()

let subject = PublishSubject<String>
let trigger = PublishSubject<String>

subject
  .skipUntil(trigger)
  .subscribe(onNext: {
    print($0)
  })
  .disposed(by: disposeBag)

// trigger subject가 .next 이벤트를 emit할 때까지 subject의 이벤트를 skip하기

subject.onNext("A")
subject.onNext("B")
// subject가 .next 이벤트를 두개 emit하더라고 skip하므로 아무것도 출력하지 않는다

trigger.onNext("X")
subject.onNext("C")
```
결과
```
C
```
# take

- `take` 연산자는 `스킵`과 반대이다. 즉 앞에서부터 몇개의 원소를 통과시킬 것인지 결정한다

![take](https://github.com/KxCoding/RxSwiftStudy/blob/master/Operators/FilteringOperators/images/take.png)


```swift
let disposeBag = DisposeBag()
Observable.of(1, 2, 3, 4, 5, 6)
  .take(3)
  .subscribe(onNext: {
    print($0)
  })
  .disposed(by: disposeBag)
```
결과
```
1
2
3
```
# takeLast

- `takeLast` 연산자는 뒤에서부터 몇개의 원소를 통과시킬 것인지 결정한다

```swift
let disposeBag = DisposeBag()
Observable.of("🐱", "🐰", "🐶", "🐸", "🐷", "🐵")
  .takeLast(3)
  .subscribe(onNext: { print($0) })
  .disposed(by: disposeBag)
```
결과
```
🐸
🐷
🐵
```

# takeWhile

- `predicate` 조건이 `false`가 나올때까지 계속 통과시키고 만약 `false`가 되어 `skip`하면 그 이후로는 통과하지 않는다.
```swift
let disposeBag = DisposeBag()

Observable.of(1, 2, 3, 4, 3, 2)
  .takeWhile { $0 < 4 }
  .subscribe(onNext: { print($0) })
  .disposed(by: disposeBag)
```
결과
```
1
2
3
```
# takeWhileWithIndex

- `takeWhile`과 비슷하다.  `predicate`를 만족하지 않는 값이 나올 때까지 계속 통과.
- `takeWhileWithIndex` 는 `predicate`에 `index`값을 사용할 수 있다.

```swift
let disposeBag = DisposeBag()

Observable.of(2, 2, 4, 4, 2, 6)
  .takeWhileWithIndex { integer, index in
    integer % 2 == 0 && index < 3
  }
  .subscribe(onNext: {
    print($0)
  })
  .disposed(by: disposeBag)
```
결과
```
2
2
4
```

# takeUntil

- `takeUntil` 연산자도 `skipUntil` 연산자와 비슷하다. `triggerSubject`가 `.next` 이벤트를 `emit` 할 때까지 계속 이벤트를 통과하고 `trigger`가 `next` 이벤트를 `emit` 하면 더이상 통과시키지 않는다
- `disposeBag` 사용 없이 구독을 해제하고 싶을 때 사용할수 있다

![takeUntil](https://github.com/KxCoding/RxSwiftStudy/blob/master/Operators/FilteringOperators/images/takeUntil.png)

```swift
let disposeBag = DisposeBag()

let subject = PublishSubject<String>()
let trigger = PublishSubject<String>()

subject
  .takeUntil(trigger)
  .subscribe(onNext: {
    print($0)
  })
  .disposed(by: disposeBag)

subject.onNext("1")
subject.onNext("2")
// 출력:
// 1
// 2

trigger.onNext("X")
subject.onNext("3")
// trigger가 emit한 이후로는 더이상 출력하지 않는다


// takeUntil 연산자는 disposeBag 없이 구독 해제에도 사용될수 있다
// 이전 코드의 trigger를 self의 해제로 대체했다.

//  Observable.of("A", "A", "B", "B", "A")
//    .takeUntil(self.rx.deallocated)
//    .subscribe(onNext: {
//      print($0)
//    })
```

# distinctUntilChanged

- `distinctUntilChanged` 연산자는 연속적인 중복을 막는다

![distinctUntilChanged](https://github.com/KxCoding/RxSwiftStudy/blob/master/Operators/FilteringOperators/images/distinctUntilChanged.png)

```swift
let disposeBag = DisposeBag()

Observable.of("A", "A", "B", "B", "A")
  .distinctUntilChanged()
  .subscribe(onNext: {
    print($0)
  })
  .disposed(by: disposeBag)
```
결과
```
A
B
A
```

# take(_:scheduler:)

- 일정 시간 동안 발생한 이벤트만 받는다
- 특정 시간 이후 `completed` 발생

#  throttle(_:scheduler:)
- 특정 시간 동안 발생한 이벤트 중 가장 최근 이벤트만 받는다
- 입력값이 과도할 때 유용하게 쓸수 있는 연산자이다.
- 예) 검색창 구독이 있고 현재 텍스트를 서버 API에 보낸다. 이 때 사용자가 글자를 빠르게 타이핑하면 타이핑이 끝났을 때의 텍스트만을 서버에 보낸다
- 예) 사용자가 bar 버튼을 탭하면 모달뷰를 띄운다. 더블클릭을 방지해서 모달뷰가 두번 나오는 것을 방지한다.
- 예) 사용자가 드래그할 때 멈추는 지점까지의 영역에 관심이 있는 것이다. 따라서 사용자의 드래그 위치가 멈출 때까지 이벤트를 무시할 수 있다

![throttle_scheduler](https://github.com/KxCoding/RxSwiftStudy/blob/master/Operators/FilteringOperators/images/throttle_scheduler.png)


# debounce
- `throttle`과 비슷
- 차이점: 이벤트 발생할때마다 타이머가 리셋됨

![debounce_scheduler](https://github.com/KxCoding/RxSwiftStudy/blob/master/Operators/FilteringOperators/images/debounce_scheduler.png)



