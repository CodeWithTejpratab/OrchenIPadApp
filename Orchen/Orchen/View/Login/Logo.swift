//
//  Logo.swift
//  Orchen
//
//  Created by Rahul Ramjeawon on 11/10/24.
//


import SwiftUI

struct Logo: View {
    var body: some View {
        Image("Logo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 200, height: 200)
            .cornerRadius(15)
    }
}
