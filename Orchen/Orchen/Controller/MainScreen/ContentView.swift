//
//  ContextView.swift
//  Orchen
//
//  Created by Rahul Ramjeawon on 11/10/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn: Bool = false
    @StateObject private var studentManager = StudentManager()
    
    var body: some View {
        if !isLoggedIn {
            LoginView(isLoggedIn: $isLoggedIn)
        } else {
            LoggedInView(studentManager: studentManager, isLoggedIn: $isLoggedIn)
        }
    }
}

struct LoggedInView: View {
    @ObservedObject var studentManager: StudentManager
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        ZStack {
            TabView {
                CheckListView()
                    .tabItem {
                        Image(systemName: "checklist")
                    }
                
                HomeView(studentManager: studentManager)
                    .tabItem {
                        Image(systemName: "house.fill")
                    }
                
                SettingView(isLoggedIn: $isLoggedIn)
                    .tabItem {
                        Image(systemName: "gearshape.fill")
                    }
            }
            .tint(.black)
        }.colorScheme(.light)
    }
}

#Preview {
    ContentView()
}
