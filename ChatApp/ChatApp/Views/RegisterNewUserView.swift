//
//  RegisterNewUser.swift
//  ChatApp
//
//  Created by Naumaan Sheikh on 2023-06-14.
//

import SwiftUI

struct RegisterNewUserView: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var password2: String = ""
    
    @State private var isHidden: Bool = true
    @State private var isHidden2: Bool = true
    @State private var isHidden3: Bool = true
    @State private var showLoginView: Bool = false
    
    @StateObject var auth = LoginAuth()
    
    var body: some View {
        
        NavigationStack {
            VStack {
                VStack {
                    Text("Register New User")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                    
                    Divider()
                        .overlay(.white)
                        .padding(.bottom, 20)
                    Group {
                        TextField("Enter username *", text: $username)
                            .font(.title3)
                            .padding()
                            .background(.white)
                            .frame(maxWidth: .infinity)
                            .cornerRadius(50.0)
                            .autocapitalization(.none)
                        
                        TextField("Enter email address *", text: $email)
                            .font(.title3)
                            .padding()
                            .background(.white)
                            .frame(maxWidth: .infinity)
                            .cornerRadius(50.0)
                            .autocapitalization(.none)
                        
                        SecureField("Enter password *", text: $password)
                            .font(.title3)
                            .padding()
                            .background(.white)
                            .frame(maxWidth: .infinity)
                            .cornerRadius(50.0)
                            .autocapitalization(.none)
                       
                        SecureField("Re-enter password *", text: $password2)
                            .font(.title3)
                            .padding()
                            .background(.white)
                            .frame(maxWidth: .infinity)
                            .cornerRadius(50.0)
                            .autocapitalization(.none)
                    }
                    
                    Button {
                        if self.password == ""
                           || self.password2 == ""
                           || self.email == "" {
                            isHidden3 = false
                            
                        } else {
                            if(self.password == self.password2) {
                                self.isHidden = true
                                auth.login(email_param: email, password_param: password)
                                
                                if !auth.loginUser {
                                    auth.registerNewUser(email_param: email, password_param: password,
                                    username_param: username)
                                } else {
                                    auth.logout()
                                    self.isHidden2 = false
                                }
                                
                            } else {
                                // error for passwords not matching
                                self.isHidden = false
                            }
                        }
                    } label: {
                        Text("Register")
                            .font(.title3)
                            .bold()
                            .padding()
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                    }
                    .background(.blue)
                    .cornerRadius(50.0)
                    .padding(.top, 20)
                    .padding(.horizontal, 80)
                    
                    Text(auth.statusMessageNewUser)
                        .foregroundColor(Color("Red"))
                        .font(.callout)
                        .padding(.bottom)
                        .frame(maxWidth: .infinity)
                    
                    if !isHidden {
                        Text("Passwords don't match. Please check again.")
                            .foregroundColor(Color("Red"))
                            .font(.callout)
                            .padding(.bottom)
                            .frame(maxWidth: .infinity)
                    }
                    if !isHidden2 {
                        Text("Email already in use or Invalid email")
                            .foregroundColor(Color("Red"))
                            .font(.callout)
                            .padding(.bottom)
                            .frame(maxWidth: .infinity)
                    }
                    if !isHidden3 {
                        Text("*All fields must be filled")
                            .foregroundColor(Color("Red"))
                            .font(.callout)
                            .padding(.bottom)
                            .frame(maxWidth: .infinity)
                    }
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .background(Color("BackColour"))
            .environmentObject(auth)
            .navigationDestination(
                isPresented: $auth.createUser) {
                    LoginView()
                }
        }
    }
}

struct RegisterNewUser_Previews: PreviewProvider {
    static var previews: some View {
        RegisterNewUserView()
    }
}
