//
//  TournamentDetailView.swift
//  ErenaAdmin
//
//  Created by Shoaib Akhtar on 30/09/25.
//

import SwiftUI

struct TournamentDetailView: View {
    @StateObject private var viewModel: TournamentDetailViewModel
    @State private var showingAddStageAlert = false
    @State private var newStageName = ""
    
    let tournament: Tournament
    
    init(tournament: Tournament) {
        self.tournament = tournament
        _viewModel = StateObject(wrappedValue: TournamentDetailViewModel(tournament: tournament))
    }
    
    var body: some View {
        VStack {
            List(viewModel.stages) { stage in
                Text(stage.name)
            }
        }
        .navigationTitle(tournament.name)
        .onAppear {
            viewModel.fetchStages()
        }
        .toolbar {
            Button("Add Stage") {
                showingAddStageAlert.toggle()
            }
        }
        .alert("New Stage", isPresented: $showingAddStageAlert) {
            TextField("Stage Name (e.g., Finals)", text: $newStageName)
            Button("Add") {
                if !newStageName.isEmpty {
                    viewModel.addStage(name: newStageName)
                    newStageName = ""
                }
            }
            Button("Cancel", role: .cancel) {
                newStageName = ""
            }
        }
    }
}
