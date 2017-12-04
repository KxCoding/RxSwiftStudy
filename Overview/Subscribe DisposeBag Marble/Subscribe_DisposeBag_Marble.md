										작성자 : 이한형
- - - -
# 1. Subscribe
* Observable의 옵저버를 연결해준다. Observable로 방출되는 항목이나 에러 또는 완료 공지 받으려면 Observable을 구독해야 한다.

```
public func subscribe(onNext: ((E) -> Void)? = nil, onError: ((Swift.Error) -> Void)? = nil, onCompleted: (() -> Void)? = nil, onDisposed: (() -> Void)? = nil) -> Disposable
```

* onNext : Observable에서 아이템을 하나씩 방출할 때마다 호출
* onError : Observable 오류로 인해 종료 시 호출
* onCompleted : 오류가 발생하지 않으면 마지막 시간 동안 onNext를 모두 호출 한 후에 마지막으로 호출
* onDisposed : 모든 유형의 시퀀스 종료 시 호출. (시퀀스가 정상적으로 완료되었거나 오류가 발생했거나 구독을 취소하여 생성이 취소된 경우)

```
// 예시
let disposeBag: DisposeBag = DisposeBag()

let textObservable: Disposable = Observable.just("RxSwift Study")
.subscribe(onNext: { value in
    print("value = \(value)")
}, onError: { error in
    print("error = \(error)")
}, onCompleted: {
    print("onCompleted 끝")
}, onDisposed: {
    print("disposed 실행")
})
        
textObservable.addDisposableTo(self.disposeBag)

// print
value = RxSwift Study
onCompleted 끝
disposed 실행
self.disposeBag 추가
```


# 2. DisposeBag
* Observable의 사용이 끝나면 메모리를 해제해야 한다. 그때 사용할 수 있는 것이 Dispose이다. RxSwift에서는 DisposeBag을 사용하는데 DisposeBag instance의 deinit() 이 실행 될 때 모든 메모리를 해제한다.
* DisposeBag에 추가하면 스레드 간의 충돌을 방지하기 위해 Spin Lock을 사용한다.
* 여러 Observable을 DisposeBag에 추가하여 한 번에 해제시키는 게 가능하다.
* DisposeBag에 추가된 시퀀스들을 바로 해제하려면 DisposeBag() 을 새로 할당하면 된다.
* dispose() 도 즉시 해제 가능
* SubScribe onCompleted 다음으로 호출한다.

# 3. Marble Diagram
* Marble Diagram은 Observable Sequence의 transformation을 시각화 해 보여줍니다. 시각화된 transformation은 이해를 돕는다.

![](Subscribe_DisposeBag_Marble/Subscribe_DisposeBag_Marble/legend.png)

* 왼쪽 ——> 오른쪽 시간 순서
* Observable로 방출된 아이템들 타임라인 위에 표시
* 네모는 Operator. 아이템들이 Operator의해서 변형 된 값들은 아래 타임라인에 표시
* X 표시는 Observable이 에러나 예외가 발생을 나타냄.
* | 표시는 Observable이 정상적으로 완료를 나타냄.

참고
* [ReactiveX - Subscribe operator](http://reactivex.io/documentation/operators/subscribe.html)
* https://academy.realm.io/kr/posts/slug-max-alexander-functional-reactive-rxswift/
* https://academy.realm.io/kr/posts/reactive-programming-with-rxswift/
* https://academy.realm.io/kr/posts/how-to-use-rxswift-with-simple-examples-ios-techtalk/
* http://rxmarbles.com/
* [App Store에서 제공하는 RxMarbles](https://itunes.apple.com/kr/app/rxmarbles/id1087272442?mt=8)

