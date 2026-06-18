//
//  PackagesComboAirInfoCard.swift
//  AirHotel
//
//  Created by 7943 on 2026/5/29.
//

import Foundation

struct PackagesComboFlightSegment: Identifiable {
    let id = UUID()
    let tag: String
    let date: String
    let noticeText: String
    let imageName: String
    let depTime: String
    let depLocation: String
    let depTerminal: String
    let arrTime: String
    let arrLocation: String
    let arrTerminal: String
    let dateVariation: String //換日
    let flightTime: String
    let transitNote: String //直飛、轉機
    let depLocDiffMark: Bool //去抵達回出發地點不同
    let arrLocDiffMark: Bool //去抵達回出發地點不同
}

struct PackagesComboAirInfoCard {
    let flights: [PackagesComboFlightSegment]
    let airTagList:[String]
    let luggageType: PackagesComboViewModel.LuggageType
}
