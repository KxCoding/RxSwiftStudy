 # Combine Operators
 
 ## 개요
     This chapter will show you several different ways to assemble sequences,
    and how to combine the data within each sequence.

![create](https://github.com/KxCoding/RxSwiftStudy/blob/master/Operators/CreateOperators/images/create.png)


---
# Operators


## Prefixing and Concatenating
    * startWith
    * concat
    * concatMap


## Merging
    * merge
  

## Combining elements
    * combineLatest
    * zip

## Triggers
    * amb
    * switchLatest
     


---



# startWith
 * 첫번째 Observable의 아이템이 emit(방출)  되기전에 두번째 Observable의 아이템을 emit한다.

![startWith](https://github.com/KxCoding/RxSwiftStudy/blob/master/Operators/CombineOperators/images/startWith.png)

```swift

let numbers = Observable.of(2,3,4)
let observable = numbers.startWith(1)

observable.subscribe(onNext: { value in
    print(value)
})


```

결과
```swift

--- Example of: startWith ---
1
2
3
4

```

# concat

 - 두 Observable Stream을 순차적으로 합힌다.
 - 단 첫번째 Observable이 Item 이 정상적으로 완료(OnComplete Event)가 되어야 두번째 Observableㅇ의 item이 emit 된다.


![concat](https://github.com/KxCoding/RxSwiftStudy/blob/master/Operators/CombineOperators/images/concat.png)

```swift

let germanCities = Observable.of("베를린","뮌핸","프랑크푸르트")
let spanishCities = Observable.of("마드리드","바르셀로나","발렌시아")

let observable = spanishCities.concat(germanCities)
observable.subscribe({ (value) in
    print(value)
})

```
결과
```swift


--- Example of: concat ---
next(마드리드)
next(바르셀로나)
next(발렌시아)
next(베를린)
next(뮌핸)
next(프랑크푸르트)
completed
```


# concatMap
    - flatmap과 동작은 비슷하다.
    - Observable Stream에서 emit한 Item에 대한 Orderd 보장한다.

![flatmap](https://github.com/KxCoding/RxSwiftStudy/blob/master/Operators/CombineOperators/images/flatmap.png)
![concatmap](https://github.com/KxCoding/RxSwiftStudy/blob/master/Operators/CombineOperators/images/concatmap.png)

```swift

let sequences = [
    "Germany": Observable.of("베를린","뮌핸","프랑크푸르트"),
    "Spain": Observable.of("마드리드","바르셀로나","발렌시아")
]

let observable = Observable.of("Germany","Spain")
    .concatMap({ country in sequences[country] ?? .empty()
})

observable.subscribe({ (value) in
    print(value)
})

```
결과
```

--- Example of: concatMap ---
next(베를린)
next(뮌핸)
next(프랑크푸르트)
next(마드리드)
next(바르셀로나)
next(발렌시아)
completed
===============================================================

```swift

let sequences = [
    "Germany": Observable.of("베를린","뮌핸","프랑크푸르트"),
    "Spain": Observable.of("마드리드","바르셀로나","발렌시아")
]

let observable = Observable.of("Germany","Spain")
    .flatMap({country in sequences[country] ?? .empty()
})
observable.subscribe({ (value) in
    print(value)
})

```
결과
```

--- Example of: concatMap ---
next(베를린)
next(뮌핸)
next(마드리드)
next(프랑크푸르트)
next(바르셀로나)
next(발렌시아)
completed
```


---

# merge
    - Observable에서 emit하는 item의 순서대로 하나의 observable로 만든다.

![merge](https://github.com/KxCoding/RxSwiftStudy/blob/master/Operators/CombineOperators/images/merge.png)



```swift

let left = PublishSubject<String>()
let right = PublishSubject<String>()


let source = Observable.of(left.asObservable(), right.asObservable())
let observable = source.merge()
let _ = observable.subscribe({ (value) in
    print(value)
})

var leftValues = ["베를린","뮌핸","프랑크푸르트"]
var rightValues = ["마드리드","바르셀로나","발렌시아","마드리드1","바르셀로나2","발렌시아3"]


repeat {
    if arc4random_uniform(2) == 0 {
        if  !leftValues.isEmpty {
            left.onNext("Left: " + leftValues.removeFirst())
        }
    } else if !rightValues.isEmpty {
        right.onNext("Right: " + rightValues.removeFirst())
    }

} while !leftValues.isEmpty || !rightValues.isEmpty

```
결과
```

--- Example of: merge ---
next(Left: 베를린)
next(Right: 마드리드)
next(Left: 뮌핸)
next(Right: 바르셀로나)
next(Right: 발렌시아)
next(Right: 마드리드1)
next(Right: 바르셀로나2)
next(Right: 발렌시아3)
next(Left: 프랑크푸르트)

```



# combineLatest
    - 2개이상의 Observable을 기반으로 Observable 각각의 값이 변경(각 Observable의 마지막 값)되었을때 갱신해주는 Operator이다.
    
![combineLatest](https://github.com/KxCoding/RxSwiftStudy/blob/master/Operators/CombineOperators/images/combineLatest.png)

```swift

let left = PublishSubject<String>()
let right = PublishSubject<String>()

let observable = Observable.combineLatest(left, right, resultSelector: { (lastLeft, lastRight) in
    "\(lastLeft) \(lastRight)"
})

let disposable = observable.subscribe({ (value) in
    print(value)
})


left.onNext("안녕")
right.onNext("세계")

right.onNext("반가워요")
disposable.dispose()

```
결과
```

--- Example of: combineLatest ---
next(안녕 세계)
next(안녕 반가워요)

```


# zip
    - 다수의 Observable를 하나의 Observable 로 만든다.
    - 2개의 OBservable이 있다면 가정하면, 각각의 Observable Stream은 서로 대응되는 Pair가 되어야 zip operator 가 emit된다.
    - 한화면에서 2개의 네트워크 데이터를 연동해야한다면 zip operator를 써서 한 Observer에서 subscribe 처리한다.

![zip](https://github.com/KxCoding/RxSwiftStudy/blob/master/Operators/CombineOperators/images/zip.png)


```swift

enum Weather {
    case cloudy
    case sunny
}

let left: Observable<Weather> = Observable.of(.sunny, .cloudy, .cloudy, .sunny)
let right = Observable.of("서울", "부산", "광주", "대구", "대전")

let observable = Observable.zip(left, right) { weather, city in
    return "It's \(weather) in \(city)"
}

observable.subscribe(onNext: { value in
    print(value)
})

```
결과
```

--- Example of: zip ---
It's sunny in 서울
It's cloudy in 부산
It's cloudy in 광주
It's sunny in 대구

```

# amb
 -  첫번째 Observable을 구독한 다른 Observable 중 하나가 첫번째 아이템을 emit하면  나머지 Observable의 구독을 해지사고 첫번쨰 Observable의
  Item만 구독한다.
  
![amb](https://github.com/KxCoding/RxSwiftStudy/blob/master/Operators/CombineOperators/images/amb.png)

```swift
let s1 =  PublishSubject<String>();
let s2 =  PublishSubject<String>();

var observable =  Observable.amb([s1,s2])
observable.subscribe(onNext: { value in
print(value)
})


s1.onNext("1-1");
s2.onNext("2-1");
s1.onNext("1-2");
s1.onNext("1-3");
s1.onNext("1-4");


```
결과
```
1-1
1-2
1-3
1-4

```

# switchLatest
- Observable에서 발행하는 Observable을 다른 Observable로 변경하여 아이템을 emit 한다.

![switchLatest](https://github.com/KxCoding/RxSwiftStudy/blob/master/Operators/CombineOperators/images/switchLatest.png)


```swift

let disposeBag = DisposeBag()

let subject1 = BehaviorSubject(value: "1")
let subject2 = BehaviorSubject(value: "A")

let variable = Variable(subject1)

variable.asObservable()
.switchLatest()
.subscribe(onNext: { print($0) })
.disposed(by: disposeBag)

subject1.onNext("2")
subject1.onNext("3")

variable.value = subject2

subject1.onNext("4")
subject2.onNext("B")

```
결과
```


--- Example of: switchLatest ---
1
2
3
A
B


```


