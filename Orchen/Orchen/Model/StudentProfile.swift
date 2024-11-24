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
