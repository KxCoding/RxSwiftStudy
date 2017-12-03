import RxSwift

/*:
 [Previous](@previous)
 
 # error
 
 Observable.error() 함수는 아이템을 발행하지 않고 에러와 함께 종료되는 Observable을 생성합니다.
 
 ![error](throw.png)
 
 */

enum TestError: Error {
  case test
}

let errorObservable = Observable<Int>.error(TestError.test)

errorObservable.subscribe { event in
  print(event)
}

/*:
 
 결과
 ```
 error(test)
 ```
 
 [Next](@next)
 */
