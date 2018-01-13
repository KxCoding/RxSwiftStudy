//: [Previous](@previous)
import RxSwift

/*:
 # Builtin Schedulers
 
 ## CurrentThreadScheduler (Serial)
 
 - 가장 기본적인 스케쥴러. 별도의 스케쥴러를 지정하지 않으면 이 스케쥴러가 사용된다.
 - Trampoline Scheduler라고도 한다.
 */
CurrentThreadScheduler.instance


/*:
 ## MainScheduler (Serial)
 
 - UI 처리를 담당하는 스케쥴러
 - 사이드 이펙트로 인해 UI 업데이트 되는 코드는 반드시 Main Scheduler에서 실행해야 한다.
 */
MainScheduler.instance

/*:
 - Concurrent 방식으로 동작하는 Main Scheduler도 제공한다.
 */
ConcurrentMainScheduler.instance

/*:
 ## SerialDispatchQueueScheduler (Serial)
 
 - 코드를 실행할 Dispatch Queue를 직접 지정할 수 있다.
 - MainScheduler 역시 이 스케쥴러의 일종이다.
 - Concurrent Dispatch Queue가 전달되더라도 Serial 방식으로 동작한다.
 - observerOn과 함께 사용할 경우 최적화가 수행된다.
 */
SerialDispatchQueueScheduler.init(queue: DispatchQueue.global(), internalSerialQueueName: "name")

/*:
 ## ConcurrentDispatchQueueScheduler (Concurrent)
 
 - 코드를 실행할 Dispatch Queue를 직접 지정할 수 있다.
 - 일반적인 백그라운드 작업에 적합하다.
 - Serial Dispatch Queue를 전달해도 된다.
 */
ConcurrentDispatchQueueScheduler.init(queue: DispatchQueue.global())

/*:
 ## OperationQueueScheduler (Concurrent)
 
 - 코드를 실행할 Operation Queue를 직접 지정할 수 있다.
 - 실행 순서나 동시에 실행 가능한 작업의 단위를 제어하고 싶을 때 사용한다.
 */
OperationQueueScheduler.init(operationQueue: OperationQueue.main)

let oq = OperationQueue()
oq.maxConcurrentOperationCount = 2
OperationQueueScheduler.init(operationQueue: oq)

/*:
 TestScheduler
 
 - 단위 테스트와 함께 사용된다. 
 */








//: [Next](@next)
