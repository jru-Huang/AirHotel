//
//  ComboHeader.swift
//  AirHotel
//
//  Created by 7943 on 2026/5/29.
//

import SwiftUI

struct ComboHeader: View {
    var body: some View {
        HStack(spacing: 12) {
            titleLine()
            Text("機加酒精選組合")
                .font(AppTypography.H02)
                .foregroundStyle(AppColor.Text.neutralBodyBase)
            Spacer()
            shareAndFavoriteView
        }
    }
    
    private var shareAndFavoriteView: some View {
        HStack(spacing: 0) {
            Button {
                print("點擊分享")
            } label: {
                HStack(spacing: 2) {
                    Image("ic_share_20")
                    Text("分享")
                        .font(AppTypography.L02R)
                        .foregroundStyle(AppColor.Text.neutralBodyBase)
                }
            }
            .padding(.vertical, 6)
            .padding(.leading, 6)
            .padding(.trailing, 8)
            
            Rectangle()
                .fill(AppColor.Border.neutralSubtle)
                .frame(width: 1)
            
            Button {
                print("點擊收藏")
            } label: {
                HStack(spacing: 2) {
                    Image("ic_heart_20")
                    Text("收藏")
                        .font(AppTypography.L02R)
                        .foregroundStyle(AppColor.Text.neutralBodyBase)
                }
            }
            .padding(.vertical, 6)
            .padding(.leading, 6)
            .padding(.trailing, 8)
        }
        .background(Color.white, in: RoundedRectangle(cornerRadius: 8))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(AppColor.Border.neutralSubtle, lineWidth: 1)
        )
    }
}

#Preview {
    ComboHeader()
}
