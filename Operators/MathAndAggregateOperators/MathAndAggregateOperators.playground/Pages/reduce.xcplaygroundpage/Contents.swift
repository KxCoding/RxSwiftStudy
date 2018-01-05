import RxSwift

/*:
 [Previous](@previous)

 # reduce
 
 초기 시드 값으로 시작하고 Observable 시퀀스에 의해 생성된 모든 요소에 accumulator 클로저를 적용하고 누산된 결과를 단일 요소 Observable 시퀀스로 반환합니다.

 ![reduce](reduce.png)
 
 */

/*:
 ## parameter
 * seed: 누산을 위한 초기값
 * accumulator: 현재까지 누산된 값과 새로 들어온 값을 가지고 새 누산 값으로 갱신하는 함수
 */

example("reduce 1") {
  let disposeBag = DisposeBag()
  
  // Observable<Int>
  let intObservable = Observable.of(1, 3, 5, 7, 9)
  
  // Observable<Int>
  let observable = intObservable.reduce(0, accumulator: { accumulatedValue, newValue in
    return accumulatedValue + newValue
  })
  
  observable.subscribe({ event in
    print(event)
  }).disposed(by: disposeBag)
}

/*:
 
 결과
 ```
 next(25)
 completed
 ```
 
 */

example("reduce 2") {
  let disposeBag = DisposeBag()
  
  // Observable<Int>
  let intObservable = Observable.of(1, 3, 5, 7, 9)
  
  // Observable<Int>
  let observable = intObservable.reduce(0, accumulator: +)
  
  observable.subscribe({ event in
    print(event)
  }).disposed(by: disposeBag)
}

/*:
 
 결과
 ```
 next(25)
 completed
 ```
 
*/

/*:
 ## parameter
 * seed: 누산을 위한 초기값
 * accumulator: 현재까지 누산된 값과 새로 들어온 값을 가지고 새 누산 값으로 갱신하는 함수
 * mapResult: 최종 누산된 값으로 변경하는 함수
 */

example("reduce 3") {
  let disposeBag = DisposeBag()
  
  // Observable<Int>
  let intObservable = Observable.of(1, 3, 5, 7, 9)
  
  // Observable<Double>
  let observable = intObservable.reduce(0, accumulator: +, mapResult: { result -> Double in
    return Double(result)
  })

  observable.subscribe({ event in
    print(event)
  }).disposed(by: disposeBag)
}

/*:
 
 결과
 ```
 next(25.0)
 completed
 ```
 
 [Next](@next)
 */
