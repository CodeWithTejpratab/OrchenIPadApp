//
//  AddButtonView.swift
//  Orchen
//
//  Created by Rahul Ramjeawon on 11/26/24.
//


import SwiftUI

struct AddButtonView: View {
    var buttonTapped: () -> Void
    
    init(_ buttonTapped: @escaping () -> Void) {
        self.buttonTapped = buttonTapped
    }
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: buttonTapped) {
                VStack {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .tint(.white)
                }
                .frame(width: 100, height: 100)
                .background(Color.loginBackground)
                .cornerRadius(50)
                .padding()
            }
        }
    }
}


#Preview {
    AddButtonView({})
}
