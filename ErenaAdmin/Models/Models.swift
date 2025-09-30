//
//  Models.swift
//  ErenaAdmin
//
//  Created by Shoaib Akhtar on 30/09/25.
//

import Foundation
import FirebaseFirestore


struct Tournament: Codable, Identifiable {
    @DocumentID var id: String?
    var name: String
    var game: String
    var startDate: Date
}

struct Stage: Codable, Identifiable, Hashable {
    @DocumentID var id: String?
    var tournamentID: String // Links this stage to a Tournament
    var name: String
}

struct TeamStanding: Codable, Identifiable, Hashable {
    @DocumentID var id: String?
    var stageID: String // Links this to a Stage
    
    var rank: Int
    var teamName: String
    var placementPoints: Int
    var killPoints: Int
    
    // This is a computed property, which makes it easy to display the total
    var totalPoints: Int {
        placementPoints + killPoints
    }
}

