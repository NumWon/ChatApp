//
//  UsersManager.swift
//  ChatApp
//
//  Created by Naumaan Sheikh on 2023-06-20.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class UsersManager: ObservableObject {
    @Published private(set) var users: [User] = []
//    @Published private(set) var lastUser = ""
    
    
    let db = Firestore.firestore()
    
    init() {
        getUsers()
    }
    
    func getUsers() {
        db.collection("users").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(String(describing: error))")
                return
            }
            
            self.users = documents.compactMap { document -> User? in
                do {
                    return try document.data(as: User.self)
                } catch {
                    print("Error decoding document into User: \(error)")
                    return nil
                }
            }
//            self.users.sort {$0.timestamp > $1.timestamp }
//            if let id = self.users.last?.id {
//                self.lastUser = id
//            }
        }
    }
    
    func createNewChat() {
    }
}
