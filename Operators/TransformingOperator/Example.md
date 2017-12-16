# 0. Overview
서버에 데이터를 `request` 하고 `response` 를 가공하여 UITableView 에 보여주는 예제.

# 1. request
`ActivityViewController.swift` 에 아래와 같은 코드를 추가한다.

---

```swift
func fetchEvents(repo: String) {
      let response = Observable.from([repo])
          .map { urlString -> URL in
              // urlString을 조합하여 URL 생성
              return URL(string: "https://api.github.com/repos/\(urlString)/events")! 
          }.map { url -> URLRequest in
              // 넘겨받은 URL 로 URLRequest 생성
              return URLRequest(url: url) 
          }.flatMap { request -> Observable<(response: HTTPURLResponse, data: Data)> in
              // 프로토콜이나 델리게이트없이 request 하고 response 을 받을수 있음.
              return URLSession.shared.rx.response(request: request) 
          }.share(replay: 1) 
}
```

## string 에서 URLRequest 까지
![StringToURLRequest](https://github.com/KxCoding/RxSwiftStudy/blob/master/Operators/TransformingOperator/Images/StringToURLRequest.png)

transforming operator 를 사용하여 string 을 URL으로, URL을 URLRequest 로 생성할 수 있다.
이러한 transformation 을 체인으로 만들때, 모든 transforming operator 는 즉시 서로의 출력을 처리한다.
## flatmap
![InsertFlatmap](https://github.com/KxCoding/RxSwiftStudy/blob/master/Operators/TransformingOperator/Images/InsertFlatmap.png)
이 사이에 flatMap 을 삽입하면 다양한 효과를 얻을 수 있다.
* 배열을 생성하는 Observable 인스턴스같이, 즉시 개체를 배출하고 컴플리트하는 Observable 을 flat 하게 만들수 있다.
* 일부 비동기 작업을 수행하고 observable이 컴플리트되기를 효과적으로 “기다리기”를 수행하는 Observable 들을 flat하게 하고, 나머지 체인연산들이 계속 작동하게 둘 수 있다.

## URLSession.rx.response(request: )
URLSession.rx.response(request: ) 는 서버로 리퀘스트 보내고, 리스펀스 받으면 이벤트를 한번 내보내고(.next) 끝낸다 (complete)
이런 상황에서 observable 이 컴플리트되고 다시 구독하면, 새로운 subscription 이 생성되고, 동일한 리퀘스트가 한번 더 생성된다.

이러한 상황을 방지하기 위해 shareReplay 를 사용하면된다. 
이 오퍼레이터는 마지막 발행된 개체의 버퍼를 유지하고, 새로운 구독자한테 피드를 제공한다.

그러므로 리퀘스트가 완료되고, 새로운 관찰자가 shared 시퀀스를 통해( sharedReplay를 통해) 구독하는 경우에, 버퍼에 보관된 리스펀스를 즉시 수신한다.

# 3. Response
`fetchEvents(repo: String)` 함수에 아래와 같은 코드를 추가한다.

---

```swift
func fetchEvents(repo: String) {
…
    response.filter { response, _ in
                  //success status 
                  return 200..<300 ~= response.statusCode 
              }.map { _, data -> [[String: Any]] in
                  //JSON encode
                  guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
                      let result = jsonObject as? [[String: Any]] else {
                          return []
                  }
                  return result 
              }.filter { objects in
                  // 빈거 거르고
                  return objects.count > 0 
              }.map { objects in
                  // JSON Object 를 Event 로 바꾸고
                  return objects.map(Event.init) 
              }.subscribe(onNext: { [weak self] newEvents in
                  //Event 처리 후 reload
                  self?.processEvents(newEvents)
                  DispatchQueue.main.async {
                      self?.tableView.reloadData()
                      self?.refreshControl?.endRefreshing()
                  }
              }).disposed(by: bag)
} 
```

## JSON to Event
![JSONToEvent](https://github.com/KxCoding/RxSwiftStudy/blob/master/Operators/TransformingOperator/Images/JSONToEvent.png)

첫번째 map 은 observable 에 대한 map이고, 두번째 map 은 Array<[String: Any]> 를 Array<Event>로 바꿔준다.

# 4. Event 처리 
`ActivityViewController.swift` 에 아래와 같은 코드를 추가한다.

---
```swift
    func processEvents(_ newEvents: [Event]) {
        var updatedEvents = newEvents + events.value
        if updatedEvents.count > 50 {
            updatedEvents = Array<Event>(updatedEvents.prefix(upTo: 50))
        }
        
        events.value = updatedEvents
    }
```
최대 50개 까지 Event 를 만든다.

# 5. Reference
RxSwift chapter 8. Transforming Operators in Practice
* <https://www.raywenderlich.com/158364/rxswift-transforming-operators-practice>
