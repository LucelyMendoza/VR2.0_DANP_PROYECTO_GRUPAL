//
//  Painting.swift
//  ArtGallery
//
//  Created by Jhon Yoset Luna Quispe on 25/10/24.
//

/*
struct Painting: Identifiable, Decodable {
    let id: String
    let painting: String
    let artist: String
    let year: String
    let price: String
}*/
import Foundation
struct Painting: Codable, Identifiable, Hashable {
    let id: String
    let painting: String
    let artist: String
    let adjustedPrice: String
    let originalPrice: String
    let dateOfSale: String
    let yearOfSale: Int
    let seller: String
    let buyer: String
    let auctionHouse: String
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case painting = "Painting"
        case artist = "Artist"
        case adjustedPrice = "Adjusted Price" // Asegúrate de que esta clave sea correcta
        case originalPrice = "Original Price"
        case dateOfSale = "Date of Sale"
        case yearOfSale = "Year of Sale"
        case seller = "Seller"
        case buyer = "Buyer"
        case auctionHouse = "Auction House"
        case image = "Image"
    }
}


struct PaintingResponse: Codable {
    let data: [Painting]
}


/*
import Foundation

struct User: Codable {
    let name: Name
    let email: String
    let picture: Picture
    
    struct Name: Codable {
        let first: String
        let last: String
    }
    
    struct Picture: Codable {
        let thumbnail: String
    }
}

struct UserResponse: Codable {
    let results: [User]
}*/
