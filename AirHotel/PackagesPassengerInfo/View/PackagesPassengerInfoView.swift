//
//  PackagesPassengerInfoView.swift
//  AirHotel
//
//  Created by 7943 on 2026/8/6.
//

import SwiftUI

struct PackagesPassengerInfoView: View {
    
   private enum SectionID {
        static let travelerInfo = "travelerInfoSection"
    }
    
    @StateObject private var viewModel: PackagesPassengerInfoViewModel
    @State private var isShowPricePerson = false
    @State private var hasReadOrderTerms = false
    @State private var isShowingOrderTerms = false
    @State private var isShowingHotelCard = false
    @State private var isShowingDoubleCheck = false
    @State private var isShowingTravelerToast = false
    @State private var shouldScrollToTravelerInfo = false
    
    init(viewModel: PackagesPassengerInfoViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    private var hasNotice: Bool {
        viewModel.lineNotice != nil || viewModel.systemNotice != nil
    }
    
    var body: some View {
        VStack(spacing: 0) {
            timeLimitView
            
            ScrollViewReader { proxy in
                VStack(spacing: 0) {
                    contentView
                        .onChange(of: shouldScrollToTravelerInfo) { shouldScroll in
                            guard shouldScroll else { return }
                            withAnimation {
                                proxy.scrollTo(SectionID.travelerInfo, anchor: .top)
                            }
                            shouldScrollToTravelerInfo = false
                        }
                    
                    submitView {
                        onTouchSubmit(proxy: proxy)
                    }
                }
            }
        }
        .ignoresSafeArea(edges: .bottom)
        .onAppear(perform: viewModel.onViewAppear)
        .background(AppColor.Background.pageGray)
        .overlay {
            if viewModel.isShowingExpireTimeDialog {
                DialogSwiftUIView(
                    model: DialogSwiftUIModel(
                        imgName: "ic_exceed_100",
                        title: "訂購時間已逾時",
                        message: "機加酒資訊已更新\n請重新整理以查看最新搜尋結果。",
                        isSingleButton: true,
                        rightTitle: "重新整理"
                    ),
                    onRightAction: {
                        viewModel.dismissExpireTimeDialog()
                    }
                )
            }
        }
        .overlay(alignment: .bottom) {
            if isShowingTravelerToast {
                Text("請填寫旅客資料")
                    .font(AppTypography.B03R)
                    .foregroundStyle(AppColor.Text.neutralWhite)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(AppColor.Surface.opacityGrayDark, in: Capsule())
                    .padding(.bottom, safeAreaBottomInset + 24)
                .transition(.opacity)
            }
        }
        .overlay {
            if isShowingHotelCard,
               let hotelDetail = viewModel.info?.hotelInfo.hotelDetail {
                PackagesPassengerInfoHotelCardView(
                    detail: hotelDetail,
                    onClose: {
                        isShowingHotelCard = false
                    }
                )
            }
        }
        .overlay {
            if isShowingDoubleCheck {
                PackagesPassengerInfoDoubleCheckView(
                    onClose: {
                        isShowingDoubleCheck = false
                    },
                    onEditTravelerInfo: {
                        isShowingDoubleCheck = false
                        shouldScrollToTravelerInfo = true
                    }
                )
            }
        }
    }
    
    private var contentView: some View {
        ScrollView {
            VStack(spacing: 0) {
                if hasNotice {
                    noticeView
                }
                
                packagesCards
                
                VStack(spacing: 12) {
                    if let buyerInfo = viewModel.info?.buyerInfo {
                        buyerInfoSection(info: buyerInfo)
                    }
                    
                    if let travelerInfo = viewModel.info?.travelerInfo {
                        travelerInfoSection(info: travelerInfo)
                            .id(SectionID.travelerInfo)
                    }
                    
                    if let priceInfo = viewModel.info?.priceDetail {
                        priceDetailSection(info: priceInfo)
                    }
                    
                    orderTermsSection
                }
            }
        }
    }
    
    private var packagesCards: some View {
        VStack(spacing: 8) {
            if let airInfo = viewModel.info?.airInfo {
                airCard(info: airInfo)
            }
            
            if let hotelInfo = viewModel.info?.hotelInfo {
                hotelCard(info: hotelInfo)
            }
            
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
        let remainingSeconds = viewModel.remainingCountdownSeconds
        let minutes = remainingSeconds / 60
        let seconds = remainingSeconds % 60
        
        return HStack(spacing: 2) {
            timeItem(String(format: "%02d", minutes))
            
            Text(":")
                .font(AppTypography.N06M)
                .foregroundStyle(AppColor.Text.neutralWhite)
            
            timeItem(String(format: "%02d", seconds))
        }
    }
    
    private func timeItem(_ value: String) -> some View {
        Text(value)
            .font(AppTypography.N06M)
            .foregroundStyle(AppColor.Text.neutralWhite)
            .frame(width: 27, height: 21)
            .background(
                AppColor.Surface.opacityWhiteBase,
                in: RoundedRectangle(cornerRadius: 4)
            )
    }
    
    // MARK: 航班
    private func airCard(info: PackagesPassengerInfoModel.AirInfoModel)-> some View {
        Button {
            print("點選航班資訊")
        } label: {
            VStack(alignment: .leading, spacing: 4) {
                airDestination(info: info)
                airDetail(info: info)
            }
            .padding(.top, 8)
            .padding(.bottom, 12)
            .background(AppColor.Surface.neutralWhite)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
    
    private func airDestination(info: PackagesPassengerInfoModel.AirInfoModel)-> some View {
        HStack(spacing: 8) {
            HStack(spacing: 2) {
                Text(info.depLocation)
                    .font(AppTypography.T03M)
                    .foregroundStyle(AppColor.Text.neutralBodyBase)
                Image("ic_line_16")
                Text(info.returnLocation)
                    .font(AppTypography.T03M)
                    .foregroundStyle(AppColor.Text.neutralBodyBase)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            rightArrow("航班資訊")
        }
        .padding(.horizontal, 12)
    }
    
    private func airDetail(info: PackagesPassengerInfoModel.AirInfoModel)-> some View {
        VStack(spacing: 4) {
            ForEach(info.airSegmentList) { info in
                airSegmentView(type: info.airType,
                               departureDateTime: info.date,
                               departureAirport: info.depAirport,
                               departureTerminal: info.depTerminal,
                               arrivalAirport: info.arrAirport,
                               arrivalTerminal: info.arrTerminal)
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppColor.Surface.neutralExtraSubtle, in: RoundedRectangle(cornerRadius: 4))
        .padding(.horizontal, 12)
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
    private func hotelCard(info: PackagesPassengerInfoModel.HotelInfoModel)-> some View {
        Button {
            isShowingHotelCard = true
        } label: {
            VStack(alignment: .leading, spacing: 4) {
                hotelName(info.hotelName)
                hotelDetail(info: info)
            }
            .padding(.top, 8)
            .padding(.bottom, 12)
            .background(AppColor.Surface.neutralWhite)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
    
    private func hotelName(_ hotelName: String)-> some View {
        HStack(spacing: 8) {
            Text(hotelName)
                .font(AppTypography.T03M)
                .foregroundStyle(AppColor.Text.neutralBodyBase)
                .multilineTextAlignment(.leading)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
            rightArrow("入住資訊")
        }
        .padding(.horizontal, 12)
    }
    
    private func hotelDetail(info: PackagesPassengerInfoModel.HotelInfoModel)-> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 4) {
                Image("ic_bed_14_gray")
                HStack(spacing: 2) {
                    Text("入住")
                    Text(info.checkInDate)
                    Text("-")
                    Text("退房")
                    Text(info.checkOutDate)
                }
                .font(AppTypography.T05M)
                .foregroundStyle(AppColor.Text.neutralBodyMid)
            }
            
            Text(info.roomDesc)
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
    private func buyerInfoSection(info: PackagesPassengerInfoModel.BuyerInfoModel)-> some View {
        VStack(spacing: 4) {
            PackagesPassengerInfoSectionHeaderView(title: "訂購人資料")
            
            VStack(spacing: 12) {
                
                HStack(alignment: .top, spacing: 12) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(info.buyerName)
                        Text(verbatim: info.buyerEmail)
                            .foregroundStyle(AppColor.Text.neutralBodyBase)
                        Text(info.buyerPhone)
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
                
                BulletExpandableTextView(item: BulletExpandableTextItem(textList: info.noticeList, lineLimit: 3))
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 20)
            .background(AppColor.Surface.neutralWhite)
        }
    }
    
    // MARK: 旅客資料
    private func travelerInfoSection(info: PackagesPassengerInfoModel.TravelerInfoModel)-> some View {
        VStack(spacing: 4) {
            PackagesPassengerInfoSectionHeaderView(title: "旅客資料")
            
            VStack(spacing: 0) {
                ForEach(Array(info.travelerList.enumerated()), id: \.element.id) { index, traveler in
                    travelerRoomPax(traveler: traveler, isLast: index == (info.travelerList.count - 1), hasCompleted: !(traveler.pax.paxDetailList.isEmpty))
                }
            }
        }
    }
    
    private func travelerRoomPax(traveler: PackagesPassengerInfoModel.Traveler, isLast: Bool, hasCompleted: Bool) -> some View {
        VStack(spacing: 0) {
            roomPaxHeader(traveler, hasCompleted: hasCompleted)
            
            if hasCompleted {
                VStack(spacing: 0) {
                    ForEach(Array(traveler.pax.paxDetailList.enumerated()), id: \.element.id) { itemIndex, paxDetail in
                        roomPaxDetail(paxDetail, isLast: itemIndex == (traveler.pax.paxDetailList.count - 1))
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
    
    private func roomPaxHeader(_ traveler: PackagesPassengerInfoModel.Traveler, hasCompleted: Bool) -> some View {
        Button {
            print("點選卡片標題（針對所有）")
        } label: {
            HStack(spacing: 12) {
                HStack(spacing: 2) {
                    Text(traveler.room)
                    Text("/")
                    Text(traveler.pax.numberOfPeople)
                }
                .font(AppTypography.T03M)
                .foregroundStyle(AppColor.Text.neutralBodyBase)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(spacing: 8) {
                    if !hasCompleted {
                        Text("請填寫旅客資料")
                            .font(AppTypography.B03R)
                            .foregroundStyle(
                                viewModel.hasTravelerInfoError
                                    ? AppColor.Text.stateError
                                    : AppColor.Text.neutralSubtle
                            )
                    }
                    Image("ic_right_20")
                }
                
            }
            .padding(.vertical, 12)
        }
    }
    
    private func roomPaxDetail(_ paxDetail: PackagesPassengerInfoModel.PaxDetail, isLast: Bool) -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 12) {
                VStack(spacing: 2) {
                    HStack(spacing: 4) {
                        Text(paxDetail.paxChineseName)
                            .font(AppTypography.B06R)
                            .foregroundStyle(AppColor.Text.neutralBodyMid)
                        
                        if paxDetail.isRoomLeader {
                            Text("入住代表人")
                                .font(AppTypography.B06M)
                                .foregroundStyle(AppColor.Text.brandPrimaryMid)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack(spacing: 2) {
                        Text(paxDetail.paxSurName)
                        Text(",")
                        Text(paxDetail.paxGivenName)
                    }
                    .font(AppTypography.B03R)
                    .foregroundStyle(AppColor.Text.neutralBodyBase)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Button {
                    print("點選編輯（針對個人）")
                } label: {
                    Text("編輯")
                        .font(AppTypography.L02R)
                        .foregroundStyle(AppColor.Text.neutralBodyLight)
                        .padding(5)
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
    private func priceDetailSection(info: PackagesPassengerInfoModel.PriceInfoModel)-> some View {
        VStack(spacing: 4) {
            PackagesPassengerInfoSectionHeaderView(title: "售價明細")
            
            VStack(spacing: 12) {
                VStack(spacing: 8) {
                    priceItem(name: "消費總金額",
                              defaultImage: "ic_down_01_14",
                              toggleImage: "ic_up_01_14",
                              discount: info.amount.amountPrice,
                              nameFont: AppTypography.T03M,
                              nameColor: AppColor.Text.neutralBodyBase,
                              discountFont: AppTypography.N05M,
                              discountColor: AppColor.Text.neutralBodyBase)
                    
                    if isShowPricePerson {
                        pricePersonCard(info.amount)
                    }
                    
                    priceItem(name: info.coupon.title, discount: info.coupon.price)
                    priceItem(name: info.colaCoin.title, discount: info.colaCoin.price)
                }
                
                divider(padding: 0)
                
                priceItem(name: "機+酒含稅總計",
                          discount: info.totalTaxPrice,
                          nameFont: AppTypography.T03R,
                          nameColor: AppColor.Text.neutralBodyBase,
                          discountFont: AppTypography.N01M,
                          discountColor: AppColor.Text.marketOrangeDark)
            }
            .padding(12)
            .background(AppColor.Surface.neutralWhite)
        }
    }
    
    private func pricePersonCard(_ amount: PackagesPassengerInfoModel.Amount)-> some View {
        VStack(spacing: 8) {
            ForEach(amount.amountDetailList, id: \.id) { detail in
                pricePerPerson(appellation: detail.appellation,
                               pricePrePerson: detail.pricePrePerson,
                               numberOfPeople: detail.numberOfPeople,
                               totalPrice: detail.totalPrice)
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
    private var orderTermsSection: some View {
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
                Text("，並接受所有規定事項。")
                    .foregroundStyle(AppColor.Text.neutralBodyMid)
            }
            .font(AppTypography.B04R)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppColor.Surface.neutralWhite)
        .onTapGesture {
            print("點選訂購須知")
            isShowingOrderTerms = true
        }
        .fullScreenCover(isPresented: $isShowingOrderTerms) {
            NavigationView {
                PackagesPassengerInfoOrderTermsView(hasReadOrderTerms: $hasReadOrderTerms, infoList: viewModel.info?.orderTermsList ?? [])
            }
        }
//        .background {
//            NavigationLink(
//                destination: OrderTermsView(hasReadOrderTerms: $hasReadOrderTerms),
//                isActive: $isShowingOrderTerms
//            ) {
//                EmptyView()
//            }
//            .hidden()
//        }
    }
    
    private func submitView(action: @escaping () -> Void) -> some View {
        VStack(spacing: 0) {
            Button(action: action) {
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

    private func onTouchSubmit(proxy: ScrollViewProxy) {
        switch viewModel.submitResult(hasAgreedOrderTerms: hasReadOrderTerms) {
        case .success:
            isShowingDoubleCheck = true
        case .incompleteTravelerInfo:
            withAnimation {
                proxy.scrollTo(SectionID.travelerInfo, anchor: .top)
                isShowingTravelerToast = true
            }
            
            Task { @MainActor in
                try? await Task.sleep(nanoseconds: 2_000_000_000)
                withAnimation {
                    isShowingTravelerToast = false
                }
            }
        case .orderTermsNotAccepted:
            isShowingOrderTerms = true
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
