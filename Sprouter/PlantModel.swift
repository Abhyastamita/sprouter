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
    var photo_metadata: [PlantPhotoModel] = [PlantPhotoModel]()
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case sci_name = "sci_name"
        case id = "id"
    }
}

struct PlantPhotoModel : Codable, Identifiable {
    @DocumentID var id: String?
    var storage_location: String
    var stage: String
    var attribution: String
}
