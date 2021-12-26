//
//  DataAPI.swift
//  firstdz
//
//  Created by wsr2 on 24.12.2021.
//

import Foundation

class DataAPI {
    static let instance = DataAPI()

    private let defaults = UserDefaults.standard

    static let userName = "username"
    static let userPassword = "userpassword"
    static let userKey = "userkey"

    private init() {}

    func saveUser(login: String, password: String, pabKey: String) {
        saveKey(keyValue: login, typeOfKey: DataAPI.userName)
        saveKey(keyValue: password, typeOfKey: DataAPI.userPassword)
        saveKey(keyValue: pabKey, typeOfKey: DataAPI.userKey)
    }

    func saveKey(keyValue: String, typeOfKey: String) {
        defaults.setValue(keyValue, forKey: typeOfKey)
    }

    func getKey(nameOfKey: String) -> String? {
        return defaults.string(forKey: nameOfKey)
    }

    func deleteKey(nameOfKey: String) {
        defaults.removeObject(forKey: nameOfKey)
    }

}
