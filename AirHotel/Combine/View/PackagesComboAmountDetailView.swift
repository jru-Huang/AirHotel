//
//  PackagesComboAmountDetailView.swift
//  AirHotel
//
//  Created by 7943 on 2026/6/3.
//

import SwiftUI

struct PackagesComboAmountDetailView: View {
    
    @Binding var showAmountDetail: Bool
    
    let info: PackagesComboAmountInfo
    
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
            setDetailInfo()
            setDiscountInfo()
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 24)
        .background(AppColor.Surface.neutralWhite)
    }
    
    private func setDetailInfo() -> some View {
        ForEach(info.detailInfo) {
            detailInfo in
            priceRow(appellation: detailInfo.appellation,
                     pricePrePerson: detailInfo.pricePrePerson,
                     numberOfPeople: detailInfo.numberOfPeople,
                     totalPrice: detailInfo.totalPrice)
        }
    }
    
    private func setDiscountInfo() -> some View {
        ForEach(info.discountInfo) { discountInfo in
            let isDiscount = discountInfo.isDiscount == true
            discountRow(icon: isDiscount ? "ic_discount_14" : "ic_cola_coin_14",
                        title: discountInfo.title,
                        content: discountInfo.content,
                        discount: discountInfo.discount,
                        titleColor: isDiscount ? AppColor.Text.marketOrangeBase : AppColor.Text.brandPrimaryBase,
                        bgColor: isDiscount ? AppColor.Surface.marketOrangeExtraSubtle : AppColor.Surface.brandPrimaryExtraSubtle,
                        leadingBorderColor: isDiscount ? AppColor.Border.marketOrangeSubtle : AppColor.Border.brandPrimarySubtle)
            
        }
    }
    
    private func priceRow(appellation: String, pricePrePerson: String, numberOfPeople: String, totalPrice: String) -> some View {
        HStack(spacing: 0) {
            HStack(spacing: 4) {
                Text(appellation)
                    .font(AppTypography.T03R)
                    .foregroundStyle(AppColor.Text.neutralBodyBase)
                Text(pricePrePerson)
                    .font(AppTypography.N05R)
                    .foregroundStyle(AppColor.Text.neutralBodyBase)
                Text(numberOfPeople)
                    .font(AppTypography.N06R)
                    .foregroundStyle(AppColor.Text.neutralBodyMid)
            }
            Spacer()
            Text(totalPrice)
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
                    .font(AppTypography.B05R)
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
    PackagesComboAmountDetailView(showAmountDetail: .constant(false), info: PackagesComboAmountInfo(
        detailInfo: [
            PackagesComboAmountDetailInfo(appellation: "大人",
                                  pricePrePerson: "$17,200",
                                  numberOfPeople: "x4",
                                  totalPrice: "$68,800"),
            PackagesComboAmountDetailInfo(appellation: "小孩",
                                  pricePrePerson: "$17,200",
                                  numberOfPeople: "x1",
                                  totalPrice: "$17,200")
        ], discountInfo: [
            PackagesComboAmountDiscountInfo(isDiscount: true,
                                    title: "優惠代碼折扣",
                                    content: "晚鳥清艙折抵800元",
                                    discount: "-$2,000"),
            PackagesComboAmountDiscountInfo(isDiscount: false,
                                    title: "可樂旅遊幣折抵",
                                    content: "均分於所有旅客",
                                    discount: "-$120")
        ]))
}
