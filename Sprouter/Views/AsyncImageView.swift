//
//  imageView.swift
//  Sprouter
//
//  Created by user232612 on 4/16/23.
//

import SwiftUI
import FirebaseStorage

struct AsyncImageView: View {
    @State var storageURL: URL?
    let storageLocation : String
    var thumbnail : Bool = false
        
        var body: some View {
            AsyncImage(url: storageURL) { image in
                      image.resizable()
                          .scaledToFit()
                          .cornerRadius(10)
                          .frame(width: thumbnail ? 50 : 350, height: thumbnail ? 50 : 350)
                  } placeholder: {
                      ProgressView()
                  }
                  .task {
                          let storage = Storage.storage()
                          let storageRef = storage.reference()
                          // Create a reference to the file you want to download
                          let imageRef = storageRef.child(storageLocation)
                          
                          // Fetch the download URL
                          do {
                              storageURL = try await imageRef.downloadURL()
                          } catch {
                              print(error)
                          }
                          return
                      }
            }
}

struct imageView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView(storageLocation: "plant_photos/lettuce.jpg", thumbnail: false)
    }
}
