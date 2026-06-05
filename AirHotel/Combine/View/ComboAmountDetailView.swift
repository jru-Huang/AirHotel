//
//  ComboAmountDetailView.swift
//  AirHotel
//
//  Created by 7943 on 2026/6/3.
//

import SwiftUI

struct ComboAmountDetailView: View {
    
    @Binding var showAmountDetail: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            titleView
            contentView
        }
    }
    
    private var titleView: some View {
        ZStack {
            Text("售價明細")
                .setTCFont(.medium, size: 16)
                .foregroundStyle(Color.textNeutralBodyBase_333333)
            HStack {
                Button {
                    showAmountDetail = false
                } label: {
                    Image("ic_close_20")
                }
                Spacer()
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(Color.white, in: RoundedCorner(radius: 8, corners: [.topLeft, .topRight]))
    }
    
    private var contentView: some View {
        VStack(spacing: 8) {
            priceRow(appellation: "大人", price: "$17,200", count: "x4", total: "$68,800")
            priceRow(appellation: "小孩", price: "$17,200", count: "x1", total: "$17,200")
            discountRow(icon: "ic_discount_14",
                        title: "優惠代碼折扣",
                        content: "晚鳥清艙折抵800元",
                        discount: "-$2,000",
                         titleColor: Color.textMarketOrangeBase_FF6F00,
                        bgColor: Color.surfaceMarketOrangeExSubtle_FFF3E9,
                         leadingBorderColor: Color.borderMarketOrangeSubtle_FFBA9E)
            discountRow(icon: "ic_cola_coin_14",
                        title: "可樂旅遊幣折抵",
                        content: "均分於所有旅客",
                        discount: "-$120",
                         titleColor: Color.textBrandPrimaryBase_9A56D3,
                         bgColor: Color.surfaceBrandPrimaryExSubtle_F1F1F8,
                         leadingBorderColor: Color.borderBrandPrimarySubtle_D4C2FF)
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 24)
        .background(Color.white)
    }
    
    private func priceRow(appellation: String, price: String, count: String, total: String) -> some View {
        HStack(spacing: 0) {
            HStack(spacing: 4) {
                Text(appellation)
                    .setTCFont(.regular, size: 14)
                    .foregroundStyle(Color.textNeutralBodyBase_333333)
                Text(price)
                    .setTCFont(.regular, size: 14)
                    .foregroundStyle(Color.textNeutralBodyBase_333333)
                Text(count)
                    .setTCFont(.regular, size: 12)
                    .foregroundStyle(Color.textNeutralBodyMid_666666)
            }
            Spacer()
            Text(total)
                .setTCFont(.regular, size: 14)
                .foregroundStyle(Color.textNeutralBodyBase_333333)
        }
    }
    
    private func discountRow(icon: String, title: String, content: String, discount: String, titleColor: Color, bgColor: Color, leadingBorderColor: Color) -> some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 4) {
                    Image(icon)
                    Text(title)
                        .setTCFont(.medium, size: 13)
                        .foregroundStyle(titleColor)
                }
                
                Text(content)
                    .setTCFont(.regular, size: 12)
                    .foregroundStyle(Color.textNeutralBodyMid_666666)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 2) {
                Text("總額折扣")
                    .setTCFont(.regular, size: 10)
                    .foregroundStyle(Color.textNeutralBodyMid_666666)
                
                Text(discount)
                    .setTCFont(.medium, size: 14)
                    .foregroundStyle(Color.textMarketOrangeDark_FC4C02)
            }
        }
        .padding(12)
        .background(bgColor, in: RoundedCorner(radius: 2, corners: [.topRight, .bottomRight]))
        .overlay(alignment: .leading) {
            Rectangle()
                .fill(leadingBorderColor)
                .frame(width: 2)
            }
    }
}

#Preview {
    ComboAmountDetailView(showAmountDetail: .constant(false))
}
