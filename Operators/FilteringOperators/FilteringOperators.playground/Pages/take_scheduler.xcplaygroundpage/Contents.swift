import RxSwift

/*:
 [Previous](@previous)
 
 # take(_:scheduler:)
 
 - 특정 시간 이후 completed 발생
 
 */

example("take(_:scheduler:)") {
  
  let disposeBag = DisposeBag()
  
  alert(title: "알림",
        text: "카메라 접근을 허용하시겠습니까?")
    .asObservable()
    //사용자가 5초 이내에 알림창의 close 버튼을 누르지 않으면 자동으로 사라지도록
    .take(5.0, scheduler: MainScheduler.instance)
    .subscribe(onCompleted: { [weak self] in
      self?.dismiss(animated: true, completion: nil)
    })
    .disposed(by: disposeBag)
}


/*:
 
 [Next](@next)
 */









