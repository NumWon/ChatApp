//
//  LoginView.swift
//  ChatApp
//
//  Created by Naumaan Sheikh on 2023-06-13.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
//    @State private var statusMessage: String = ""
    
    @State private var isHidden: Bool = true
    @State private var showNextView: Bool = false
    
    @StateObject var auth = LoginAuth()
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Sign In")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                
                Image("AppLogo")
                    .resizable()
                    .frame(width: 150.0, height: 150.0)
                    .scaledToFit()
                    .cornerRadius(200.0)
                    .padding(.bottom, 20)
                
                TextField("Enter email address", text: $email)
                    .font(.title3)
                    .padding()
                    .background(.white)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(50.0)
                    .autocapitalization(.none)
                
                SecureField("Enter password", text: $password)
                    .font(.title3)
                    .padding()
                    .background(.white)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(50.0)
                    .autocapitalization(.none)
                
                Button {
                    showNextView = false
                    auth.login(email_param: email, password_param: password)
                } label: {
                    Text("Login")
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
//                    Text("Incorrect Email/Password. Please try again.")
                    Text(auth.statusMessage)
                        .foregroundColor(.red)
                        .font(.callout)
                        .padding(.bottom)
                        .frame(maxWidth: .infinity)
                }

                NavigationLink(
                    destination:
                        RegisterNewUserView(),
                    label: {
                        Text("Register Now")
                            .foregroundColor(Color("Blue"))
                            .font(.callout)
                            .padding(.top)
                            .frame(maxWidth: .infinity)
                })
                
                Text("Forgot Password?")
                    .foregroundColor(Color("Blue"))
                    .font(.callout)
                    .padding(.top, 1)
                    .frame(maxWidth: .infinity)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .background(Color("BackColour"))
            .environmentObject(auth)
            .navigationDestination(
                isPresented: $auth.loginUser) {
                    ChatView()
                }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
