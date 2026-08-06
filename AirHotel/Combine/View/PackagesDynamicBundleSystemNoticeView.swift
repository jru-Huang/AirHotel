//
//  PackagesDynamicBundleSystemNoticeView.swift
//  AirHotel
//
//  Created by 7943 on 2026/5/29.
//

import SwiftUI

struct PackagesDynamicBundleSystemNoticeView: View {
    let systemNoticeConfig: PackagesDynamicBundleSystemNoticeConfig
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
    
    private func noticeView(config: PackagesDynamicBundleSystemNoticeConfig) -> some View {
        HStack(spacing: 4) {
            Image(config.imageName)
            Text(config.content)
                .lineLimit(1)
                .font(AppTypography.B04R)
                .foregroundStyle(AppColor.Text.neutralBodyBase)
        }
        .padding(8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(config.bgColor)
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .stroke(config.strokeColor, lineWidth: 1)
        )
    }
}

struct PackagesDynamicBundleSystemNoticeModel: Identifiable {
    let config: PackagesDynamicBundleSystemNoticeConfig
    let detailInfo: PackagesNoticeDetailInfo?

    var id: UUID {
        config.id
    }
}

struct PackagesDynamicBundleSystemNoticeConfig: Identifiable {
    let id = UUID()
    let imageName: String
    let content: String
    let bgColor: Color
    let strokeColor: Color
}


#Preview {
    PackagesDynamicBundleSystemNoticeView(
        systemNoticeConfig:
            PackagesDynamicBundleSystemNoticeConfig(
                                                imageName: "ic_countdown_time_20",
                                                content: "有位低價機票將於 23:20 - 24:00 進行全球價格同步，暫時停止訂位，若有訂購需求，請於 23:20 前完成訂位與付款",
                                                bgColor: AppColor.Surface.brandPrimaryExtraSubtle,
                                                strokeColor: AppColor.Border.brandPrimarySubtle), onTouchNotice: {}
    )
}
