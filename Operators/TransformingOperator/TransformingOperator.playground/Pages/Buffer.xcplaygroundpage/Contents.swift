/*:
 [Previous](@previous)

 # Buffer
 - Buffer가 꽉 차거나, 인자로 전달한 시간이 되면 데이터들을 Subscriber들에게 전달한다.
 - Buffer가 꽉 차기 전에 Error가 발생하면, Buffer에 들어있던 데이터들은 무시하고 Error만 전달한다.
 - 인자로 전달한 시간이 되기 전에 Error가 발생하면, Buffer에 들어있던 데이터들은 무시하고 Error만 전달한다.
 
 ## function prototype
 
 - ### public func buffer(timeSpan: RxTimeInterval, count: Int, scheduler: SchedulerType)
 - ### -> RxSwift.Observable<[Self.E]>
 
 
 ## parameters
 - ### timeSpan: RxTimeInterval
 - : timeSpan만큼 시간이 경과되면, Subscriber에게 Buffer에 있는 데이터들을 전달한다.
 
 - ### count: Int
 - : Buffer 사이즈. Buffer 사이즈만큼 데이터가 들어오면 Subscriber에게 Buffer에 있는 데이터들을 전달한다.
 
 - ### scheduler: SchedulerType
 - : Scheduler
 
 
 ## return
 - ### Sequence Observable
 
 */
import Foundation
import RxSwift

example("Buffer 예제 1") {
    print("- inputs : 1, 2, 3")
    print("- expected : [\"1\", \"2\"] \n")
    
    let disposeBag = DisposeBag()
    let subject = PublishSubject<String>()
    subject
        .buffer(timeSpan: 2.0, count: 2, scheduler: MainScheduler.instance)
        .asObservable()
        .subscribe(onNext: { (strings) in
            print(strings)
        }).disposed(by: disposeBag)
    
    subject.onNext("1")
    subject.onNext("2")
    subject.onNext("3")
}


example("Buffer 예제 2") {
    print("- inputs : 1, error, 2, 3")
    print("- expected : error \n")
    
    let disposeBag = DisposeBag()
    let subject = PublishSubject<String>()
    subject
        .buffer(timeSpan: 2.0, count: 2, scheduler: MainScheduler.instance)
        .asObservable()
        .subscribe(onNext: { (strings) in
            print(strings)
        }, onError: { (error) in
            print(error)
        }).disposed(by: disposeBag)
    
    subject.onNext("1")
    subject.onError(Error.error)
    subject.onNext("2")
    subject.onNext("3")
}


example("Buffer 예제 3") {
    print("- inputs : 1, 2, error, 3")
    print("- expected : [\"1\", \"2\"] 출력 후, error \n")
    
    let disposeBag = DisposeBag()
    let subject = PublishSubject<String>()
    subject
        .buffer(timeSpan: 2.0, count: 2, scheduler: MainScheduler.instance)
        .asObservable()
        .subscribe(onNext: { (strings) in
            print(strings)
        }, onError: { (error) in
            print(error)
        }).disposed(by: disposeBag)
    
    subject.onNext("1")
    subject.onNext("2")
    subject.onError(Error.error)
    subject.onNext("3")
}
/*:
 [Next](@next)
 */
