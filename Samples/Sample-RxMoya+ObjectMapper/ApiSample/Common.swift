//
//  Common.swift
//  ApiSample
//
//  Created by Keun young Kim on 2017. 12. 7..
//  Copyright © 2017년 KxCoding. All rights reserved.
//

import Foundation
import SwiftyJSON


let baseUrl = URL(string: "https://kxcoding-study.azurewebsites.net/api")!
let listUrl = baseUrl.appendingPathComponent("/books")
let bookUrl = baseUrl.appendingPathComponent("/books/1")

struct Book: Codable {
    var id: Int!
    var title: String!
    var description: String!
    var yes24Link: String!
    var publicationDate: String!
    
    
    
    init(id: Int, title: String, description: String, yes24Link: String, publicationDate: String) {
        self.id = id
        self.title = title
        self.description = description
        self.yes24Link = yes24Link
        self.publicationDate = publicationDate
    }
    
    init?(json: JSON) {
        guard let id = json["id"].int else { return nil }
        guard let title = json["title"].string else { return nil }
        guard let description = json["description"].string else { return nil }
        guard let yes24Link = json["yes24Link"].string else { return nil }
        guard let publicationDate = json["publicationDate"].string else { return nil }
        
        self.init(id: id, title: title, description: description, yes24Link: yes24Link, publicationDate: publicationDate)
    }
}

struct BookDetailDto: Codable {
    var code: Int!
    var book: Book!
    
//    private enum CodingKeys: String, CodingKey {
//        case code
//        case book = "list"
//    }
    
    init?(json: JSON) {
        guard let code = json["code"].int else { return nil }
        guard let bookDict = json["book"].dictionary else { return nil }
        guard let book = Book(json: JSON(bookDict)) else { return nil }
        
        self.code = code
        self.book = book
    }
}

struct BookListDto: Codable {
    let code: Int
    let totalCount: Int
    let list: [Book]
}
