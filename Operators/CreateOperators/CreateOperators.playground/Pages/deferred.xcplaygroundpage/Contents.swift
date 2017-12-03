import RxSwift

/*:
 [Previous](@previous)

 # deferred
 
 Observable.deferred() 함수는 옵저버가 subscribe() 함수를 호출할때까지  Observable의 생성을 지연합니다.
 
 ![deferred](deferred.png)
 
 */

let defferredObservable = Observable<String>.deferred({ Observable<String>.just("defer") })

defferredObservable.subscribe { event in
  print(event)
}

/*:
 
 결과
 ```
 next(defer)
 completed
 ```
 
 [Next](@next)
 */
