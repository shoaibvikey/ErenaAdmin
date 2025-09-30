//
//  ContentView.swift
//  ErenaAdmin
//
//  Created by Shoaib Akhtar on 30/09/25.
//

import SwiftUI
import FirebaseFirestore

struct AddTournamentView: View {
    @State private var tournamentName: String = ""
    @State private var gameName: String = ""
    @State private var startDate = Date()

    @State private var feedbackMessage = ""
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Tournament Details")) {
                    TextField("Tournament Name", text: $tournamentName)
                    TextField("Game (e.g., BGMI)", text: $gameName)
                    DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                }

                Section {
                    Button("Save Tournament") {
                        addTournament()
                    }
                }

                if !feedbackMessage.isEmpty {
                    Text(feedbackMessage)
                }
            }
            .navigationTitle("Add New Tournament")
            .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Done") {
                                    dismiss()
                                }
                            }
                        }
        }
    }

    private func addTournament() {
        guard !tournamentName.isEmpty, !gameName.isEmpty else {
            feedbackMessage = "Please fill all fields."
            return
        }

        let newTournament = Tournament(
            name: tournamentName,
            game: gameName,
            startDate: startDate
        )

        let db = Firestore.firestore()
        do {
            try db.collection("tournaments").addDocument(from: newTournament)
            feedbackMessage = "Tournament Saved Successfully!"
            tournamentName = ""
            gameName = ""
        } catch {
            feedbackMessage = "Error saving tournament: \(error.localizedDescription)"
        }
    }
}

