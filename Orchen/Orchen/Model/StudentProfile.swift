//
//  StudentProfile.swift
//  Orchen
//
//  Created by Rahul Ramjeawon on 11/22/24.
//

import Foundation

class StudentProfile: Identifiable, ObservableObject {
    @Published var studentID: Int
    @Published var name: String
    @Published var grade: String
    @Published var credit: Int
    @Published var observations: [Observation]
    
    private var observationCount: Int {
        observations.count + 1
    }
    
    init(studentID: Int, name: String, grade: String, credit: Int = 0, observations: [Observation] = []) {
        self.studentID = studentID
        self.name = name
        self.grade = grade
        self.credit = credit
        self.observations = observations
    }
    
    func addObservation() {
        observations.append(Observation(observationID: "Observation \(observationCount)"))
    }
    
    func editProfile(name: String = "", grade: String = "") {
        self.name = name
        self.grade = grade
    }
    
    func getObservationSummary() {
        
    }
}

