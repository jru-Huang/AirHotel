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
                .font(AppTypography.D03)
                .foregroundStyle(AppColor.Text.neutralBodyBase)
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
        .background(AppColor.Surface.neutralWhite, in: RoundedCorner(radius: 8, corners: [.topLeft, .topRight]))
    }
    
    private var contentView: some View {
        VStack(spacing: 8) {
            priceRow(appellation: "大人", price: "$17,200", count: "x4", total: "$68,800")
            priceRow(appellation: "小孩", price: "$17,200", count: "x1", total: "$17,200")
            discountRow(icon: "ic_discount_14",
                        title: "優惠代碼折扣",
                        content: "晚鳥清艙折抵800元",
                        discount: "-$2,000",
                        titleColor: AppColor.Text.marketOrangeBase,
                        bgColor: AppColor.Surface.marketOrangeExtraSubtle,
                        leadingBorderColor: AppColor.Border.marketOrangeSubtle)
            discountRow(icon: "ic_cola_coin_14",
                        title: "可樂旅遊幣折抵",
                        content: "均分於所有旅客",
                        discount: "-$120",
                        titleColor: AppColor.Text.brandPrimaryBase,
                        bgColor: AppColor.Surface.brandPrimaryExtraSubtle,
                        leadingBorderColor: AppColor.Border.brandPrimarySubtle)
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 24)
        .background(AppColor.Surface.neutralWhite)
    }
    
    private func priceRow(appellation: String, price: String, count: String, total: String) -> some View {
        HStack(spacing: 0) {
            HStack(spacing: 4) {
                Text(appellation)
                    .font(AppTypography.T03R)
                    .foregroundStyle(AppColor.Text.neutralBodyBase)
                Text(price)
                    .font(AppTypography.N05R)
                    .foregroundStyle(AppColor.Text.neutralBodyBase)
                Text(count)
                    .font(AppTypography.N06R)
                    .foregroundStyle(AppColor.Text.neutralBodyMid)
            }
            Spacer()
            Text(total)
                .font(AppTypography.N05R)
                .foregroundStyle(AppColor.Text.neutralBodyBase)
        }
    }
    
    private func discountRow(icon: String, title: String, content: String, discount: String, titleColor: Color, bgColor: Color, leadingBorderColor: Color) -> some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 4) {
                    Image(icon)
                    Text(title)
                        .font(AppTypography.T04M)
                        .foregroundStyle(titleColor)
                }
                
                Text(content)
                    .font(AppTypography.B05)
                    .foregroundStyle(AppColor.Text.neutralBodyMid)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 2) {
                Text("總額折扣")
                    .font(AppTypography.B06R)
                    .foregroundStyle(AppColor.Text.neutralBodyMid)
                
                Text(discount)
                    .font(AppTypography.N05M)
                    .foregroundStyle(AppColor.Text.marketOrangeDark)
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
