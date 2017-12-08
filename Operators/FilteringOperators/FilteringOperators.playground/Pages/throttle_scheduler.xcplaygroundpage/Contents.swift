import RxSwift

/*:
 [Previous](@previous)
 
 #  throttle(_:scheduler:)
 - next 이벤트 발생 후 특정 시간 이내에 발생하는 next 이벤트 무시하기
 - 예) 더블클릭 필터링
 
 */

example("throttle(_:scheduler:)") {
  
  let disposeBag = DisposeBag()
  
  //이미지를 클릭시 images 배열에 image가 삽입되는 경우
  images.asObservable()
    //0.5초 동안 복수 클릭시 한번으로 간주
    .throttle(0.5, scheduler: MainScheduler.instance)
    .subscribe(onNext: { [weak self] photos in
      guard let preview = self?.imagePreview else { return }
      preview.image = UIImage.collage(images: photos,
                                      size: preview.frame.size)
    })
    .disposed(by: disposeBag)
}




/*:
 
 [Next](exercise)
 */









