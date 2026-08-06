//
//  PackagesPassengerInfoView.swift
//  AirHotel
//
//  Created by 7943 on 2026/8/6.
//

import SwiftUI

struct PackagesPassengerInfoView: View {
    
    @StateObject var viewModel: PackagesPassengerInfoViewModel
    
    private var hasNotice: Bool {
        return viewModel.lineNotice != nil || viewModel.systemNotice != nil
    }
    
    var body: some View {
        VStack(spacing: 0) {
            noticeTimeLimitView
            
            if hasNotice {
                noticeView
            }
        }
        .onAppear(perform: viewModel.onViewAppear)
        .background(AppColor.Background.pageGray)
    }
    
    private var noticeView: some View {
        VStack(spacing: 0) {
            if let lineNotice = viewModel.lineNotice {
                PackagesDynamicBundleSystemNoticeView(systemNoticeConfig: lineNotice.config, onTouchNotice: {
                    print("LINE PAY導購（ 待後續聯盟行銷）")
                })
            }
            
            if let systemNotice = viewModel.systemNotice {
                PackagesDynamicBundleSystemNoticeView(systemNoticeConfig: systemNotice.config, onTouchNotice: {
                    if let detailInfo = systemNotice.detailInfo {
                        viewModel.presentNoticeInfo(detailInfo)
                    }
                })
            }
            
        }
    }
    
    // MARK: 倒數計時
    private var noticeTimeLimitView: some View {
        HStack(spacing: 6) {
            noticeTitle
            noticeTime
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 12)
        .background(
            Rectangle()
                .foregroundColor(.clear)
                .background(
                    LinearGradient(
                        stops: [
                            Gradient.Stop(color: Color(red: 0.63, green: 0.37, blue: 0.85), location: 0.00),
                            Gradient.Stop(color: Color(red: 0.71, green: 0.6, blue: 1), location: 1.00),
                        ],
                        startPoint: UnitPoint(x: 0, y: 0.5),
                        endPoint: UnitPoint(x: 1, y: 0.5)
                    )
                )
        )
    }
    
    private var noticeTitle: some View {
        HStack(spacing: 4) {
            Image("ic_countdown_20_white")
            Text("請在 15 分鐘內填寫並送出訂單")
                .font(AppTypography.B04M)
                .foregroundStyle(AppColor.Text.neutralWhite)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var noticeTime: some View {
        HStack(spacing: 2) {
            Text("14")
                .font(AppTypography.N06M)
                .foregroundStyle(AppColor.Text.neutralWhite)
                .padding(.vertical, 2)
                .padding(.horizontal, 6)
                .background(AppColor.Surface.opacityWhiteBase, in: RoundedRectangle(cornerRadius: 4))
            Text(":")
                .font(AppTypography.N06M)
                .foregroundStyle(AppColor.Text.neutralWhite)
            Text("59")
                .font(AppTypography.N06M)
                .foregroundStyle(AppColor.Text.neutralWhite)
                .padding(.vertical, 2)
                .padding(.horizontal, 6)
                .background(AppColor.Surface.opacityWhiteBase, in: RoundedRectangle(cornerRadius: 4))
        }
    }
}

#Preview {
    PackagesPassengerInfoView(viewModel: PackagesPassengerInfoViewModel())
}
