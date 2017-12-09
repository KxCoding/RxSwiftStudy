# Subject ?
`Observer`와 `Observable` 두 역활을 수행하는 `프록시` 입니다.
`Observer`의 역활로, 새로운 특정 `event`를 수신합니다. `Observable`의 역활로는 `event`들을 내보낼 수 있습니다.

![Alt text](https://github.com/KxCoding/RxSwiftStudy/blob/master/Subject/images/subject.png)

![Alt text](https://github.com/KxCoding/RxSwiftStudy/blob/master/Subject/images/subject2.png)

## Subject 종류
* PublishSubject
* BehaviorSubject
* Variable
* ReplaySubject

### PublishSubject
`새로운 값`을 수신받으면 현재 자신을 구독중인 `구독자`들에게 `새로운 값`을 *그대로 내보냅니다*.

![Alt text](https://github.com/KxCoding/RxSwiftStudy/blob/master/Subject/images/publishSubject.png)

```swift
let subject = PublishSubject<Int>()
subject.onNext(1)

// 출력:
//
let subscription1 = subject.subscribe { event in
  print("1)", event.element ?? event)
})

subject.onNext(2) // subject.on(.next(2)
subject.onNext(3)

// 출력:
// 1) 2
// 1) 3

let subscription2 = subject.subscribe { event in
  print("2)", event.element ?? event)
}

subject.onNext(4)

// 출력:
// 1) 4
// 2) 4
```

#### PublishSubject lifeCycle
`PublishSubject`는 `.completed` or `.error` (`stop event`)를 수신받을 경우, 현재 구독하고 있는 모든 구독자에게 `stop event`를 방출하고 종료된다(더 이상 `.next` event를 발행 수 없다는 의미). 그 이후에 `새로운 구독자`가 있을 경우  `새로운 구독자`에게 `stop event`를 방출한다.

```swift
let subject = PublishSubject<Int>()

subject.onNext(1)
// 출력:
//

let subscription1 = subject.subscribe { event in
  print("1)", event.element ?? event)
}

subject.onNext(2)
// 출력:
// 1) 2

let subscription2 = subject.subscribe { event in
  print("2)", event.element ?? event)
}

subject.onNext(3)
// 출력:
// 1) 3
// 2) 3

subscription1.dispose()
subject.onNext(4)

// 출력:
// 2) 4

subject.onCompleted() // or onError(error: Error)
// 출력:
// 2) completed

subject.onNext(5)

let subscription3 = subject.subscribe { event in
  print("3)", event.element ?? event)
}
// 출력:
// 3) completed
```

### BehaviorSubject
`PublishSubject`와 비슷하지만, `초기 값`을 가지고 시작하며, `최신 값`을 `새로운 구독자`에게 *재생합니다*.

![Alt text](https://github.com/KxCoding/RxSwiftStudy/blob/master/Subject/images/behaviorSubject.png)

```swift

enum MyError: Error {
  case myError
}

let disposeBag = DisposeBag()

let subject = BehaviorSubject<Int>(value: 1)

let subscription1 = subject.subscribe { event in
  print("1)", event.element ?? event)
}
.disposed(by: disposeBag)

// 출력:
// 1) 1

subject.onNext(2)
// 출력:
// 1) 2

let subscription2 = subject.subscribe { event in
  print("2)", event.element ?? event)
}
.disposed(by: disposeBag)
// 출력:
// 2) 2

subject.onNext(3)
// 출력:
// 1) 3
// 2) 3

subject.onError(MyError.myError)
// 출력:
// 1) error
// 2) error

let subscription3 = subject.subscribe { event in
  print("3)", event.element ?? event)
}
// 출력:
// 3) error
```

#### BehaviorSubject lifeCycle
`PublishSubject`와 동일하다.

### ReplaySubject
`BehaviorSubject`와 비슷하지만, 지정된 `버퍼 사이즈`로 초기화되며, 지정된 사이즈까지 버퍼를 유지하고 `새로운 구독자`에게 버퍼에 있는 값을 *재생합니다*.

![Alt text](https://github.com/KxCoding/RxSwiftStudy/blob/master/Subject/images/replaySubject.png)

```swift
let disposeBag = DisposeBag()

let subject = ReplaySubject<Int>.create(bufferSize: 2)

subject.onNext(1)
subject.onNext(2)
subject.onNext(3)

// 출력:
//

let subscription1 = subject.subscribe { event in
  print("1)", event.element ?? event)
}

// 출력:
// 1) 2
// 1) 3

subject.onNext(4)
// 출력:
// 1) 4

let subscription2 = subject.subscribe { event in
  print("2)", event.element ?? event)
}

// 출력:
// 2) 3
// 2) 4

subject.onNext(5)
// 출력:
// 1) 5
// 2) 5

subject.onError(MyError.myError)
// 출력:
// 1) error
// 2) error

/**
subject.dispose()
let subscription3 = subject.subscribe { event in
  print("3)", event.element ?? event)
}
// 출력:
// Object `RxSwift.ReplayMany<Swift.Int>` was already disposed.
*/

// 여전히 버퍼가 살아있음.
let subscription3 = subject.subscribe { event in
  print("3)", event.element ?? event)
}
// 출력:
// 3) 4
// 3) 5
// 3) error
```

#### ReplaySubject lifeCycle
`PublishSubject`와 비슷하지만 차이가 있다.

### Variable
`BehaviorSubject`의 `랩퍼 클래스`이고이며, 현재 값을 `value`변수에 저장하며, 저장된 값을 `구독자`에게 보낸다. 즉, `value`변수에 값을 설정하면 자동으로 `onNext(_:)` 가 호출된다. 그리고 `Variable`는 `Error` event를 내보내지 않습니다.

```swift
let disposeBag = DisposeBag()

let variable = Variable<Int>(1)

variable.value = 2

let subscription1 = variable.asObservable().subscribe { event in
  print("1)", event.element ?? event)
}
.disposed(by: disposeBag)
// 출력
// 1) 2

variable.value = 3
// 출력
// 1) 3

let subscription2 = variable.asObservable().subscribe { event in
  print("2)", event.element ?? event)
}
.disposed(by: disposeBag)
// 출력
// 2) 3

variable.value = 4
// 출력
// 1) 4
// 2) 4
```


