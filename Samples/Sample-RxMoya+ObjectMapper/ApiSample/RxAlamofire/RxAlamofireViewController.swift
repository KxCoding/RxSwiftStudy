//
//  RxAlamofireViewController.swift
//  ApiSample
//
//  Created by Keun young Kim on 2017. 12. 7..
//  Copyright © 2017년 KxCoding. All rights reserved.
//

import UIKit
import RxSwift
import NSObject_Rx
import RxAlamofire
import SwiftyJSON

class RxAlamofireViewController: CommonViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        json(.get, bookUrl)
        .observeOn(MainScheduler.instance)
            .map { BookDetailDto(json: JSON($0)) }
            .subscribe { print($0) }
            .disposed(by: self.rx.disposeBag)
        

        RxAlamofire.requestJSON(.get, listUrl)
            .subscribe(onNext: { response, json in
                if let jsonDict = json as? [String: Any] {
                    dump(jsonDict)
                }
            }, onError: { error in
                print(error)
            }, onCompleted: {
                print("completed")
            }, onDisposed: {
                print("disposed")
            }).disposed(by: self.rx.disposeBag)
    }
}
