//
//  Event.swift
//  TransformingOperator
//
//  Created by sally on 2017. 12. 15..
//  Copyright © 2017년 syjdev. All rights reserved.
//

import Foundation

typealias AnyDict = [String: Any]

class Event {
    let repo: String
    let name: String
    let imageUrl: URL
    let action: String
    
    // MARK: - JSON -> Event
    init(dictionary: AnyDict) {
        guard let repoDict = dictionary["repo"] as? AnyDict,
            let actor = dictionary["actor"] as? AnyDict,
            let repoName = repoDict["name"] as? String,
            let actorName = actor["display_login"] as? String,
            let actorUrlString = actor["avatar_url"] as? String,
            let actorUrl  = URL(string: actorUrlString),
            let actionType = dictionary["type"] as? String
            else {
                fatalError()
        }
        
        repo = repoName
        name = actorName
        imageUrl = actorUrl
        action = actionType
    }
    
    // MARK: - Event -> JSON
    var dictionary: AnyDict {
        return [
            "repo" : ["name": repo],
            "actor": ["display_login": name, "avatar_url": imageUrl.absoluteString],
            "type" : action
        ]
    }
}

