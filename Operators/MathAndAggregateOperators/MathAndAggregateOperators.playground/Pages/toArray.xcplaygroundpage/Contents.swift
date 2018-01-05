import RxSwift

/*:
 [Previous](@previous)
 
 # toArray
 
 Observable 시퀀스를 배열로 변환하고 해당 배열을 새로운 단일 요소 Observable 시퀀스로 내보내고 종료합니다.
 
 ![toArray](toArray.png)
 
 */

example("toArray 1") {
  let disposeBag = DisposeBag()
  
  // Observable<Int>
  let intObservable = Observable.of(1, 3, 5, 7, 9)
  
  // Observable<[Int]>
  let toArrayObservable = intObservable.toArray()
  
  toArrayObservable.subscribe({ event in
    print(event)
  }).disposed(by: disposeBag)
}

/*:
 
 결과
 ```
 next([1, 3, 5, 7, 9])
 completed
 ```
 
 [Next](@next)
 */

example("toArray 2") {
  let disposeBag = DisposeBag()
  
  // Observable<String>
  let snowmanObservable = Observable<String>.repeatElement("⛄").take(10)
  
  // Observable<[String]>
  let toArrayObservable = snowmanObservable.toArray()
  
  toArrayObservable.subscribe({ event in
    print(event)
  }).disposed(by: disposeBag)
}

/*:
 
 결과
 ```
 next(["⛄", "⛄", "⛄", "⛄", "⛄", "⛄", "⛄", "⛄", "⛄", "⛄"])
 completed
 ```
 
 [Next](@next)
 */
