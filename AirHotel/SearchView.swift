//
//  SearchView.swift
//  AirHotel
//
//  Created by 7943 on 2026/5/4.
//

import SwiftUI

struct SearchView: View {
    @State private var isChangeCheckInDate: Bool = false
    @State private var isDirectFlightOnly: Bool = false
    
    var body: some View {
        VStack {
            searchCardView
//            .padding(.horizontal, 16)
        }
        .ignoresSafeArea()
        .background(Color.backgroundPagePurple_F8F8F8)
    }
    
    private var searchCardView: some View {
        VStack(spacing: 16) {
            locationRowView
            divider
            
            dateRowView
            changeCheckInDate
            divider
            
            roomAndCabinRow
            divider
            
            directFlightOnlyRow
            
            searchButtonView
        }
        .padding(16)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    private var locationRowView: some View {
        HStack {
            searchInfoButton(title: "出發地",
                       mainValue: "TPE",
                       minorValue: "台北",
                       mainValueFont: (fontThickness: .medium, size: 20),
                       alignment: .leading, action: {
                print("點擊出發地")
            })
            
            Spacer()
            
            searchInfoButton(title: "目的地",
                       mainValue: "",
                       minorValue: "",
                       mainValueFont: (fontThickness: .medium, size: 20),
                       alignment: .trailing, action: {
                print("點擊目的地")
            })
        }
    }
    
    private var dateRowView: some View {
        HStack {
            
            searchInfoButton(title: "出發日",
                       mainValue: "2024/01/24 (六)",
                       mainValueFont: (fontThickness: .regular, size: 14),
                       alignment: .leading, action: {
                print("點擊出發日")
            })
            
            Spacer()
            Button("5日") { }
            .padding(.vertical, 2)
            .padding(.horizontal, 12)
            .foregroundStyle(Color.textNeutralBodyLight_9B9B9B)
            .background(Color.surfaceNeutralSubtle_F2F2F2)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            Spacer()
            
            searchInfoButton(title: "回程日",
                       mainValue: "2024/01/28 (三)",
                       mainValueFont: (fontThickness: .regular, size: 14),
                       alignment: .trailing,
                       action: {
                print("點擊回程日")
            })
        }
    }
    
    private var changeCheckInDate: some View {
        HStack {
            Spacer()
            Button {
                isChangeCheckInDate.toggle()
            } label: {
                HStack(spacing: 6) {
                    Image(isChangeCheckInDate ? "checkbox" : "uncheckbox")
                    Text("調整入住日期")
                        .setTCFont(.regular, size: 14)
                        .foregroundStyle(Color.textNeutralBodyMid_666666)
                }
            }
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 8)
        .frame(maxWidth: .infinity)
        .background(Color.surfaceNeutralExSubtle_F8F8F8)
        .clipShape(RoundedRectangle(cornerRadius: 4))
    }
    
    private var roomAndCabinRow: some View {
        HStack {
            searchInfoButton(title: "房間 / 人數",
                       mainValue: "1間房4大人1小孩",
                       mainValueFont: (fontThickness: .regular, size: 14),
                       alignment: .leading,
                       action: {
                print("點擊房間 / 人數")
            })
            
            Spacer()
            
            searchInfoButton(title: "艙等",
                       mainValue: "不限艙等",
                       mainValueFont: (fontThickness: .regular, size: 14),
                       alignment: .trailing,
                       action: {
                print("點擊艙等")
            })
        }
    }
    
    private var directFlightOnlyRow: some View {
        HStack {
            Spacer()
            Button {
                isDirectFlightOnly.toggle()
            } label: {
                HStack {
                    Image(isDirectFlightOnly ? "checkCircle" : "uncheckCircle")
                    Text("限直飛")
                        .setTCFont(.regular, size: 14)
                        .foregroundStyle(Color.textNeutralSubtitle_B2B2B2)
                }
            }
        }
    }
    
    private var searchButtonView: some View {
        Button {
            print("點擊搜尋")
        } label: {
            Text("搜尋")
                .setTCFont(.medium, size: 14)
                .foregroundStyle(Color.white)
        }
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity)
        .background(Color.surfaceBrandSecondaryBase_00A3E0)
        .clipShape(RoundedRectangle(cornerRadius: 4))
    }
    
    private var divider: some View {
        Divider()
            .overlay(Color.borderNeutralExSubtle_E4E4E4)
    }
}

struct searchInfoButton: View {
    let title: String
    let mainValue: String
    let minorValue: String?
    let mainValueFont: (fontThickness: FontThickness, size: CGFloat)
    let alignment: HorizontalAlignment
    
    let action: () -> Void
    
    init(title: String,
         mainValue: String,
         minorValue: String? = nil,
         mainValueFont: (fontThickness: FontThickness, size: CGFloat),
         alignment: HorizontalAlignment,
         action: @escaping () -> Void) {
        self.title = title
        self.mainValue = mainValue
        self.minorValue = minorValue
        self.mainValueFont = mainValueFont
        self.alignment = alignment
        self.action = action
    }
    
    var body: some View {
        Button {
            print("點擊\(title)")
            action()
        } label: {
            VStack(alignment: alignment) {
                Text(title)
                    .setTCFont(.regular, size: 12)
                    .foregroundStyle(Color.textNeutralSubtitle_B2B2B2)
                Text(mainValue)
                    .setTCFont(mainValueFont.fontThickness, size: mainValueFont.size)
                    .foregroundStyle(Color.textNeutralBodyBase_333333)
                
                if let minorValue {
                    Text(minorValue)
                        .setTCFont(.regular, size: 12)
                        .foregroundStyle(Color.textNeutralBodyBase_333333)
                }
            }
            .background(Color.orange)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    SearchView()
}
