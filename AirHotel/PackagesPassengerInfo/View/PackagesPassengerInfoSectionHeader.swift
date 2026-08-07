//
//  PackagesPassengerInfoSectionHeader.swift
//  AirHotel
//
//  Created by 7943 on 2026/8/7.
//

import SwiftUI

struct PackagesPassengerInfoSectionHeader: View {
    
    var title: String
    
    var body: some View {
        HStack(spacing: 8) {
            titleLine()
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(AppColor.Surface.neutralWhite)
    }
}

#Preview {
    PackagesPassengerInfoSectionHeader(title: "訂購人資料")
}
