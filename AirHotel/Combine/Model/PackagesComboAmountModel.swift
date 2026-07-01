//
//  PackagesComboAmountModel.swift
//  AirHotel
//
//  Created by 7943 on 2026/6/8.
//

import SwiftUI

struct PackagesComboAmountModel {
    let personDetailList: [PackagesComboAmountPersonDetail]
    let discountList: [PackagesComboAmountDiscount]
}

struct PackagesComboAmountPersonDetail: Identifiable {
    let id = UUID()
    let appellation: String
    let pricePrePerson: String
    let numberOfPeople: String
    let totalPrice: String
}

struct PackagesComboAmountDiscount: Identifiable {
    let id = UUID()
    let isDiscount: Bool //是：優惠代碼；否：可樂旅遊幣
    let title: String
    let content: String
    let discount: String
    
}
