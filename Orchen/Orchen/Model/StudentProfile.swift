//
//  StudentProfile.swift
//  Orchen
//
//  Created by Rahul Ramjeawon on 11/22/24.
//

import Foundation

class StudentProfile: Identifiable {
    var studentID: Int = 0
    var name: String = ""
    var grade: String = ""
    var credit: Int = 0
    var observations: [Observation] = []
    
    init(studentID: Int, name: String, grade: String, credit: Int = 0, observations: [Observation] = []) {
        self.studentID = studentID
        self.name = name
        self.grade = grade
        self.credit = credit
        self.observations = observations
    }
    
    func addObservation(observation: Observation) {
        observations.append(observation)
    }
    
    func editProfile(name: String = "", grade: String = "") {
        self.name = name
        self.grade = grade
    }
    
    func getObservationSummary() {
        
    }
}
