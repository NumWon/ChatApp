//
//  TitleRow.swift
//  ChatApp
//
//  Created by Naumaan Sheikh on 2023-06-12.
//

//TitleRow(imageUrl: self.imageUrl!, name: self.usersManager.currentUser.username)

import SwiftUI

struct TitleRow: View {
//    var imageUrl = URL(string: "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80")

    var imageUrl: URL
    var name: String
    
    init(imageUrl: URL, name: String) {
        self.imageUrl = imageUrl
        self.name = name
    }
    
    var body: some View {
        HStack(spacing: 20) {
            AsyncImage(url: imageUrl) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .cornerRadius(50)
            } placeholder: {
                ProgressView()
            }
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.title).bold()
                
                Text("Online")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
//            Image(systemName: "phone.fill")
//                .foregroundColor(.gray)
//                .padding(10)
//                .background(.white)
//                .cornerRadius(50)
        }
        .padding()
    }
}

struct TitleRow_Previews: PreviewProvider {
    static var previews: some View {
        TitleRow(imageUrl: URL(string: "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80")!, name: "Naumaan Sheikh")
            .background(Color("Peach"))
    }
}
