//
//  ComboTaxNoticeView.swift
//  AirHotel
//
//  Created by 7943 on 2026/5/29.
//

import SwiftUI

struct ComboTaxNoticeView: View {
    let taxNotice: String
    
    var body: some View {
        Button {
            print("點擊稅收公告")
        } label: {
            HStack(spacing: 6) {
                Image("ic_notice_20")
                Text(taxNotice)
                    .lineLimit(1)
                    .setTCFont(.regular, size: 13)
                    .foregroundStyle(Color.textNeutralBodyBase_333333)
                HStack(spacing: 2) {
                    Text("詳情")
                        .setTCFont(.regular, size: 12)
                        .foregroundStyle(Color.textNeutralBodyMid_666666)
                    Image("ic_right_14")
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color.surfaceMarketOrangeExSubtle_FFF3E9)
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(Color.surfaceMarketOrangeSubtle_FFCEBA)
                .frame(height: 1)
        }
    }
}

#Preview {
    ComboTaxNoticeView(taxNotice: "")
}
