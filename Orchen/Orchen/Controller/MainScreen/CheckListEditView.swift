import SwiftUI

func ratingForColor(_ color: String) -> Rating {
    switch color {
    case "Green": return .one
    case "Yellow": return .two
    case "Red": return .three
    case "Black": return .four
    default: return .one
    }
}

struct CheckListEditView: View {
    @ObservedObject var observation: Observation
    @State private var expandedItemID: UUID?
    @State private var isPopupVisible = false
    @State private var activeNote: String = ""
    @State private var activeItemID: UUID?
    @State private var newSectionTitle: String = ""
    @State private var newSectionDescription: String = ""

    let colors: [String] = ["Green", "Yellow", "Red", "Black"]

    var body: some View {
        VStack(spacing: 10) {
            // Header
            HStack {
                Text(observation.observationID)
                    .font(.system(size: 40))
                    .bold()
                    .padding()
            }
            
            // Checklist Items
            ForEach(observation.items) { item in
                VStack(spacing: 0) {
                    Button(action: {
                        withAnimation {
                            expandedItemID = (expandedItemID == item.id) ? nil : item.id
                        }
                    }) {
                        HStack {
                            Text(item.sectionTitle)
                                .font(.largeTitle)
                                .foregroundColor(.black)
                            Spacer()
                            
                            HStack {
                                Text("\(item.sectionLists.filter { $0.rating == .one }.count)")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.green)
                                    .cornerRadius(20)
                                Text("\(item.sectionLists.filter { $0.rating == .two }.count)")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.yellow)
                                    .cornerRadius(20)
                                Text("\(item.sectionLists.filter { $0.rating == .three }.count)")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.red)
                                    .cornerRadius(20)
                                Text("\(item.sectionLists.filter { $0.rating == .four }.count)")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.black)
                                    .cornerRadius(20)
                            }
                            .padding()
                            Image(systemName: expandedItemID == item.id ? "chevron.up" : "chevron.down")
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(8)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                    }
                    
                    // Expanded Checklist Section
                    if expandedItemID == item.id {
                        VStack(spacing: 10) {
                            ForEach(item.sectionLists) { section in
                                HStack {
                                    Text(section.description)
                                        .font(.headline)
                                        .bold()
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity, alignment: .leading)

                                    Button(action: {
                                        activeNote = section.note
                                        activeItemID = section.id
                                        isPopupVisible = true
                                    }) {
                                        Image(systemName: "message")
                                    }
                                    .padding(8)
                                    .buttonStyle(BorderlessButtonStyle())
                                    
                                    HStack {
                                        ForEach(colors, id: \.self) { color in
                                            CheckboxView(
                                                color: color,
                                                isSelected: section.rating == ratingForColor(color)
                                            ) {
                                                section.rating = ratingForColor(color)
                                                observation.updateItem(item)
                                            }
                                        }
                                    }
                                    .padding()
                                }
                            }

                            
                            // Add New Section Item
                            HStack {
                                TextField("New Section Description", text: $newSectionDescription)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                Button("Add") {
                                    
                                    observation.addSection(to: item, description: newSectionDescription)
                                    newSectionDescription = ""
                                }
                                .padding(.horizontal)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                            }
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .transition(.opacity)
                    }
                }
            }
            
            Spacer()
                .padding()
                .overlay(
                    ZStack {
                        if isPopupVisible {
                            Color.black.opacity(0.0)
                                .ignoresSafeArea()
                                .onTapGesture {
                                    saveNote()
                                }
                            
                            VStack(spacing: 10) {
                                Text("Edit Note")
                                    .font(.headline)
                                    .padding(.bottom, 10)
                                    .padding(.top, 10)
                                TextEditor(text: $activeNote)
                                    .frame(height: 150)
                                    .cornerRadius(8)
                                    .border(Color.gray, width: 1)
                                    .padding()
                                Button("Save") {
                                    saveNote()
                                }
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                            }
                            .padding(20)
                            .frame(width: 400, height: 300) // Larger popup dimensions
                            .background(Color.white)
                            .cornerRadius(16)
                            .shadow(radius: 10)
                        }
                    }
                )

            


            // Add New Checklist Section
            VStack {
                HStack {
                    TextField("New Checklist Section Title", text: $newSectionTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button("Add Section") {
                        observation.addChecklistItem(title: newSectionTitle)
                        newSectionTitle = ""
                    }
                    .padding(.horizontal)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                .padding()
            }
        }
        .padding()
    }
    
    private func saveNote() {
          if let id = activeItemID,
             let section = observation.items.flatMap({ $0.sectionLists }).first(where: { $0.id == id }) {
              section.note = activeNote
          }
          isPopupVisible = false
          activeItemID = nil
      }
    
    private func updateRating(for section: SectionList, color: String) {
        section.rating = ratingForColor(color)
    }
    
}


struct CheckboxView: View {
    let color: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Image(systemName: isSelected ? "checkmark.square.fill" : "square")
            .foregroundColor(colorForName(color))
            .onTapGesture {
                action()
            }
    }

    private func colorForName(_ name: String) -> Color {
        switch name {
        case "Green": return .green
        case "Yellow": return .yellow
        case "Red": return .red
        case "Black": return .black
        default: return .gray
        }
    }
}



#Preview {
    let sectionLists = [
        SectionList(description: "The goals of the lesson are clearly communicated to the students.", note: "Sample Note", rating: .one),
        SectionList(description: "The stated goal(s) and criteria for success are specific", note: "Another Note", rating: .two),
        SectionList(description: "ST clearly explains the relevance of the stated goal to the students.", note: "Another Note", rating: .three)
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
    let observation = Observation(observationID: "Example Observation", items: sampleItems)
    
    CheckListEditView(observation: observation)
}
