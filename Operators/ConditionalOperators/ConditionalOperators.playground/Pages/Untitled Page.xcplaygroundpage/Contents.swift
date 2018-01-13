/*:
 # Amb (Ambiguous)
 
 두 개 이상의 소스 Observable이 주어 질때, 그 중 첫 번째로 항목을 배출한 Observable이 배출하는 항목들을 전달한다.
 
 ![Amb](amb.png)
 
 */
import Foundation
import RxSwift

let bag = DisposeBag()
let a = PublishSubject<String>()
let b = PublishSubject<String>()

let o = a.amb(b)
o.subscribe { print($0) }.addDisposableTo(bag)

a.onNext("One")
a.onNext("Two")
b.onNext("하나")
a.onCompleted()
b.onCompleted()

