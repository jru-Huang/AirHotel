//
//  PresentNoticeInfo.swift
//  AirHotel
//
//  Created by 7943 on 2026/6/8.
//

import Foundation

struct PresentedNotice: Identifiable {
    let id = UUID()
    let noticeInfo: NoticeDetailInfo
}

struct NoticeDetailInfo: Identifiable {
    let id = UUID()
    let navTitle: String
    let noticeInfoList: [NoticeDetail]
}

struct NoticeDetail: Identifiable  {
    let id = UUID()
    let title: String
    let content: String
}
