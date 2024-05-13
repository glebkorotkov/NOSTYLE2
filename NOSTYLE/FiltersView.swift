//
//  FiltersView.swift
//  NOSTYLE
//
//  Created by Gleb Korotkov on 09.05.2024.
//

import Foundation

import SwiftUI

struct FiltersView: View {
    @State private var selectedFilter: FilterType?
    enum FilterType: String {
        case sepia = "Sepia"
        case blackAndWhite = "Black & White"
        case negative = "Negative"
        case blur = "Blur"
    }
    var body: some View {
            Picker("Apply Filter", selection: $selectedFilter) {
                Text("Sepia").tag(FilterType.sepia)
                Text("Black & White").tag(FilterType.blackAndWhite)
                Text("Negative").tag(FilterType.negative)
                Text("Blur").tag(FilterType.blur)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
    }
    /*private func applyRedFilter() {
        guard let inputImage = UIImage(named: "testImage") else { return }
        
        if let redFilteredImage = applyRedFilter(to: inputImage) {
            self.filteredImage = Image(uiImage: redFilteredImage)
        }
    }
    
    private func applyRedFilter(to image: UIImage) -> UIImage? {
        guard let cgImage = image.cgImage else {
            return nil
        }
        
        let context = CGContext(
            data: nil,
            width: cgImage.width,
            height: cgImage.height,
            bitsPerComponent: 8,
            bytesPerRow: cgImage.bytesPerRow,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        )
        
        if let context = context {
            context.draw(cgImage, in: CGRect(origin: .zero, size: CGSize(width: cgImage.width, height: cgImage.height)))
            
            let data = context.data!.assumingMemoryBound(to: UInt8.self)
            
            for i in 0 ..< cgImage.width * cgImage.height {
                let offset = i * 4
                let red = min(255, Int(0.393 * Double(data[offset]) + 0.769 * Double(data[offset + 1]) + 0.189 * Double(data[offset + 2])))
                let green = min(255, Int(0.349 * Double(data[offset]) + 0.686 * Double(data[offset + 1]) + 0.168 * Double(data[offset + 2])))
                let blue = min(255, Int(0.272 * Double(data[offset]) + 0.534 * Double(data[offset + 1]) + 0.131 * Double(data[offset + 2])))
                data[offset]  = UInt8(red)
                data[offset + 1] = UInt8(green)
                data[offset + 2] = UInt8(blue)
                
            }
            
            let newCGImage = context.makeImage()
            let redFilteredImage = UIImage(cgImage: newCGImage!)
            
            return redFilteredImage
        }
        
        return nil
    }*/

}

#Preview {
    FiltersView()
}


/*
 import SwiftUI

 struct TestView: View {
     @State private var rotatedImage: Image?
     @State private var degrees: Double = 0.0

     var body: some View {
         VStack {
             if let image = rotatedImage {
                 image
                     .resizable()
                     .scaledToFit()
             } else {
                 Text("Изображение не загружено или не удалось повернуть")
             }

             Slider(value: $degrees, in: 0...360, step: 1.0, onEditingChanged: { _ in
                 rotateImage()
             }).padding()
         }.onAppear(perform: loadImage)
     }

     func loadImage() {
         guard let testImage = UIImage(named: "testImage") else {
             return
         }

         guard let cgImage = testImage.cgImage else {
             return
         }

         rotatedImage = Image(uiImage: UIImage(cgImage: cgImage))
     }
     /*private func applyRedFilter() {
         guard let inputImage = UIImage(named: "testImage") else { return }
         
         if let redFilteredImage = applyRedFilter(to: inputImage) {
             self.filteredImage = Image(uiImage: redFilteredImage)
         }
     }
     
     private func applyRedFilter(to image: UIImage) -> UIImage? {
         guard let cgImage = image.cgImage else {
             return nil
         }
         
         let context = CGContext(
             data: nil,
             width: cgImage.width,
             height: cgImage.height,
             bitsPerComponent: 8,
             bytesPerRow: cgImage.bytesPerRow,
             space: CGColorSpaceCreateDeviceRGB(),
             bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
         )
         
         if let context = context {
             context.draw(cgImage, in: CGRect(origin: .zero, size: CGSize(width: cgImage.width, height: cgImage.height)))
             
             let data = context.data!.assumingMemoryBound(to: UInt8.self)
             
             for i in 0 ..< cgImage.width * cgImage.height {
                 let offset = i * 4
                 let red = min(255, Int(0.393 * Double(data[offset]) + 0.769 * Double(data[offset + 1]) + 0.189 * Double(data[offset + 2])))
                 let green = min(255, Int(0.349 * Double(data[offset]) + 0.686 * Double(data[offset + 1]) + 0.168 * Double(data[offset + 2])))
                 let blue = min(255, Int(0.272 * Double(data[offset]) + 0.534 * Double(data[offset + 1]) + 0.131 * Double(data[offset + 2])))
                 data[offset]  = UInt8(red)
                 data[offset + 1] = UInt8(green)
                 data[offset + 2] = UInt8(blue)
                 
             }
             
             let newCGImage = context.makeImage()
             let redFilteredImage = UIImage(cgImage: newCGImage!)
             
             return redFilteredImage
         }
         
         return nil
     }*/

     func rotateImage() {
         guard let testImage = UIImage(named: "testImage") else {
             return
         }

         guard let cgImage = testImage.cgImage else {
             return
         }

         DispatchQueue.global().async {
             if let rotatedCGImage = rotateImage(cgImage, degrees: CGFloat(self.degrees)) {
                 let rotatedUIImage = UIImage(cgImage: rotatedCGImage)
                 let image = Image(uiImage: rotatedUIImage)

                 DispatchQueue.main.async {
                     self.rotatedImage = image
                 }
             }
         }
     }

     func rotateImage(_ image: CGImage, degrees: CGFloat) -> CGImage? {
         let radians = degrees * .pi / 180
         let rotatedSize = CGRect(origin: .zero, size: CGSize(width: image.width, height: image.height))
             .applying(CGAffineTransform(rotationAngle: radians))
             .integral.size

         guard let colorSpace = CGColorSpace(name: CGColorSpace.sRGB) else {
             return nil
         }

         guard let context = CGContext(
             data: nil,
             width: Int(rotatedSize.width),
             height: Int(rotatedSize.height),
             bitsPerComponent: 8,
             bytesPerRow: 0,
             space: colorSpace,
             bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
         ) else {
             return nil
         }

         context.translateBy(x: rotatedSize.width / 2, y: rotatedSize.height / 2)
         context.rotate(by: radians)
         context.draw(image, in: CGRect(x: -CGFloat(image.width) / 2, y: -CGFloat(image.height) / 2, width: CGFloat(image.width), height: CGFloat(image.height)))

         return context.makeImage()
     }
 }

 struct TestView_Previews: PreviewProvider {
     static var previews: some View {
         TestView()
     }
 }
 */
