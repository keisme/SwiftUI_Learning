//
//  MeView.swift
//  HotProspects
//
//  Created by Bruce on 2020/5/25.
//  Copyright © 2020 JFF147. All rights reserved.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct MeView: View {
  @State private var name = "Bruce"
  @State private var emailAddress = "keisme3.0@gmail.com"
  let context = CIContext()
  let filter = CIFilter.qrCodeGenerator()
  
  var body: some View {
    VStack {
      TextField("Name", text: $name)
        .textContentType(.name)
        .font(.title)
        .padding(.horizontal)
      
      TextField("Email address", text: $emailAddress)
        .textContentType(.emailAddress)
        .font(.title)
        .padding([.horizontal, .bottom])
      
      Spacer()
      
      Image(uiImage: generateQRCode(from: "\(name)\n\(emailAddress)"))
        .interpolation(.none)
        .resizable()
        .scaledToFit()
        .frame(width: 200, height: 200)
    }
    .navigationBarTitle("Bruce")
  }
  
  func generateQRCode(from string: String) -> UIImage {
    let data = Data(string.utf8)
    filter.setValue(data, forKey: "inputMessage")
    
    if let outputImage = filter.outputImage {
      if let cgImg = context.createCGImage(outputImage, from: outputImage.extent) {
        return UIImage(cgImage: cgImg)
      }
    }
    return UIImage(systemName: "xmark.circle") ?? UIImage()
  }
}

struct MeView_Previews: PreviewProvider {
  static var previews: some View {
    MeView()
  }
}
