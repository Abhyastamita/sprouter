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
    @Published var plantPhotoData = [PlantPhotoModel]()
    
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
                            let subcollref = document.reference.collection("photo_metadata")
                            subcollref.getDocuments { (querySnapshot, err) in
                                if let err = err {
                                    print("Error getting documents: \(err)")
                                } else {
                                    for metadata in querySnapshot!.documents {
                                        do {
                                            plant.photo_metadata.append(try metadata.data(as: PlantPhotoModel.self))
                                        } catch {
                                            print(error)
                                        }
                                    }
                                }
                            }
                            self.plants.append(plant)
                        } catch {
                            print(error)
                        }
                    }
                }
            }
    }
    
}
