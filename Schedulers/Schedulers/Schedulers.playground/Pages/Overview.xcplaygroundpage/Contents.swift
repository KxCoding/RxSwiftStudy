/*:
 # Schedulers
 
 ## Overview
 - 코드가 실행되는 컨텍스트.
 - 내부적으로는 GCD의 DispatchQueue와 유사한 형태로 처리된다.
 - Thread, DispatchQueue, Operation을 활용하는 기본 스케쥴러가 제공되면, 대부분의 경우 기본 스케쥴러로 필요한 작성을 모두 처리할 수 있다.
 
 ## Not a Thread
 - 스레드를 추상화 한 것이라고 이해하면 쉽지만, 스레드와 완전히 동일한 개념은 아니다.
 - 하나의 스레드 내에 두 개 이상의 개별 스케쥴러가 존재하거나 하나의 스케쥴러가 두 개의 스레드에 결쳐 있는 경우도 있다.
 - 즉, 스레드와 1:1 관계를 가지는 것은 아니다.
 
 ## Serial Scheduler, Concurrent Scheduler
 - Serial Scheduler는 작업을 순차적으로 처리하고, Concurrent Scheduler는 동시에 처리
 - Serial Scheduler는 별도의 최적화를 수행할 수 있고, 현재 시점에서는 DispatchQueue를 사용한 스케쥴러에 한해서 최적화를 수행한다.
 - Serial DispatchQueue Scheduler에서 observeOn 연산자는 DispatchQueue.async 호출로 최적화 된다.
 
 */

//: [Next](@next)
