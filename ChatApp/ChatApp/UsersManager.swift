//
//  UsersManager.swift
//  ChatApp
//
//  Created by Naumaan Sheikh on 2023-06-20.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class UsersManager: ObservableObject {
    @Published private(set) var users: [User] = []
//    @Published private(set) var currentUser = Auth.auth().currentUser
    
    @Published public var currentUser: User = User (
        id: "",
        uid: "",
        username: "",
        email: "",
        contacts: [])
//    @Published private(set) var lastUser = ""
    
    
    let db = Firestore.firestore()
    
    init() {
        
        let doc = db.collection("users").document("\(Auth.auth().currentUser?.uid ?? "")")
        doc.getDocument { document, error in
            if let document = document, document.exists {
                let data = document.data()
                self.currentUser.id = data!["id"] as? String ?? ""
                self.currentUser.uid = data!["uid"] as? String ?? ""
                self.currentUser.email = data!["email"] as? String ?? ""
                self.currentUser.username = data!["username"] as? String ?? ""
            } else {
                print("Document doesn't exist")
            }
            
        }
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
