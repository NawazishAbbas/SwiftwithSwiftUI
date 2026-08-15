//
//  ProductsModel.swift
//  SwiftwithSwiftUI
//
//  Created by Qubitse on 15/08/2026.
//

import Foundation

// MARK: - ProductsModel
struct ProductsModel: Codable {
    let products: [Product]?
    let total: Int?
    let skip: Int?
    let limit: Int?

    enum CodingKeys: String, CodingKey {
        case products = "products"
        case total = "total"
        case skip = "skip"
        case limit = "limit"
    }
}

// MARK: - Product
struct Product: Codable {
    let id: Int?
    let title: String?
    let description: String?
    let category: Category?
    let price: Double?
    let discountPercentage: Double?
    let rating: Double?
    let stock: Int?
    let tags: [String]?
    let brand: String?
    let sku: String?
    let weight: Int?
    let dimensions: Dimensions?
    let warrantyInformation: String?
    let shippingInformation: String?
    let availabilityStatus: String?
    let reviews: [Review]?
    let returnPolicy: String?
    let minimumOrderQuantity: Int?
    let meta: Meta?
    let images: [String]?
    let thumbnail: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case description = "description"
        case category = "category"
        case price = "price"
        case discountPercentage = "discountPercentage"
        case rating = "rating"
        case stock = "stock"
        case tags = "tags"
        case brand = "brand"
        case sku = "sku"
        case weight = "weight"
        case dimensions = "dimensions"
        case warrantyInformation = "warrantyInformation"
        case shippingInformation = "shippingInformation"
        case availabilityStatus = "availabilityStatus"
        case reviews = "reviews"
        case returnPolicy = "returnPolicy"
        case minimumOrderQuantity = "minimumOrderQuantity"
        case meta = "meta"
        case images = "images"
        case thumbnail = "thumbnail"
    }
}

enum AvailabilityStatus: String, Codable {
    case inStock = "In Stock"
    case lowStock = "Low Stock"
}

enum Category: String, Codable {
    case beauty = "beauty"
    case fragrances = "fragrances"
    case furniture = "furniture"
    case groceries = "groceries"
}

// MARK: - Dimensions
struct Dimensions: Codable {
    let width: Double?
    let height: Double?
    let depth: Double?

    enum CodingKeys: String, CodingKey {
        case width = "width"
        case height = "height"
        case depth = "depth"
    }
}

// MARK: - Meta
struct Meta: Codable {
    let createdAt: String?
    let updatedAt: String?
    let barcode: String?
    let qrCode: String?

    enum CodingKeys: String, CodingKey {
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case barcode = "barcode"
        case qrCode = "qrCode"
    }
}

// MARK: - Review
struct Review: Codable {
    let rating: Int?
    let comment: String?
    let date: String?
    let reviewerName: String?
    let reviewerEmail: String?

    enum CodingKeys: String, CodingKey {
        case rating = "rating"
        case comment = "comment"
        case date = "date"
        case reviewerName = "reviewerName"
        case reviewerEmail = "reviewerEmail"
    }
}
