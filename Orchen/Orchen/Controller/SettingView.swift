//
//  SettingView.swift
//  Orchen
//
//  Created by Rahul Ramjeawon on 11/14/24.
//


import SwiftUI

struct SettingView: View {
    @Binding var isLoggedIn: Bool
    private let loginManager = LoginManager()
    
    var body: some View {
        ZStack {
            Button {
                loginManager.signOut {
                    isLoggedIn = false
                }
            } label: {
                Text("Logout")
                    .font(.system(size: 40))
                    .tint(Color.white)
                    .bold()
                    .frame(width: 150, height: 150)
                    .background(.green)
                    .cornerRadius(20)
            }
        }.colorScheme(.light)
    }
}

struct SettingView_Previews: PreviewProvider {
    @State static var isLoggedIn = true
    static var previews: some View {
        SettingView(isLoggedIn: $isLoggedIn)
    }
}
