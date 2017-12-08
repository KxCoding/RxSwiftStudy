//
//  AlamofireViewController.swift
//  ApiSample
//
//  Created by Keun young Kim on 2017. 12. 7..
//  Copyright © 2017년 KxCoding. All rights reserved.
//

import UIKit
import Alamofire

class AlamofireViewController: CommonViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Alamofire"

        Alamofire.request(listUrl).responseJSON { [weak self] response in
            guard response.result.isSuccess else {
                return
            }
            
            guard let json = response.result.value as? [String: Any] else {
                return
            }
            
            guard let data = response.data else {
                return
            }
            
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
        }
    }
}
