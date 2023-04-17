//
//  imageView.swift
//  Sprouter
//
//  Created by user232612 on 4/16/23.
//

import SwiftUI
import FirebaseStorage

struct AsyncImageView: View {
    let storage_location : String
        
        var body: some View {
            let storage = Storage.storage()
            let storageRef = storage.reference()
            // Create a reference to the file you want to download
            let imageRef = storageRef.child(storage_location)

            // Fetch the download URL
            imageRef.downloadURL { url, error in
              if let error = error {
                print(error)
              } else {
                  AsyncImage(url: url) { image in
                      image.resizable()
                          .scaledToFit()
                          .cornerRadius(10)
                          .frame(width: 150, height: 150)
                  } placeholder: {
                      ProgressView()
                  }
              }
            }
            
            
        }
}

struct imageView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView(storage_location: "plant_photos/lettuce.jpg")
    }
}
