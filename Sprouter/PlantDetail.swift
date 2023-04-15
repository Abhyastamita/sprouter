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
            Text(plant.photos?[0].attribution ?? "")
        }
    }
}

//struct PlantDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        PlantDetail()
//    }
//}
