//
//  CommonViewController.swift
//  ApiSample
//
//  Created by Keun young Kim on 2017. 12. 7..
//  Copyright © 2017년 KxCoding. All rights reserved.
//

import UIKit

class CommonViewController: UIViewController {
    
    @IBOutlet var listTableView: UITableView?
    
    var list: BookListDto?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension CommonViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list?.list.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        if let target = list?.list[indexPath.row] {
            cell.textLabel?.text = target.title
            cell.detailTextLabel?.text = target.description
        }
        
        return cell
    }
}
