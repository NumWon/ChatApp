//
//  UsersView.swift
//  ChatApp
//
//  Created by Naumaan Sheikh on 2023-06-22.
//

import SwiftUI

struct UsersView: View {
    @StateObject var usersManager = UsersManager()
    var imageUrl = URL(string: "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80")
    
    var body: some View {
        VStack {
            TitleRow(imageUrl: self.imageUrl!, name: self.usersManager.currentUser.username)
            ScrollView {
                ForEach(usersManager.users, id: \.id) { user in
                    
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("BackColour"))
    }
}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView()
    }
}
