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
//    @State var plant = PlantModel(name: "", sci_name: "")
    //Would need if people could add their own plants
    
    var body: some View {
        
        NavigationStack {
                            
            List {
                ForEach($plantApp.plants) { $plant in
                    NavigationLink {
                        PlantDetail(plant: $plant)
                    } label: {
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
        .onAppear {
            plantApp.fetchData()
        }
        .refreshable {
            plantApp.fetchData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
