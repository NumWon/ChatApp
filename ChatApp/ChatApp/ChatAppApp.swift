//
//  ChatAppApp.swift
//  ChatApp
//
//  Created by Naumaan Sheikh on 2023-06-12.
//

import SwiftUI
import Firebase

@main
struct ChatAppApp: App {
    
    init() {
        FirebaseApp.configure()
    }
      
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
