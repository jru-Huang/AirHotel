//
//  ComboChangeSearchNavView.swift
//  AirHotel
//
//  Created by 7943 on 2026/6/5.
//

import SwiftUI

struct ComboChangeSearchNavView: View {
    
    let navBarHeight: CGFloat
    var onTouchBack: (() -> Void)
    var onTouchCancel: (() -> Void)
    
    var body: some View {
        ZStack {
            Text("更改條件")
                .font(AppTypography.D03)
                .foregroundStyle(AppColor.Text.neutralBodyBase)
            
            HStack {
                Button {
                    onTouchBack()
                } label: {
                    Image("arrow_back_purple")
                }
                .padding(.trailing, 5)
                .padding(.vertical, 5)
                
                Spacer()
                Button {
                    onTouchCancel()
                } label: {
                    Text("取消")
                        .padding(.leading, 5)
                        .padding(.vertical, 5)
                        .font(AppTypography.L02R)
                        .foregroundStyle(AppColor.Text.brandPrimaryDark)
                }
            }
            .padding(.horizontal, 16)
        }
        .frame(height: navBarHeight)
        .background(AppColor.Surface.neutralWhite)
        .shadow(color: .black.opacity(0.1), radius: 0.5, x: 0, y: 1)
    }
}

#Preview {
    ComboChangeSearchNavView(navBarHeight: 44, onTouchBack: {print("點擊返回P0")}, onTouchCancel: { print("點擊取消")})
}
