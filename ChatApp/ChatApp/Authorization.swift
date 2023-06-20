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
    @Published private(set) var loginUser: Bool = false
    @Published private(set) var createUser: Bool = false
    
    var handle: AuthStateDidChangeListenerHandle?
    
    let db = Firestore.firestore()
    
    init(email_param: String, password_param: String) {
        self.email = email_param
        self.password = password_param
    }

    
    // need to change view based on change in var of self.uid
    func login() {
        let root = Firestore.firestore() // instance of database 
        Auth.auth().signIn(withEmail: email, password: password, completion: { result, error in
            if let error = error {
                print("Failed to login user: ", error.localizedDescription)
                return
            }
            print("Successfully logged in as user: \(result?.user.uid ?? "")")
            self.uid = result?.user.uid ?? ""
            self.loginUser = true
            
        })
        sleep(1)
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
        } catch let error{
            print("Error signing out: \(error)")
        }
    }
    
    
    // need to change view based on change in var of self.createUser
    func registerNewUser() {
        var ret = false
        var uid = ""
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error != nil {
                self.createUser = false
                print(error?.localizedDescription ?? "")
            } else {
                ret = true
                uid = authResult?.user.uid ?? ""
            }
        }
        
        sleep(1)
        if ret && uid != "" {
            do {
                let newUser = User(id: "\(UUID())", uid: uid, name: name, email: email)
                try db.collection("users").document().setData(from: newUser)
            } catch let error {
                print("Error in adding user to Firestore: \(error)")
            }
        }
    }
}
