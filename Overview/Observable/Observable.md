# Observable

_참고 문서 **http://reactivex.io/documentation/ko/observable.html**_

## 요약

### ReactiveX

- Observer는 Observable을 구독한다.
- Obseravable이 배출하는 하나 또는 연속된 항목에 Observer는 반응한다.
- 이러한 패턴은 동시성 연산을 가능하게 한다.
- 임의의 순서에 따라 병렬로 실행되고 결과는 나중에 연산된다.
- 이 접근 방법은 의존관계가 없는 많은 코드들을 실행할 때, 하나의 코드 블럭이 실행 결과를 리턴할 때까지 기다릴 필요 없이 계속해서 다음 코드 블럭을 실행할 수 있기 때문에 한번에 여러개의 코드를 실행 시킬 수 있어 — 결과적으로 보면 전체 코드의 실행 시간은 그 중 실행 시간이 긴 시간 만큼 밖에 걸리지 않는 큰 장점을 제공한다.

### Observable

- Observable은 항목들을 배출하거나 Observable의 메서드 호출을 통해 Observer에게 알림을 보낸다.
- Observer가 존재하지 않는다면 Observable들은 새로운 항목들을 배출하지 않는다.
- "뜨거운(Hot)" Observable은 생성되자 마자 항목들을 배출하기도 하기 때문에, 이 Observable을 구독하는 Observer들은 어떤 경우에는 항목들이 배출되는 중간부터 Observable을 구독할 수 있다.
-  "차가운(Cold)" Observable은 Observer가 구독할 때 까지 항목을 배출하지 않기 때문에 이 Observable을 구독하는 Observer는 Observable이 배출하는 항목 전체를 구독할 수 있도록 보장 받는다.
- "연결 가능한(Connectable)" Observable이라고 불리는 Observable 객체가 존재하는데, 이 Observable은 Observer의 구독 여부와는 상관 없이 자신의 `Connect` 메서드가 호출되기 전까지 항목들을 배출하지 않는다.

### 연산자

- 표준 옵저버 패턴을 조금 확장한 것이며, 연속된 이벤트를 처리하는데 있어서는 싱글 콜백보다는 훨씬 더 효과적인 방법을 제공한다.
- ReactiveX의 진짜 힘은 연산자로부터 나온다.
- 연산자들은 콜백이 제공하는 효율적인 장점들을 바탕으로 선언적인 방법을 통해 연속된 비동기 호출을 구성할 수 있는 방법을 제공하는데, 중요한 것은 일반적인 비동기 시스템이 가진 중첩된 콜백 핸들러의 단점들을 제거했다는 점이다.
- 대부분의 연산자들은 Observable 상에서 동작하고 Observable을 리턴한다.
- 연산자 체인에 걸려있는 각각의 연산자들은 이전 연산자가 리턴한 Observable을 변경한다.
- Observable 연산자들은 호출 순서에 영향을 받는다.

---
# Setup

## RxSwift 시작하기

`git clone https://github.com/ReactiveX/RxSwift`

### [RxSwift에서 제공하는 예제 앱 실행해보기](https://github.com/ReactiveX/RxSwift/blob/master/Documentation/ExampleApp.md)

1. `Rx.xcworkspace`를 연다.
1. `RxExample-iOS` 스킴을 선택한다.
1. 실행한다.

### [RxSwift에서 제공하는 플레이그라운드 실행해보기](https://github.com/ReactiveX/RxSwift/blob/master/Documentation/Playgrounds.md)

1. `Rx.xcworkspace`를 연다.
1. `RxSwift-macOS` 스킴을 선택한다.
1. 빌드한다.
1. `Rx` 플레이그라운드를 연다.
1. `Debug Area`를 확인한다.

## 예제

_예제 문서 **https://pilgwon.github.io/blog/2017/09/26/RxSwift-By-Examples-1-The-Basics.html**_

번역되어 있고, 이해하기 쉽다.
키워드 자동 완성 예제라고 생각하자.

1. 프로젝트 생성 (HelloRxSwift)
1. `pod init`
1. `Podfile` 편집
1. `pod install`
1. `ViewController.swift`에 아웃렛 추가
1. `Main.storyboard`에 테이블 뷰와 서치 바 추가
1. `Main.storyboard`에서 아웃렛, 테이블 뷰 데이터소스 연결, 테이블 뷰 셀 아이덴티피어 지정
1. 모듈 임포트
1. 데이터 변수 + `DisposeBag` 선언
1.  `UITableViewDataSource` 구현
1. 서치 바 텍스트 구독
1. 서치 바 텍스트 Observable에 `debounce()`와 `distinctUntilChanged()` 연산자 추가
1. 서치 바 텍스트 Observable에 `filter()` 연산자 추가
