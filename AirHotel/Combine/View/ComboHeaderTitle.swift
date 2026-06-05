//
//  ComboHeaderTitle.swift
//  AirHotel
//
//  Created by 7943 on 2026/5/28.
//

import SwiftUI

struct ComboHeaderTitle: View {
    let title: String
    let titleButton: String
    
    let clickAction: () -> Void
    
    var body: some View {
        HStack {
            Text(title)
                .setTCFont(.medium, size: 16)
                .foregroundStyle(Color.textNeutralBodyBase_333333)
            Spacer()
            Button {
                clickAction()
            } label: {
                Text(titleButton)
                    .setTCFont(.regular, size: 14)
                    .foregroundStyle(Color.textBrandPrimaryDark_84329B)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 12)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.surfaceBrandPrimaryBase_9A56D3, lineWidth: 1)
            )
        }
    }
}

#Preview {
    ComboHeaderTitle(title: "已選航班", titleButton: "更換航班", clickAction: {print("點擊更換航班")})
}
