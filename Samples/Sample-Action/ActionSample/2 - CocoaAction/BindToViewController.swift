//
//  BindToViewController.swift
//  ActionSample
//
//  Created by Keun young Kim on 2017. 12. 15..
//  Copyright © 2017년 KxCoding. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Action
import NSObject_Rx

class BindToViewController: UIViewController {
    
    let action = Action<UITextField, Int> { input in
        return Observable.create({ observer -> Disposable in
            let cnt = input.text?.count ?? 0
            
            DispatchQueue.global().async {
                Thread.sleep(forTimeInterval: 2)
                
                observer.onNext(cnt)
                observer.onCompleted()
            }
            
            return Disposables.create()
        })
    }

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var countButton: UIButton!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn = UIBarButtonItem(title: "Count", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = btn
        navigationItem.rightBarButtonItem?.rx.bind(to: action, input: inputField)
        
        countButton.rx.bind(to: action, input: inputField)
        
        action.elements
            .map { "\($0)" }
            .bind(to: countLabel.rx.text)
            .disposed(by: self.rx.disposeBag)
        
        action.executing
            .bind(to: loader.rx.isAnimating)
            .disposed(by: self.rx.disposeBag)
        
        action.executing
            .bind(to: countLabel.rx.isHidden)
            .disposed(by: self.rx.disposeBag)
        
        action.elements
            .observeOn(MainScheduler.instance)
            .subscribe({ [weak self] _ in self?.inputField.text = nil })
            .disposed(by: self.rx.disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        inputField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        inputField.resignFirstResponder()
    }
}
