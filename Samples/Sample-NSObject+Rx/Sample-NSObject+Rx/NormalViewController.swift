//
//  NormalViewController.swift
//  Sample-NSObject+Rx
//
//  Created by Keun young Kim on 2017. 12. 1..
//  Copyright © 2017년 KxCoding. All rights reserved.
//

import UIKit
import RxSwift

class NormalViewController: UIViewController {
   
   let bag = DisposeBag()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      let o = Observable.just(0)
      o.subscribe { print($0) }
         .disposed(by: bag)
   }
}

