//
//  LoginManager.swift
//  Orchen
//
//  Created by Rahul Ramjeawon on 11/10/24.
//

import Foundation
import FirebaseCore
import FirebaseAuth

struct LoginManager {
  
    var email: String {
        Auth.auth().currentUser?.email ?? "example@gmail.com"
    }
    
    var displayName: String {
        Auth.auth().currentUser?.displayName ?? "Unknown User"
    }
   
    var photoUrl: URL? {
        Auth.auth().currentUser?.photoURL
    }
    func performLogin(with email: String, and password: String, errorHandler: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
             errorHandler(error)
        }
    }
    
    func loginStatus() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    func signOut(updateLogin: () -> Void) {
        do {
            try Auth.auth().signOut()
            updateLogin()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getUserID() -> String {
        Auth.auth().currentUser?.uid ?? ""
    }
}
