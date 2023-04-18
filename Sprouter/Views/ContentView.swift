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
    
    var body: some View {
        
        NavigationStack {
                            
            List {
                ForEach($plantApp.plants) { $plant in
                    NavigationLink {
                        PlantDetail(plant: $plant)
                    } label: {
                        HStack {
                            if garden.contains(plant) {
                                Image(systemName: "sprout.fill")
                                    .accessibilityLabel("This plant been planted")
                                    .foregroundColor(.green)
                            }
                            VStack(alignment: .leading) {
                                Text(plant.name)
                                    .textCase(.uppercase)
                                Text(plant.sci_name)
                                    .italic()
                            }
                        }
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
