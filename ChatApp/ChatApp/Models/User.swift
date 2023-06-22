//
//  User.swift
//  ChatApp
//
//  Created by Naumaan Sheikh on 2023-06-20.
//

import Foundation

struct User: Identifiable, Codable {
    var id: String
    var uid: String
    var username: String
    var email: String
    var contacts = [String]()
}
