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
    
    func performLogin(with email: String, and password: String, errorHandler: @escaping (Error?) -> Bool) -> Bool {
        var onSuccess: Bool = false
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            onSuccess = errorHandler(error)
        }
        return onSuccess
    }
    
    func loginStatus() -> Bool {
        return Auth.auth().currentUser != nil ? true : false
    }
    
    func signOut(signOutError: @escaping (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
        } catch {
            signOutError(error)
        }
    }
    
}
