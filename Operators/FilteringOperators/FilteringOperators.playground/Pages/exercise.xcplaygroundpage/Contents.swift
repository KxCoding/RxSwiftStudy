//: [Previous](throttle_scheduler)


/*:
 
 # Challenge: Marin에게 전화를 걸어봅시다
 
 - 조건1: 전화번호 첫자리는 0으로 시작하므로 0이 나올 때까지 이전의 번호들은 무시하기
 - 조건2: 각 입력값은 한자리수 정수만 가능
 - 조건3: 전화번호는 같은 수가 연속하지 않는다
 - 조건4: 총 전화번호 자릿수는 11자리이므로 11개의 숫자만 받는다
 - 기타 필요한 메소드: toArray()
 
 - subscribe 의 next event handler에 들어갈 코드는 아래와 같습니다
 
 ```swift
 .subscribe(onNext: {
 let phone = phoneNumber(from: $0)
 if let contact = contacts[phone] {
 print("Dialing \(contact) (\(phone))...")
 } else {
 print("Contact not found")
 }
 
 })
 ```
 
 */

import RxSwift

example("Challenge") {
  
  let disposeBag = DisposeBag()
  
  let contacts = [
    "010-1234-2345": "Florent",
    "010-1234-3415": "Junior",
    "010-1234-2415": "Marin",
    "010-1234-1415": "Scott"
  ]
  
  
  //전화번호 형태로 변형해주는 메소드
  func phoneNumber(from inputs: [Int]) -> String {
    var phone = inputs.map(String.init).joined()
    
    phone.insert("-", at: phone.index(
      phone.startIndex,
      offsetBy: 3)
    )
    
    phone.insert("-", at: phone.index(
      phone.startIndex,
      offsetBy: 8)
    )
    
    return phone
  }
  
  
  let input = PublishSubject<Int>()
  // 이곳에 필터링 연산자를 이용해 위의 조건을 충족하는 구독코드를 작성해봅시다
  
  
  
  
  
  
  
  
  
  
  input.onNext(1)
  input.onNext(010)
  input.onNext(0)
  input.onNext(0)
  input.onNext(603)
  input.onNext(1)
  input.onNext(10)
  input.onNext(1)
  input.onNext(0)
  
  "1123422411".characters.forEach {
    if let number = (Int("\($0)")) {
      input.onNext(number)
    }
  }
  
  
  // 현재는 contact not found 상황이지만, 정답코드 작성 후 아래의 next 이벤트 원소에 7 대신 5를 전달하면 Marin에게 전화가 연결됩니다
  input.onNext(7)
}


