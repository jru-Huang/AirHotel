//
//  PackagesNoticeInfoModel.swift
//  AirHotel
//
//  Created by 7943 on 2026/6/8.
//

import Foundation

struct PackagesNoticeInfoModel: Identifiable {
    let id = UUID()
    let noticeInfo: PackagesNoticeDetailInfo
}

struct PackagesNoticeDetailInfo: Identifiable {
    let id = UUID()
    let navTitle: String
    let noticeDetailList: [PackagesNoticeDetail]
}

struct PackagesNoticeDetail: Identifiable  {
    let id = UUID()
    let title: String
    let content: String
}
