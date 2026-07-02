//
//  PackagesComboSystemNoticeView.swift
//  AirHotel
//
//  Created by 7943 on 2026/5/29.
//

import SwiftUI

struct PackagesComboSystemNoticeView: View {
    let systemNoticeConfig: PackagesComboSystemNoticeConfig
    var onTouchNotice: (()-> Void)
    
    var body: some View {
        VStack(spacing: 6) {
            Button {
                onTouchNotice()
            } label: {
                noticeView(config: systemNoticeConfig)
            }
        }
        .padding(.horizontal, 6)
        .padding(.top, 6)
    }
    
    private func noticeView(config: PackagesComboSystemNoticeConfig) -> some View {
        HStack(spacing: 4) {
            Image(config.imageName)
            Text(config.content)
                .lineLimit(1)
                .font(AppTypography.B04R)
                .foregroundStyle(AppColor.Text.neutralBodyBase)
        }
        .padding(8)
        .frame(maxWidth: .infinity)
        .background(config.bgColor)
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .stroke(config.strokeColor, lineWidth: 1)
        )
    }
}

#Preview {
    PackagesComboSystemNoticeView(systemNoticeConfig:
                                    PackagesComboSystemNoticeConfig(imageName: "ic_countdown_time_20",
                                                            content: "有位低價機票將於 23:20 - 24:00 進行全球價格同步，暫時停止訂位，若有訂購需求，請於 23:20 前完成訂位與付款",
                                                            bgColor: AppColor.Surface.brandPrimaryExtraSubtle,
                                                            strokeColor: AppColor.Border.brandPrimarySubtle),
                          onTouchNotice: {  print("點擊公告")})
}
