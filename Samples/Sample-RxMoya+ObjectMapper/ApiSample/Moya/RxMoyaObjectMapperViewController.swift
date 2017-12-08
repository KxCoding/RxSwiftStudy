//
//  RxMoyaObjectMapperViewController.swift
//  ApiSample
//
//  Created by Keun young Kim on 2017. 12. 7..
//  Copyright © 2017년 KxCoding. All rights reserved.
//

import UIKit
import Moya
import RxAlamofire
import RxSwift

class RxMoyaObjectMapperViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let provider = MoyaProvider<BookApi>()
        provider.rx.request(.detail(id: 1))
            .mapObject(BookDetailDto.self)
            .subscribe { print($0) }
    }
}
