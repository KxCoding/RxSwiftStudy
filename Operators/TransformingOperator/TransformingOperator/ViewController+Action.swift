//
//  ViewController+Action.swift
//  TransformingOperator
//
//  Created by syjdev on 2017. 12. 16..
//  Copyright © 2017년 syjdev. All rights reserved.
//

import UIKit

extension ViewController {
    @IBAction func didClickResetButton(_ sender: Any) {
        bufferExam1Switch.setOn(false, animated: false)
        bufferExam2Switch.setOn(false, animated: false)
        windowByExamSwitch.setOn(false, animated: false)
        currentSubject?.onCompleted()
    }
    
    
    @IBAction func didChangeSwitchState(_ sender: UISwitch) {
        bufferExam1Switch.setOn(bufferExam1Switch.isEqual(sender), animated: false)
        bufferExam2Switch.setOn(bufferExam2Switch.isEqual(sender), animated: false)
        windowByExamSwitch.setOn(windowByExamSwitch.isEqual(sender), animated: false)
        
        currentSubject?.onCompleted()
        
        switch sender.switchType {
        case .bufferExam1:
            executeBufferExam1()
            break
        case .bufferExam2:
            executeBufferExam2()
            break
        case .windowExam:
            executeWindowExam()
            break
        default:
            break
        }
    }
}
