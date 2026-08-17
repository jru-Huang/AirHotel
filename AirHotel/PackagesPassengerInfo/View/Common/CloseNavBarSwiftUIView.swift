//
//  CloseNavBarSwiftUIView.swift
//  AirHotel
//
//  Created by 7943 on 2026/8/14.
//

import SwiftUI

struct CloseNavBarSwiftUIView: View {
    
    let title: String
    var dismiss: ()->Void
    
    var body: some View {
        ZStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image("ic_close_20")
                }
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            
            Text(title)
                .font(AppTypography.D03)
                .foregroundStyle(AppColor.Text.neutralBodyBase)
        }
        .background(AppColor.Surface.neutralWhite)
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(AppColor.Border.neutralExtraSubtle)
                .frame(height: 1)
        }
    }
}

#Preview {
    CloseNavBarSwiftUIView(title: "標題", dismiss: {print("關閉")})
}
