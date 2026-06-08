//
//  ComboAirCard.swift
//  AirHotel
//
//  Created by 7943 on 2026/5/28.
//

import SwiftUI

struct ComboAirCard: View {
    let info: ComboAirInfoCard
    
    var body: some View {
        VStack(spacing: 12) {
            ComboCardTitle(title: "已選航班",
                           titleButton: "更換航班",
                           clickAction: {
                print("點擊已選航班")
            })
            flightDetailView
        }
        .padding(12)
        .background(Color.white, in: RoundedRectangle(cornerRadius: 8))
    }
    
    private var flightDetailView: some View {
        VStack(spacing: 4) {
            Button {
                print("點擊航班卡片")
            } label: {
                outAndInboundFlightView
            }
            
            tagAndLuggageView
        }
    }
    
    private var outAndInboundFlightView: some View {
        VStack(spacing: 4) {
            ForEach(info.flights) { flight in
                flightInfo(segment: flight)
            }
        }
    }
    
    private func flightInfo(segment: ComboFlightSegment) -> some View {
        VStack(spacing: 0) {
            
            // tag, date
            HStack(spacing: 8) {
                Text(segment.tag)
                    .font(AppTypography.T05M)
                    .foregroundStyle(AppColor.Text.neutralWhite)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 6)
                    .background(AppColor.Surface.brandPrimaryBase, in: RoundedCorner(radius: 4, corners: [.bottomLeft, .bottomRight, .topRight]))
                
                Text(segment.date)
                    .font(AppTypography.T03M)
                    .foregroundStyle(AppColor.Text.neutralBodyBase)
                Spacer()
                
                if segment.noticeText.isEmpty == false {
                    HStack(spacing: 1) {
                        Text(segment.noticeText)
                            .font(AppTypography.B05)
                            .foregroundStyle(AppColor.Text.brandSecondaryBase)
                        Image("ic_notice_16")
                    }
                    .padding(.trailing, 8)
                }
            }
            .padding(.vertical, 2)
            
            // flight info
            HStack(spacing: 6) {
                Image(segment.imageName)
                    .padding(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(AppColor.Border.brandPrimaryExtraSubtle, lineWidth: 1)
                    )
                
                HStack(spacing: 8) {
                    
                    VStack(spacing: 0) {
                        Text(segment.depTime)
                            .font(AppTypography.N03B)
                            .foregroundStyle(AppColor.Text.neutralBodyBase)
                        
                        HStack(spacing: 1) {
                            Text(segment.depLocation)
                                .padding(.horizontal, 2)
                                .setTCFont(.medium, size: 10) // ??
                                .foregroundStyle(segment.depLocDiffMark == true ? AppColor.Text.neutralBodyBase : AppColor.Text.neutralBodyMid)
                                .background(segment.depLocDiffMark == true ? AppColor.Surface.neutralMid : Color.clear, in: RoundedRectangle(cornerRadius: 2))
                            Text(segment.depTerminal)
                                .setTCFont(.medium, size: 10) // ??
                                .foregroundStyle(AppColor.Text.neutralBodyMid)
                        }
                    }
                    
                    VStack(alignment: .center, spacing: 0) {
                        HStack(spacing: 4) {
                            RoundedRectangle(cornerRadius: 0.5)
                                .fill(AppColor.Border.neutralSubtle)
                                .frame(width: 37.5, height: 1)
                            
                            Text(segment.flightTime)
                                .font(AppTypography.B06R)
                                .foregroundStyle(AppColor.Text.neutralBodyMid)
                            
                            RoundedRectangle(cornerRadius: 0.5)
                                .fill(AppColor.Border.neutralSubtle)
                                .frame(width: 37.5, height: 1)
                        }
                        
                        Text(segment.transitNote)
                            .font(AppTypography.B06R)
                            .foregroundStyle(
                                segment.transitNote == "直飛" ?
                                AppColor.Text.neutralBodyMid : AppColor.Text.brandPrimaryBase
                            )
                    }
                    
                    ZStack(alignment: .topTrailing) {
                        VStack(spacing: 0) {
                            Text(segment.arrTime)
                                .font(AppTypography.N03B)
                                .foregroundStyle(AppColor.Text.neutralBodyBase)
                            
                            HStack(spacing: 1) {
                                Text(segment.arrLocation)
                                    .padding(.horizontal, 2)
                                    .setTCFont(.medium, size: 10) // ??
                                    .foregroundStyle(segment.arrLocDiffMark == true ? AppColor.Text.neutralBodyBase : AppColor.Text.neutralBodyMid)
                                    .background(segment.arrLocDiffMark == true ? AppColor.Surface.neutralMid : Color.clear, in: RoundedRectangle(cornerRadius: 2))
                                Text(segment.arrTerminal)
                                    .setTCFont(.medium, size: 10) // ??
                                    .foregroundStyle(AppColor.Text.neutralBodyMid)
                            }
                        }
                        if segment.dateVariation.isEmpty == false {
                            Text(segment.dateVariation)
                                .font(AppTypography.N07M)
                                .foregroundStyle(AppColor.Text.brandSecondaryBase)
                                .offset(x: 8, y: -5)
                        }
                    }
                }
                .padding(.horizontal, 6)
                .padding(.vertical, 4)
                
                Spacer()
            }
            .padding(.vertical, 8)
        }
    }
    
    private var tagAndLuggageView: some View {
        VStack(spacing: 8) {
            airTagView(tagList: info.airTagList)
            
            Rectangle()
                .fill(AppColor.Border.neutralExtraSubtle)
                .frame(height: 1)
            
            HStack(spacing: 4) {
                Image(info.luggageType.imageName)
                
                Text(info.luggageType.note)
                    .font(AppTypography.T03M)
                    .foregroundStyle(AppColor.Text.neutralBodyMid)
                
                Spacer()
                
                Button {
                    print("點擊行李資訊及票規")
                } label: {
                    Text("行李資訊及票規")
                        .font(AppTypography.L02R)
                        .foregroundStyle(AppColor.Text.brandPrimaryDark)
                }
            }
        }
    }
    
    private func airTagView(tagList: [String]) -> some View {
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
}
#Preview {
    ComboAirCard(info: ComboAirInfoCard(flights: [
        ComboFlightSegment(
            tag: "去程",
            date: "2026年01月24日 週六",
            noticeText: "", //多家航空
            imageName: "ic_logo_BR",
            depTime: "12:05",
            depLocation: "TPE",
            depTerminal: "T1",
            arrTime: "15:30",
            arrLocation: "HND",
            arrTerminal: "T1",
            dateVariation: "",
            flightTime: "3小時25分",
            transitNote: "轉機1次",
            depLocDiffMark: false,
            arrLocDiffMark: true
        ),
        ComboFlightSegment(
            tag: "回程",
            date: "2026年01月28日 週三",
            noticeText: "共享航班",
            imageName: "ic_logo_BR",
            depTime: "03:05",
            depLocation: "NRT",
            depTerminal: "T1",
            arrTime: "06:20",
            arrLocation: "TPE",
            arrTerminal: "T1",
            dateVariation: "+1",
            flightTime: "3小時15分",
            transitNote: "直飛",
            depLocDiffMark: true,
            arrLocDiffMark: false
        )
    ], airTagList: ["慶祝台灣隊金牌", "旅展促銷活動", "新春節團購", "春節快樂", "元宵節"], luggageType: .partial))
}
