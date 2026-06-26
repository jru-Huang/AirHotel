//
//  PackagesComboHotelInfoModel.swift
//  AirHotel
//
//  Created by 7943 on 2026/6/3.
//

import Foundation

struct PackagesComboHotelInfoModel {
    let hotelNotice: String
    let checkInOutDate: String
    let hotelImg: String
    let hotelChineseName: String
    let hotelEnglishName: String
    let hotelRating: Double
    let hotelGrade: Double
    let hotelStar: String
    let roomDescription: String
    let hasBreakfast: Bool
    let bookingRuleKey: PackagesComboViewModel.BookingRuleKey
    let bookingRule: String
    let hotelTagList: [String]
    let hotelGreenMark: Bool
}
