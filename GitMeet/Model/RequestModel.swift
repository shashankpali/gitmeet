//
//  RequestModel.swift
//  GitMeet
//
//  Created by Shashank Pali on 02/08/22.
//

import Foundation

struct Request: Codable {
    let state: String
    let title: String
    let createdAt: String
    let closedAt: String?
    let user: User
    
    private enum CodingKeys: String, CodingKey {
        case state, title, user
        case createdAt = "created_at"
        case closedAt = "closed_at"
    }
}
struct User: Codable {
    let avatarURL: String?
    let login: String
    
    private enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
    }
}
