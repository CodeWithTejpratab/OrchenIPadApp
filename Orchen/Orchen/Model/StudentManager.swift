//
//  StudentManager.swift
//  Orchen
//
//  Created by Rahul Ramjeawon on 11/26/24.
//

import Foundation

class StudentManager: ObservableObject {
    
    @Published var students: [StudentProfile] = []
    
    func addStudent (_ student: StudentProfile) {
        self.students.append(student)
    }
    
    func search(for searchTerm: String) -> [StudentProfile] {
        return searchTerm.isEmpty ? students : students.filter { student in student.name.localizedCaseInsensitiveContains(searchTerm)
        }
    }
    
}
