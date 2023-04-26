//
//  GardenModel.swift
//  Sprouter
//
//  Created by user232612 on 4/17/23.
//

import Foundation

class GardenViewModel: ObservableObject {
    private var plants: Set<GardenPlant>
    private let saveKey = "Garden"
    var count : Int
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    init() {
        plants = []
        if let data  = UserDefaults.standard.data(forKey: saveKey) {
            do {
                plants = try decoder.decode(Set<GardenPlant>.self, from: data)
            } catch {
                print("Unable to decode plants (\(error)")
            }
        }
        count = plants.count
    }
    
    func contains(_ plant: PlantModel) -> Bool {
        plants.contains(where: { plant.id == $0.id})
    }
    
    func add(_ plant: PlantModel, datePlanted: Date) {
        objectWillChange.send()
        plants.insert(GardenPlant(id: plant.id ?? "", datePlanted: datePlanted))
        save()
        count = plants.count
    }
    
    func remove(_ plant: PlantModel) {
        objectWillChange.send()
        if let i = plants.firstIndex(where: { plant.id == $0.id}) {
            plants.remove(at: i)
            count = plants.count
            save()
        }
    }
    
    func getPlantedDate(_ plant: PlantModel) -> String {
        
        if let i = plants.firstIndex(where: { plant.id == $0.id}) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            let date = plants[i].datePlanted
            return dateFormatter.string(from: date)
        }
        
        return ""
    }
    
    func getExpectedGermination(_ plant: PlantModel) -> String {
        
        if let i = plants.firstIndex(where: { plant.id == $0.id}) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            let date = plants[i].datePlanted
            let today = Date()
            guard let earliest = Calendar.current.date(byAdding: .day, value: plant.min_germ, to: date) else { return "" }
            guard let latest = Calendar.current.date(byAdding: .day, value: plant.max_germ, to: date) else { return "" }
            return "Your plant should \(latest < today ? "have sprouted" : "sprout") between \(dateFormatter.string(from: earliest)) and \(dateFormatter.string(from: latest))."
        }
        
        return ""
    }
    
    
    func save() {
        do {
            let data = try encoder.encode(plants)
            UserDefaults.standard.set(data, forKey: saveKey)
        } catch {
            print("Unable to save planting data")
        }
    }
}


