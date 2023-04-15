//
//  PlantViewModel.swift
//  Sprouter
//
//  Created by user232612 on 4/15/23.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class PlantViewModel : ObservableObject {
    @Published var plants = [PlantModel]()
    let db = Firestore.firestore()
    
    func authorize() {
        let auth = Auth.auth()
        auth.signInAnonymously { (result, error) in
            if error != nil {
                print(error!)
                return
            } else {
                print("Successfully signed in anonymously.")
            }
        }
    }
    
    func fetchData() {
        self.plants.removeAll()
        db.collection("plants").order(by: "name")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        var plant: PlantModel
                        do {
                            plant = try document.data(as: PlantModel.self)
                            plant.photos = self.fetchPhotoMetadata(plant_id: plant.id!)
                            self.plants.append(plant)
                        } catch {
                            print(error)
                        }
                    }
                }
            }
    }
    
    func fetchPhotoMetadata(plant_id: String) -> [PlantPhotoModel] {
        var photo_data: [PlantPhotoModel] = []
        db.collection("plant_photo_metadata").whereField("plant_id", isEqualTo: plant_id)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        do {
                            photo_data.append(try document.data(as: PlantPhotoModel.self))
                        } catch {
                            print(error)
                        }
                    }
                }
            }
        return photo_data
    }
    
}
