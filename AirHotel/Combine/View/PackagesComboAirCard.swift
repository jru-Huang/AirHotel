//
//  PackagesComboAirCard.swift
//  AirHotel
//
//  Created by 7943 on 2026/5/28.
//

import SwiftUI

struct PackagesComboAirCard: View {
    let info: PackagesComboAirInfoModel
    
    var onTouchCard: (()->Void)
    var body: some View {
        VStack(spacing: 12) {
            PackagesComboCardTitle(title: "已選航班",
                           titleButton: "更換航班",
                           clickAction: {
                print("點擊更換航班")
            })
            flightDetailView
        }
        .padding(12)
        .background(Color.white, in: RoundedRectangle(cornerRadius: 8))
    }
    
    private var flightDetailView: some View {
        VStack(spacing: 4) {
            Button {
                onTouchCard()
            } label: {
                depAndReturnFlightView
            }
            
            tagAndLuggageView
        }
    }
    
    private var depAndReturnFlightView: some View {
        VStack(spacing: 4) {
            ForEach(info.segmentInfoList) { segmentInfo in
                flightInfo(segment: segmentInfo)
            }
        }
    }
    
    private func flightInfo(segment: PackagesComboSegmentInfoModel) -> some View {
        VStack(spacing: 0) {
            
            // tag, date
            HStack(spacing: 8) {
                Text(segment.type)
                    .font(AppTypography.T05M)
                    .foregroundStyle(AppColor.Text.neutralWhite)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 6)
                    .background(AppColor.Surface.brandPrimaryBase, in: RoundedCorner(radius: 4, corners: [.bottomLeft, .bottomRight, .topRight]))
                
                Text(segment.date)
                    .font(AppTypography.T03M)
                    .foregroundStyle(AppColor.Text.neutralBodyBase)
                Spacer()
                
                if segment.carrierNoticeText.isEmpty == false {
                    HStack(spacing: 1) {
                        Text(segment.carrierNoticeText)
                            .font(AppTypography.B05R)
                            .foregroundStyle(AppColor.Text.brandSecondaryBase)
                        Image("ic_notice_16")
                    }
                    .padding(.trailing, 8)
                }
            }
            .padding(.vertical, 2)
            
            // flight info
            HStack(spacing: 6) {
                // jru:多家＆共享航空 icon: ic_flight_28
                carrierLogoView(url: segment.carrierLogo, ticketingCarrier: segment.ticketingCarrier)
                    .frame(width: 40, height: 40, alignment: .center)
                    .background(segment.carrierLogo.isEmpty == true ? AppColor.Surface.neutralExtraSubtle : AppColor.Surface.neutralWhite, in: RoundedRectangle(cornerRadius: 4))
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(AppColor.Border.brandPrimaryExtraSubtle, lineWidth: 1)
                    )
                
                HStack(spacing: 8) {
                    // Departure
                    VStack(spacing: 0) {
                        Text(segment.depTime)
                            .font(AppTypography.N03B)
                            .foregroundStyle(AppColor.Text.neutralBodyBase)
                        
                        HStack(spacing: 1) {
                            Text(segment.depLocation)
                                .padding(.horizontal, 2)
                                .font(AppTypography.B06M)
                                .foregroundStyle(segment.isDepLocHighlight == true ? AppColor.Text.neutralBodyBase : AppColor.Text.neutralBodyMid)
                                .background(segment.isDepLocHighlight == true ? AppColor.Surface.neutralMid : Color.clear, in: RoundedRectangle(cornerRadius: 2))
                            Text(segment.depTerminal)
                                .font(AppTypography.B06M)
                                .foregroundStyle(AppColor.Text.neutralBodyMid)
                        }
                    }
                    
                    VStack(alignment: .center, spacing: 0) {
                        HStack(spacing: 4) {
                            RoundedRectangle(cornerRadius: 0.5)
                                .fill(AppColor.Border.neutralSubtle)
                                .frame(height: 1)
                            
                            Text(segment.segmentTimeDesc)
                                .font(AppTypography.B06R)
                                .foregroundStyle(AppColor.Text.neutralBodyMid)
                                .fixedSize()
                            
                            RoundedRectangle(cornerRadius: 0.5)
                                .fill(AppColor.Border.neutralSubtle)
                                .frame(height: 1)
                        }
                        
                        Text(segment.transitCountDesc)
                            .font(AppTypography.B06R)
                            .foregroundStyle(
                                segment.transitCountDesc == "直飛" ?
                                AppColor.Text.neutralBodyMid : AppColor.Text.brandPrimaryBase
                            )
                    }
                    
                    // Arrival
                    ZStack(alignment: .topTrailing) {
                        VStack(spacing: 0) {
                            Text(segment.arrTime)
                                .font(AppTypography.N03B)
                                .foregroundStyle(AppColor.Text.neutralBodyBase)
                            
                            HStack(spacing: 1) {
                                Text(segment.arrLocation)
                                    .padding(.horizontal, 2)
                                    .font(AppTypography.B06M)
                                    .foregroundStyle(segment.isArrLocHighlight == true ? AppColor.Text.neutralBodyBase : AppColor.Text.neutralBodyMid)
                                    .background(segment.isArrLocHighlight == true ?  AppColor.Surface.neutralMid : Color.clear, in: RoundedRectangle(cornerRadius: 2))
                                Text(segment.arrTerminal)
                                    .font(AppTypography.B06M)
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
    
    private func carrierLogoView(url: String, ticketingCarrier: String) -> some View {
        return AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .padding(6)
            case .empty, .failure:
                Text(ticketingCarrier)
                    .font(AppTypography.H01)
                    .foregroundStyle(AppColor.Text.neutralBodyLight)
                    .padding(6)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            default:
                Image("ic_flight_28")
                    .padding(6)
            }
        }
    }
}

#Preview {
    PackagesComboAirCard(info: PackagesComboAirInfoModel(segmentInfoList: [
        PackagesComboSegmentInfoModel(
            type: "去程",
            date: "2026年01月24日 週六",
            carrierNoticeText: "", //多家航空
            carrierLogo: "ic_logo_BR",
            ticketingCarrier: "BR",
            depTime: "12:05",
            depLocation: "TPE",
            depTerminal: "T1",
            arrTime: "15:30",
            arrLocation: "HND",
            arrTerminal: "T1",
            dateVariation: "",
            segmentTimeDesc: "3小時25分",
            transitCountDesc: "轉機1次",
            isDepLocHighlight: false,
            isArrLocHighlight: true
        ),
        PackagesComboSegmentInfoModel(
            type: "回程",
            date: "2026年01月28日 週三",
            carrierNoticeText: "共享航班",
            carrierLogo: "ic_logo_BR",
            ticketingCarrier: "BR",
            depTime: "03:05",
            depLocation: "NRT",
            depTerminal: "T1",
            arrTime: "06:20",
            arrLocation: "TPE",
            arrTerminal: "T1",
            dateVariation: "+1",
            segmentTimeDesc: "3小時15分",
            transitCountDesc: "直飛",
            isDepLocHighlight: true,
            isArrLocHighlight: false
        )
    ], airTagList: ["慶祝台灣隊金牌", "旅展促銷活動", "新春節團購", "春節快樂", "元宵節"], luggageType: .partial), onTouchCard: {})
}
