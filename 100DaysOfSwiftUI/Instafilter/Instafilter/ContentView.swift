//
//  ContentView.swift
//  Instafilter
//
//  Created by Bruce on 2020/5/18.
//  Copyright © 2020 JFF147. All rights reserved.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

class ImageSaver: NSObject {
  var successHandler: (() -> Void)?
  var errorHandler: ((Error) -> Void)?
  
  func writeToPhotoAlbum(image: UIImage) {
    UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
  }
  
  @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
    // save complete
    if let error = error {
      errorHandler?(error)
    } else {
      successHandler?()
    }
  }
}

struct ContentView: View {
  @State private var image: Image?
  @State private var showingImagePicker = false
  @State private var inputImage: UIImage?
  @State private var filterIntensity = 0.5
  @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
  @State private var showingFilterSheet = false
  @State private var processedImage: UIImage?
  @State private var noImageToSave = false
  @State private var changeFilterButtonTitle = "Change Filter"
  let context = CIContext()
  
  var body: some View {
    //    VStack {
    //      image?
    //        .resizable()
    //        .scaledToFit()
    //
    //      Button("Select Image") {
    //        self.showingImagePicker = true
    //      }
    //    }
    //    .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
    //      ImagePicker(image: self.$inputImage)
    //    }
    
    let intensity = Binding<Double>(
      get: {
        self.filterIntensity
    },
      set: {
        self.filterIntensity = $0
        self.applyProcessing()
    }
    )
    
    return NavigationView {
      VStack {
        ZStack {
          Rectangle()
            .fill(Color.secondary)
          // display the image
          if image != nil {
            image!
              .resizable()
              .scaledToFit()
          } else {
            Text("Tap to select a picture")
              .foregroundColor(.white)
              .font(.headline)
          }
        }
        .onTapGesture {
          // select an image
          self.showingImagePicker = true
        }
        
        HStack {
          Text("Intensity")
          Slider(value: intensity)
        }
        .padding(.vertical)
        
        HStack {
          Button(changeFilterButtonTitle) {
            // change filter
            self.showingFilterSheet = true
          }
          
          Spacer()
          
          Button("Save") {
            // save the picture
            guard let processedImage = self.processedImage else {
              self.noImageToSave = true
              return
            }
            
            let imageSaver = ImageSaver()
            
            imageSaver.successHandler = {
              print("Success!")
            }
            
            imageSaver.errorHandler = {
              print("Oops: \($0.localizedDescription)")
            }
            
            imageSaver.writeToPhotoAlbum(image: processedImage)
          }
          .alert(isPresented: $noImageToSave) {
            Alert(title: Text("No image to save!"))
          }
        }
      }
      .padding([.horizontal, .bottom])
      .navigationBarTitle("Instafilter")
      .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
        ImagePicker(image: self.$inputImage)
      }
      .actionSheet(isPresented: $showingFilterSheet) {
        ActionSheet(title: Text("Select a filter"), buttons: [
          .default(Text("Crystallize")) {
            self.changeFilterButtonTitle = "Crystallize"
            self.setFilter(CIFilter.crystallize()) },
          .default(Text("Edges")) {
            self.changeFilterButtonTitle = "Edges"
             self.setFilter(CIFilter.edges()) },
          .default(Text("Gaussian Blur")) {
          self.changeFilterButtonTitle = "Gaussian Blur"
          self.setFilter(CIFilter.gaussianBlur()) },
          .default(Text("Pixellate")) {
          self.changeFilterButtonTitle = "Pixellate"
          self.setFilter(CIFilter.pixellate()) },
          .default(Text("Sepia Tone")) {
          self.changeFilterButtonTitle = "Sepia Tone"
          self.setFilter(CIFilter.sepiaTone()) },
          .default(Text("Unsharp Mask")) {
            self.changeFilterButtonTitle = "Unsharp Mask"
             self.setFilter(CIFilter.unsharpMask()) },
          .default(Text("Vignette")) {
            self.changeFilterButtonTitle = "Vignette"
             self.setFilter(CIFilter.vignette()) },
          .cancel()
        ])
      }
    }
  }
  
  func loadImage() {
    guard let inputImage = inputImage else { return }
    let beginImage = CIImage(image: inputImage)
    currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
    applyProcessing()
  }
  
  func applyProcessing() {
    let inputKeys = currentFilter.inputKeys
    if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
    if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey) }
    if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }
    guard let outputImage = currentFilter.outputImage else { return }
    if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
      let uiImage = UIImage(cgImage: cgimg)
      image = Image(uiImage: uiImage)
      processedImage = uiImage
    }
  }
  
  func setFilter(_ filter: CIFilter) {
    currentFilter = filter
    loadImage()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
