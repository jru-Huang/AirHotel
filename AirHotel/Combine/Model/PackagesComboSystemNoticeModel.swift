//
//  PackagesComboSystemNoticeModel.swift
//  AirHotel
//
//  Created by 7943 on 2026/5/29.
//

import SwiftUI

struct PackagesComboSystemNoticeModel: Identifiable {
    let config: PackagesComboSystemNoticeConfig
    let detailInfo: PackagesNoticeDetailInfo

    var id: UUID {
        config.id
    }
}

struct PackagesComboSystemNoticeConfig: Identifiable {
    let id = UUID()
    let imageName: String
    let content: String
    let bgColor: Color
    let strokeColor: Color
}
