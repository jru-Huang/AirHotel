//
//  PackagesComboNavView.swift
//  AirHotel
//
//  Created by 7943 on 2026/5/29.
//

import SwiftUI

struct PackagesComboNavView: View {
    
    let navBarHeight: CGFloat
    let navInfo: PackagesComboNavInfo?
    
    let onTouchBack: () -> Void
    let onTouchSearch: () -> Void
    let onTouchTrace: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            Button {
                onTouchBack()
                
            } label: {
                Image("arrow_back_purple")
                    .padding(.trailing, 5)
                    .padding(.vertical, 5)
            }
            
            navBarView
            
            Button {
                onTouchTrace()
            } label: {
                Image("ic_love_20")
                    .padding(.leading, 5)
                    .padding(.vertical, 5)
            }
            
        }
        .padding(.horizontal, 16)
        .frame(height: navBarHeight)
        .background(AppColor.Surface.neutralWhite)
        .shadow(color: .black.opacity(0.1), radius: 0.5, x: 0, y: 1)
    }
    
    @ViewBuilder
    private var navBarView: some View {
        if let navInfo {
            Button {
                onTouchSearch()
            } label: {
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Text(navInfo.location)
                            .font(AppTypography.D03)
                            .foregroundStyle(AppColor.Text.neutralBodyBase)
                        Image("ic_search_16")
                    }
                    HStack(spacing: 4) {
                        Text(navInfo.date)
                            .font(AppTypography.T06R)
                            .foregroundStyle(AppColor.Text.neutralBodyBase)
                        Rectangle()
                            .fill(AppColor.Border.neutralBase)
                            .frame(width: 0.5, height: 9)
                        Text(navInfo.roomAndPeople)
                            .font(AppTypography.T06R)
                            .foregroundStyle(AppColor.Text.neutralBodyBase)
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }else {
            Spacer()
        }
    }
}

#Preview {
    PackagesComboNavView(navBarHeight: 44, navInfo: PackagesComboNavInfo(location: "台北–東京", date: "01/24–01/28", roomAndPeople: "1間房，4大人1小孩"), onTouchBack: {}, onTouchSearch: {}, onTouchTrace: {})
}
