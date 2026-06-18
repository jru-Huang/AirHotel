//
//  PackagesComboAmountDetailInfo.swift
//  AirHotel
//
//  Created by 7943 on 2026/6/8.
//

import SwiftUI

struct PackagesComboAmountInfo {
    let detailInfo: [PackagesComboAmountDetailInfo]
    let discountInfo: [PackagesComboAmountDiscountInfo]
}

struct PackagesComboAmountDetailInfo: Identifiable {
    let id = UUID()
    let appellation: String
    let pricePrePerson: String
    let numberOfPeople: String
    let totalPrice: String
}

struct PackagesComboAmountDiscountInfo: Identifiable {
    let id = UUID()
    let isDiscount: Bool //是：優惠代碼；否：可樂旅遊幣
    let title: String
    let content: String
    let discount: String
    
}
