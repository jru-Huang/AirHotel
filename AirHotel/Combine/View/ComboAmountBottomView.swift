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
                    .font(AppTypography.T06)
                    .foregroundStyle(AppColor.Text.neutralBodyMid)
                
                HStack(spacing: 4) {
                    Text("$")
                        .font(AppTypography.B05)
                        .foregroundStyle(AppColor.Text.marketOrangeDark)
                    Text("83,880")
                        .font(AppTypography.N03M)
                        .foregroundStyle(AppColor.Text.marketOrangeDark)
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
                        .font(AppTypography.L03R)
                        .foregroundStyle(AppColor.Text.brandPrimaryDark)
                    Image(showAmountDetail == true ? "ic_down_16": "ic_up_16")
                }
                .padding(.bottom, 8)
            }
            .padding(.trailing, 14)
            
            Button {
                print("點擊訂購")
            } label: {
                
                ZStack {
                    AppColor.Surface.brandPrimaryBase
                    
                    Text("訂購")
                        .font(AppTypography.L02M)
                        .foregroundStyle(AppColor.Text.neutralWhite)
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
