//
//  ComboHotelInfoCard.swift
//  AirHotel
//
//  Created by 7943 on 2026/6/3.
//

import Foundation

struct ComboHotelInfoCard {
    let hotelNotice: String
    let checkInOutDate: String
    let hotelName: String
    let hotelSubtitle: String
    let overall: String
    let hotelGrade: CGFloat
    let starHotel: String
    let hasBreakfast: Bool
    let bookingRuleKey: ComboPackagesViewModel.BookingRuleKey
    let bookingRule: String
    let hotelTagList: [String]
}
