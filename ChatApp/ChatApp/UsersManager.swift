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
    @Published private(set) var contacts: [User] = []
    @Published var queriedUsers: [User] = []
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
                self.currentUser.contacts = data!["contacts"] as? [String] ?? []
            } else {
                print("Document doesn't exist")
            }
            
        }
        getUsers()
    }
    
    // find User profiles of all users in contacts and add to the users
    func getUsers() {
        db.collection("users").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error fethcing documents: \(String(describing: error))")
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
        }
        
        // fill contacts array with User of all contacts
        for i in 0..<currentUser.contacts.count {
            let contactUID = currentUser.contacts[i]
            let doc = db.collection("users").document("\(contactUID)")
            doc.getDocument { document, error in
                if let document = document, document.exists {
                    let data = document.data()
                    self.contacts[i].email = data!["email"] as? String ?? ""
                    self.contacts[i].username = data!["username"] as? String ?? ""
                }
            }
        }
    }
    
    func createNewChat(keyword: String) {
        db.collection("users").whereField("keywordsForLookup", arrayContains: keyword).getDocuments { querySnapshot, error in
            guard let documents = querySnapshot?.documents, error == nil else { return }
            self.queriedUsers = documents.compactMap { queryDocumentSnapshot in
                try? queryDocumentSnapshot.data(as: User.self)
                
            }
            
        }
    }
}
//-----------------------------------------------------------------------

//    func getContacts() {
//        let refToRead = self.db.collection("users/").document("\(currentUser.uid)")
//        refToRead.getDocument(completion: { documentSnapshot, error in
//            if let err = error {
//                print("Error fetching document: \(String(describing: error))")
//                return
//            }
//
//            if let doc = documentSnapshot {
//                self.currentUser.contacts = doc.get("contacts") as! [String]
//            }
//        })
//    }
