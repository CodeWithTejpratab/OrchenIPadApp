//
//  NewStudentView.swift
//  Orchen
//
//  Created by Rahul Ramjeawon on 11/27/24.
//

import SwiftUI

struct NewStudentView: View {
    @ObservedObject var studentManager: StudentManager
    @State private var studentID: String = ""
    @State private var name: String = ""
    @State private var grade: String = ""
    @State private var credit: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.white
            
            VStack(alignment: .center, spacing: 20) {
                HStack {
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "multiply")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .tint(.black)
                    }
                }
                .padding()
                
                Text("Add New Student")
                    .font(.system(size: 36))
                    .bold()
                    .padding()
                
                VStack(spacing: 20) {
                    InputTextField(name: "Student ID",
                                   text: $studentID,
                                   keyboardType: .numberPad)
                    
                    InputTextField(name: "Full Name",
                                   text: $name)
                    
                    InputTextField(name: "Grade",
                                   text: $grade)
                    
                    InputTextField(name: "Credit",
                                   text: $credit,
                                   keyboardType: .numberPad)
                }
                .frame(width: 400)
                
                
                Button("Save") {
                    let studentProfile = StudentProfile(studentID: Int(studentID) ?? 0,
                                                        name: name,
                                                        grade: grade,
                                                        credit: Int(credit) ?? 0)
                    studentManager.addStudent(studentProfile)
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.loginBackground.opacity(0.8))
                .font(.largeTitle)
                .padding()
                .foregroundStyle(.white)
                
            }
        }
        .colorScheme(.light)
    }
}

#Preview {
    NewStudentView(studentManager: StudentManager())
}

struct InputTextField: View {
    var name: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        TextField(name, text: $text)
            .font(.largeTitle)
            .keyboardType(keyboardType)
            .padding()
            .foregroundStyle(.black)
            .background(Color.gray.opacity(0.6))
            .cornerRadius(20)
    }
}
