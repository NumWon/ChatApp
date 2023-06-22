//
//  Authorization.swift
//  ChatApp
//
//  Created by Naumaan Sheikh on 2023-06-14.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class LoginAuth: ObservableObject {
    @Published private(set) var email = ""
    @Published private(set) var password = ""
    @Published private(set) var name = ""
    @Published private(set) var uid: String = ""
    @Published private(set) var statusMessage: String = ""
    @Published public var loginUser: Bool = false
    @Published private(set) var createUser: Bool = false
    
//    var handle: AuthStateDidChangeListenerHandle?
    
    let db = Firestore.firestore()
    
//    init(email_param: String, password_param: String) {
//        self.email = email_param
//        self.password = password_param
//    }
    public init() {}

    
    // need to change view based on change in var of self.uid
    func login(email_param: String, password_param: String) {
        self.email = email_param
        self.password = password_param
//        let root = Firestore.firestore() // instance of database
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Failed to login user: ", error.localizedDescription)
                self.statusMessage = "Failed to login user: \(error)"
                return
            } else {
                print("Successfully logged in as user: \(result?.user.uid ?? "")")
                self.uid = result?.user.uid ?? "abc123"
                self.loginUser = true
                
                self.statusMessage = "Successfully logged in as user: \(result?.user.uid ?? "")"
            }
        }
    }
    
    func logout() {
        do {
            self.loginUser = false
            self.uid = ""
            self.statusMessage = ""
            self.email = ""
            self.password = ""
            self.name = ""
            
            try Auth.auth().signOut()
        } catch let error{
            print("Error signing out: \(error)")
        }
    }
    
    
    // need to change view based on change in var of self.createUser
    func registerNewUser(email_param: String, password_param: String) {
        self.email = email_param
        self.password = password_param
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error != nil {
                self.createUser = false
                print(error?.localizedDescription ?? "")
            } else {
                self.createUser = true
                let uid = authResult?.user.uid ?? ""
                self.addToDatabase(uid: uid, name: self.name, email: self.email)
            }
        }
    }
    
    func addToDatabase(uid: String, name: String, email: String) {
        do {
            let newUser = User(id: "\(UUID())", uid: uid, name: name, email: email)
            try db.collection("users").document().setData(from: newUser)
        } catch let error {
            print("Error in adding user to Firestore Database: \(error)")
        }
    }
}
