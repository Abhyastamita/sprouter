//
//  PlantDetail.swift
//  Sprouter
//
//  Created by user232612 on 4/15/23.
//

import SwiftUI

struct PlantDetail: View {
    
    @Binding var plant : PlantModel
    @ObservedObject var plantApp = PlantViewModel()
    @EnvironmentObject var garden: GardenModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                Text(plant.name)
                    .textCase(.uppercase)
                Text(plant.sci_name)
                    .italic()
                
                Button(garden.contains(plant) ? "Remove" : "Add") {
                    if garden.contains(plant) {
                        garden.remove(plant)
                    } else {
                        garden.add(plant)
                    }
                }
                .buttonStyle(.borderedProminent)
                .padding()
                
                ForEach(plant.photos ?? []) { metadata in
                    VStack(alignment: .leading, spacing: 6) {
                        AsyncImageView(storageLocation: metadata.storage_location)
                            .overlay(
                                Text(metadata.stage.capitalized)
                                    .padding(3.0)
                                    .background(Color.white)
                                    .padding(10.0)
                                    .opacity(0.7)
                                , alignment: .bottom)
                        Text(metadata.attribution)
                            .padding(3.0)
                            .background(Color.gray.opacity(0.2))
                            .font(.caption)
                        Spacer()
                    }
                }
            }
        }
    }
}

//struct PlantDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        PlantDetail()
//    }
//}
