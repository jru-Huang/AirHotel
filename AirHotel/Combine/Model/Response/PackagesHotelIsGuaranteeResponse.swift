//
//  PackagesHotelIsGuaranteeResponse.swift
//  AirHotel
//
//  Created by 7943 on 2026/6/30.
//

import Foundation

struct PackagesHotelIsGuaranteeResponse: Codable {
    let guaranteeMark: Bool?
    let serviceFeeDesc: String?
    let cancelDesc: String?
    
    enum CodingKeys: String, CodingKey {
        case guaranteeMark = "Guarantee_Mark"
        case serviceFeeDesc = "Service_Fee_Desc"
        case cancelDesc = "Cancel_Desc"
    }
}
