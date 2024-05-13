//
//  rotateView.swift
//  NOSTYLE
//
//  Created by Gleb Korotkov on 10.05.2024.
//

import Foundation





/*import SwiftUI
import UIKit

struct RotateView: View {
//    var origImage: UIImage?
    @State private var angle: Double = 0
    var body: some View {
        Slider(value: $angle, in: 0...360, step: 1)
                        .padding()
        }
    let originalImage = UIImage(named: "rotate")
    if let rotatedImage = rotateImage(image: originalImage, degrees: $angle) {
        // Повернутое изображение доступно в переменной rotatedImage
        // Используйте его по своему усмотрению
    }
}


#Preview {
    RotateView()
}

import SwiftUI

struct SepiaFilterView: View {
    @State private var filteredImage: Image?
    
    var body: some View {
        VStack {
            if let image = filteredImage {
                image
                    .resizable()
                    .scaledToFit()
            } else {
                Text("Выберите изображение")
            }
        }
        .onAppear {
            if let inputImage = UIImage(named: "yourImageName") {
                if let sepiaImage = applySepiaFilter(to: inputImage) {
                    filteredImage = Image(uiImage: sepiaImage)
                }
            }
        }
    }
    
    func applySepiaFilter(to image: UIImage) -> UIImage? {
        guard let cgImage = image.cgImage else {
            return nil
        }
        
        let context = CGContext(
            data: nil,
            width: cgImage.width,
            height: cgImage.height,
            bitsPerComponent: cgImage.bitsPerComponent,
            bytesPerRow: cgImage.bytesPerRow,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        )
        
        if let context = context {
            context.draw(cgImage, in: CGRect(origin: .zero, size: CGSize(width: cgImage.width, height: cgImage.height)))
            if let sepiaImage = context.makeImage() {
                return UIImage(cgImage: sepiaImage)
            }
        }
        
        return nil
    }
}

*/


//Сепия
/*import SwiftUI

struct TestView: View {
    
       @State private var originalImage: Image?
       @State private var filteredImage: Image?
       
       var body: some View {
           VStack {
               if originalImage != nil {
                   originalImage!
                       .resizable()
                       .scaledToFit()
               }
               
               if filteredImage != nil {
                   filteredImage!
                       .resizable()
                       .scaledToFit()
               }
               
               Button("Select Image") {
                   pickImage()
               }
               
               Button("Apply Red Filter") {
                   applyRedFilter()
               }
           }
       }
       private func pickImage() {
           let picker = UIImagePickerController()
           picker.sourceType = .photoLibrary

       }
       
       private func applyRedFilter() {
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
       }

}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
*/

// поворот камеры
/*import SwiftUI

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

//мозайка
import SwiftUI
import CoreGraphics

struct MosaicFilterView: View {
    @State private var mosaicImage: UIImage?
    
    var body: some View {
        VStack {
            if let image = mosaicImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Text("Загрузка изображения...")
            }
        }
        .onAppear {
            if let image = UIImage(named: "testImage") {
                mosaicImage = applyMosaicFilter(to: image, blockSize: 50)
            }
        }
    }
    
    func applyMosaicFilter(to image: UIImage, blockSize: Int) -> UIImage? {
        guard let cgImage = image.cgImage else { return nil }
        
        let context = CGContext(
            data: nil,
            width: cgImage.width,
            height: cgImage.height,
            bitsPerComponent: cgImage.bitsPerComponent,
            bytesPerRow: cgImage.bytesPerRow,
            space: cgImage.colorSpace ?? CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: cgImage.bitmapInfo.rawValue
        )
        
        context?.draw(cgImage, in: CGRect(x: 0, y: 0, width: cgImage.width, height: cgImage.height))
        
        for y in stride(from: 0, to: cgImage.height, by: blockSize) {
            for x in stride(from: 0, to: cgImage.width, by: blockSize) {
                let blockRect = CGRect(x: x, y: y, width: blockSize, height: blockSize).integral
                let color = averageColor(in: blockRect, in: context!)
                context?.setFillColor(color.cgColor)
                context?.fill(blockRect)
            }
        }
        
        if let outputCGImage = context?.makeImage() {
            return UIImage(cgImage: outputCGImage)
        }
        return nil
    }
    
    func averageColor(in rect: CGRect, in context: CGContext) -> UIColor {
        var totalR: CGFloat = 0
        var totalG: CGFloat = 0
        var totalB: CGFloat = 0
        
        for y in Int(rect.minY)..<Int(rect.maxY) {
            for x in Int(rect.minX)..<Int(rect.maxX) {
                if let pixelData = context.data?.assumingMemoryBound(to: UInt8.self) {
                    let pixelIndex = (y * context.width + x) * 4
                    totalR += CGFloat(pixelData[pixelIndex]) / 255.0
                    totalG += CGFloat(pixelData[pixelIndex + 1]) / 255.0
                    totalB += CGFloat(pixelData[pixelIndex + 2]) / 255.0
                }
            }
        }
        
        let blockSize = rect.width * rect.height
        let avgR = totalR / blockSize
        let avgG = totalG / blockSize
        let avgB = totalB / blockSize
        
        return UIColor(red: avgR, green: avgG, blue: avgB, alpha: 1.0)
    }
}

struct MosaicFilterView_Previews: PreviewProvider {
    static var previews: some View {
        MosaicFilterView()
    }
}

struct MosaicFilterViewApp: App {
    var body: some Scene {
        WindowGroup {
            MosaicFilterView()
        }
    }
}


//кружочки
/*
import SwiftUI
import CoreGraphics

struct MosaicFilterView: View {
    @State private var mosaicImage: UIImage?
    
    var body: some View {
        VStack {
            if let image = mosaicImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Text("Загрузка изображения...")
            }
        }
        .onAppear {
            if let image = UIImage(named: "testImage") {
                mosaicImage = applyMosaicFilter(to: image, blockSize: 40)
            }
        }
    }
    
    func applyMosaicFilter(to image: UIImage, blockSize: Int) -> UIImage? {
        guard let cgImage = image.cgImage else { return nil }
        
        let context = CGContext(
            data: nil,
            width: cgImage.width,
            height: cgImage.height,
            bitsPerComponent: cgImage.bitsPerComponent,
            bytesPerRow: cgImage.bytesPerRow,
            space: cgImage.colorSpace ?? CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: cgImage.bitmapInfo.rawValue
        )
        
        context?.draw(cgImage, in: CGRect(x: 0, y: 0, width: cgImage.width, height: cgImage.height))
        
        for y in stride(from: 0, to: cgImage.height, by: blockSize) {
            for x in stride(from: 0, to: cgImage.width, by: blockSize) {
                let blockRect = CGRect(x: x, y: y, width: blockSize, height: blockSize).integral
                let color = averageColor(in: blockRect, in: context!)
                context?.setFillColor(color.cgColor)
                context?.fillEllipse(in: blockRect)
            }
        }
        
        if let outputCGImage = context?.makeImage() {
            return UIImage(cgImage: outputCGImage)
        }
        return nil
    }
    
    func averageColor(in rect: CGRect, in context: CGContext) -> UIColor {
        var totalR: CGFloat = 0
        var totalG: CGFloat = 0
        var totalB: CGFloat = 0
        
        for y in Int(rect.minY)..<Int(rect.maxY) {
            for x in Int(rect.minX)..<Int(rect.maxX) {
                if let pixelData = context.data?.assumingMemoryBound(to: UInt8.self) {
                    let pixelIndex = (y * context.width + x) * 4
                    totalR += CGFloat(pixelData[pixelIndex]) / 255.0
                    totalG += CGFloat(pixelData[pixelIndex + 1]) / 255.0
                    totalB += CGFloat(pixelData[pixelIndex + 2]) / 255.0
                }
            }
        }
        
        let blockSize = rect.width * rect.height
        let avgR = totalR / blockSize
        let avgG = totalG / blockSize
        let avgB = totalB / blockSize
        
        return UIColor(red: avgR, green: avgG, blue: avgB, alpha: 1.0)
    }
}

struct MosaicFilterView_Previews: PreviewProvider {
    static var previews: some View {
        MosaicFilterView()
    }
}

struct MosaicFilterViewApp: App {
    var body: some Scene {
        WindowGroup {
            MosaicFilterView()
        }
    }
}
*/
