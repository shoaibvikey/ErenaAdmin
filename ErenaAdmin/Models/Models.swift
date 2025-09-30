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
