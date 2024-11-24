//
//  HomeView.swift
//  Orchen
//
//  Created by Rahul Ramjeawon on 11/14/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var studentManager: StudentManager
    @State private var searchText: String = ""
    
    private var filteredStudents: [StudentProfile] {
        studentManager.search(for: searchText)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    HStack {
                        TextField("Search students", text: $searchText)
                            .font(.system(size: 20))
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(20)
                    }
                    .padding(20)
                    
                    List(filteredStudents) { student in
                        NavigationLink {
                            Text(student.name)
                        } label: {
                            HStack {
                                Image(systemName: "person.crop.circle")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .padding(.leading, 30)
                                
                                Text(student.name)
                                    .font(.system(size: 36))
                                    .bold()
                                    .lineLimit(1)
                                    .foregroundColor(.indigo)
                                    .padding(.leading, 50)
                                Text("(\(student.studentID))")
                                    .font(.system(size: 36))
                                    .bold()
                                    .lineLimit(1)
                                    .foregroundColor(.indigo)
                            }
                            .frame(height: 80)
                        }
                    }
                    .listStyle(PlainListStyle())
                    .onAppear {
                        let student = StudentProfile()
                        student.name = "Emil Levin"
                        let student1 = StudentProfile()
                        student1.name = "James Bond"
                        studentManager.addStudent(student)
                        studentManager.addStudent(student1)
                    }
                }
                
                VStack {
                    Spacer()
                    AddButtonView({
                        let student = StudentProfile()
                        student.name = "Emil Levin"
                        let student1 = StudentProfile()
                        student1.name = "James Bond"
                        studentManager.addStudent(student)
                        studentManager.addStudent(student1)
                    })
                    .padding(.bottom, 20)
                }
            }
            .navigationTitle("Students")
            .animation(.default, value: searchText)
        }
        .colorScheme(.light)
    }
}

#Preview {
    HomeView(studentManager: StudentManager())
}
