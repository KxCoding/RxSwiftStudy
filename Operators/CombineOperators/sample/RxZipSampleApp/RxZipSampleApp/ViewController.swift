//
//  ViewController.swift
//  RxZipSampleApp
//
//  Created by SuyoungKang on 2017. 12. 18..
//  Copyright © 2017년 flybbird. All rights reserved.
//
import UIKit
import RxSwift
import RxCocoa

enum MyError: Error {
    case optionalError
}

struct Gugudan {
    var leftValue:Int
    var rightValue:Int
    var resultValue:Int
    
}

class ViewController: UIViewController {
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var resultTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // A Observable : firstTextField 에서 방출하는 Item
        let aObservable = firstTextField.rx.text
            .map { (valueText) -> Int in
                // 일부러 에러를 날수 있는 상황을 만들어둔다..
                if let valueText = valueText, let value = Int(valueText) {
                    return value
                }
                
                throw MyError.optionalError
            }
            .catchError { (error) -> Observable<Int> in
                // 에러발생시 디폴트를 5단으로 내린다..
                Observable.just(5)
            }
            .flatMap { (inputValue) -> Observable<Int> in
                Observable<Int>.interval(1.0, scheduler: MainScheduler.instance)
                    .flatMap({ index -> Observable<Int> in
                        Observable.just(inputValue)
                    })
                    .take(10)
        }
        
        
        // B Observable : fisttextField 에서 방출하는 Item
        let bObservable = self.secondTextField.rx.text
            .map { (valueText) -> Int in
                // 일부러 에러를 날수 있는 상황을 만들어둔다..
                if let valueText = valueText, let value = Int(valueText) {
                    return value
                }
                
                throw MyError.optionalError
            }
            .catchError { (error) -> Observable<Int> in
                // 에러발생시 디폴트를 5부터 시작하도록 한다.
                Observable.just(5)
            }
            .flatMap { (inputValue) -> Observable<Int> in
                Observable<Int>.interval(1.0, scheduler: MainScheduler.instance)
                    .flatMap({ index -> Observable<Int> in
                        Observable.just(inputValue + index)
                    })
                    .take(10 - inputValue)
        }
        
        calculateButton.rx.tap.bind {
            print("button Tapped")
            
            /*
             aObservable.subscribe(onNext: { numberValue in
             print("aObervable Data = \(numberValue)")
             }, onError: { (error) in
             print(error.localizedDescription)
             })
             
             bObservable.subscribe({ numberValue in
             print("bObervable Data = \(numberValue)")
             })
             */
            
            
            Observable.zip(aObservable, bObservable, resultSelector: { (aNumber, bNumber) -> Gugudan in
                //                print("@ Left Observable = \(aNumber) Right Observable = \(bNumber) ")
                //                return aNumber * bNumber
                return Gugudan(leftValue: aNumber, rightValue: bNumber, resultValue: aNumber*bNumber )
            })
                .subscribe(onNext: { (gugudan) in
                    let result = String(format: "%d * %d = %d", arguments: [gugudan.leftValue,gugudan.rightValue , gugudan.resultValue])
                    self.resultTextView.text = self.resultTextView.text + result + "\r\n"
                }, onError: { error in
                    print(error.localizedDescription)
                }, onCompleted: {
                    print(">>> ZIP onCompleted")
                }, onDisposed: {
                    print("<<< onDisPosed")
                })
            //                .subscribe({ gugudan in
            //                    if let gugudan = gugudan.element {
            //                      let result = String(format: "%d * %d = %d", arguments: [gugudan.leftValue,gugudan.rightValue , gugudan.resultValue])
            ////                        print(result)
            //                        self.resultTextView.text = self.resultTextView.text + result + "\r\n"
            //                    }
            //                })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
}

