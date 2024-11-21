//
//  LoginView.swift
//  Orchen
//
//  Created by Rahul Ramjeawon on 11/10/24.
//

import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    @State private var showingAlert = false
    @State private var showOverlay: Bool = false
    @Binding var isLoggedIn: Bool
    
    private let loginManager = LoginManager()
    
    var body: some View {
        ZStack {
            BackgoundColor()
            
            VStack(spacing: 20) {
                Logo()
                
                TextField("Username", text: $username)
                    .padding()
                    .autocapitalization(.none)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                    .keyboardType(.emailAddress)
                    .overlay(
                        LoginOverlayConfig(with: showOverlay)
                    )
                
                PasswordTextField(password: $password, showOverlay: showOverlay)
                
                AlertButton(showAlert: $showingAlert,
                            showOverlay: $showOverlay,
                            buttonTapped: loginButtonTapped,
                            eMessage: errorMessage)
               
            }
            .colorScheme(.light)
            .frame(width: 450)
        }.onAppear() {
            isLoggedIn = loginManager.loginStatus()
        }
        
    }
    
    private func peformErrorAlert(error: String) {
        self.errorMessage = error
        self.showingAlert = true
    }
    
    private func loginButtonTapped() {
        isLoggedIn = loginManager.performLogin(with: username, and: password) { Error in
            if let e = Error {
                peformErrorAlert(error: e.localizedDescription)
                return false
            } else {
                showOverlay = false
                return true
            }
        }
    }
    
}

struct PasswordTextField: View {
    @State private var showPassword: Bool = false
    @Binding var password: String
    var showOverlay: Bool
    
    var body: some View {
        HStack {
            if showPassword {
                TextField("Password", text: $password)
                    .padding()
            } else {
                SecureField("Password", text: $password)
                    .padding()
            }
            Button(action: { self.showPassword.toggle()}) {
                Image(systemName: showPassword ? "eye.fill" : "eye")
                    .foregroundColor(.secondary)
                    .padding()
            }
        }
        .background(Color(.secondarySystemBackground))
        .cornerRadius(8)
        .overlay(
            LoginOverlayConfig(with: showOverlay)
        )
    }
}

struct LoginOverlayConfig: View {
    var showOverlay: Bool
    
    init(with showOverlay: Bool) {
        self.showOverlay = showOverlay
    }
    
    var body: some View {
        if showOverlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.red, lineWidth: 4)
        } else {
            EmptyView()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    @State static var isLoggedIn = false
    static var previews: some View {
        LoginView(isLoggedIn: $isLoggedIn)
    }
}
