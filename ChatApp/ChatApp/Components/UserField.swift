//
//  UserField.swift
//  ChatApp
//
//  Created by Naumaan Sheikh on 2023-06-22.
//

import SwiftUI

struct UserField: View {
    var user: User
    
    var imageUrl = URL(string: "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80")
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                AsyncImage(url: imageUrl) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .cornerRadius(50)
                } placeholder: {
                    ProgressView()
                }
                Text("asdasdas")
            }
            Divider()
        }
        .padding()
    }
}

struct UserField_Previews: PreviewProvider {
    static var previews: some View {
        UserField(user: User(id: "", uid: "", username: "", email: "")
                  , imageUrl: URL(string: "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80"))
    }
}
