//
//  UserList.swift
//  Itika's Task
//
//  Created by Itika Soni on 25/07/23.
//

import Foundation

// MARK: - UserListElement
struct UserListElement: Codable {
    let address: Address?
    let id: Int?
    let email, username, password: String?
    let name: Name?
    let phone: String?
    let v: Int?

    enum CodingKeys: String, CodingKey {
        case address, id, email, username, password, name, phone
        case v = "__v"
    }
}

// MARK: - Address
struct Address: Codable {
    let geolocation: Geolocation?
    let city, street: String?
    let number: Int?
    let zipcode: String?
}

// MARK: - Geolocation
struct Geolocation: Codable {
    let lat, long: String?
}

// MARK: - Name
struct Name: Codable {
    let firstname, lastname: String?
}

typealias UserList = [UserListElement]
