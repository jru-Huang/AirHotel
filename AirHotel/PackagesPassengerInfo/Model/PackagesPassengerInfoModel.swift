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
    }
    
    struct BuyerInfoModel {
        let buyerName: String
        let buyerEmail: String
        let buyerPhone: String
        let noticeList: [String]
    }
    
    struct TravelerInfoModel {
        let travelerList: [Traveler]
    }
    
    struct Traveler: Identifiable {
        let id = UUID()
        let room: String
        let pax: Pax
    }
    
    struct Pax {
        let numberOfPeople: String
        let paxDetailList: [PaxDetail]
    }
    
    struct PaxDetail: Identifiable {
        let id = UUID()
        let paxChineseName: String
        let paxSurName: String
        let paxGivenName: String
        let isRoomLeader: Bool
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
