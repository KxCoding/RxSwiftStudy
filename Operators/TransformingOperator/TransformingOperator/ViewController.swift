//
//  ViewController.swift
//  TransformingOperator
//
//  Created by syjdev on 2017. 12. 13..
//  Copyright © 2017년 syjdev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum TestError: Error {
    case normal
}


enum SwitchType: Int {
    case bufferExam1 = 1
    case bufferExam2 = 2
    case windowExam = 4
    case others = 5
}


extension UISwitch {
    var switchType: SwitchType {
        get {
            guard let switchType = SwitchType(rawValue: tag) else { return SwitchType.others }
            return switchType
        }
        
        set(newSwitchType) {
            tag = newSwitchType.rawValue
        }
    }
}


class ViewController: UIViewController {
    
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var bufferExam1Switch: UISwitch!
    @IBOutlet weak var bufferExam2Switch: UISwitch!
    @IBOutlet weak var windowByExamSwitch: UISwitch!
    
    var currentSubject: PublishSubject<String>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetButton.layer.borderWidth = 0.5
        resetButton.layer.borderColor = UIColor.black.cgColor
        
        bufferExam1Switch.switchType = .bufferExam1
        bufferExam2Switch.switchType = .bufferExam2
        windowByExamSwitch.switchType = .windowExam
    }

    internal func executeBufferExam1() {
        print("\n\n### buffer exam 1 ###")
        let subject = PublishSubject<String>()
        _ = subject
            .buffer(timeSpan: 2.0, count: 2, scheduler: MainScheduler.instance)
            .asObservable()
            .subscribe(onNext: { (strings) in
                print(strings)
            }, onError: { (error) in
                print(error)
            }, onDisposed: {
                print("exam 1 subject disposed")
            })

        currentSubject = subject
        subject.onNext("1")
        subject.onNext("2")
        subject.onNext("3")
        subject.onNext("4")
        subject.onNext("5")
    }
    
    
    internal func executeBufferExam2() {
        print("\n\n### buffer exam 2 ###")
        let subject = PublishSubject<String>()
        _ = subject
            .buffer(timeSpan: 2.0, count: 2, scheduler: MainScheduler.instance)
            .asObservable()
            .subscribe(onNext: { (strings) in
                print(strings)
            }, onError: { (error) in
                print("error")
            }, onDisposed: {
                print("exam 2 subject disposed")
            })
        
        currentSubject = subject
        subject.onNext("1")
        subject.onNext("2")
        subject.onError(TestError.normal)
        subject.onNext("3")
        subject.onNext("4")
        subject.onNext("5")
    }
    
    
    internal func executeWindowExam() {
        print("\n\n### window exam ###")
        let subject = PublishSubject<String>()
        _ = subject
            .window(timeSpan: 2, count: 2, scheduler: MainScheduler.instance)
            .subscribe(onNext: { (window) in
                _ = window.asObservable().subscribe(onNext: { (string) in
                    print(string)
                }, onDisposed: {
                    print("disposed")
                })
            }, onDisposed: {
                print("window subject disposed")
            })

        currentSubject = subject
        subject.onNext("1")
        subject.onNext("2")
        subject.onNext("3")
        subject.onNext("4")
        subject.onNext("5")
    }
}
