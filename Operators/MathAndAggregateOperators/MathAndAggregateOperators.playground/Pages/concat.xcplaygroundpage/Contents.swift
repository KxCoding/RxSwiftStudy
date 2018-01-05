import RxSwift

/*:
 [Previous](@previous)
 
 # concat
 
 이전 Observable 시퀀스가 성공적으로 종료(completed)된 경우 모든 내부 Observable 시퀀스를 연결합니다.
 
 */

example("concat 1") {
  let disposeBag = DisposeBag()
  
  let subject1 = PublishSubject<String>()
  let subject2 = PublishSubject<String>()
  
  let variable = Variable(subject1)
  
  variable.asObservable()
    .concat()
    .subscribe { print($0) }
    .disposed(by: disposeBag)
  
  subject1.onNext("subject1 - A")
  subject1.onNext("subject1 - B")
  
  variable.value = subject2
  
  subject2.onNext("subject2 - A") // 무시당함
  
  subject1.onCompleted()          // 성공적으로 종료
  
  subject2.onNext("subject2 - B")
}

/*:
 
 결과
 ```
 next(subject1 - A)
 next(subject1 - B)
 next(subject2 - B)
 ```
 
 */

example("concat 2") {
  let disposeBag = DisposeBag()
  
  let subject1 = PublishSubject<String>()
  let subject2 = PublishSubject<String>()
  
  let variable = Variable(subject1)
  
  variable.asObservable()
    .concat()
    .subscribe { print($0) }
    .disposed(by: disposeBag)
  
  subject1.onNext("subject1 - A")
  subject1.onNext("subject1 - B")
  
  variable.value = subject2
  
  subject2.onNext("subject2 - A")   // 무시당함
  
  subject1.onError(TestError.test)  // 에러
  
  subject2.onNext("subject2 - B")   // 무시당함
}

/*:
 
 결과
 ```
 next(subject1 - A)
 next(subject1 - B)
 error(test)
 ```
 
 */

example("concat 3") {
  let disposeBag = DisposeBag()
  
  let subject1 = BehaviorSubject(value: "subject1 - A")
  let subject2 = BehaviorSubject(value: "subject2 - A")
  
  let variable = Variable(subject1)
  
  variable.asObservable()
    .concat()
    .subscribe { print($0) }
    .disposed(by: disposeBag)
  
  subject1.onNext("subject1 - B")
  subject1.onNext("subject1 - C")
  
  variable.value = subject2
  
  subject2.onNext("subject2 - B")   // 무시당함
  subject2.onNext("subject2 - C")
  
  subject1.onCompleted()            // 성공적으로 종료
  
  subject2.onNext("subject2 - D")
}

/*:
 
 결과
 ```
 next(subject1 - A)
 next(subject1 - B)
 next(subject1 - C)
 next(subject2 - C)
 next(subject2 - D)
 ```
 
 [Next](@next)
 */
