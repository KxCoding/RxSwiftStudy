import RxSwift

/*:
 [Previous](@previous)

 # generate
 
 Observable.generate() 함수의 기본 형식은 3개의 파라미터를 갖습니다.
 
 * initialState: 첫 아이템 발생을 위한 초기값
 * condition: 조건문을 통해 이벤트 발행/종료할지 결정하는 함수
 * iterate: 이전 아이템 기반으로 다음 아이템 만들어내는 함수
 
 ![generate](generate.png)
 
 */

let intGenerateObservable = Observable<Int>.generate(initialState: 0,
                                                     condition: { $0 < 5 },
                                                     iterate: { $0 + 1 })

intGenerateObservable.subscribe { event in
  print(event)
}

print("")

/*:
 
 결과
 ```
 next(0)
 next(1)
 next(2)
 next(3)
 next(4)
 completed
 ```
 
 */

let stringGenerateObservable = Observable<String>.generate(initialState: "⭐",
                                                           condition: { $0.count < 10 },
                                                           iterate: { "\($0)⭐" })

stringGenerateObservable.subscribe { event in
  print(event)
}

/*:

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

 [Next](@next)
 */
