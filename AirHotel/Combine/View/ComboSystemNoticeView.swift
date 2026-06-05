//
//  ComboSystemNoticeView.swift
//  AirHotel
//
//  Created by 7943 on 2026/5/29.
//

import SwiftUI

struct ComboSystemNoticeView: View {
    let systemNoticeList: [ComboNoticeInfo]
    
    var body: some View {
        VStack(spacing: 6) {
            ForEach(systemNoticeList) { systemNotice in
                Button {
                    print("點擊系統公告")
                } label: {
                    noticeView(noticeInfo: systemNotice)
                }
            }
        }
        .padding(.horizontal, 6)
        .padding(.top, 6)
    }
    
    private func noticeView(noticeInfo: ComboNoticeInfo) -> some View {
        
        HStack(spacing: 4) {
            Image(noticeInfo.imageName)
            Text(noticeInfo.content)
                .lineLimit(1)
                .font(AppTypography.B04R)
                .foregroundStyle(AppColor.Text.neutralBodyBase)
        }
        .padding(8)
        .frame(maxWidth: .infinity)
        .background(noticeInfo.bgColor)
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .stroke(noticeInfo.strokeColor, lineWidth: 1)
        )
    }
}

#Preview {
    ComboSystemNoticeView(systemNoticeList: [
        ComboNoticeInfo(imageName: "ic_time_20",
                        content: "有位低價機票將於 23:20 - 24:00 進行全球價格同步，暫時停止訂位，若有訂購需求，請於 23:20 前完成訂位與付款",
                        bgColor: AppColor.Surface.brandPrimaryExtraSubtle,
                        strokeColor: AppColor.Border.brandPrimarySubtle),
        ComboNoticeInfo(imageName: "ic_bell_20",
                        content: "春節期間（2/8–2/14），官網與系統皆正常運作，客服服務時間為 09:00–18:00，如有急件需求可透過線上客服聯繫，感謝您的體諒與支持，祝您新春愉快。",
                        bgColor: AppColor.Surface.brandSecondaryExtraSubtle,
                        strokeColor: AppColor.Border.brandSecondarySubtle)
        ])
}
