//
//  Authorization.swift
//  ChatApp
//
//  Created by Naumaan Sheikh on 2023-06-14.
//

import Foundation
import Firebase
import FirebaseAuth

class LoginAuth: ObservableObject {
    @Published private(set) var email = ""
    @Published private(set) var password = ""
    
    var handle: AuthStateDidChangeListenerHandle?
    
    init(email_param: String, password_param: String) {
        self.email = email_param
        self.password = password_param
    }

    func login() -> Bool {
        var ret = false
        Auth.auth().signIn(withEmail: self.email, password: self.password) { (result, error) in
            if error != nil {
                ret = false
                print(error?.localizedDescription ?? "")
            } else {
                ret = true
            }
        }
        return ret
    }
    
    func registerNewUser() -> Bool {
        var ret = true
        Auth.auth().createUser(withEmail: self.email, password: self.password) { authResult, error in
            if error != nil {
                ret = false
                print(error?.localizedDescription ?? "")
            }
        }
        return ret
    }
}
