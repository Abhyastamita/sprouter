//
//  AddPlantView.swift
//  Sprouter
//
//  Created by user232612 on 4/25/23.
//

import SwiftUI

struct AddPlantFormPopoverView: View {
    @Binding var plant : PlantModel
    @EnvironmentObject var garden : GardenModel
    @Binding var showPopover : Bool
    @State private var date = Date()
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        return dateFormatter.string(from: Date())
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Form {
                DatePicker(
                    "Planted Date",
                    selection: $date,
                    displayedComponents: [.date]
                )
                .padding(.horizontal)
                HStack {
                    Spacer()
                    Button("Cancel") {
                        showPopover = false
                    }
                    Button("Add") {
                        garden.add(plant, datePlanted: date)
                        showPopover = false
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                    Spacer()
                }
                .padding(.horizontal)
            }
        }
        .padding(.horizontal)
        .frame(width: 350, height: 200)
        .background(Color("AccentColor"))
    }
}
