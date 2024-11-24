//
//  Observation.swift
//  Orchen
//
//  Created by Rahul Ramjeawon on 11/22/24.
//

import Foundation

class Observation: Identifiable {
    var observationID: String
    var sectionTitle: String
    var date: Date
    var item: [CheckListItem]
    var additonalCriteria: [CustomCriteria]
    
    init(observationID: String, sectionTitle: String, date: Date, item: [CheckListItem], additionalCriteria: [CustomCriteria]) {
        self.observationID = observationID
        self.sectionTitle = sectionTitle
        self.date = date
        self.item = item
        self.additonalCriteria = additionalCriteria
    }
    
    class CheckListItem: Identifiable {
        var description: String
        var note: String
        var rating: Number
        
        init(description: String, note: String, rating: Number) {
            self.description = description
            self.note = note
            self.rating = rating
        }
    }
    
    class CustomCriteria: Identifiable {
        var name: String
        var description: String
        private var count: Int
        
        init(name: String, description: String) {
            self.name = name
            self.description = description
            self.count = 0
        }
        
        func increment() {
            count += 1
        }
        
        func deincrement() {
            count -= 1
        }
    }
    
    enum Number {
        case one, two, three, four
    }
}
