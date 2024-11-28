//
//  ObservationView.swift
//  Orchen
//
//  Created by Rahul Ramjeawon on 11/27/24.
//

import SwiftUI

struct ObservationView: View {
    @ObservedObject var student: StudentProfile
    
    init(for student: StudentProfile) {
        self.student = student
    }
    
    var body: some View {
        NavigationStack {
            ZStack{
                VStack {
                    List (student.observations) { observation in
                        NavigationLink {
                            
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
                }
                VStack {
                    Spacer()
                    AddButtonView({
                        student.addObservation()
                    })
                }
                .padding(.bottom, 20)
            }
            .navigationTitle("Observations")
        }
    }
}

#Preview {
    ObservationView(for: StudentProfile(studentID: 0,
                                        name: "",
                                        grade: ""))
}
