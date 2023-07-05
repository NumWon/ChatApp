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
    var keywordsForLookup: [String] {
        [self.username.generateStringSequence()].flatMap { $0 }
    }
}

extension String {
    
    /// describing: E.g. Mark -> ["M", "Ma", "Mar", "Mark"]
    func generateStringSequence() -> [String] {
        
        guard self.count > 0 else {return [] }
        var seqs: [String] = []
        for i in 1..<self.count {
            seqs.append(String(self.prefix(i)))
        }
        return seqs
    }
}
