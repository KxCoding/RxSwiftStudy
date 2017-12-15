/*:
 # Action
 
 RxSwift를 통해 Action을 추상화 하는 도구
 
 기존에 IBAction을 활요한 Target-Action 패턴을 개선할 수 있다.
 
 ## Work Factory
 
 입력을 받아서 Observable을 리턴하는 Closure
 
 Action은 execute()가 호출될 때 파라미터를 Closure로 전달하고 작업을 처리하기 위해 Subscribe
 
 - enabled 상태에서만 실행될 수 있다
 - 동시 실행이 불가능하다. 하나의 Action은 한 번에 하나의 작업만 실행할 수 있다
 - 개별 작업에서 발생하는 next 이벤트와 error 이벤트를 결합
 
 */

import UIKit
import RxSwift
import Action

var action: Action<String, Int> = Action { (input) -> Observable<Int> in
    return Observable.create({ observer -> Disposable in
        observer.onNext(input.count)
        observer.onCompleted()
        
        return Disposables.create()
    })
}


action.execute("Hello Action").subscribe { print($0) }

print("----------------------------------------")


/*:
 ### Conditional Action
 
 enabledIf 를 활용하면 workFactory로 전달한 Action의 실제 실행을 제어할 수 있다
 */
var source: String? = "Hello"

let condition = PublishSubject<Bool>()

action = Action(enabledIf: condition.asObservable(), workFactory: { (input) -> Observable<Int> in
    return Observable.create({ observer -> Disposable in
        observer.onNext(input.count)
        observer.onCompleted()
        
        return Disposables.create()
    })
})

if let _ = source {
    condition.onNext(true)
}

action.execute(source ?? "").subscribe { print($0) }


/*:
 ## Cocoa Action
 
 UIButton 과 함께 사용할 수 있는 Action
 
 UIButton 버튼의 enabled 속성이 Action의 enabled 속성에 바인딩 된다. 그래서 이 속성의 값에 따라서 Action 실재 실행여부가 자동으로 제어된다.
 
 실제 형식은 Action<Void, Void>
 */
