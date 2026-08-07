//
//  PackagesPassengerInfoView.swift
//  AirHotel
//
//  Created by 7943 on 2026/8/6.
//

import SwiftUI

struct PackagesPassengerInfoView: View {
    
    @StateObject var viewModel: PackagesPassengerInfoViewModel
    
    private var hasNotice: Bool {
        return viewModel.lineNotice != nil || viewModel.systemNotice != nil
    }
    
    var body: some View {
        VStack(spacing: 0) {
            noticeTimeLimitView
            
            if hasNotice {
                noticeView
            }
            
            VStack(spacing: 8) {
                airCard
                hotelCard
                baggageFareRule
            }
            .padding(.top, 8)
            .padding(.bottom, 12)
            .padding(.horizontal, 12)
        }
        .onAppear(perform: viewModel.onViewAppear)
        .background(AppColor.Background.pageGray)
    }
    
    private var noticeView: some View {
        VStack(spacing: 0) {
            if let lineNotice = viewModel.lineNotice {
                PackagesDynamicBundleSystemNoticeView(systemNoticeConfig: lineNotice.config, onTouchNotice: {
                    print("LINE PAY導購（ 待後續聯盟行銷）")
                })
            }
            
            if let systemNotice = viewModel.systemNotice {
                PackagesDynamicBundleSystemNoticeView(systemNoticeConfig: systemNotice.config, onTouchNotice: {
                    if let detailInfo = systemNotice.detailInfo {
                        viewModel.presentNoticeInfo(detailInfo)
                    }
                })
            }
            
        }
    }
    
    // MARK: 時效
    private var noticeTimeLimitView: some View {
        HStack(spacing: 6) {
            noticeTitle
            noticeTime
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 12)
        .background(
            Rectangle()
                .foregroundColor(.clear)
                .background(
                    LinearGradient(
                        stops: [
                            Gradient.Stop(color: Color(red: 0.63, green: 0.37, blue: 0.85), location: 0.00),
                            Gradient.Stop(color: Color(red: 0.71, green: 0.6, blue: 1), location: 1.00),
                        ],
                        startPoint: UnitPoint(x: 0, y: 0.5),
                        endPoint: UnitPoint(x: 1, y: 0.5)
                    )
                )
        )
    }
    
    private var noticeTitle: some View {
        HStack(spacing: 4) {
            Image("ic_countdown_20_white") //jru:專案icon改名
            Text("請在 15 分鐘內填寫並送出訂單")
                .font(AppTypography.B04M)
                .foregroundStyle(AppColor.Text.neutralWhite)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var noticeTime: some View {
        let components = "14:59".split(separator: ":")

        return HStack(spacing: 2) {
            timeItem(String(components[0]))

            Text(":")
                .font(AppTypography.N06M)
                .foregroundStyle(AppColor.Text.neutralWhite)

            timeItem(String(components[1]))
        }
    }
    
    private func timeItem(_ value: String) -> some View {
        Text(value)
            .font(AppTypography.N06M)
            .foregroundStyle(AppColor.Text.neutralWhite)
            .padding(.vertical, 2)
            .padding(.horizontal, 6)
            .background(
                AppColor.Surface.opacityWhiteBase,
                in: RoundedRectangle(cornerRadius: 4)
            )
    }
    
    // MARK: 航班
    private var airCard: some View {
        Button {
            print("點選航班資訊")
        } label: {
            VStack(alignment: .leading, spacing: 4) {
                airDestination
                airDetail
            }
            .padding(.top, 8)
            .padding(.bottom, 12)
            .background(AppColor.Surface.neutralWhite)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
    
    private var airDestination: some View {
        HStack(spacing: 8) {
            HStack(spacing: 2) {
                Text("台北")
                    .font(AppTypography.T03M)
                    .foregroundStyle(AppColor.Text.neutralBodyBase)
                Image("ic_line_16")
                Text("東京")
                    .font(AppTypography.T03M)
                    .foregroundStyle(AppColor.Text.neutralBodyBase)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
           rightArrow("航班資訊")
        }
        .padding(.horizontal, 12)
    }
    
    private var airDetail: some View {
        VStack(spacing: 4) {
            depSegmentView
            returnSegmentView
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppColor.Surface.neutralExtraSubtle, in: RoundedRectangle(cornerRadius: 4))
        .padding(.horizontal, 12)
    }
    
    private func rightArrow(_ text: String)-> some View {
        HStack(spacing: 0) {
            Text(text)
                .font(AppTypography.L03M)
                .foregroundStyle(AppColor.Text.brandPrimaryMid)
            Image("ic_right_14_purple") //jru:專案icon改名
        }
    }
    
    private var depSegmentView: some View {
        HStack(alignment: .center,spacing: 8) {
            airSegmentType(text: "去程")
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 4) {
                    Group {
                        Text("2026年01月24日")
                        Text("週六")
                        Text("12:05")
                    }
                    .font(AppTypography.T03M)
                    .foregroundStyle(AppColor.Text.neutralBodyBase)
                }
                
                HStack(spacing: 2) {
                    Group {
                        Text("桃園機場")
                        Text("T1")
                        Text("-")
                        Text("東京羽田機場")
                        Text("T2")
                    }
                    .font(AppTypography.B05R)
                    .foregroundStyle(AppColor.Text.neutralBodyMid)
                }
            }
        }
    }
    
    private var returnSegmentView: some View {
        HStack(alignment: .center,spacing: 8) {
            airSegmentType(text: "回程")
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 4) {
                    Group {
                        Text("2026年01月24日")
                        Text("週六")
                        Text("12:05")
                    }
                    .font(AppTypography.T03M)
                    .foregroundStyle(AppColor.Text.neutralBodyBase)
                }
                
                HStack(spacing: 2) {
                    Group {
                        Text("東京羽田機場")
                        Text("T2")
                        Text("-")
                        Text("桃園機場")
                        Text("T1")
                    }
                    .font(AppTypography.B05R)
                    .foregroundStyle(AppColor.Text.neutralBodyMid)
                }
            }
        }
    }
    
    private func airSegmentType(text: String) -> some View {
        Text(text)
            .font(AppTypography.T05M)
            .foregroundStyle(AppColor.Text.neutralBodyMid)
            .padding(.vertical, 2)
            .padding(.horizontal, 6)
            .overlay(
            RoundedRectangle(cornerRadius: 2)
            .inset(by: 0.5)
            .stroke(AppColor.Border.neutralMid, lineWidth: 1)
            )
    }
    
    // MARK: 飯店
    private var hotelCard: some View {
        Button {
            print("點選入住資訊")
        } label: {
            VStack(alignment: .leading, spacing: 4) {
                hotelName
                hotelDetail
            }
            .padding(.top, 8)
            .padding(.bottom, 12)
            .background(AppColor.Surface.neutralWhite)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        
    }
    
    private var hotelName: some View {
        HStack(spacing: 8) {
            Text("JR九州最大五星超高級日本大都會酒")
                .font(AppTypography.T03M)
                .foregroundStyle(AppColor.Text.neutralBodyBase)
                .frame(maxWidth: .infinity, alignment: .leading)
            rightArrow("入住資訊")
        }
        .padding(.horizontal, 12)
    }
    
    private var hotelDetail: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 4) {
                Image("ic_bed_14_gray")
                HStack(spacing: 2) {
                    Group {
                        Text("入住")
                        Text("09/12 (二)")
                        Text("-")
                        Text("退房")
                        Text("09/28 (二)")
                    }
                    .font(AppTypography.T05M) //????
                    .foregroundStyle(AppColor.Text.neutralBodyMid)//???
                }
            }
            
            Text("標準雙床房，非吸菸房")
                .font(AppTypography.B04M)
                .foregroundStyle(AppColor.Text.neutralBodyBase)
                .padding(8)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(AppColor.Surface.neutralExtraSubtle, in: RoundedRectangle(cornerRadius: 4))
        }
        .padding(.top, 4)
        .padding(.horizontal, 12)
        
    }
    
    private var baggageFareRule: some View {
        Button {
            print("點選行李及更改取消規定")
        } label: {
            HStack(spacing: 10) {
                HStack(spacing: 2) {
                    Image("ic_package_20")
                    Text("行李及更改取消規定")
                        .font(AppTypography.T03M)
                        .foregroundStyle(AppColor.Text.neutralBodyMid)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Image("ic_right_01_14")
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(AppColor.Surface.neutralWhite)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}

#Preview {
    PackagesPassengerInfoView(viewModel: PackagesPassengerInfoViewModel())
}
