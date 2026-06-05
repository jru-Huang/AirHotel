//
//  ComboDiscountSection.swift
//  AirHotel
//
//  Created by 7943 on 2026/6/1.
//

import SwiftUI
import Combine

struct ComboDiscountSection: View {
    
    @Binding var info: ComboDiscountInfoCard
    
    @State var isLogin: Bool = true
    @State var colaCoinMark: Bool = true
    @State var currentColaCoins: String = "13,727"
    @State var colaCoinRemarkText: String = "每 10 枚可折抵訂單金額 $3"
    @State var colaCoinDiscountText: String = "-$3,636"
    @State var colaCoinDisableDes: String = "您所使用的優惠代碼折扣，可樂旅遊幣無法同時使用折抵，請擇一使用"
    
    var body: some View {
        VStack(spacing: 12) {
            discountView
            dividerView
            colaCoinView
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(Color.white, in: RoundedRectangle(cornerRadius: 8))
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
                        Image("ic_ticket_20")
                        Text("優惠代碼")
                            .setTCFont(.medium, size: 14)
                            .foregroundStyle(Color.textNeutralBodyBase_333333)
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
                                .setTCFont(.regular, size: 12)
                                .foregroundStyle(info.discount.isEmpty == true ? Color.textNeutralBodyLight_9B9B9B : Color.textMarketOrangeDark_FC4C02)
                                .lineLimit(1)
                        }
                        
                        Image("ic_right_12")
                    }
                    .frame(width: (screenWidth - 32) / 2, alignment: .trailing)
                    
                }
            }
            
            if info.discountError.isEmpty == false {
                Text(info.discountError)
                    .setTCFont(.regular, size: 12)
                    .foregroundStyle(Color.textStateError_D6001C)
                    .padding(.leading, 26) //icon 20 + spacing 6
                    .multilineTextAlignment(.leading)
            }
            
        }
    }
    
    private var colaCoinView: some View {
        
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                HStack(spacing: 6) {
                    Image(isLogin == true ? "ic_cola_coin_20_focus" : "ic_cola_coin_20_default")
                    Text("可樂旅遊幣")
                        .setTCFont(.medium, size: 14)
                        .foregroundStyle(isLogin == true ? Color.textNeutralBodyBase_333333 : Color.textStateDisabled_C3C3C3)
                }
                
                Spacer()
                
                HStack(alignment: .center, spacing: 2) {
                    Text("餘額")
                        .setTCFont(.regular, size: 10)
                        .foregroundStyle(Color.textNeutralBodyBase_333333)
                    HStack(alignment: .center, spacing: 0) {
                        Text("600")
                            .setTCFont(.regular, size: 14)
                            .foregroundStyle(Color.textNeutralBodyBase_333333)
                        
                        Text("枚")
                            .setTCFont(.regular, size: 10)
                            .foregroundStyle(Color.textNeutralBodyBase_333333)
                    }
                }
                
                Text(isLogin == true ? (currentColaCoins.isEmpty == true) ? "歡迎多加消費以累積可樂旅遊幣！" : currentColaCoins : "選擇或自行輸入")
                    .setTCFont(.regular, size: 12)
                    .foregroundStyle(Color.textNeutralBodyMid_666666)
                if isLogin == false {
                    Image("ic_right_12")
                }
            }
            //ColaCoin.currentColaCoins == "歡迎多加消費以累積可樂旅遊幣!" 隱藏coinView
            coinView
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
            remarkView
            
            //Price_Detail_List.colaCoinMark == true隱藏
            disableView
        }
        .padding(.leading, 26)
    }
    
    private var inputCoinView: some View {
        Button {
            print("點擊輸入可樂幣")
        } label: {
            HStack(spacing: 10) {
                Text("請輸入欲使用的數量")
                    .setTCFont(.regular, size: 12)
                    .foregroundStyle(Color.textNeutralCaption_C3C3C3)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                Button {
                    print("點擊刪除可樂幣")
                } label: {
                    Image("ic_delete_16")
                }
                
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(Color.surfaceNeutralExSubtle_F8F8F8, in: RoundedRectangle(cornerRadius: 4))
            
        }
    }
    
    private var remarkView: some View {
        HStack {
            Text("折抵訂單金額須 10 枚以上")
                .setTCFont(.regular, size: 12)
                .foregroundStyle(Color.textNeutralBodyLight_9B9B9B)
                .multilineTextAlignment(.leading)
            
            Spacer()
            //清空可樂幣
            HStack(spacing: 2) {
                Text("可折抵")
                    .setTCFont(.regular, size: 12)
                    .foregroundStyle(Color.textNeutralBodyMid_666666)
                
                Text("$1000")
                    .setTCFont(.regular, size: 12)
                    .foregroundStyle(Color.textMarketOrangeDark_FC4C02)
                
                Text("元")
                    .setTCFont(.regular, size: 12)
                    .foregroundStyle(Color.textNeutralBodyMid_666666)
            }
        }
    }
    
    private var disableView: some View {
        Text("您所使用的優惠代碼折扣，可樂旅遊幣無法同時使用折抵，請擇一使用")
            .setTCFont(.regular, size: 12)
            .foregroundStyle(Color.textStateError_D6001C)
            .multilineTextAlignment(.leading)
    }
    
    private var dividerView: some View {
        Rectangle()
            .frame(height: 1)
            .foregroundStyle(Color.borderNeutralExSubtle_E4E4E4)
    }
}

#Preview {
    ComboDiscountSection(info:
            .constant(
                            ComboDiscountInfoCard(discount: "優惠折扣買大送小優惠折扣買大送小優惠折扣買大送小優惠折扣買大送小", discountError: "此優惠代碼已全數兌換完畢。此優惠代碼已全數兌換完畢。此優惠代碼已全數兌換完畢。此優惠代碼已全數兌換完畢。"))
    )
}
