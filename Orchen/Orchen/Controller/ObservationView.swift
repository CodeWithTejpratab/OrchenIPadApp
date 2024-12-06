import SwiftUI

struct ObservationView: View {
    @ObservedObject var student: StudentProfile
    @State private var isEditing: Bool = false
    @State private var editedName: String = ""
    @State private var editedGrade: String = ""
    @State private var editedCredit: String = ""
    @State private var editedNotes: String = ""
    
    init(for student: StudentProfile) {
        self.student = student
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    VStack(spacing: 20) {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .padding()
                        
                        if isEditing {
                            TextField("Name", text: $editedName)
                                .font(.title)
                                .multilineTextAlignment(.center)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                            
                            TextField("Grade", text: $editedGrade)
                                .font(.body)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                            
                            TextField("Credits", text: $editedCredit)
                                .font(.body)
                                .keyboardType(.numberPad)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                            
                            TextField("Notes", text: $editedNotes)
                                .font(.body)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                        } else {
                            Text(student.name)
                                .font(.title)
                                .bold()
                            
                            Text("Grade: \(student.grade)")
                                .font(.body)
                            
                            Text("Credits: \(student.credit)")
                                .font(.body)
                            
                            Text("Notes: \(editedNotes.isEmpty ? "No notes available" : editedNotes)")
                                .font(.body)
                                .italic()
                        }
                    }
                    .padding()
                    
                    Divider()
                        .padding(.horizontal)
                    
                    VStack {
                        List {
                            ForEach(student.observations) { observation in
                                NavigationLink {
                                    CheckListEditView(observation: observation)
                                } label: {
                                    HStack {
                                        Text(observation.observationID)
                                            .font(.system(size: 36))
                                            .bold()
                                            .lineLimit(1)
                                            .foregroundColor(.indigo)
                                        Spacer()
                                        VStack(spacing: 10) {
                                            Text(
                                                observation.date.formatted(.dateTime
                                                    .day()
                                                    .month()
                                                    .year()
                                                )
                                            )
                                            Text(student.name)
                                        }
                                        .padding()
                                    }
                                    .frame(height: 80)
                                }
                            }
                            .onDelete { indexSet in
                                student.deleteObservation(at: indexSet)
                            }
                        }
                    }
                    
                    Spacer()
                }
                
                VStack {
                    Spacer()
                    AddButtonView({
                        student.addObservation()
                    })
                }
                .padding(.bottom, 20)
            }
            .navigationTitle("Student Profile")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(isEditing ? "Save" : "Edit") {
                        if isEditing {
                            student.name = editedName
                            student.grade = editedGrade
                            student.credit = Int(editedCredit) ?? student.credit
                        } else {
                            editedName = student.name
                            editedGrade = student.grade
                            editedCredit = String(student.credit)
                        }
                        isEditing.toggle()
                    }
                }
            }
        }
    }
}

#Preview {
    ObservationView(for: StudentProfile(studentID: 0, name: "John Doe", grade: "10th", credit: 20, observations: []))
}
