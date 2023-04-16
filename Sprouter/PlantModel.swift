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
}

struct PhotoMetadataModel : Codable, Hashable {
    // @DocumentID var id: String? = UUID().uuidString
    var storage_location: String
    var stage: String
    var attribution: String
}

