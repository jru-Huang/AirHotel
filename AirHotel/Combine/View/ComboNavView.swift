//
//  ComboNavView.swift
//  AirHotel
//
//  Created by 7943 on 2026/5/29.
//

import SwiftUI

struct ComboNavView: View {
    @Binding var isShowedSearchView: Bool
    
    let navBarHeight: CGFloat
    let navInfo: ComboNavInfo
    
    var showSearchView: ((Bool) -> Void)
    
    var body: some View {
        HStack(spacing: 12) {
            Button {
                print("點擊返回")
                
            } label: {
                Image("arrow_back_purple")
                    .padding(.trailing, 5)
                    .padding(.vertical, 5)
            }
            
            Button {
                print("更改搜尋條件")
                isShowedSearchView.toggle()
                showSearchView(isShowedSearchView)
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
                            .font(AppTypography.T06)
                            .foregroundStyle(AppColor.Text.neutralBodyBase)
                        Rectangle()
                            .fill(AppColor.Border.neutralBase)
                            .frame(width: 0.5, height: 9)
                        Text(navInfo.roomAndPeople)
                            .font(AppTypography.T06)
                            .foregroundStyle(AppColor.Text.neutralBodyBase)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            
            Button {
                print("點擊收藏")
            } label: {
                Image("ic_love_20")
                    .padding(.leading, 5)
                    .padding(.vertical, 5)
            }
            
        }
        .padding(.horizontal, 16)
        .frame(height: navBarHeight)
        .shadow(color: .black.opacity(0.1), radius: 0.5, x: 0, y: 1)
    }
}

#Preview {
    ComboNavView(isShowedSearchView: .constant(false), navBarHeight: 44, navInfo: ComboNavInfo(location: "台北–東京", date: "01/24–01/28", roomAndPeople: "1間房，4大人1小孩"), showSearchView: {_ in print("showSearchView")})
}
