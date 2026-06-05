//
//  ComboAmountBottomView.swift
//  AirHotel
//
//  Created by 7943 on 2026/6/3.
//

import SwiftUI

struct ComboAmountBottomView: View {
    @Binding var showAmountDetail: Bool
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text("機＋酒含稅總計")
                    .setTCFont(.regular, size: 10)
                    .foregroundStyle(Color.textNeutralBodyMid_666666)
                
                HStack(spacing: 4) {
                    Text("$")
                        .setTCFont(.regular, size: 12)
                        .foregroundStyle(Color.textMarketOrangeDark_FC4C02)
                    Text("83,880")
                        .setTCFont(.semibold, size: 18)
                        .foregroundStyle(Color.textMarketOrangeDark_FC4C02)
                }
            }
            .padding(.leading, 14)
            
            Spacer()
            
            Button {
                print("點擊售價明細")
                showAmountDetail.toggle()
            } label: {
                HStack(spacing: 4) {
                    Text("售價明細")
                        .setTCFont(.regular, size: 12)
                        .foregroundStyle(Color.textBrandPrimaryDark_84329B)
                    Image(showAmountDetail == true ? "ic_down_16": "ic_up_16")
                }
                .padding(.bottom, 8)
            }
            .padding(.trailing, 14)
            
            Button {
                print("點擊訂購")
            } label: {
                
                ZStack {
                    Color.textBrandPrimaryBase_9A56D3
                    
                    Text("訂購")
                        .setTCFont(.medium, size: 14)
                        .foregroundStyle(.white)
                }
                .frame(width: 108, height: 47)
            }
        }
        .background(Color.white)
        .overlay(alignment: .top, content: {
            Rectangle()
                .fill(Color.black.opacity(0.1))
                .frame(height: 1)
        })

    }
}

#Preview {
    ComboAmountBottomView(showAmountDetail: .constant(true))
}
