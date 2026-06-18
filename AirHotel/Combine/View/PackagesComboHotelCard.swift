//
//  PackagesComboHotelCard.swift
//  AirHotel
//
//  Created by 7943 on 2026/5/29.
//

import UIKit
import SwiftUI

struct PackagesComboHotelCard: View {
    let info: PackagesComboHotelInfoCard
    var onTouchNotice: (() -> Void)
    
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
            .font(AppTypography.B03)
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
                    Image("Hotel")
                        .scaledToFill()
                    Spacer()
                }
                .clipShape(RoundedRectangle(cornerRadius: 4))
                
                VStack(alignment: .leading, spacing: 2) {
                    
                    TextWithIconView(
                        text: info.hotelName,
                        iconName: "ic_esg_16",
                        numberOfLines: 3
                    )
                    
                    VStack(alignment: .leading, spacing: 6) {
                        if info.hotelSubtitle.isEmpty == false {
                            Text(info.hotelSubtitle)
                                .font(AppTypography.B05)
                                .foregroundStyle(AppColor.Text.neutralBodyMid)
                                .lineLimit(1)
                        }
                        
                        HStack(spacing: 4) {
                            Text(info.overall)
                                .padding(.horizontal, 4)
                                .padding(.bottom, 1)
                                .font(AppTypography.N07M)
                                .foregroundStyle(AppColor.Text.neutralWhite)
                                .background(AppColor.Surface.brandPrimaryBase, in: RoundedCorner(radius: 4, corners: [.topLeft, .bottomRight]))
                            
                            HStack(spacing: 2) {
                                
                                HStack(spacing: 0) {
                                    
                                    let fullStarCount: Int = Int(info.hotelGrade)
                                    ForEach(0..<fullStarCount, id: \.self) { _ in
                                        Image("ic_star_12_all")
                                    }
                                    
                                    if info.hotelGrade > Double(fullStarCount) {
                                        Image("ic_star_12_half")
                                    }
                                }
                                Text(info.starHotel)
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
            print("點擊更換房型-> 飯店詳細頁（ 釘選房型 ）")
        } label: {
            
            VStack(alignment: .leading, spacing: 6) {
                Text("標準雙床房，非吸菸房(View will be selected by the hotel )")
                    .font(AppTypography.B04M)
                    .foregroundStyle(AppColor.Text.neutralBodyBase)
                    .multilineTextAlignment(.leading)
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 2) {
                        Image(info.hasBreakfast == true ? "ic_breakfast_16_breakfast_gray" : "ic_breakfast_16_nobreakfast_gray")
                        Text(info.hasBreakfast == true ? "僅包含大人早餐" : "不包含早餐")
                            .font(AppTypography.B05)
                            .foregroundStyle(AppColor.Text.neutralBodyMid)
                    }
                    
                    HStack(spacing: 0) {
                        Button {
                            print("點擊Booking規則-> 房型取消限制說明")
                            onTouchNotice()
                        } label: {
                            HStack(spacing: 2) {
                                Image(info.bookingRuleKey.imageName)
                                Text(info.bookingRule)
                                    .font(AppTypography.B05)
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

struct TextWithIconView: UIViewRepresentable {
    let text: String
    let iconName: String
    let numberOfLines: Int
    
    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        label.numberOfLines = numberOfLines
        label.lineBreakMode = .byTruncatingTail
        return label
    }
    
    func updateUIView(_ label: UILabel, context: Context) {
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: iconName)
        attachment.bounds = CGRect(x: 0, y: -4, width: 16, height: 16)
        
        let attributedText = NSMutableAttributedString(
            string: text + " ",
            attributes: [
                .font: AppTypography.UI.T03M,
                .foregroundColor: AppColor.UI.Text.neutralBodyBase
            ]
        )
        
        attributedText.append(NSAttributedString(attachment: attachment))
        label.attributedText = attributedText
        label.preferredMaxLayoutWidth = screenWidth - 32 - 24 - 8 - 58
        label.textAlignment = .left
    }
}

#Preview {
    PackagesComboHotelCard(info: PackagesComboHotelInfoCard(
        hotelNotice: "您的去程航班為 01/24 12:05 抵達，請留意入住日、回程航班為 01/28 03:05 出發請留意退房日。",
        checkInOutDate: "01月24日-01月28日 (4晚)",
        hotelName: "JR九州最大五星超高級日本大都五星超高級日本大都五星超高級會酒池袋總店會酒池袋總店啊",
        hotelSubtitle: "HOTEL METROPOLITAN TOKYO IKEBUKUROHOTE HOTEL METROPOLITAN TOKYO IKEBUKUROHOTE",
        overall: "4.3",
        hotelGrade: 3.5,
        starHotel: "4星飯店",
        hasBreakfast: false,
        bookingRuleKey: .Refundable,
        bookingRule: "可免費取消",
        hotelTagList: ["慶祝台灣隊金牌","旅展促銷","限時早鳥優惠","週三狂歡日","慶祝台灣隊金牌2"]), onTouchNotice: {print("房型取消")})
}
