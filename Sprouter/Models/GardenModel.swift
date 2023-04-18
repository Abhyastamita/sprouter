//
//  GardenModel.swift
//  Sprouter
//
//  Created by user232612 on 4/17/23.
//

import Foundation

class GardenModel: ObservableObject {
    private var plants: Set<String> // IDs of plants the user has planted
    private let saveKey = "Garden"
    
    init() {
        //load saved data
        plants = []
    }
    
    func contains(_ plant: PlantModel) -> Bool {
        plants.contains(plant.id ?? "")
    }
    
    func add(_ plant: PlantModel) {
        objectWillChange.send()
        plants.insert(plant.id ?? "")
        save()
    }
    
    func remove(_ plant: PlantModel) {
        objectWillChange.send()
        plants.remove(plant.id ?? "")
        save()
    }
    
    func save() {
        
    }
}
