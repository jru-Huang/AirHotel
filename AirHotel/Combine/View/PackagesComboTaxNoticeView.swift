//
//  PackagesComboTaxNoticeView.swift
//  AirHotel
//
//  Created by 7943 on 2026/5/29.
//

import SwiftUI

struct PackagesComboTaxNoticeView: View {
    let taxNotice: String
    var onTouchNotice: (() -> Void)
    
    var body: some View {
        Button {
            onTouchNotice()
        } label: {
            HStack(spacing: 6) {
                Image("ic_notice_20")
                Text(taxNotice)
                    .lineLimit(1)
                    .font(AppTypography.B04R)
                    .foregroundStyle(AppColor.Text.neutralBodyBase)
                HStack(spacing: 2) {
                    Text("詳情")
                        .font(AppTypography.L03R)
                        .foregroundStyle(AppColor.Text.neutralBodyMid)
                    Image("ic_right_14")
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(AppColor.Surface.marketOrangeExtraSubtle)
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(AppColor.Surface.marketOrangeSubtle)
                .frame(height: 1)
        }
    }
}

#Preview {
    PackagesComboTaxNoticeView(taxNotice: "東京從2002年10月徵收住宿税。徵税標準根據住宿金額按每人每晚徵收，每晚住宿費在1萬日元以上每人每晚徵收100日元，1.5萬日元以上每人每晚徵收200日元，部分房價不包含住宿税，需客人另付前臺，具體以飯店告知為準。", onTouchNotice: { print("點擊公告")})
}
