//
//  PaintingDetailView.swift
//  ArtGallery
//
//  Created by Jhon Yoset Luna Quispe on 30/10/24.
//

import SwiftUI

struct PaintingDetailView: View {
    let painting: Painting
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Título "Detalles" en negrita y color negro, centrado
                Text("Detalles")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .center)  // Centrado

                // Imagen centrada
                AsyncImage(url: URL(string: painting.image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)  // Imagen centrada
                } placeholder: {
                    ProgressView()
                }

                // Nombre de la pintura alineado a la izquierda, con color #7E0303
                Text("Painting: \(painting.painting)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: "#7E0303"))  // Color especificado

                // Información del artista alineada a la izquierda
                Text("Artist: \(painting.artist)")
                    .font(.headline)

            }
            .padding()
            .navigationTitle("Painting Details")
        }
    }
}

// Extensión para el color hexadecimal
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = scanner.string.startIndex
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        self.init(
            .sRGB,
            red: Double((rgb >> 16) & 0xFF) / 255.0,
            green: Double((rgb >> 8) & 0xFF) / 255.0,
            blue: Double(rgb & 0xFF) / 255.0,
            opacity: 1.0
        )
    }
}
