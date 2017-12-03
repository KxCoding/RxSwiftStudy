import RxSwift

/*:
 [Previous](@previous)
 
 # from
 
 Observable.from() 함수는 **Sequence**(Array, Dictionary, Set 같은)로 부터 Observable을 생성합니다.
 
 ![from](from.png)
 
 */

// Array
let array: [Int] = [1, 2, 3, 4, 5]

let arrayObservable = Observable.from(array)

arrayObservable.subscribe { event in
  print(event)
}

print("")

/*:
 
 결과
 ```
 next(1)
 next(2)
 next(3)
 next(4)
 next(5)
 completed
 ```
 
 */

// Dictionary
let dictionary: [Int: String] = [0: "0", 1: "1", 2: "2", 3: "3"]

let dictionaryObservable = Observable.from(dictionary)

dictionaryObservable.subscribe { event in
  print(event)
}

print("")

/*:
 
 결과
 ```
 next((key: 2, value: "2"))
 next((key: 0, value: "0"))
 next((key: 1, value: "1"))
 next((key: 3, value: "3"))
 completed
 ```
 
 */

// Set
let set: Set<Int> = [1, 2, 3]

let setObservable = Observable.from(set)

setObservable.subscribe { event in
  print(event)
}

/*:
 
 결과
 ```
 next(2)
 next(3)
 next(1)
 completed
 ```
 
 [Next](@next)
 */
