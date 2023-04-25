//
//  ContentView.swift
//  Sprouter
//
//  Created by user232612 on 4/13/23.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    
    @ObservedObject var plantApp = PlantViewModel()
    @StateObject var garden = GardenModel()
    @State private var myPlants = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach($plantApp.plants) { $plant in
                    if !myPlants || (myPlants && garden.contains(plant)) {
                        NavigationLink {
                            PlantDetailView(plant: $plant)
                        } label: {
                            HStack {
                                if garden.contains(plant) {
                                    Image(systemName: "leaf.fill")
                                        .accessibilityLabel("This plant been planted")
                                        .foregroundColor(.green)
                                } else {
                                    Image(systemName: "leaf")
                                        .accessibilityLabel("This plant not been planted")
                                        .foregroundColor(.brown)
                                }
                                VStack(alignment: .leading) {
                                    Text(plant.name)
                                        .textCase(.uppercase)
                                    Text(plant.sci_name)
                                        .italic()
                                    if garden.contains(plant) {
                                        Text("Planted: \(garden.getPlantedDate(plant))")
                                    }
                                }
                            }
                        }
                    }
                    
                }
                if myPlants && garden.count == 0 {
                    Text("You have not added any plants to your planted list.")
                }
            }
            .navigationTitle("Sprouter")
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.status) {
                    Toggle(isOn: $myPlants) {
                        Text(myPlants ? "Show all plants" : "Only show plants in my garden")
                    }
                }
            }
        }
        .task {
            await plantApp.fetchData()
        }
        .environmentObject(garden)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
