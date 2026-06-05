//
//  ComboNavView.swift
//  AirHotel
//
//  Created by 7943 on 2026/5/29.
//

import SwiftUI

struct ComboNavView: View {
    @Binding var isShowedSearchView: Bool
    
    let navInfo: ComboNavInfo
    
    var showSearchView: ((Bool) -> Void)
    
    var body: some View {
        HStack(spacing: 12) {
            Button {
                print("點擊返回")
                
            } label: {
                Image("arrow_back_purple")
                    .frame(maxWidth: 44 ,maxHeight: 44)
            }
            
            Button {
                print("更改搜尋條件")
                isShowedSearchView.toggle()
                showSearchView(isShowedSearchView)
            } label: {
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Text(navInfo.location)
                            .setTCFont(.medium, size: 16)
                            .foregroundStyle(Color.textNeutralBodyBase_333333)
                        Image("ic_search_16")
                    }
                    HStack(spacing: 4) {
                        Text(navInfo.date)
                            .setTCFont(.regular, size: 10)
                            .foregroundStyle(Color.textNeutralBodyBase_333333)
                        Rectangle()
                            .fill(Color.borderNeutralBase_9B9B9B)
                            .frame(width: 0.5, height: 9)
                        Text(navInfo.roomAndPeople)
                            .setTCFont(.regular, size: 10)
                            .foregroundStyle(Color.textNeutralBodyBase_333333)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            
            Button {
                print("點擊收藏")
            } label: {
                Image("ic_love_20")
                    .frame(maxWidth: 44 ,maxHeight: 44)
            }
            
        }
        .background(Color.white)
        .overlay(alignment: .bottom, content: {
            Rectangle()
                .fill(Color.black.opacity(0.1))
                .frame(height: 1)
        })

    }
}

#Preview {
    ComboNavView(isShowedSearchView: .constant(false), navInfo: ComboNavInfo(location: "台北–東京", date: "01/24–01/28", roomAndPeople: "1間房，4大人1小孩"), showSearchView: {_ in print("showSearchView")})
}
