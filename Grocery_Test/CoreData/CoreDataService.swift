//
//  CoreDataService.swift
//  Grocery_Test
//
//  Created by Денис Андриевский on 03.11.2020.
//

import UIKit
import CoreData

final class CoreDataService {
    
    private let appDelegate = UIApplication.shared.delegate as? AppDelegate
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func createUser() {
        guard let appDelegate = appDelegate, let managedContext = context else { return }
        let newUserMO = UserMO(entity: UserMO.entity(), insertInto: managedContext)
        newUserMO.name = User.shared.name
        newUserMO.imgData = User.shared.imageData
        newUserMO.surname = User.shared.surname
        newUserMO.token = User.shared.token
        appDelegate.saveContext()
    }
    
    func changeName(_ name: String) {
        guard let appDelegate = appDelegate, let user = retrieveUser() else { return }
        user.name = name
        appDelegate.saveContext()
    }
    
    func changeSurname(_ surname: String) {
        guard let appDelegate = appDelegate, let user = retrieveUser() else { return }
        user.surname = surname
        appDelegate.saveContext()
    }
    
    func changeImage(_ data: Data) {
        guard let appDelegate = appDelegate, let user = retrieveUser() else { return }
        user.imgData = data
        appDelegate.saveContext()
    }
    
    func changeToken(_ token: String) {
        guard let appDelegate = appDelegate, let user = retrieveUser() else { return }
        user.token = token
        appDelegate.saveContext()
    }
    
    func clearUser() {
        guard let appDelegate = appDelegate, let managedContext = context, let currentUser = retrieveUser() else { return }
        managedContext.delete(currentUser)
        appDelegate.saveContext()
    }
    
    func retrieveUser() -> UserMO? {
        let fetchRequest = NSFetchRequest<UserMO>(entityName: "UserMO")
        guard let managedContext = context, let results = try? managedContext.fetch(fetchRequest), let result = results.first else { return nil }
        return result
    }
    
}
