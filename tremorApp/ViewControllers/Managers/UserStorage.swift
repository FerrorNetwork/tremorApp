//
//  UserStorage.swift
//  tremorApp
//
//  Created by Данил on 06.05.2023.
//

import Foundation

class UserStorage {
    static let shared = UserStorage()
        
        private let userDefaults = UserDefaults.standard
        
        private let firstNameKey = "firstName"
        private let lastNameKey = "lastName"
        private let genderKey = "gender"
        private let birthdateKey = "birthdate"
        private let weightKey = "weight"
        private let heightKey = "height"
        
        func saveUser(_ user: Profile) {
            userDefaults.set(user.firstName, forKey: firstNameKey)
            userDefaults.set(user.lastName, forKey: lastNameKey)
            userDefaults.set(user.gender, forKey: genderKey)
            userDefaults.set(user.birthdate, forKey: birthdateKey)
            userDefaults.set(user.weight, forKey: weightKey)
            userDefaults.set(user.height, forKey: heightKey)
        }
        
        func loadUser() -> Profile? {
            guard let firstName = userDefaults.string(forKey: firstNameKey),
                  let lastName = userDefaults.string(forKey: lastNameKey),
                  let gender = userDefaults.string(forKey: genderKey),
                  let weight = userDefaults.string(forKey: weightKey),
                  let height = userDefaults.string(forKey: heightKey),
                  let birthdate = userDefaults.object(forKey: birthdateKey) as? Date else {
                return nil
            }
                
            
            return Profile(firstName: firstName, lastName: lastName, gender: gender, birthdate: birthdate, weight: weight, height: height)
        }
}
