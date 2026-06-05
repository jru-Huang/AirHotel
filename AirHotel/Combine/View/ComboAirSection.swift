//
//  ComboAirSection.swift
//  AirHotel
//
//  Created by 7943 on 2026/5/28.
//

import SwiftUI

struct ComboAirSection: View {
    let info: ComboAirInfoCard
    
    var body: some View {
        VStack(spacing: 12) {
            ComboHeaderTitle(title: "已選航班",
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
    
    private var tagAndLuggageView: some View {
        VStack(spacing: 8) {
            airTagView(tagList: info.airTagList)
            
            Rectangle()
                .fill(Color.borderNeutralExSubtle_E4E4E4)
                .frame(height: 1)
            
            HStack(spacing: 4) {
                Image(info.luggageType.imageName)
                
                Text(info.luggageType.note)
                    .setTCFont(.medium, size: 14)
                    .foregroundStyle(Color.textNeutralBodyMid_666666)
                
                Spacer()
                
                Button {
                    print("點擊行李資訊及票規")
                } label: {
                    Text("行李資訊及票規")
                        .setTCFont(.regular, size: 14)
                        .foregroundStyle(Color.textBrandPrimaryDark_84329B)
                }
            }
        }
    }
    
    private func flightInfo(segment: ComboFlightSegment) -> some View {
        VStack(spacing: 0) {
            
            // tag, date
            HStack(spacing: 8) {
                Text(segment.tag)
                    .setTCFont(.medium, size: 12)
                    .foregroundStyle(Color.white)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 6)
                    .background(Color.surfaceBrandPrimaryBase_9A56D3, in: RoundedCorner(radius: 4, corners: [.bottomLeft, .bottomRight, .topRight]))
                
                Text(segment.date)
                    .setTCFont(.regular, size: 14)
                    .foregroundStyle(Color.textNeutralBodyBase_333333)
                Spacer()
                
                if segment.noticeText.isEmpty == false {
                    HStack(spacing: 1) {
                        Text(segment.noticeText)
                            .setTCFont(.regular, size: 12)
                            .foregroundStyle(Color.surfaceBrandSecondaryBase_00A3E0)
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
                            .stroke(Color.borderBrandPrimaryExSubtle_F8F8FA, lineWidth: 1)
                    )
                
                HStack(spacing: 8) {
                    
                    VStack(spacing: 0) {
                        Text(segment.depTime)
                            .setTCFont(.semibold, size: 18)
                            .foregroundStyle(Color.textNeutralBodyBase_333333)
                        
                        HStack(spacing: 1) {
                            Text(segment.depLocation)
                                .padding(.horizontal, 2)
                                .setTCFont(.medium, size: 10)
                                .foregroundStyle(segment.depLocDiffMark == true ? Color.textNeutralBodyBase_333333 : Color.textNeutralBodyMid_666666)
                                .background(segment.depLocDiffMark == true ? Color.surfaceNeutralMid_D6D6D6 : Color.clear, in: RoundedRectangle(cornerRadius: 2))
                            Text(segment.depTerminal)
                                .setTCFont(.medium, size: 10)
                                .foregroundStyle(Color.textNeutralBodyMid_666666)
                        }
                    }
                    
                    VStack(alignment: .center, spacing: 0) {
                        HStack(spacing: 4) {
                            RoundedRectangle(cornerRadius: 0.5)
                                .fill(Color.borderNeutralSubtle_D6D6D6)
                                .frame(width: 37.5, height: 1)
                            
                            Text(segment.flightTime)
                                .setTCFont(.regular, size: 10)
                                .foregroundStyle(Color.textNeutralBodyMid_666666)
                            
                            RoundedRectangle(cornerRadius: 0.5)
                                .fill(Color.borderNeutralSubtle_D6D6D6)
                                .frame(width: 37.5, height: 1)
                        }
                        
                        Text(segment.transitNote)
                            .setTCFont(.regular, size: 10)
                            .foregroundStyle(
                                segment.transitNote == "直飛" ?
                                Color.textNeutralBodyMid_666666 : Color.textBrandPrimaryBase_9A56D3
                            )
                    }
                    
                    ZStack(alignment: .topTrailing) {
                        VStack(spacing: 0) {
                            Text(segment.arrTime)
                                .setTCFont(.semibold, size: 18)
                                .foregroundStyle(Color.textNeutralBodyBase_333333)
                            
                            HStack(spacing: 1) {
                                Text(segment.arrLocation)
                                    .padding(.horizontal, 2)
                                    .setTCFont(.medium, size: 10)
                                    .foregroundStyle(segment.arrLocDiffMark == true ? Color.textNeutralBodyBase_333333 : Color.textNeutralBodyMid_666666)
                                    .background(segment.arrLocDiffMark == true ? Color.surfaceNeutralMid_D6D6D6 : Color.clear, in: RoundedRectangle(cornerRadius: 2))
                                Text(segment.arrTerminal)
                                    .setTCFont(.medium, size: 10)
                                    .foregroundStyle(Color.textNeutralBodyMid_666666)
                            }
                        }
                        if segment.dateVariation.isEmpty == false {
                            Text(segment.dateVariation)
                                .setTCFont(.medium, size: 10)
                                .foregroundStyle(Color.textBrandSecondaryBase_00A3E0)
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
    
    private func airTagView(tagList: [String]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 4) {
                ForEach(tagList, id: \.self) { tag in
                    Text(tag)
                        .padding(.vertical, 2)
                        .padding(.horizontal, 4)
                        .setTCFont(.medium, size: 12)
                        .foregroundStyle(Color.textMarketOrangeMid_FF8212)
                        .background(Color.surfaceMarketOrangeExSubtle_FFF3E9, in: RoundedRectangle(cornerRadius: 2))
                }
            }
        }
    }
}
#Preview {
    ComboAirSection(info: ComboAirInfoCard(flights: [
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
