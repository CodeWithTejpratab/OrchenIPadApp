//
//  ButtonView.swift
//  Orchen
//
//  Created by Rahul Ramjeawon on 11/10/24.
//


import SwiftUI

struct AlertButton: View {
    var showAlert: Binding<Bool>
    @Binding var showOverlay: Bool
    var buttonTapped: () -> Void
    var eMessage: String
    
    var body: some View {
        Button(action: buttonTapped) {
            Text("Log In")
                .font(.headline.weight(.bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.orange)
                .cornerRadius(8)
        }
        .alert( "Error", isPresented: showAlert) {
            Button("OK", role: .cancel) {showOverlay = true}
        } message: {
            Text(eMessage)
        }
    }
}
