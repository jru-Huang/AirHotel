//
//  PackagesNoticeInfo.swift
//  AirHotel
//
//  Created by 7943 on 2026/6/8.
//

import Foundation

struct PackagesNoticeInfo: Identifiable {
    let id = UUID()
    let noticeInfo: PackagesNoticeDetailInfo
}

struct PackagesNoticeDetailInfo: Identifiable {
    let id = UUID()
    let navTitle: String
    let noticeInfoList: [PackagesNoticeDetail]
}

struct PackagesNoticeDetail: Identifiable  {
    let id = UUID()
    let title: String
    let content: String
}
