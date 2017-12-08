//
//  MoyaObjectMapperViewController.swift
//  ApiSample
//
//  Created by Keun young Kim on 2017. 12. 7..
//  Copyright © 2017년 KxCoding. All rights reserved.
//

import UIKit
import Moya
import Moya_ObjectMapper

class MoyaObjectMapperViewController: CommonViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let provider = MoyaProvider<BookApi>()
        provider.request(.detail(id: 1)) { result in
            switch result {
            case .success(let response):
                let data = response.data
                let statusCode = response.statusCode
                
                do {
                    if let book = try? response.mapObject(BookDetailDto.self) {
                        dump(book)
                    } else {
                        print("fail")
                    }
                } catch {
                    print(error)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
