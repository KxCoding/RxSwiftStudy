//
//  ButtonWithActionViewController.swift
//  Action
//
//  Created by Keun young Kim on 2017. 12. 15..
//  Copyright © 2017년 KxCoding. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Action
import NSObject_Rx

class ButtonWithActionViewController: UIViewController {
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    }
}
