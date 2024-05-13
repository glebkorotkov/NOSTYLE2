//
//  Main.swift
//  NOSTYLE
//
//  Created by Gleb Korotkov on 09.05.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedImage: UIImage?
    @State private var isShowingImagePicker = false

    var body: some View {
        NavigationView {
            VStack {
                Button("Select Image") {
                    isShowingImagePicker.toggle()
                }
                .padding()

                if let image = selectedImage {
                    NavigationLink(destination: EditImageView(image: image)) {
                        Text("Edit Image")
                    }
                }
            }
            .sheet(isPresented: $isShowingImagePicker) {
                ImagePicker(selectedImage: $selectedImage)
            }
            .navigationBarTitle("Photo Editor")
        }
    }
}

struct EditImageView: View {
    @State private var rotatedImage: UIImage?
    var image: UIImage

    var body: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .padding()

            HStack {
                Button("Rotate Left") {
                    rotatedImage = rotateImage(image: image, degrees: -90)
                }
                .padding()

                Button("Rotate Right") {
                    rotatedImage = rotateImage(image: image, degrees: 90)
                }
                .padding()
                .disabled(rotatedImage == nil)
            }

            if let rotated = rotatedImage {
                Image(uiImage: rotated)
                    .resizable()
                    .scaledToFit()
                    .padding()
            }
        }
    }

    func rotateImage(image: UIImage, degrees: Double) -> UIImage {
        let rotatedSize = CGRect(origin: .zero, size: image.size)
            .applying(CGAffineTransform(rotationAngle: CGFloat(degrees.toRadians())))
            .integral.size

        UIGraphicsBeginImageContext(rotatedSize)

        if let context = UIGraphicsGetCurrentContext() {
            context.translateBy(x: rotatedSize.width / 2, y: rotatedSize.height / 2)
            context.rotate(by: CGFloat(degrees.toRadians()))

            image.draw(in: CGRect(x: -image.size.width / 2, y: -image.size.height / 2, width: image.size.width, height: image.size.height))
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return rotatedImage ?? image
        }

        return image
    }
}

extension Double {
    func toRadians() -> Double {
        return self * .pi / 180
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
        }
    }
}

@main
struct PhotoEditorApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
