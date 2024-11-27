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
            VStack(alignment: .leading, spacing: 10) {
                AsyncImage(url: URL(string: painting.image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                Text("Painting: \(painting.painting)")
                    .font(.title)
                    .fontWeight(.bold)
                Text("Artist: \(painting.artist)")
                    .font(.headline)
                Text("Adjusted Price: \(painting.adjustedPrice)")
                Text("Original Price: \(painting.originalPrice)")
                Text("Date of Sale: \(painting.dateOfSale)")
                Text("Year of Sale: \(painting.yearOfSale)")
                Text("Seller: \(painting.seller)")
                Text("Buyer: \(painting.buyer)")
                Text("Auction House: \(painting.auctionHouse)")
            }
            .padding()
            .navigationTitle("Painting Details")
        }
    }
}

