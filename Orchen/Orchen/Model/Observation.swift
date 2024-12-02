import Foundation

class Observation: Identifiable, ObservableObject {
    var id: String { observationID }
    @Published var observationID: String
    @Published var date: Date = Date()
    @Published var items: [CheckListItem]
    @Published var additionalCriteria: [CustomCriteria]
    
    init(observationID: String, items: [CheckListItem] = sampleItems, additionalCriteria: [CustomCriteria] = []) {
        self.observationID = observationID
        self.items = items
        self.additionalCriteria = additionalCriteria
    }
    
    func addChecklistItem(title: String) {
        guard !title.isEmpty else { return }
        let newItem = CheckListItem(sectionTitle: title, sectionLists: [])
        items.append(newItem)
    }
    
    func addSection(to item: CheckListItem, description: String) {
        guard !description.isEmpty else { return }
        let newSection = SectionList(description: description, note: "", rating: nil)
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].sectionLists.append(newSection)
        }
    }
    
    func updateItem(_ item: CheckListItem) {
            objectWillChange.send()
        }
    
    class CheckListItem: Identifiable, ObservableObject {
        var id = UUID()
        @Published var sectionTitle: String
        @Published var sectionLists: [SectionList]
        
        init(sectionTitle: String, sectionLists: [SectionList]) {
            self.sectionTitle = sectionTitle
            self.sectionLists = sectionLists
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
}

class SectionList: Identifiable, ObservableObject {
    var id = UUID()
    @Published var description: String
    @Published var note: String
    @Published var rating: Rating?
    
    init(description: String, note: String, rating: Rating?) {
        self.description = description
        self.note = note
        self.rating = rating
    }
}

enum Rating: Int, CaseIterable {
    case one = 1
    case two
    case three
    case four
}

let sectionLists = [
    SectionList(description: "The goals of the lesson are clearly communicated to the students.", note: "League is dead", rating: nil),
    SectionList(description: "The stated goal(s) and criteria for success are specific", note: "An egg inside of an egg means the egg came first", rating: nil),
    SectionList(description: "ST clearly explains the relevance of the stated goal to the students.", note: "Dr. Arafat best man", rating: nil)
]

let sampleItems = [
    Observation.CheckListItem(
        sectionTitle: "Identifying & Communicating Goals",
        sectionLists: sectionLists
    ),
    Observation.CheckListItem(
        sectionTitle: "Alignment",
        sectionLists: []
    ),
    Observation.CheckListItem(
        sectionTitle: "Teaching Procedures",
        sectionLists: []
    ),
]
