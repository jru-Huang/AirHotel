//
//  PackagesComboHotelCard.swift
//  AirHotel
//
//  Created by 7943 on 2026/5/29.
//

import UIKit
import SwiftUI

struct PackagesComboHotelCard: View {
    let info: PackagesComboHotelInfoModel
    var onTouchBookingRuleDesc: (() -> Void)
    
    var body: some View {
        VStack(spacing: 12) {
            PackagesComboCardTitle(title: "已選住宿", titleButton: "更換住宿", clickAction: {
                print("點擊更換住宿")
            })
            
            hotelDetailView
        }
        .padding(12)
        .background(Color.white, in:  RoundedRectangle(cornerRadius: 8))
    }
    
    private var hotelDetailView: some View {
        VStack(alignment: .leading, spacing: 8) {
            if info.hotelNotice.isEmpty == false {
                noticeView
            }
            dateView
            
            dividerView
            
            hotelTitleView
            VStack(spacing: 4) {
                hotelInfoView
                hotelTagView(tagList: info.hotelTagList)
            }
        }
    }
    
    private var noticeView: some View {
        Text(info.hotelNotice)
            .font(AppTypography.B03R)
            .foregroundStyle(AppColor.Text.marketOrangeDark)
    }
    
    private var dateView: some View {
        HStack(spacing: 8) {
            HStack(spacing: 2) {
                Image("ic_bed_14")
                Text("入住退房日")
                    .font(AppTypography.T04M)
                    .foregroundStyle(AppColor.Text.neutralBodyBase)
            }
            .padding(.vertical, 4)
            .padding(.horizontal, 6)
            .background(AppColor.Surface.brandPrimaryExtraSubtle, in: RoundedRectangle(cornerRadius: 4))
            
            Text(info.checkInOutDate)
                .font(AppTypography.T03M)
                .foregroundStyle(AppColor.Text.neutralBodyBase)
        }
    }
    
    private var hotelTitleView: some View {
        Button {
            print("點擊飯店Title-> 飯店詳細頁")
        } label: {
            
            HStack {
                VStack(spacing: 0) {
                    HomeAdImageViewSwiftUIView(url: info.hotelImg,
                                               width: 58,
                                               height: 58)
                    Spacer(minLength: 0)
                }
                .clipShape(RoundedRectangle(cornerRadius: 4))
                
                VStack(alignment: .leading, spacing: 2) {
                    
                    TextWithIconView(
                        text: info.hotelChineseName,
                        iconName: "ic_esg_16",
                        numberOfLines: 3,
                        showIcon: info.hotelGreenMark
                    )
                    
                    VStack(alignment: .leading, spacing: 6) {
                        
                        if info.hotelEnglishName.isEmpty == false {
                            Text(info.hotelEnglishName)
                                .font(AppTypography.B06M)
                                .foregroundStyle(AppColor.Text.neutralBodyMid)
                                .lineLimit(1)
                        }else {
                            Spacer()
                        }
                        
                        HStack(spacing: 4) {
                            if let hotelRating = info.hotelRating {
                                Text(String(format: "%.1f", hotelRating))
                                    .padding(.horizontal, 4)
                                    .padding(.bottom, 1)
                                    .font(AppTypography.N07M)
                                    .foregroundStyle(AppColor.Text.neutralWhite)
                                    .background(AppColor.Surface.brandPrimaryBase, in: RoundedCorner(radius: 4, corners: [.topLeft, .bottomRight]))
                            }
                            
                            HStack(spacing: 2) {
                                if let hotelGrade = info.hotelGrade {
                                    HStack(spacing: 0) {
                                        
                                        let fullStarCount: Int = Int(hotelGrade)
                                        ForEach(0..<fullStarCount, id: \.self) { _ in
                                            Image("ic_star_12_all")
                                        }
                                        
                                        if hotelGrade > Double(fullStarCount) {
                                            Image("ic_star_12_half")
                                        }
                                    }
                                }
                                
                                Text(info.gradeDesc)
                                    .font(AppTypography.B06R)
                                    .foregroundStyle(AppColor.Text.neutralBodyLight)
                                
                            }
                        }
                    }
                }
            }
        }
    }
    
    private var hotelInfoView: some View {
        
        Button {
            print("點選更換房型卡片(灰色區塊）-> 飯店詳細頁（ 釘選房型 ）")
        } label: {
            
            VStack(alignment: .leading, spacing: 6) {
                Text(info.roomDescription)
                    .font(AppTypography.B04M)
                    .foregroundStyle(AppColor.Text.neutralBodyBase)
                    .multilineTextAlignment(.leading)
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 2) {
                        Image(info.breakfastMark == true ? "ic_breakfast_16_breakfast_gray" : "ic_breakfast_16_nobreakfast_gray")
                        Text(info.breakfastType)
                            .font(AppTypography.B05R)
                            .foregroundStyle(AppColor.Text.neutralBodyMid)
                    }
                    
                    HStack(spacing: 0) {
                        Button {
                            onTouchBookingRuleDesc()
                        } label: {
                            HStack(spacing: 2) {
                                Image(info.guaranteeMark == false ? "ic_check_16" : "ic_cancel_16")
                                Text(info.bookingRule)
                                    .font(AppTypography.B05R)
                                    .foregroundStyle(AppColor.Text.neutralBodyMid)
                                    .overlay(alignment: .bottom) {
                                        GeometryReader { geo in
                                            Path { path in
                                                path.move(to: CGPoint(x: 0, y: 0))
                                                path.addLine(to: CGPoint(x: geo.size.width, y: 0))
                                            }
                                            .stroke(
                                                AppColor.Text.neutralBodyMid,
                                                style: StrokeStyle(
                                                    lineWidth: 1,
                                                    lineCap: .round,
                                                    dash: [0, 3]
                                                )
                                            )
                                        }
                                        .frame(height: 1)
                                        .offset(y: 2)
                                    }
                            }
                        }
                        Spacer()
                        
                        HStack(spacing: 0) {
                            Text("更換房型")
                                .font(AppTypography.L02R)
                                .foregroundStyle(AppColor.Text.neutralBodyBase)
                            Image("ic_right_12")
                        }
                    }
                }
            }
            .padding(8)
            .background(AppColor.Surface.neutralExtraSubtle, in: RoundedRectangle(cornerRadius: 4))
        }
    }
    
    private func hotelTagView(tagList: [String]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 4) {
                ForEach(tagList, id: \.self) { tag in
                    Text(tag)
                        .padding(.vertical, 2)
                        .padding(.horizontal, 4)
                        .font(AppTypography.T05M)
                        .foregroundStyle(AppColor.Text.marketOrangeMid)
                        .background(AppColor.Surface.marketOrangeExtraSubtle, in: RoundedRectangle(cornerRadius: 2))
                }
            }
        }
    }
    
    private var dividerView: some View {
        Rectangle()
            .frame(height: 1)
            .foregroundStyle(AppColor.Border.neutralExtraSubtle)
    }
}

private struct TextWithIconView: View {
    let text: String
    let iconName: String
    let numberOfLines: Int
    let showIcon: Bool
    
    var body: some View {
        inlineText
            .font(AppTypography.T03M)
            .foregroundStyle(AppColor.Text.neutralBodyBase)
            .lineLimit(numberOfLines)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var inlineText: Text {
        var result = Text(text)
        
        if showIcon {
            result = result + Text(" ") + Text(Image(iconName)).baselineOffset(-3)
        }
        
        return result
    }
}

#Preview {
    PackagesComboHotelCard(info: PackagesComboHotelInfoModel(
        hotelNotice: "您的去程航班為 01/24 12:05 抵達，請留意入住日、回程航班為 01/28 03:05 出發請留意退房日。",
        checkInOutDate: "01月24日-01月28日 (4晚)",
        hotelImg: "",
        hotelChineseName: "JR九州最大五星超高級日本大都五星超高級日本大都五星超高級會酒池袋總店會酒池袋總店啊",
        hotelEnglishName: "HOTEL METROPOLITAN TOKYO IKEBUKUROHOTE HOTEL METROPOLITAN TOKYO IKEBUKUROHOTE",
        hotelRating: 4.3,
        hotelGrade: 3.5,
        gradeDesc: "4星飯店",
        roomDescription: "標準雙床房，非吸菸房(View will be selected by the hotel )",
        breakfastMark: false,
        breakfastType: "僅大人早餐",
        guaranteeMark: false,
        bookingRule: "可免費取消",
        hotelTagList: ["慶祝台灣隊金牌","旅展促銷","限時早鳥優惠","週三狂歡日","慶祝台灣隊金牌2"],
        hotelGreenMark: false),
                           onTouchBookingRuleDesc: {print("房型取消")}
    )
}
