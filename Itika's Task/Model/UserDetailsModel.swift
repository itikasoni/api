
//
//  UserDetailsModel.swift
//  Itika's Task
//
//  Created by Itika Soni on 19/07/23.
//

import Foundation

// MARK: - UserDetailsModel
struct UserDetailsModel: Codable {
    let status: Int?
    let message: String?
    let data: [UserDetailsDatum]?
}

// MARK: - Datum
struct UserDetailsDatum: Codable {
    let id: Int?
    let username, email, password: String?
    let platform, platformID: JSONNull?
    let mobileNumber, countryCode, referralCode: String?
    let myReferralCode: JSONNull?
    let fcmToken: String?
    let profileImg: String?
    let latitude, longitude: JSONNull?
    let createdAt, updatedAt: String?
    let otp: JSONNull?
    let followers, following: Int
    let token: String?
    let docType: JSONNull?
    let frontImg, backImg: String?
    let status: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id, username, email, password, platform
        case platformID = "platform_id"
        case mobileNumber = "mobile_number"
        case countryCode = "country_code"
        case referralCode = "referral_code"
        case myReferralCode = "my_referral_code"
        case fcmToken = "fcm_token"
        case profileImg = "profile_img"
        case latitude, longitude
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case otp, followers, following, token
        case docType = "doc_type"
        case frontImg = "front_img"
        case backImg = "back_img"
        case status
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
