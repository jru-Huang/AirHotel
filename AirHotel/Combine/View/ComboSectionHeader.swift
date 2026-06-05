//
//  ComboSectionHeader.swift
//  AirHotel
//
//  Created by 7943 on 2026/5/29.
//

import SwiftUI

struct ComboSectionHeader: View {
    var body: some View {
        HStack(spacing: 12) {
            titleLine()
            Text("機加酒精選組合")
                .setTCFont(.medium, size: 16)
                .foregroundStyle(Color.textNeutralBodyBase_333333)
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
                        .setTCFont(.regular, size: 14)
                        .foregroundStyle(Color.gray700_434343)
                }
            }
            .padding(.vertical, 6)
            .padding(.leading, 6)
            .padding(.trailing, 8)
            
            Rectangle()
                .fill(Color.borderNeutralSubtle_D6D6D6)
                .frame(width: 1)
            
            Button {
                print("點擊收藏")
            } label: {
                HStack(spacing: 2) {
                    Image("ic_heart_20")
                    Text("收藏")
                        .setTCFont(.regular, size: 14)
                        .foregroundStyle(Color.gray700_434343)
                }
            }
            .padding(.vertical, 6)
            .padding(.leading, 6)
            .padding(.trailing, 8)
        }
        .background(Color.white, in: RoundedRectangle(cornerRadius: 8))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.borderNeutralSubtle_D6D6D6, lineWidth: 1)
        )
    }
}

#Preview {
    ComboSectionHeader()
}
