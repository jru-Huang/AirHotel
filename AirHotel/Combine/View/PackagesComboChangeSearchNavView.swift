//
//  PackagesComboChangeSearchNavView.swift
//  AirHotel
//
//  Created by 7943 on 2026/6/5.
//

import SwiftUI

struct PackagesComboChangeSearchNavView: View {
    
    let navBarHeight: CGFloat
    
    let onTouchCancel: (() -> Void)
    
    var body: some View {
        ZStack {
            Text("更改條件")
                .font(AppTypography.D03)
                .foregroundStyle(AppColor.Text.neutralBodyBase)
            
            HStack {
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
    PackagesComboChangeSearchNavView(navBarHeight: 44, onTouchCancel: { print("點擊取消")})
}
