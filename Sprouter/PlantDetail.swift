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
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(plant.name)
                .textCase(.uppercase)
            Text(plant.sci_name)
                .italic()
            ForEach(plant.photos ?? []) { metadata in
                Text(metadata.attribution)
            }
        }
    }
}

//struct PlantDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        PlantDetail()
//    }
//}
