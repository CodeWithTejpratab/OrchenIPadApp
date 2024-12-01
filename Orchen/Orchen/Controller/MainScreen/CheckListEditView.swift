import SwiftUI

struct CheckListEditView: View {
    @ObservedObject var observation: Observation
    @State private var expandedItemID: UUID?
    @State private var isPopupVisible = false
    @State private var activeNote: String = ""
    @State private var activeItemID: UUID?
    @State private var selectedColor: String? = nil
    
    let colors: [String] = ["Green", "Yellow", "Red", "Black"]
    
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                HStack {
                    Text(observation.observationID)
                        .font(.system(size: 40))
                        .bold()
                        .padding()
                }
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
                                Image(systemName: expandedItemID == item.id ? "chevron.up" : "chevron.down")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(.systemGray5))
                            .cornerRadius(8)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                        }
                        
                        if expandedItemID == item.id {
                            HStack {
                                Text(item.description)
                                    .font(.headline)
                                    .bold()
                                    .foregroundColor(.black)
                                
                                Button(action: {
                                    activeNote = item.note
                                    activeItemID = item.id
                                    isPopupVisible = true
                                }) {
                                    HStack {
                                        Image(systemName: "message")
                                    }
                                    .padding(8)
                                }
                                .buttonStyle(BorderlessButtonStyle())
                                
                                HStack {
                                    ForEach(colors, id: \.self) { color in
                                        CheckboxView(color: color, isSelected: selectedColor == color) {
                                            selectedColor = color
                                        }
                                    }
                                }
                                .padding()
                            }
                            .frame(width: .infinity)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .transition(.opacity)
                        }
                    }
                }
                Spacer()
            }
            .padding()
            .overlay(
                ZStack {
                    if isPopupVisible {
                        Color.black.opacity(0.4)
                            .ignoresSafeArea()
                            .onTapGesture {
                                saveNote()
                            }
                        VStack {
                            TextField("Enter your note", text: $activeNote)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                            Button("Save") {
                                saveNote()
                            }
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(16)
                        .shadow(radius: 10)
                    }
                }
            )
        }
        VStack {
            Spacer()
            AddButtonView({
                
            })
        }
        .padding(.bottom, 20)
    }
    
    private func saveNote() {
        if let id = activeItemID,
           let item = observation.items.first(where: { $0.id == id }) {
            item.note = activeNote
        }
        isPopupVisible = false
        activeItemID = nil
    }
    
}

struct CheckboxView: View {
    let color: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: isSelected ? "checkmark.square" : "square")
                .foregroundColor(colorForName(color))
                .onTapGesture {
                    action()
                }
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
    let sampleItems = [
        Observation.CheckListItem(
            sectionTitle: "Section 1",
            description: "This is a description for Section 1.",
            note: "Some important note for Section 1.",
            rating: .four
        ),
        Observation.CheckListItem(
            sectionTitle: "Section 2",
            description: "Details for Section 2.",
            note: "Additional info about Section 2.",
            rating: .four
        )
    ]
    let observation = Observation(observationID: "Example Observation", items: sampleItems)
    
    CheckListEditView(observation: observation)
}
