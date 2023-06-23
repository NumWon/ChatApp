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
    @Published private(set) var username = ""
    @Published private(set) var uid: String = ""
    @Published private(set) var statusMessage: String = ""
    @Published private(set) var statusMessageNewUser: String = ""
    @Published public var loginUser: Bool = false
    @Published public var createUser: Bool = false
    
    
    let db = Firestore.firestore()
    
    public init() {}

    
    // need to change view based on change in var of self.uid
    func login(email_param: String, password_param: String) {
        self.email = email_param
        self.password = password_param
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Failed to login user: ", error.localizedDescription)
                self.statusMessage = "\(error.localizedDescription)"
                return
            } else {
                print("Successfully logged in as user: \(result?.user.uid ?? "")")
                self.loginUser = true
                
//                self.statusMessage = "Successfully logged in as user: \(result?.user.uid ?? "")"
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
            self.username = ""
            
            try Auth.auth().signOut()
        } catch let error{
            print("Error signing out: \(error)")
        }
    }
    
    
    // need to change view based on change in var of self.createUser
    func registerNewUser(email_param: String, password_param: String, username_param: String) {
        self.email = email_param
        self.password = password_param
        self.username = username_param
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error != nil {
                self.createUser = false
                print("Failed to create user: ", error?.localizedDescription ?? "")
                
            } else {
                let uid = authResult?.user.uid ?? ""
                self.addToDatabase(uid: uid, username: self.username, email: self.email)
            }
        }
    }
    
    func addToDatabase(uid: String, username: String, email: String) {
        do {
            let newUser = User(id: "\(UUID())", uid: uid, username: username, email: email)
            try db.collection("users").document("\(uid)").setData(from: newUser)
            
            self.createUser = true
        } catch let error {
            print("Error in adding user to Firestore Database: \(error)")
            self.statusMessageNewUser = "Error adding user to database"
            
//            let user = Auth.auth().currentUser
//            user?.delete { error in
//                if let error = error {
//                    print("Error deleting account: \(error.localizedDescription)")
//                } else {
//                    print("Deleted user account")
//                }
//
//            }
        }
    }
}
