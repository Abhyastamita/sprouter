//
//  PlantDetail.swift
//  Sprouter
//
//  Created by user232612 on 4/15/23.
//

import SwiftUI

struct PlantDetailView: View {
    
    @Binding var plant : PlantModel
    @ObservedObject var plantApp = PlantViewModel()
    @EnvironmentObject var garden: GardenModel
    @State var showPopover = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                Text(plant.name)
                    .textCase(.uppercase)
                Text(plant.sci_name)
                    .italic()
                Text("Spacing: \(plant.getLocalizedSpacingString())")
                Text("Sprouts in \(plant.min_germ) to \(plant.max_germ) days")
                if garden.contains(plant) {
                    Divider()
                    VStack {
                        Text("Planted: \(garden.getPlantedDate(plant))")
                        Text(garden.getExpectedGermination(plant))
                    }
                    .padding()
                    .background(.gray)
                }
                Button(garden.contains(plant) ? "Remove from Planted List" : "Add to Planted List") {
                    if garden.contains(plant) {
                        garden.remove(plant)
                    } else {
                        showPopover = true
                        //garden.add(plant)
                    }
                }
                .popover(isPresented: $showPopover) {
                    AddPlantFormPopoverView(plant: $plant, garden: _garden, showPopover: $showPopover)
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
