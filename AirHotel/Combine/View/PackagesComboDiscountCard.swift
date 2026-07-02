//
//  PackagesComboDiscountCard.swift
//  AirHotel
//
//  Created by 7943 on 2026/6/1.
//

import SwiftUI
import Combine

struct PackagesComboDiscountCard: View {
    
    @Binding var info: PackagesComboDiscountInfoCard
    
    @State var isLogin: Bool = true
    @State var colaCoinMark: Bool = true
    @State var currentColaCoins: String = "13,727" //"歡迎多加消費以累積可樂旅遊幣！"
    @State var colaCoinRemarkText: String = "每 10 枚可折抵訂單金額 $2"
    @State var colaCoinDiscountText: String = "-$3,636"
    @State var colaCoinDisableDes: String = "您所使用的優惠代碼折扣，可樂旅遊幣無法同時使用折抵，請擇一使用"
    @State var inputCoinText: String = "使用5,000枚，均分於所有旅客" //"請輸入欲使用的數量"
    
    var body: some View {
        VStack(spacing: 12) {
            discountView
            dividerView
            colaCoinView
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(AppColor.Surface.neutralWhite, in: RoundedRectangle(cornerRadius: 8))
    }
    
    private var discountView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Button {
                print("點擊優惠代碼")
                info.discount = ""
                info.discountError = ""
            } label: {
                HStack(spacing: 0) {
                    
                    HStack(alignment: .top, spacing: 6) {
                        Image("ic_discount_ticket_20")
                        Text("優惠代碼")
                            .font(AppTypography.T03M)
                            .foregroundStyle(AppColor.Text.neutralBodyBase)
                    }
                    
                    Spacer(minLength: 12)
                    
                    HStack(spacing: 4) {
                        HStack(spacing: 6) {
                            if info.discount.isEmpty == false {
                                Button {
                                    print("刪除優惠代碼")
                                    info.discount = ""
                                } label: {
                                    Image("ic_delete_16")
                                        .frame(width: 25, height: 25)
                                }
                            }
                            
                            Text(info.discount.isEmpty == true ? "選擇或自行輸入" : info.discount)
                                .font(AppTypography.T05R)
                                .foregroundStyle(info.discount.isEmpty == true ? AppColor.Text.neutralBodyLight : AppColor.Text.marketOrangeDark)
                                .lineLimit(1)
                        }
                        
                        Image("ic_right_12")
                    }
                    .frame(width: (screenWidth - 32) / 2, alignment: .trailing)
                    
                }
            }
            
            if info.discountError.isEmpty == false {
                Text(info.discountError)
                    .font(AppTypography.B05R)
                    .foregroundStyle(AppColor.Text.stateError)
                    .padding(.leading, 26) //icon 20 + spacing 6
                    .multilineTextAlignment(.leading)
            }
            
        }
    }
    
    private var colaCoinView: some View {
        
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                HStack(spacing: 6) {
                    Image(isLogin == true ? "ic_cola_coin_focus_20" : "ic_cola_coin_default_20")
                    Text("可樂旅遊幣")
                        .font(AppTypography.T03M)
                        .foregroundStyle(isLogin == true ? AppColor.Text.neutralBodyBase : AppColor.Text.stateDisabled)
                }
                
                Spacer()
                
                if currentColaCoins.isEmpty == false {
                    HStack(alignment: .center, spacing: 2) {
                        Text("餘額")
                            .font(AppTypography.B06R)
                            .foregroundStyle(AppColor.Text.neutralBodyBase)
                        HStack(alignment: .center, spacing: 0) {
                            Text(currentColaCoins)
                                .font(AppTypography.N05R)
                                .foregroundStyle(AppColor.Text.neutralBodyBase)
                            
                            Text("枚")
                                .font(AppTypography.B06R)
                                .foregroundStyle(AppColor.Text.neutralBodyBase)
                        }
                    }
                }
                
                Text(isLogin == false ? "選擇或自行輸入" : currentColaCoins)
                    .font(AppTypography.T05R)
                    .foregroundStyle(currentColaCoins == "選擇或自行輸入" ? AppColor.Text.neutralBodyLight : AppColor.Text.neutralBodyMid)
                if isLogin == false {
                    Image("ic_right_12")
                }
            }
            //ColaCoin.currentColaCoins == "歡迎多加消費以累積可樂旅遊幣!" 隱藏coinView
            if !(currentColaCoins == "歡迎多加消費以累積可樂旅遊幣!") {
                coinView
            }
        }
        
    }
    
    private var coinView: some View {
        VStack(alignment: .leading, spacing: 4) {
            //ColaCoin.useCoinMark == false隱藏
            Button {
                print("點擊可樂旅遊幣")
            } label: {
                inputCoinView
            }
            
            //ColaCoin.currentColaCoins == "" 隱藏remarkView
            if !(currentColaCoins == "") {
                remarkView
            }
            
            //Price_Detail_List.colaCoinMark == true隱藏
            if colaCoinMark {
                disableView
            }
        }
        .padding(.leading, 26)
    }
    
    private var inputCoinView: some View {
        Button {
            print("點擊輸入可樂幣")
        } label: {
            HStack(spacing: 10) {
                Text(inputCoinText)
                    .font(AppTypography.B05R)
                    .foregroundStyle(inputCoinText == "請輸入欲使用的數量" ? AppColor.Text.neutralCaption : AppColor.Text.neutralBodyBase)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                Button {
                    print("點擊刪除可樂幣")
                    inputCoinText = "請輸入欲使用的數量"
                } label: {
                    Image("ic_delete_16")
                }
                
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(AppColor.Surface.neutralExtraSubtle, in: RoundedRectangle(cornerRadius: 4))
            
        }
    }
    
    private var remarkView: some View {
        HStack {
            Text(colaCoinRemarkText)
                .font(AppTypography.B05R)
                .foregroundStyle(AppColor.Text.neutralBodyLight)
                .multilineTextAlignment(.leading)
            
            Spacer()
            //清空可樂幣
            HStack(spacing: 2) {
                Text("可折抵")
                    .font(AppTypography.B05R)
                    .foregroundStyle(AppColor.Text.neutralBodyMid)
                
                Text("$1000")
                    .font(AppTypography.N06R)
                    .foregroundStyle(AppColor.Text.marketOrangeDark)
                
                Text("元")
                    .font(AppTypography.B05R)
                    .foregroundStyle(AppColor.Text.neutralBodyMid)
            }
        }
    }
    
    private var disableView: some View {
        Text(colaCoinDisableDes)
            .font(AppTypography.B05R)
            .foregroundStyle(AppColor.Text.stateError)
            .multilineTextAlignment(.leading)
    }
    
    private var dividerView: some View {
        Rectangle()
            .frame(height: 1)
            .foregroundStyle(AppColor.Border.neutralExtraSubtle)
    }
}

#Preview {
    PackagesComboDiscountCard(info:
            .constant(
                PackagesComboDiscountInfoCard(discount: "優惠折扣買大送小優惠折扣買大送小優惠折扣買大送小優惠折扣買大送小", discountError: "此優惠代碼已全數兌換完畢。此優惠代碼已全數兌換完畢。此優惠代碼已全數兌換完畢。此優惠代碼已全數兌換完畢。"))
    )
}
