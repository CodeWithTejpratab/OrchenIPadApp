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
    
    @State private var email: String = ""
    @State private var displayName: String = ""
    @State private var imageURL: URL?
    
    fileprivate func fetchUser() {
        email = loginManager.email
        displayName = loginManager.displayName
        imageURL = loginManager.photoUrl
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                ZStack {
                    AsyncImage(url: imageURL) { phase in
                        switch phase {
                        case .empty:
                            Image(systemName: "person.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.gray)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                        case .failure:
                            Image(systemName: "exclamationmark.triangle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.red)
                        @unknown default:
                            Image(systemName: "person.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .frame(width: 200, height: 200)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(40)
                .padding()
                
                Text(displayName)
                    .font(.largeTitle)
                    .bold()
                    .padding(.horizontal)
                
                Text(email)
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                
                Button {
                    loginManager.signOut {
                        isLoggedIn = false
                    }
                } label: {
                    Text("Logout")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: 200, minHeight: 50)
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .padding()
            }
            .padding(.top, 50)
        }
        .colorScheme(.light)
        .onAppear {
            fetchUser()
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    @State static var isLoggedIn = true
    static var previews: some View {
        SettingView(isLoggedIn: $isLoggedIn)
    }
}
