//
//  ContextView.swift
//  Orchen
//
//  Created by Rahul Ramjeawon on 11/10/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn: Bool = true
    @StateObject private var studentManager = StudentManager()
    
    var body: some View {
        if !isLoggedIn {
            LoginView(isLoggedIn: $isLoggedIn)
        } else {
            LoggedInView(studentManager: studentManager)
        }
    }
}

struct LoggedInView: View {
    @StateObject var studentManager: StudentManager
    
    var body: some View {
        ZStack {
            TabView {
                CheckListView()
                    .tabItem {
                        Image(systemName: "checklist")
                    }
                    .padding(.bottom, 10)
                
                HomeView(studentManager: studentManager)
                    .tabItem {
                        Image(systemName: "house.fill")
                    }
                    .padding(.bottom, 10)
                
                SettingView()
                    .tabItem {
                        Image(systemName: "gearshape.fill")
                    }
                    .padding(.bottom, 10)
            }
            .tint(.black)
        }
    }
}

#Preview {
    ContentView()
}
