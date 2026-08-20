//
//  PackagesPassengerInfoModel.swift
//  AirHotel
//
//  Created by 7943 on 2026/8/13.
//

import Foundation

struct PackagesPassengerInfoModel: Identifiable {
    let id = UUID()
    let airInfo: AirInfoModel
    let hotelInfo: HotelInfoModel
    let buyerInfo: BuyerInfoModel
    let travelerInfo: TravelerInfoModel
    let priceDetail: PriceInfoModel
    let orderTermsList: [OrderTermsInfoModel]
    
    struct AirInfoModel {
        let depLocation: String
        let returnLocation: String
        let airSegmentList: [AirSegment]
    }
    
    struct AirSegment: Identifiable {
        let id = UUID()
        let airType: String
        let date: String
        let depAirport: String
        let depTerminal: String
        let arrAirport: String
        let arrTerminal: String
    }
    
    struct HotelInfoModel {
        let hotelName: String
        let checkInDate: String
        let checkOutDate: String
        let roomDesc: String
        let hotelDetail: HotelDetail
    }
    
    struct HotelDetail {
        // 飯店名稱
        let hotelChineseName: String
        let hotelEnglishName: String
        let hotelGrade: Double // 星級
        let gradeDesc: String // 星等描述 (APP顯示)，如果沒有資料則回傳空字串
        let hotelRating: Double // 評分
        let hotelGreenMark: Bool
        let displayTag: [String]
        // 房型
        let roomDescription: String // 房型
        let breakfastMark: Bool // 是否含早餐
        let breakfastType: String // 早餐
        // 取消/更改說明
        let bookingRule: String
        let guaranteeMark: Bool
        let serviceFeeDesc: String
        let cancelDesc: String
        // 入住退房時間
        let checkInTime: String
        let checkOutTime: String
        // 入住資訊
        let checkInfo: String
    }
    
    struct BuyerInfoModel {
        let buyerName: String
        let buyerEmail: String
        let buyerPhone: String
        let noticeList: [String]
    }
    
    struct TravelerInfoModel {
        let travelerRoomList: [TravelerRoom]
    }
    
    struct TravelerRoom: Identifiable {
        let id = UUID()
        let roomNo: String
        let numberOfPeople: String
        let travelerList:  [TravelerModel]
    }
    
    struct PriceInfoModel {
        let amount: Amount
        let coupon: PriceItem
        let colaCoin: PriceItem
        let totalTaxPrice: String
    }
    
    struct Amount {
        let amountPrice: String
        let amountDetailList: [PricePersonDetail]
    }
    
    struct PriceItem {
        let title: String
        let price: String
    }
    
    struct PricePersonDetail: Identifiable {
        let id = UUID()
        let appellation: String
        let pricePrePerson: String
        let numberOfPeople: String
        let totalPrice: String
    }
    
    struct OrderTermsInfoModel: Identifiable {
        let id = UUID()
        let title: String
        let content: String
    }
}
