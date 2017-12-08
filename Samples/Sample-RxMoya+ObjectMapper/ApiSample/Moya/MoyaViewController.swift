//
//  MoyaViewController.swift
//  ApiSample
//
//  Created by Keun young Kim on 2017. 12. 7..
//  Copyright © 2017년 KxCoding. All rights reserved.
//

import UIKit
import Moya
import Moya_ObjectMapper

class MoyaViewController: CommonViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let provider = MoyaProvider<BookApi>()
        provider.request(.list) { [weak self] result in
            switch result {
            case .success(let response):
                let data = response.data
                //let statusCode = response.statusCode

                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(BookListDto.self, from: data)
                    self?.list = decodedData
                    
                    DispatchQueue.main.async {
                        self?.listTableView?.reloadData()
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
