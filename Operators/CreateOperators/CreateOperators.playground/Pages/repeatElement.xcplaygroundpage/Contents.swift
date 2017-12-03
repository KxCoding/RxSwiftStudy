import RxSwift

/*:
 [Previous](@previous)
 
 # repeatElement
 
 Observable.repeatElement() 함수는 설정한 element를 반복적으로 이벤트 발행하는 Observable을 생성합니다.
 
 ![repeat](repeat.png)
 
 */

let repeatElementObservable = Observable<String>.repeatElement("repeat")
//  .take(10)

repeatElementObservable.subscribe { event in
  print(event)
}

/*:
 
 결과
 ```
 next(repeat)
 next(repeat)
 next(repeat)
 ...무한
 ```
 
 [Next](@next)
 */
