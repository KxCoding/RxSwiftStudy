import RxSwift

/*:
 [Previous](@previous)
 
 #  throttle(_:scheduler:)
 - 특정 시간 동안 발생한 이벤트 중 가장 최근 이벤트만 받는다
 - 입력값이 과도할 때 유용하게 쓸수 있는 연산자이다.
 - 예) 검색창 구독이 있고 현재 텍스트를 서버 API에 보낸다. 이 때 사용자가 글자를 빠르게 타이핑하면 타이핑이 끝났을 때의 텍스트만을 서버에 보낸다
 - 예) 사용자가 bar 버튼을 탭하면 모달뷰를 띄운다. 더블클릭을 방지해서 모달뷰가 두번 나오는 것을 방지한다.
 - 예) 사용자가 드래그할 때 멈추는 지점까지의 영역에 관심이 있는 것이다. 따라서 사용자의 드래그 위치가 멈출 때까지 이벤트를 무시할 수 있다
 
 ![throttle_scheduler](throttle_scheduler.png)
 
 
 # debounce
 - throttle과 비슷
 - 차이점: 이벤트 발생할때마다 타이머가 리셋됨
 
 ![throttle_scheduler](debounce_scheduler.png)
 
 */






/*:
 
 [Next](exercise)
 */









