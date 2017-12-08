//
//  MoyaCommon.swift
//  ApiSample
//
//  Created by Keun young Kim on 2017. 12. 7..
//  Copyright © 2017년 KxCoding. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper

enum BookApi {
    case list
    case detail(id: Int)
}

extension BookApi: TargetType {
    var baseURL: URL {
        return baseUrl
    }
    
    var path: String {
        switch self {
        case .list:
            return "/books"
        case .detail(let id):
            return "/books/\(id)"
        }
    }
    
    var sampleData: Data {
        switch self {
        case .list:
            return Data()
        case .detail:
            return Data()
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .list:
            return .get
        case .detail:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .list:
            return .requestPlain
        case .detail(let id):
            return .requestParameters(parameters: ["id": id], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}


extension Book: Mappable {
    init?(map: Map) {
        id = nil
        title = nil
        description = nil
        yes24Link = nil
        publicationDate = nil
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        description <- map["description"]
        yes24Link <- map["yes24Link"]
        publicationDate <- map["publicationDate"]
    }
}

extension BookDetailDto: Mappable {
    init?(map: Map) {
        code = 0
        book = nil
    }
    
    mutating func mapping(map: Map) {
        code <- map["code"]
        book <- map["book"]
    }
}
