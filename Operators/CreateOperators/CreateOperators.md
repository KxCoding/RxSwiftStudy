 # Create Operator(생성 연산자)
 `Create Operator`의 역할은  `Observable`을 생성합니다. 다른 연산자(`Transforming`, `Filtering`, `Combining` 등..) 도 `Observable`을 생성 할 수 있지만, `Create Operator`는 `Observable`을 처음 만들때 사용합니다. 그래서 다른 연산자보다 먼저 배워야 합니다.

---

## 종류
* [create](create)
* [generate](generate)
* [deferred](deferred)
* [empty](empty)
* [never](never)
* [error](error)
* [from](from)
* [of](of)
* [interval](interval)
* [just](just)
* [range](range)
* [repeatElement](repeatElement)
* [startWith](startWith)
* [timer](timer)
* …

# Event(이벤트) 발생

`Observable`은 이벤트를 발행할 수 있고 3가지 상태를 가지고 있습니다.
```swift
public enum Event<Element> {
  case next(Element)      /// Next element is produced.
  case error(Swift.Error) /// Sequence terminated with an error.
  case completed          /// Sequence completed successfully.
}
```
* **next**: 데이터의 발행을 알립니다. 요소를 포함하고 `error`나 `completed` 가 되기전까지 발행 가능합니다. 0개이상 발행 가능
* **error**: 에러가 발생했다고 알리고 데이터의 발행을 종료합니다.
* **completed**: 모든 데이터의 발행이 완료됐다고 알리고 종료합니다.

`Observable`이 종료되고나면 더이상의 이벤트 발행이 불가능합니다.


# create

`Observable.create()` 함수는 개발자가 `observer`의 `on* 메서드`를 직접 호출해서 `Observable`을 생성합니다.

* 제네릭으로 어떤 타입의 이벤트가 발생할지 설정합니다.
* `observer.on*` 메서드로 이벤트를 발생합니다.
* `observer.on(.next(Element))` or `observer.onNext(Element)`
* `observer.on(.error(Error))` or `observer.onError(Error)`
* `observer.on(.completed)` or `observer.onCompleted()`
* `Disposable` 리턴합니다.

![create](https://github.com/KxCoding/RxSwiftStudy/blob/master/Operators/CreateOperators/images/create.png)

```swift
let nameObservable = Observable<String>.create { observer -> Disposable in
  let names: [String] = [
    "김근영", "이로운", "김민희",
    "손명기", "박정연", "정상엽",
    "이한형", "성일우", "송회문",
    "강수영", "박준우"
  ]
  for name in names {
    observer.on(.next(name))
  }
  observer.on(.completed)
  return Disposable.create {
    // dispose될때 처리할 내용
    print("disposed")
  }
}

nameObservable.subscribe { event in
  print(event)
}
```

결과
```swift
next(김근영)
next(이로운)
next(김민희)
next(손명기)
next(박정연)
next(정상엽)
next(이한형)
next(성일우)
next(송회문)
next(강수영)
next(박준우)
completed
disposed
```

```swift
enum NameError: Error {
  case empty
}

let nameObservable2 = Observable<String>.create { observer -> Disposable in
  let names: [String] = [
    "김근영", "", "이로운", "김민희",
    "손명기", "박정연", "정상엽",
    "이한형", "성일우", "송회문",
    "강수영", "박준우"
  ]
  for name in names {
    if name.isEmpty {
      observer.on(.error(NameError.empty))
    } else {
      observer.on(.next(name))
      print("이벤트 발행했음") // error or completed 이후에 next이벤트 발행 안함
    }
  }
  observer.on(.completed)
  return Disposables.create {
    print("disposed")
  }
}

nameObservable2.subscribe { event in
  print(event)
}
```
결과
```swift
next(김근영)
error(empty)
disposed
```

# generate

`Observable.generate()` 함수의 기본 형식은 3개의 파라미터를 갖습니다.

* `initialState`: 첫 아이템 발생을 위한 초기값
* `condition`: 조건문을 통해 이벤트 발행/종료할지 결정하는 함수
* `iterate`: 이전 아이템 기반으로 다음 아이템 만들어내는 함수

![generate](https://github.com/KxCoding/RxSwiftStudy/blob/master/Operators/CreateOperators/images/generate.png)
```swift
let intGenerateObservable = Observable<Int>.generate(
  initialState: 0,
  condition: { $0 < 5 },
  iterate: { $0 + 1 }
)

intGenerateObservable.subscribe { event in
  print(event)
}
```
결과
```
next(0)
next(1)
next(2)
next(3)
next(4)
completed
```

```swift
let stringGenerateObservable = Observable<String>.generate(
  initialState: "⭐",
  condition: { $0.count < 10 },
  iterate: { "\($0)⭐" }
)

stringGenerateObservable.subscribe { event in
  print(event)
}
```
결과
```
next(⭐)
next(⭐⭐)
next(⭐⭐⭐)
next(⭐⭐⭐⭐)
next(⭐⭐⭐⭐⭐)
next(⭐⭐⭐⭐⭐⭐)
next(⭐⭐⭐⭐⭐⭐⭐)
next(⭐⭐⭐⭐⭐⭐⭐⭐)
next(⭐⭐⭐⭐⭐⭐⭐⭐⭐)
completed
```

# deferred

`Observable.deferred()` 함수는 옵저버가 `subscribe()` 함수를 호출할때까지  `Observable`의 생성을 지연합니다.

![deferred](https://github.com/KxCoding/RxSwiftStudy/blob/master/Operators/CreateOperators/images/deferred.png)

```swift
let deferredObservable = Observable<String>.deferred(
  { Observable<String>.just("defer") }
)

deferredObservable.subscribe { event in
  print(event)
}
```
결과
```
next(defer)
completed
```
# empty

`Observable.empty()` 함수는 아이템을 발행하지 않고 정상적으로 종료되는 `Observable`을 생성합니다.

![empty](https://github.com/KxCoding/RxSwiftStudy/blob/master/Operators/CreateOperators/images/empty.png)

```swift
let emptyObservable = Observable<Int>.empty()

emptyObservable.subscribe { event in
  print(event)
}
```

결과
```
completed
```
# never

`Observable.never()` 함수는 아이템을 발행하지 않고 종료되지 않는 `Observable`을 생성합니다.

![never](https://github.com/KxCoding/RxSwiftStudy/blob/master/Operators/CreateOperators/images/never.png)


결과
```
아이템을 발행하지 않고 종료되지 않아서 결과없음
```
# error

`Observable.error()` 함수는 아이템을 발행하지 않고 에러와 함께 종료되는 `Observable`을 생성합니다.

![error](https://github.com/KxCoding/RxSwiftStudy/blob/master/Operators/CreateOperators/images/throw.png)

```swift
enum TestError: Error {
  case test
}

let errorObservable = Observable<Int>.error(TestError.test)

errorObservable.subscribe { event in
  print(event)
}
```
결과
```
error(test)
```
# from

`Observable.from()` 함수는 **Sequence**(`Array`, `Dictionary`, `Set` 같은)로 부터 `Observable`을 생성합니다.

![from](https://github.com/KxCoding/RxSwiftStudy/blob/master/Operators/CreateOperators/images/from.png)

```swift
// Array
let array: [Int] = [1, 2, 3, 4, 5]

let arrayObservable = Observable.from(array)

arrayObservable.subscribe { event in
  print(event)
}
```
결과
```
next(1)
next(2)
next(3)
next(4)
next(5)
completed
```

```swift
// Dictionary
let dictionary: [Int: String] = [0: "0", 1: "1", 2: "2", 3: "3"]

let dictionaryObservable = Observable.from(dictionary)

dictionaryObservable.subscribe { event in
  print(event)
}
```
결과
```
next((key: 2, value: "2"))
next((key: 0, value: "0"))
next((key: 1, value: "1"))
next((key: 3, value: "3"))
completed
```

```swift
// Set
let set: Set<Int> = [1, 2, 3]

let setObservable = Observable.from(set)

setObservable.subscribe { event in
  print(event)
}
```
결과
```
next(2)
next(3)
next(1)
completed
```

# of

`Observable.of()` 함수는 `고정된 개수의 요소`로부터 `Observable`을 생성합니다.

```swift
let ofObservable = Observable<Int>.of(1, 2, 3, 4, 5)

ofObservable.subscribe { event in
  print(event)
}
```
결과
```
next(1)
next(2)
next(3)
next(4)
next(5)
completed
```
```swift
let ofObservable2 = Observable<String>.of("A", "B", "C", "D", "E", "F")

ofObservable2.subscribe { event in
  print(event)
}
```
결과
```
next(A)
next(B)
next(C)
next(D)
next(E)
next(F)
completed
```

# interval

`Observable.interval()` 함수는 일정시간 간격으로 Int 이벤트를 무한히 발행합니다.
첫번째 파라미터 period 만큼 쉬었다가 이벤트를 발행합니다.
0부터 시작

![interval](https://github.com/KxCoding/RxSwiftStudy/blob/master/Operators/CreateOperators/images/interval.png)


```swift
let intervalObservable = Observable<Int>.interval(1.0, scheduler: MainScheduler.instance)

intervalObservable.subscribe { event in
  print(event)
}
```
결과
```
next(0)
next(1)
next(2)
next(3)
next(4)
next(5)
next(6)
next(7)
next(8)
next(9)
next(10)
next(11)
next(12)
...무한
```

# just

`Observable.just()` 함수는 단 하나의 이벤트를 발행하는 `Observable`을 생성합니다.

![just](https://github.com/KxCoding/RxSwiftStudy/blob/master/Operators/CreateOperators/images/just.png)


```swift
let justObservable = Observable<String>.just("🔴")

justObservable.subscribe { event in
  print(event)
}
```

결과
```
next(🔴)
completed
```

# range

`Observable.range()` 함수는 n부터 m개의 Int 이벤트를 발행하는  `Observable`을 생성합니다.

![range](https://github.com/KxCoding/RxSwiftStudy/blob/master/Operators/CreateOperators/images/range.png)

```swift
let rangeObservable = Observable<Int>.range(start: 0, count: 5)

rangeObservable.subscribe { event in
  print(event)
}
```
결과
```
next(0)
next(1)
next(2)
next(3)
next(4)
completed
```

# repeatElement

`Observable.repeatElement()`함수는 설정한 `element`를 반복적으로 이벤트 발행하는 `Observable`을 생성합니다.

![repeat](https://github.com/KxCoding/RxSwiftStudy/blob/master/Operators/CreateOperators/images/repeat.png)

```swift
let repeatElementObservable = Observable<String>.repeatElement("repeat")
// 중간에 멈추고 싶다면 .take(10) 활용.
repeatElementObservable.subscribe { event in
  print(event)
}
```
결과
```
next(repeat)
next(repeat)
next(repeat)
...무한
```
# timer

`Observable.timer()` 함수는 지정된 시간이 지나고 난 후 **항목을 하나 배출**하는 `Observable`을 생성합니다.

![timer](timer.png)
![timer](https://github.com/KxCoding/RxSwiftStudy/blob/master/Operators/CreateOperators/images/timer.png)

```swift
let timeObservable = Observable<Int>.timer(3.0, scheduler: MainScheduler.instance)

timerObservable.subscribe { event in
  print(event)
}
```
결과
```
next(0)
completed
```

```swift
// dueTime 후에 period 마다 아이템 발행
let timerObservable2 = Observable<Int>.timer(5, period: 2, scheduler: MainScheduler.instance)
timerObservable2.subscribe { event in
  print(event)
}
```
결과
```
next(0)
next(1)
next(2)
next(3)
next(4)
next(5)
next(6)
next(7)
next(8)
next(9)
...무한
```






