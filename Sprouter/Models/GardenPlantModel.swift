//
//  GardenPlantModel.swift
//  Sprouter
//
//  Created by user232612 on 4/25/23.
//

import Foundation

struct GardenPlant: Hashable, Identifiable, Codable {
    let id: String
    let datePlanted: Date
}
