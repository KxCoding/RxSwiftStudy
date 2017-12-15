# Cocoa Action

UIButton 과 함께 사용할 수 있는 Action

UIButton 버튼의 enabled 속성이 Action의 enabled 속성에 바인딩 된다. 그래서 이 속성의 값에 따라서 Action 실재 실행여부가 자동으로 제어된다.

실제 형식은 Action<Void, Void>

<pre><code>
let alertAction = CocoaAction {
    return Observable.create { [weak self] observer -> Disposable in
        let alertController = UIAlertController(title: "Hello Action", message: "This alert was triggered by a button action", preferredStyle: .alert)
        var ok = UIAlertAction.Action("OK", style: .default)
        ok.rx.action = CocoaAction {
            observer.onCompleted()
            return .empty()
        }
        alertController.addAction(ok)
        self?.present(alertController, animated: true, completion: nil)

        return Disposables.create()
    }
}

button.rx.action = alertAction
</code></pre>
