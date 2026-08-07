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
            
            buyerInfoSection
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
                    Text("2026年01月24日")
                    Text("週六")
                    Text("12:05")
                }
                .font(AppTypography.T03M)
                .foregroundStyle(AppColor.Text.neutralBodyBase)
                
                HStack(spacing: 2) {
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
    
    private var returnSegmentView: some View {
        HStack(alignment: .center,spacing: 8) {
            airSegmentType(text: "回程")
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 4) {
                    Text("2026年01月24日")
                    Text("週六")
                    Text("12:05")
                }
                .font(AppTypography.T03M)
                .foregroundStyle(AppColor.Text.neutralBodyBase)
                
                HStack(spacing: 2) {
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
                    Text("入住")
                    Text("09/12 (二)")
                    Text("-")
                    Text("退房")
                    Text("09/28 (二)")
                }
                .font(AppTypography.T05M) //????
                .foregroundStyle(AppColor.Text.neutralBodyMid)//???
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
    
    private var buyerInfoSection: some View {
        VStack(spacing: 4) {
            PackagesPassengerInfoSectionHeader(title: "訂購人資料")
            
            VStack(spacing: 12) {
                
                HStack(alignment: .top, spacing: 12) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("王大明")
                        Text(verbatim: "cola123@gmail.com")
                            .foregroundStyle(AppColor.Text.neutralBodyBase)
                        Text("0912345678")
                    }
                    .font(AppTypography.B03R)
                    .foregroundStyle(AppColor.Text.neutralBodyBase)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button {
                        print("點選編輯")
                    } label: {
                        Image("ic_edit_20")
                    }
                }
                
                ExpandableText(
                    text: "● 本系統為自動化機加酒組合訂購服務，僅提供「機票+飯店」套裝銷售，恕不適用信用卡特定合作專案、航空公司額外贈送服務，亦不提供單項加購（如：租車、當地行程）之需求。如您有特殊加購或個別專案需求，請至專屬頁面訂購或洽詢專人處裡。後續訂購相關通知、付款成功後開立之電子機票及住宿券，將統一寄送至訂購人電子郵件信箱。請務必確認所填寫之聯絡資料正確無誤，以避免因資訊錯誤導致無法順利收取行程重要憑證。"
                )
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 20)
            .background(AppColor.Surface.neutralWhite)
        }
    }
}

struct ExpandableText: View {
    let text: String
    var lineLimit: Int = 4

    @State private var isExpanded = false
    @State private var limitedTextHeight: CGFloat = 0
    @State private var fullTextHeight: CGFloat = 0

    private var isTruncated: Bool {
        fullTextHeight > limitedTextHeight + 0.5
    }

    var body: some View {
        Text(text)
            .font(AppTypography.B05R)
            .foregroundStyle(AppColor.Text.neutralBodyMid)
            .lineLimit(isExpanded ? nil : lineLimit)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background {
                // 取得限制後高度
                GeometryReader { limitedProxy in
                    Color.clear
                        .preference(
                            key: LimitedTextHeightKey.self,
                            value: limitedProxy.size.height //畫面上限制 4 行的 Text，實際寬度
                        )

                    // 用相同寬度測量完整文字
                    Text(text)
                        .font(AppTypography.B05R)
                        .lineLimit(nil)
                        .frame(
                            width: limitedProxy.size.width, //測量完整文字時，也必須使用完全相同的寬度
                            alignment: .leading
                        )
                        .fixedSize(horizontal: false, vertical: true)
                        .hidden()
                        .background {
                            GeometryReader { fullProxy in
                                Color.clear
                                    .preference(
                                        key: FullTextHeightKey.self,
                                        value: fullProxy.size.height
                                    )
                            }
                        }
                }
            }
            .padding(.vertical, 8)
            .padding(.leading, 4)
            .padding(.trailing, 8)
            .background(AppColor.Surface.neutralExtraSubtle)
            .overlay(alignment: .bottomTrailing) {
                if !isExpanded && isTruncated {
                    moreButton
                }
            }
            .onPreferenceChange(LimitedTextHeightKey.self) {
                limitedTextHeight = $0
            }
            .onPreferenceChange(FullTextHeightKey.self) {
                fullTextHeight = $0
            }
    }

    private var moreButton: some View {
        HStack(spacing: 4) {
            Text("…")
                .font(AppTypography.B05R)
                .foregroundStyle(AppColor.Text.neutralBodyMid)

            Button("顯示更多") {
                withAnimation {
                    isExpanded = true
                }
            }
            .font(AppTypography.L03R)
            .foregroundStyle(AppColor.Text.brandSecondaryBase)
            .buttonStyle(.plain)
        }
        .padding(.bottom, 8)
        .padding(.trailing, 8)
        .background(AppColor.Surface.neutralExtraSubtle)
    }
}

private struct LimitedTextHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

private struct FullTextHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

#Preview {
    PackagesPassengerInfoView(viewModel: PackagesPassengerInfoViewModel())
}
