//
//  ViewController.swift
//  FilteringOperators
//
//  Created by junwoo on 2017. 12. 8..
//  Copyright © 2017년 samchon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

  @IBOutlet weak var clickBtn: UIButton!
  let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    var count = 0
    
    clickBtn.rx.tap
      .map({ count += 1 })
      .take(3, scheduler: MainScheduler.instance)
      //.throttle(2, scheduler: MainScheduler.instance)
      //.debounce(2, scheduler: MainScheduler.instance)
      .subscribe(onNext: {
        print("tap \(count)")
      })
      .disposed(by: disposeBag)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  
  
}

