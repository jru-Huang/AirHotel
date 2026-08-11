//
//  PackagesPassengerInfoView.swift
//  AirHotel
//
//  Created by 7943 on 2026/8/6.
//

import SwiftUI

struct PackagesPassengerInfoView: View {
    @StateObject private var viewModel: PackagesPassengerInfoViewModel
    @State private var isShowPricePerson = false
    @State private var hasReadOrderTerms = false

    init(viewModel: PackagesPassengerInfoViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    private var hasNotice: Bool {
        viewModel.lineNotice != nil || viewModel.systemNotice != nil
    }
    
    var body: some View {
        VStack(spacing: 0) {
            timeLimitView
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    
                    if hasNotice {
                        noticeView
                    }
                    
                    packagesInfoView
                    
                    VStack(spacing: 12) {
                        buyerInfoSection
                        travelerInfoSection
                        priceDetailSection
                        orderTermSection
                    }
                    
                    submit
                }
            }
        }
        .ignoresSafeArea(edges: .bottom)
        .onAppear(perform: viewModel.onViewAppear)
        .background(AppColor.Background.pageGray)
    }
    
    private var packagesInfoView: some View {
        VStack(spacing: 8) {
            airCard
            hotelCard
            baggageFareRuleCard
        }
        .padding(.top, 8)
        .padding(.bottom, 12)
        .padding(.horizontal, 12)
    }
    
    // MARK: 公告
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
    private var timeLimitView: some View {
        HStack(spacing: 6) {
            timeLimitTitle
            countdownTimer
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
    
    private var timeLimitTitle: some View {
        HStack(spacing: 4) {
            Image("ic_countdown_20_white") //jru:專案icon改名
            Text("請在 15 分鐘內填寫並送出訂單")
                .font(AppTypography.B04M)
                .foregroundStyle(AppColor.Text.neutralWhite)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var countdownTimer: some View {
        let components = "14:59".split(separator: ":", maxSplits: 1).map(String.init)
        let minutes = components.first ?? "00"
        let seconds = components.count > 1 ? components[1] : "00"

        return HStack(spacing: 2) {
            timeItem(minutes)
            
            Text(":")
                .font(AppTypography.N06M)
                .foregroundStyle(AppColor.Text.neutralWhite)
            
            timeItem(seconds)
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
    
    private var depSegmentView: some View {
        airSegmentView(
            type: "去程",
            departureDateTime: "2026-08-11T10:45:00",
            departureAirport: "桃園機場",
            departureTerminal: "T1",
            arrivalAirport: "東京羽田機場",
            arrivalTerminal: "T2"
        )
    }
    
    private var returnSegmentView: some View {
        airSegmentView(
            type: "回程",
            departureDateTime: "2026-08-16T20:15:00",
            departureAirport: "東京羽田機場",
            departureTerminal: "T2",
            arrivalAirport: "桃園機場",
            arrivalTerminal: "T1"
        )
    }

    private func airSegmentView(
        type: String,
        departureDateTime: String,
        departureAirport: String,
        departureTerminal: String,
        arrivalAirport: String,
        arrivalTerminal: String
    ) -> some View {
        let formattedDateTime = formatAirSegmentDateTime(departureDateTime)

        return HStack(alignment: .center, spacing: 8) {
            airSegmentType(text: type)

            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 4) {
                    Text(formattedDateTime.date)
                    Text(formattedDateTime.weekday)
                    Text(formattedDateTime.time)
                }
                .font(AppTypography.T03M)
                .foregroundStyle(AppColor.Text.neutralBodyBase)
                
                HStack(spacing: 2) {
                    Text(departureAirport)
                    Text(departureTerminal)
                    Text("-")
                    Text(arrivalAirport)
                    Text(arrivalTerminal)
                }
                .font(AppTypography.B05R)
                .foregroundStyle(AppColor.Text.neutralBodyMid)
            }
        }
    }

    private func formatAirSegmentDateTime(
        _ dateTime: String
    ) -> (date: String, weekday: String, time: String) {
        let formatted = FormatUtil.convertStringToString(
            dateStringFrom: dateTime,
            dateFormatTo: "yyyy年MM月dd日 週EEEEE HH:mm"
        )
        let components = formatted.split(separator: " ", omittingEmptySubsequences: false)

        guard components.count == 3 else {
            return (dateTime, "", "")
        }

        return (
            date: String(components[0]),
            weekday: String(components[1]),
            time: String(components[2])
        )
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
    
    private func rightArrow(_ text: String)-> some View {
        HStack(spacing: 0) {
            Text(text)
                .font(AppTypography.L03M)
                .foregroundStyle(AppColor.Text.brandPrimaryMid)
            Image("ic_right_14_purple") //jru:專案icon改名
        }
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
            Text("JR九州最大五星超高級日本大都會酒JR九州最大五星超高級日本大都會酒")
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
                .font(AppTypography.T05M)
                .foregroundStyle(AppColor.Text.neutralBodyMid)
            }
            
            Text("標準雙床房，非吸菸房(View will be selected by the hotel )標準雙床房，非吸菸房")
                .font(AppTypography.B04M)
                .foregroundStyle(AppColor.Text.neutralBodyBase)
                .multilineTextAlignment(.leading)
                .padding(8)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(AppColor.Surface.neutralExtraSubtle, in: RoundedRectangle(cornerRadius: 4))
        }
        .padding(.top, 4)
        .padding(.horizontal, 12)
    }
    
    private var baggageFareRuleCard: some View {
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
    
    // MARK: 訂購人資料
    private var buyerInfoSection: some View {
        VStack(spacing: 4) {
            PackagesPassengerInfoSectionHeaderView(title: "訂購人資料")
            
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
                
                BulletExpandableTextView(item: BulletExpandableTextItem(textList: ["本系統為自動化機加酒組合訂購服務，僅提供「機票+飯店」套裝銷售，恕不適用信用卡特定合作專案、航空公司額外贈送服務，亦不提供單項加購（如：租車、當地行程）之需求。如您有特殊加購或個別專案需求，請至專屬頁面訂購或洽詢專人處理。", "後續訂購相關通知、付款成功後開立之電子機票及住宿券，將統一寄送至訂購人電子郵件信箱。請務必確認所填寫之聯絡資料正確無誤，以避免因資訊錯誤導致無法順利收取行程重要憑證。"], lineLimit: 3))
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 20)
            .background(AppColor.Surface.neutralWhite)
        }
    }
    
    // MARK: 旅客資料
    private var travelerInfoSection: some View {
        VStack(spacing: 4) {
            PackagesPassengerInfoSectionHeaderView(title: "旅客資料")
            
            VStack(spacing: 0) {
                ForEach([0,1,2], id: \.self) { index in
                    travelerRoomPax(index: index, isLast: index == 2, hasCompleted: index == 0)
                }
            }
        }
    }
    
    private func travelerRoomPax(index: Int, isLast: Bool, hasCompleted: Bool) -> some View {
        VStack(spacing: 0) {
            roomPaxHeader(index: index, hasCompleted: hasCompleted)
            
            if hasCompleted {
                VStack(spacing: 0) {
                    ForEach([0,1], id: \.self) { itemIndex in
                        roomPaxDetail(index: itemIndex, isLast: itemIndex == 1)
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.bottom, 12)
            }
            
            if !isLast {
                divider(padding: 0)
            }
        }
        .padding(.horizontal, 16)
        .background(AppColor.Surface.neutralWhite)
    }
    
    private func roomPaxHeader(index: Int, hasCompleted: Bool) -> some View {
        Button {
            print("點選卡片標題（針對所有）")
        } label: {
            HStack(spacing: 12) {
                HStack(spacing: 2) {
                    Text("房間\(index + 1)")
                    Text("/")
                    Text("2大人")
                }
                .font(AppTypography.T03M)
                .foregroundStyle(AppColor.Text.neutralBodyBase)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(spacing: 8) {
                    if !hasCompleted {
                        Text("請填寫旅客資料")
                            .font(AppTypography.B03R)
                            .foregroundStyle(AppColor.Text.neutralSubtle)
                    }
                    Image("ic_right_20")
                }
                
            }
            .padding(.vertical, 12)
        }
    }
    
    private func roomPaxDetail(index: Int, isLast: Bool) -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 12) {
                VStack(spacing: 2) {
                    HStack(spacing: 4) {
                        Text("吳威廉\(index)")
                            .font(AppTypography.B06R)
                            .foregroundStyle(AppColor.Text.neutralBodyMid)
                        Text("入住代表人")
                            .font(AppTypography.B06M)
                            .foregroundStyle(AppColor.Text.brandPrimaryMid)
                    }
                    
                    Text("WU,WALLEN")
                        .font(AppTypography.B03R)
                        .foregroundStyle(AppColor.Text.neutralBodyBase)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Button {
                    print("點選編輯（針對個人）")
                } label: {
                    Text("編輯")
                        .font(AppTypography.L02R)
                        .foregroundStyle(AppColor.Text.neutralBodyLight)
                }
            }
            .padding(.top, 8)
            .padding(.bottom, 6)
            .padding(.horizontal, 16)
            .background(AppColor.Surface.neutralExtraSubtle)
            
            if !isLast {
                divider(padding: 16)
            }
        }
    }
    
    // MARK: 售價明細
    private var priceDetailSection: some View {
        VStack(spacing: 4) {
            PackagesPassengerInfoSectionHeaderView(title: "售價明細")
            
            VStack(spacing: 12) {
                VStack(spacing: 8) {
                    priceItem(name: "消費總金額",
                              defaultImage: "ic_down_01_14",
                              toggleImage: "ic_up_01_14",
                              discount: "$68,000",
                              nameFont: AppTypography.T03M,
                              nameColor: AppColor.Text.neutralBodyBase,
                              discountFont: AppTypography.N05M,
                              discountColor: AppColor.Text.neutralBodyBase)
                    
                    if isShowPricePerson {
                        pricePersonCard
                    }
                    
                    priceItem(name: "優惠折扣", discount: "-$800")
                    priceItem(name: "可樂旅遊幣", discount: "-$1000")
                }
                
                divider(padding: 0)
                
                priceItem(name: "機+酒含稅總計",
                          discount: "$66,200",
                          nameFont: AppTypography.T03R,
                          nameColor: AppColor.Text.neutralBodyBase,
                          discountFont: AppTypography.N01M,
                          discountColor: AppColor.Text.marketOrangeDark)
            }
            .padding(12)
            .background(AppColor.Surface.neutralWhite)
        }
    }
    
    private var pricePersonCard: some View {
        VStack(spacing: 8) {
            ForEach([0,1], id: \.self) { _ in
                pricePerPerson(appellation: "大人",
                               pricePrePerson: "$17,000",
                               numberOfPeople: "x2",
                               totalPrice: "$34,000")
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(AppColor.Surface.neutralExtraSubtle, in: RoundedRectangle(cornerRadius: 8))
    }
    
    private func pricePerPerson(appellation: String,
                                pricePrePerson: String,
                                numberOfPeople: String,
                                totalPrice: String) -> some View {
        HStack(spacing: 12) {
            HStack(spacing: 4) {
                Text(appellation)
                    .font(AppTypography.N05R)
                    .foregroundStyle(AppColor.Text.neutralBodyBase)
                Text(pricePrePerson)
                    .font(AppTypography.N05R)
                    .foregroundStyle(AppColor.Text.neutralBodyBase)
                Text(numberOfPeople)
                    .font(AppTypography.N06R)
                    .foregroundStyle(AppColor.Text.neutralBodyMid)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(totalPrice)
                .font(AppTypography.N05R)
                .foregroundStyle(AppColor.Text.neutralBodyBase)
        }
    }
    
    private func priceItem(name: String,
                           defaultImage: String? = nil,
                           toggleImage: String? = nil,
                           discount: String,
                           nameFont: Font = AppTypography.T03R,
                           nameColor: Color = AppColor.Text.neutralBodyBase,
                           discountFont: Font = AppTypography.N05R,
                           discountColor: Color = AppColor.Text.marketOrangeDark) -> some View {
        HStack {
            if let defaultImage, let toggleImage {
                Button {
                    isShowPricePerson.toggle()
                } label: {
                    HStack(spacing: 4) {
                        priceItemName(name, font: nameFont, color: nameColor)
                        Image(isShowPricePerson ? toggleImage : defaultImage)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .buttonStyle(.plain)
            } else {
                priceItemName(name, font: nameFont, color: nameColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Text(discount)
                .font(discountFont)
                .foregroundStyle(discountColor)
                .multilineTextAlignment(.trailing)
        }
    }

    private func priceItemName(_ name: String, font: Font, color: Color) -> some View {
        Text(name)
            .font(font)
            .foregroundStyle(color)
    }
    
    // MARK: 訂購須知
    private var orderTermSection: some View {
        HStack(spacing: 8) {
            Image(hasReadOrderTerms ? "checkbox_active" : "checkbox_default") //jru: icon修改
            HStack(spacing: 0) {
                Text("我已閱讀")
                    .foregroundStyle(AppColor.Text.neutralBodyMid)
                Text("訂購須知")
                    .foregroundStyle(AppColor.Text.brandPrimaryDark)
                    .overlay(alignment: .bottom) {
                        Rectangle()
                            .fill(AppColor.Text.brandPrimaryDark)
                            .frame(height: 0.5)
                    }
                    .onTapGesture {
                        print("點選訂購須知")
                        hasReadOrderTerms.toggle()
                    }
                Text("，並接受所有規定事項。")
                    .foregroundStyle(AppColor.Text.neutralBodyMid)
            }
            .font(AppTypography.B04R)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppColor.Surface.neutralWhite)
    }
    
    private var submit: some View {
        VStack(spacing: 0) {
            Button {
                print("送出訂單")
            } label: {
                Text("送出訂單")
                    .font(AppTypography.L02M)
                    .foregroundStyle(AppColor.Text.neutralWhite)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(height: 40)
            .background(AppColor.Surface.brandPrimaryBase)
            
            AppColor.Surface.brandPrimaryBase
                .frame(height: safeAreaBottomInset)
        }
    }
    
    private func divider(padding: CGFloat) -> some View {
        Rectangle()
            .fill(AppColor.Border.neutralExtraSubtle)
            .frame(height: 1)
            .padding(.horizontal, padding)
    }
}

#Preview {
    PackagesPassengerInfoView(viewModel: PackagesPassengerInfoViewModel())
}
