//
//  User.swift
//  Grocery_Test
//
//  Created by Денис Андриевский on 03.11.2020.
//

import Foundation
import CoreData

final class User {
    
    private let coredataService = CoreDataService()
    
    var name: String? {
        didSet {
            if name != nil {
                coredataService.changeName(name!)
            }
        }
    }
    var surname: String? {
        didSet {
            if surname != nil {
                coredataService.changeSurname(surname!)
            }
        }
    }
    var token: String? {
        didSet {
            if token != nil {
                coredataService.changeToken(token!)
            } else {
                surname = nil
                name = nil
                imageData = nil
                coredataService.clearUser()
            }
        }
    }
    var imageData: Data? {
        didSet {
            if imageData != nil {
                coredataService.changeImage(imageData!)
            }
        }
    }
    
    static let shared = User()
    private init() { }
    
    func retrieve() {
        guard let userMO = coredataService.retrieveUser() else { coredataService.createUser(); return }
        self.name = userMO.name
        self.surname = userMO.surname
        self.token = userMO.token
        self.imageData = userMO.imgData
    }
}

// Request Model
struct RequestUserModel: Decodable {
    var token: String?
    var success: Bool
    var message: String?
}
