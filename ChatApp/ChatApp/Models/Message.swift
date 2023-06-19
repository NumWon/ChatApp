//
//  Message.swift
//  ChatApp
//
//  Created by Naumaan Sheikh on 2023-06-12.
//

import Foundation

struct Message: Identifiable, Codable {
    var id: String
    var text: String
    var received: Bool
    var timestamp: Date
}

