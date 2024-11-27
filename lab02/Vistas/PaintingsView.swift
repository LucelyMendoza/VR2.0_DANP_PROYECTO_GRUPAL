//
//  PaintingsView.swift
//  ArtGallery
//
//  Created by Jhon Yoset Luna Quispe on 25/10/24.
//

import Foundation
import SwiftUI

struct PaintingsView: View {
    @StateObject private var viewModel = PaintingsViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                if viewModel.isLoading {
                    ProgressView("Loading Paintings...")
                } else {
                    LazyVStack(alignment: .leading, spacing: 16) {
                        ForEach(viewModel.paintings) { painting in
                            PaintingRow(painting: painting)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Art Gallery")
            .onAppear {
                viewModel.fetchPaintings()
            }
        }
    }
}

struct PaintingRow: View {
    let painting: Painting

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: URL(string: painting.imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .clipped()
            } placeholder: {
                ProgressView()
            }

            Text("Painting: \(painting.painting)")
                .font(.headline)

            Text("Artist: \(painting.artist)")
                .font(.subheadline)

            Text("Year: \(painting.year)")
                .font(.subheadline)

            Text("Price: \(painting.adjustedPrice)")
                .font(.subheadline)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}
