/*:
 [Previous](@previous)
 
 # Window
 - Buffer와 유사한 부분이 많음.
 - Buffer랑 달리, Window는 Observable들의 Observable을 Return.
 - Subscriber에게 Observable을 보내고, 새 데이터가 들어오면 Subscriber에게 보냈던 Observable에 보냄.
 
 
 ## function prototype
 
 - ### public func window(timeSpan: RxTimeInterval, count: Int, scheduler: SchedulerType)
 - ### -> Observable<Observable<E>>
 
 
 ## parameters
 - ### timeSpan: RxTimeInterval
 - : timeSpan만큼 시간이 경과되면, winodw에 있는 데이터들을 전부 내보내고 Observable을 Dispose한다.
 
 - ### count: Int
 - : window의 사이즈. window 사이즈만큼 데이터가 들어오면 winodw에 있는 데이터들을 전부 내보낸다.
 - 그 후, Subscribe에게 보냈던 Observable을 Dispose하고 새 Observable을 Subscribe에게 보낸다.
 
 - ### scheduler: SchedulerType
 - : Scheduler
 
 
 ## return
 - ### Observable들의 Observable
 
 */
import Foundation
import RxSwift

example("Window 예제") {
    print("- inputs : 1, 2, 3, 4, 5")
    
    let disposeBag = DisposeBag()
    let subject = PublishSubject<Int>()
    subject
        .window(timeSpan: 2, count: 2, scheduler: MainScheduler.instance)
        .subscribe(onNext: { (window) in
            window.asObservable().subscribe(onNext: { (int) in
                print(int)
            }, onDisposed: {
                print("disposed")
            }).disposed(by: disposeBag)
        }).disposed(by: disposeBag)
    
    subject.onNext(1)
    subject.onNext(2)
    subject.onNext(3)
    subject.onNext(4)
    subject.onNext(5)
    subject.onCompleted()
}

/*:
 [Next](@next)
 */


