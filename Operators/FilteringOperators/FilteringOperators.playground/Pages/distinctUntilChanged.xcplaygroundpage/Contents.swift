import RxSwift

/*:
 [Previous](@previous)
 
 # distinctUntilChanged
 
 - distinctUntilChanged 연산자는 연속적인 중복을 막는다
 
 ![distinctUntilChanged](distinctUntilChanged.png)
 
 */

// Equatable
example("distinctUntilChanged") {
  
  let disposeBag = DisposeBag()
  
  Observable.of("A", "A", "B", "B", "A")
    .distinctUntilChanged()
    .subscribe(onNext: {
      print($0)
    })
    .disposed(by: disposeBag)
}


//custom 비교
example("distinctUntilChanged(_:)") {
  let disposeBag = DisposeBag()
  
  let formatter = NumberFormatter()
  formatter.numberStyle = .spellOut
  
  Observable<NSNumber>.of(10, 110, 20, 200, 210, 310)
    .distinctUntilChanged { a, b in
      
      //10 -> ["ten"]
      guard let aWords = formatter.string(from: a)?
        .components(separatedBy: " "),
      //110 -> ["one", "hundred", "ten"]
        let bWords = formatter.string(from: b)?
          .components(separatedBy: " ")
        else {
          return false
      }
      
      //커스텀 비교로직(같은 것을 포함하는지)
      var containsMatch = false
      for aWord in aWords {
        for bWord in bWords {
          if aWord == bWord {
            containsMatch = true
            break
          }
        }
      }
      
      return containsMatch
    }
    .subscribe(onNext: {
      print($0)
    })
    .disposed(by: disposeBag)
}

/*:
 
 [Next](@next)
 */








