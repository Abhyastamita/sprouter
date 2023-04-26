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
    @EnvironmentObject var garden: GardenViewModel
    @State var showPopover = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(plant.name)
                    .font(.title)
                    .textCase(.uppercase)
                    .padding([.top, .leading, .trailing])
                Text(plant.sci_name)
                    .italic()
                    .padding(.horizontal)
                Spacer()
                Divider()
                    .background(.green)
                    .padding(.horizontal)
                Spacer()
                Text("Spacing: \(plant.getLocalizedSpacingString())")
                    .padding(.horizontal)
                Text("Sprouts in \(plant.min_germ) to \(plant.max_germ) days")
                    .padding(.horizontal)
                if garden.contains(plant) {
                    Spacer()
                    Divider()
                        .background(.green)
                        .padding(.horizontal)
                    Spacer()
                    Text("Planted: \(garden.getPlantedDate(plant))")
                        .padding(.horizontal)
                    Text(garden.getExpectedGermination(plant))
                        .padding([.top, .leading, .trailing])
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
            }
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.green, lineWidth: 2)
            }
            .padding(.horizontal, 10.0)
            
            Text("Gallery")
                .font(.title)
                .padding(.top, 10)
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
