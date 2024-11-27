//
//  QRView.swift
//  lab02
//
//  Created by epismac on 9/10/24.
//

import SwiftUI
import Vision
import PhotosUI

struct QRView: View {
    @State private var selectedImage: UIImage?
    @State private var painting: Painting?
    @State private var isImagePickerPresented = false
    @State private var isCameraPresented = false

    var body: some View {
        NavigationView {
            VStack {
                if let painting = painting {
                    // Muestra los datos de la pintura si se encuentra una
                    PaintingDetailView(painting: painting)
                } else {
                    Text("Sube una imagen de un código QR para ver los detalles de la pintura.")
                        .font(.headline)
                        .padding()
                    
                    if let selectedImage = selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .padding()
                    }
                }
                
                HStack {
                    Button("Subir Imagen") {
                        isImagePickerPresented = true
                    }
                    .padding()
                    /*
                    Button("Capturar Imagen") {
                        isCameraPresented = true
                    }
                    .padding()*/
                }
            }
            .navigationTitle("QR Scanner")
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(sourceType: .photoLibrary, selectedImage: $selectedImage, completion: processQRCode)
            }
            .sheet(isPresented: $isCameraPresented) {
                ImagePicker(sourceType: .camera, selectedImage: $selectedImage, completion: processQRCode)
            }
            .onChange(of: selectedImage) { newImage in
                if let image = newImage {
                    processQRCode(from: image)
                }
            }
        }
    }

    private func processQRCode(from image: UIImage) {
        guard let cgImage = image.cgImage else { return }
        
        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        let request = VNDetectBarcodesRequest { request, error in
            if let results = request.results as? [VNBarcodeObservation] {
                for result in results {
                    if let payloadString = result.payloadStringValue {
                        fetchPaintingData(withId: payloadString)
                        break
                    }
                }
            }
        }
        
        do {
            try requestHandler.perform([request])
        } catch {
            print("Error al procesar la imagen: \(error)")
        }
    }

    private func fetchPaintingData(withId id: String) {
        // Simulación de búsqueda de datos de pintura basados en el ID
        let samplePaintings = [
            Painting(
                id: "0piYz0uIAxbNKMhUS3q6",
                painting: "Eight Elvises",
                artist: "Andy Warhol",
                adjustedPrice: "$109,500,000",
                originalPrice: "$100,000,000",
                dateOfSale: "1/10/2008",
                yearOfSale: 2008,
                seller: "Annibale Berlingieri",
                buyer: "",
                auctionHouse: "Private sale",
                image: "http://upload.wikimedia.org/wikipedia/en/b/be/Eight_Elvises.jpg"
            )
        ]
        
        if let foundPainting = samplePaintings.first(where: { $0.id == id }) {
            DispatchQueue.main.async {
                self.painting = foundPainting
            }
        } else {
            print("Pintura no encontrada para el ID: \(id)")
        }
    }

}
