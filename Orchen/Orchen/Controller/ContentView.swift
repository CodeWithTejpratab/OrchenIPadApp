//
//  ContextView.swift
//  Orchen
//
//  Created by Rahul Ramjeawon on 11/10/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn: Bool = false
    
    var body: some View {
        if !isLoggedIn {
            LoginView(isLoggedIn: $isLoggedIn)
        } else {
            HomeView()
        }
    }
}

#Preview {
    ContentView()
}
