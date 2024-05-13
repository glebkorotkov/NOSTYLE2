//
//  filters.swift
//  NOSTYLE
//
//  Created by Gleb Korotkov on 10.05.2024.
//

/*import Foundation

import SwiftUI

struct MosaicFilterView {
    @State private var filteredImage: Image?
    
    func applyMosaicFilter(to image: UIImage) -> UIImage? {
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
            
            let data = context.data!.assumingMemoryBound(to: UInt8.self)
            let dataLength = cgImage.width * cgImage.height * 4
            
            for y in 0..<cgImage.height {
                for x in 0..<cgImage.width {
                    let index = 4 * (y * cgImage.width + x)
                    let red = data[index]
                    let green = data[index + 1]
                    let blue = data[index + 2]
                    
                    for _y in y..<(y + 10) {
                        for _x in x..<(x + 10) {
                            if _y < cgImage.height && _x < cgImage.width {
                                let _index = 4 * (_y * cgImage.width + _x)
                                data[_index] = red
                                data[_index + 1] = green
                                data[_index + 2] = blue
                            }
                        }
                    }
                }
            }
            
            let newCGImage = context.makeImage()
            let mosaicImage = UIImage(cgImage: newCGImage!)

            return mosaicImage
        }
        
        return nil
    }
}

struct BlurFilterView: View {
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
                if let blurredImage = applyBlurFilter(to: inputImage) {
                    filteredImage = Image(uiImage: blurredImage)
                }
            }
        }
    }
    
    func applyBlurFilter(to image: UIImage) -> UIImage? {
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
            
            //let imageProvider = CGImageProvider(dataProvider: context.makeImage()?.dataProvider)
            //let filter = CIFilter(name: "CIGaussianBlur", parameters: [kCIInputImageKey: CIImage(cgImage: imageProvider.scaled(by: 1.0))])
            //let outputImage = filter?.outputImage
            
            /*if let outputImage = outputImage {
                let filteredImage = UIImage(ciImage: outputImage)
                return filteredImage
            }*/
        }
        
        return nil
    }
}


import SwiftUI

struct NegativeFilterView: View {
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
                if let negativeImage = applyNegativeFilter(to: inputImage) {
                    filteredImage = Image(uiImage: negativeImage)
                }
            }
        }
    }
    
    func applyNegativeFilter(to image: UIImage) -> UIImage? {
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
            
            if let data = context.data {
                //let buffer = data.bindMemory(to: UInt8.self, capacity: cgImage.width * cgImage.height * 4)
                
                /*for i in 0 ..< buffer.count {
                    buffer[i] = 255 - buffer[i]  // Invert pixel values for negative effect
                }*/
            }
            
            if let negativeImage = context.makeImage() {
                return UIImage(cgImage: negativeImage)
            }
        }
        
        return nil
    }
}

// Использование NegativeFilterView
*/
