//
//  RegisterNewUser.swift
//  ChatApp
//
//  Created by Naumaan Sheikh on 2023-06-14.
//

import SwiftUI

struct RegisterNewUserView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var password2: String = ""
    
    @State private var isHidden: Bool = true
    @State private var isHidden2: Bool = true
    @State private var isHidden3: Bool = true
    @State private var isHidden4: Bool = true
    @State private var showLoginView: Bool = false
    
    @State private var auth = LoginAuth()
    
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
                    
                    Button {
//                        var auth = LoginAuth(email_param: email, password_param: password)
                        if self.password == ""
                           || self.password2 == ""
                           || self.email == "" {
                            isHidden4 = false
                            
                        } else {
                            if(self.password == self.password2) {
                                self.isHidden2 = true
                                auth.login(email_param: email, password_param: password)
                                
                                if !auth.loginUser {
                                    auth.registerNewUser(email_param: email, password_param: password)
                                    if auth.createUser {
                                        // if register successful
                                        self.isHidden = true
                                        showLoginView = true
                                        print("Creating new user...")
                                    } else {
                                        // display error message if register fail
                                        self.isHidden = false
                                    }
                                } else {
                                    auth.logout()
                                    self.isHidden3 = false
                                }
                                
                            } else {
                                self.isHidden2 = false
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
                    
                    if !isHidden {
                        Text("**Something went wrong when trying to create a new user. Try again.")
                            .foregroundColor(Color("Red"))
                            .font(.callout)
                            .padding(.bottom)
                            .frame(maxWidth: .infinity)
                    } else if !isHidden2 {
                        Text("Passwords don't match. Please check again.")
                            .foregroundColor(Color("Red"))
                            .font(.callout)
                            .padding(.bottom)
                            .frame(maxWidth: .infinity)
                    } else if !isHidden3 {
                        Text("Email already in use or Invalid email")
                            .foregroundColor(Color("Red"))
                            .font(.callout)
                            .padding(.bottom)
                            .frame(maxWidth: .infinity)
                    } else if !isHidden4 {
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
            .navigationDestination(
                isPresented: $showLoginView) {
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
