//
//  TournamentListView.swift
//  ErenaAdmin
//
//  Created by Shoaib Akhtar on 30/09/25.
//

import SwiftUI

struct TournamentListView: View {
    @StateObject private var viewModel = TournamentListViewModel()
    @State private var showingAddTournamentSheet = false

    var body: some View {
        NavigationStack {
            List(viewModel.tournaments) { tournament in
                NavigationLink(destination: TournamentDetailView(tournament: tournament)) {
                    VStack(alignment: .leading) {
                        Text(tournament.name)
                            .font(.headline)
                        Text(tournament.game)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("Tournaments")
            .onAppear() {
                self.viewModel.fetchData()
            }
            .toolbar {
                Button(action: {
                    showingAddTournamentSheet.toggle()
                }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddTournamentSheet) {
                AddTournamentView()
            }
        }
    }
}

