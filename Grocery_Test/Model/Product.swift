//
//  Product.swift
//  Grocery_Test
//
//  Created by Денис Андриевский on 03.11.2020.
//

import Foundation

struct Product {
    var title: String
    var description: String
    var id: Int
    var img: Data?
    
    var reviews: [Review] = []
    
    init(from model: ProductModel) {
        self.title = model.title
        self.description = model.text
        self.id = model.id
    }
    
}

struct Review {
    var username: String
    var rate: Int
    var text: String
    
    init(from model: ReviewModel) {
        self.username = model.created_by.username ?? C.anonymTitle
        self.rate = model.rate
        self.text = model.text
    }
    
}

struct ReviewModel: Decodable {
    var rate: Int
    var text: String
    var created_by: CreatedBy
}

struct CreatedBy: Decodable {
    var username: String?
}

struct ProductModel: Decodable {
    var title: String
    var text: String
    var id: Int
    var img: String
}
