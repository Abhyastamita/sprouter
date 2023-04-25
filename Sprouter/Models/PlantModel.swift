//
//  PlantModel.swift
//  Sprouter
//
//  Created by user232612 on 4/15/23.
//

import Foundation
import FirebaseFirestoreSwift

struct PlantModel : Codable, Identifiable {
    @DocumentID var id: String?
    var name: String
    var sci_name: String
    var photos: [PhotoMetadataModel]?
    var min_germ: Int
    var max_germ: Int
    var spacing: Int
    
    func getLocalizedSpacingString() -> String {
        let distance = Measurement<UnitLength>(value: Double(spacing), unit: .inches)
        return distance.formatted()
    }
}

struct PhotoMetadataModel : Codable, Hashable, Identifiable {
    let id = UUID()
    var storage_location: String
    var stage: String
    var attribution: String
}

