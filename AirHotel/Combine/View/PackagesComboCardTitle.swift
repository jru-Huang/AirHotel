//
//  PackagesComboCardTitle.swift
//  AirHotel
//
//  Created by 7943 on 2026/5/28.
//

import SwiftUI

struct PackagesComboCardTitle: View {
    let title: String
    let titleButton: String
    
    let clickAction: () -> Void
    
    var body: some View {
        HStack {
            Text(title)
                .font(AppTypography.T02M)
                .foregroundStyle(AppColor.Text.neutralBodyBase)
            Spacer()
            Button {
                clickAction()
            } label: {
                Text(titleButton)
                    .font(AppTypography.L02R)
                    .foregroundStyle(AppColor.Text.brandPrimaryDark)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 12)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(AppColor.Surface.brandPrimaryBase, lineWidth: 1)
            )
        }
    }
}

#Preview {
    PackagesComboCardTitle(title: "已選航班", titleButton: "更換航班", clickAction: {print("點擊更換航班")})
}
