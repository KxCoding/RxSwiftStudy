import RxSwift

/*:
 [Previous](@previous)

 # create
 
 Observable.create() 함수는 개발자가 observer의 on* 메서드를 직접 호출해서 Observable을 생성합니다.
 
 * 제네릭으로 어떤 타입의 이벤트가 발생할지 설정합니다.
 * observer.on* 메서드로 이벤트를 발생합니다.
 * observer.on(.next(Element)) or observer.onNext(Element)
 * observer.on(.error(Error)) or observer.onError(Error)
 * observer.on(.completed) or observer.onCompleted()
 * Disposable 리턴합니다.

 ![create](create.png)
 
 */

let nameObservable = Observable<String>.create { observer -> Disposable in
  let names: [String] = ["김근영", "이로운", "김민희", "손명기", "박정연", "정상엽", "이한형", "성일우", "송회문", "강수영", "박준우"]
  for name in names {
    observer.on(.next(name))
  }
  observer.on(.completed)
  return Disposables.create {
    // dispose될때 처리할 내용
    print("disposed")
  }
}

nameObservable.subscribe { event in
  print(event)
}

print("")

/*:
 
 결과
 ```
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
 
 */

enum NameError: Error {
  case empty
}

let nameObservable2 = Observable<String>.create { observer -> Disposable in
  let names: [String] = ["김근영", "", "이로운", "김민희", "손명기", "박정연", "정상엽", "이한형", "성일우", "송회문", "강수영", "박준우"]
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

/*:
 
 결과
 ```
 next(김근영)
 error(empty)
 disposed
 ```
 
 [Next](@next)
*/
