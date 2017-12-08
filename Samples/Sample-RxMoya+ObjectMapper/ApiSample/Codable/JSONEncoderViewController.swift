//
//  JSONEncoderViewController.swift
//  ApiSample
//
//  Created by Keun young Kim on 2017. 12. 7..
//  Copyright © 2017년 KxCoding. All rights reserved.
//

import UIKit



class JSONEncoderViewController: UIViewController {
    @IBOutlet weak var resultView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "JSONEncoder"
        
        let book = Book(id: 100, title: "Swift 4", description: "Swift 4 책이에요!", yes24Link: "http://yes24.com", publicationDate: "2017.12.07")
        
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(book)
            let jsonString = String(data: jsonData, encoding: .utf8)
            
            resultView.text = jsonString
        } catch {
            print(error)
        }
    }
}
