//
//  HomeView.swift
//  Orchen
//
//  Created by Rahul Ramjeawon on 11/14/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var studentManager: StudentManager
    @State private var searchText: String = ""
    @State private var showRecentStudents: Bool = true
    @State private var addStudentButtonTap: Bool = false
    
    private var filteredStudents: [StudentProfile] {
        studentManager.search(for: searchText, shouldFilter: showRecentStudents)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    HStack(spacing: 10) {
                        Image(systemName: "magnifyingglass")
                        TextField("Search students", text: $searchText)
                            .font(.system(size: 20))
                        Button {
                            searchText.removeAll()
                        } label: {
                            Image(systemName: "multiply")
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(20)
                    .padding(20)
                    
                    List(filteredStudents) { student in
                        NavigationLink {
                            ObservationView(for: student)
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
                                Text("(\(String(student.studentID)))")
                                    .font(.system(size: 36))
                                    .bold()
                                    .lineLimit(1)
                                    .foregroundColor(.indigo)
                            }
                            .frame(height: 80)
                        }
                    }
                    .listStyle(PlainListStyle())
                }
                
                VStack {
                    Spacer()
                    AddButtonView({
                        addStudentButtonTap.toggle()
                    })
                    .sheet(isPresented: $addStudentButtonTap) {
                        NewStudentView(studentManager: studentManager)
                    }
                    .padding(.bottom, 20)
                }
            }
            .navigationTitle("Students")
            .animation(.default, value: searchText)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showRecentStudents.toggle()
                    } label: {
                        Image(systemName: showRecentStudents ? "chevron.down.circle.fill" : "chevron.up.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding(.leading, 5)
                        Text(showRecentStudents ? "Recent" : "")
                            .foregroundColor(.black)
                    }
                }
            }
        }
        .colorScheme(.light)
    }
}

#Preview {
    HomeView(studentManager: StudentManager())
}
