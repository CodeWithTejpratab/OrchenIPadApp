//
//  Observation.swift
//  Orchen
//
//  Created by Rahul Ramjeawon on 11/22/24.
//

import Foundation

class Observation: Identifiable, ObservableObject {
    var id: String { observationID }
    @Published var observationID: String
    @Published var date: Date = Date()
    @Published var item: [CheckListItem]
    @Published var additionalCriteria: [CustomCriteria]

    init(observationID: String, item: [CheckListItem] = [], additionalCriteria: [CustomCriteria] = []) {
        self.observationID = observationID
        self.item = item
        self.additionalCriteria = additionalCriteria
    }

    class CheckListItem: Identifiable, ObservableObject {
        var id = UUID()
        @Published var sectionTitle: String
        @Published var description: String
        @Published var note: String
        @Published var rating: Rating

        init(sectionTitle: String, description: String, note: String, rating: Rating) {
            self.sectionTitle = sectionTitle
            self.description = description
            self.note = note
            self.rating = rating
        }
    }

    class CustomCriteria: Identifiable, ObservableObject {
        var id = UUID()
        @Published var name: String
        @Published var description: String
        @Published private(set) var count: Int

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

    enum Rating: Int, CaseIterable {
        case one = 1
        case two
        case three
        case four
    }
}
