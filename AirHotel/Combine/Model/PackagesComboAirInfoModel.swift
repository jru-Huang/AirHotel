//
//  PackagesComboAirInfoModel.swift
//  AirHotel
//
//  Created by 7943 on 2026/5/29.
//

import Foundation

struct PackagesComboAirInfoModel {
    let segmentInfoList: [PackagesComboSegmentInfoModel]
    let airTagList:[String]
    let luggageType: PackagesComboViewModel.LuggageType
}

struct PackagesComboSegmentInfoModel: Identifiable {
    let id = UUID()
    let type: String
    let date: String
    let carrierNoticeText: String
    let carrierLogo: String
    let ticketingCarrier: String
    let depTime: String
    let depLocation: String
    let depTerminal: String
    let arrTime: String
    let arrLocation: String
    let arrTerminal: String
    let dateVariation: String
    let segmentTimeDesc: String
    let transitCountDesc: String
    let isDepLocHighlight: Bool
    let isArrLocHighlight: Bool
}
