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
import FirebaseStorage

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
    
    @MainActor
    func fetchData() async {
        self.plants.removeAll()
        do {
            let snapshot = try await db.collection("plants").order(by: "name").getDocuments()
            snapshot.documents.forEach { document in
                var plant: PlantModel
                do {
                    plant = try document.data(as: PlantModel.self)
                    self.plants.append(plant)
                } catch {
                    print(error)
                }
            }
        } catch {
                print(error)
        }
        
    }
}
