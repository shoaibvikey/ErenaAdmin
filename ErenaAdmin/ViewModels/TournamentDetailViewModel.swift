//
//  TournamentDetailViewModel.swift
//  ErenaAdmin
//
//  Created by Shoaib Akhtar on 30/09/25.
//

import Foundation
import Combine
import FirebaseFirestore

class TournamentDetailViewModel: ObservableObject {
    @Published var stages = [Stage]()
    private var db = Firestore.firestore()
    
    private var tournament: Tournament
    
    init(tournament: Tournament) {
        self.tournament = tournament
    }
    
    func fetchStages() {
        guard let tournamentID = tournament.id else { return }
        
        db.collection("stages")
          .whereField("tournamentID", isEqualTo: tournamentID)
          .addSnapshotListener { (querySnapshot, error) in
            
            guard let documents = querySnapshot?.documents else {
                print("No documents in stages collection")
                return
            }
            
            self.stages = documents.compactMap { queryDocumentSnapshot -> Stage? in
                return try? queryDocumentSnapshot.data(as: Stage.self)
            }
        }
    }
    
    func addStage(name: String) {
        guard let tournamentID = tournament.id else { return }
        
        let newStage = Stage(tournamentID: tournamentID, name: name)
        
        do {
            _ = try db.collection("stages").addDocument(from: newStage)
        } catch {
            print("Error adding stage: \(error.localizedDescription)")
        }
    }
}

