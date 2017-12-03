import RxSwift

/*:
 [Previous](@previous)

 # Event(이벤트) 발생
 
 Observable은 이벤트를 발행할 수 있고 3가지 상태를 가지고 있습니다.
 */

public enum Event<Element> {
  case next(Element)      /// Next element is produced.
  case error(Swift.Error) /// Sequence terminated with an error.
  case completed          /// Sequence completed successfully.
}

/*:
 
 * **next**: 데이터의 발행을 알립니다. 요소를 포함하고 error나 completed 가 되기전까지 발행 가능합니다. 0개이상 발행 가능
 * **error**: 에러가 발생했다고 알리고 데이터의 발행을 종료합니다.
 * **completed**: 모든 데이터의 발행이 완료됐다고 알리고 종료합니다.
 
 Observable이 종료되고나면 더이상의 이벤트 발행이 불가능합니다.

 [Next](@next)
 */
