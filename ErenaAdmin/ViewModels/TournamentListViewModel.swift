//
//  TournamentListViewModel.swift
//  ErenaAdmin
//
//  Created by Shoaib Akhtar on 30/09/25.
//

import Foundation
import Combine
import FirebaseFirestore

class TournamentListViewModel: ObservableObject {
    @Published var tournaments = [Tournament]()
    
    private var db = Firestore.firestore()
    
    func fetchData() {
        db.collection("tournaments").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.tournaments = documents.compactMap { queryDocumentSnapshot -> Tournament? in
                return try? queryDocumentSnapshot.data(as: Tournament.self)
            }
        }
    }
}
