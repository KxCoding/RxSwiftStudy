//
//  JSONDecoderViewController.swift
//  ApiSample
//
//  Created by Keun young Kim on 2017. 12. 7..
//  Copyright © 2017년 KxCoding. All rights reserved.
//

import UIKit



class JSONDecoderViewController: CommonViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "JSONDecoder"

        DispatchQueue.global().async { [weak self] in
            do {
                let data = try Data(contentsOf: listUrl)
                
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(BookListDto.self, from: data)
                self?.list = decodedData
                
                DispatchQueue.main.async {
                    self?.listTableView?.reloadData()
                }
            } catch {
                print(error)
            }
        }
    }
}
