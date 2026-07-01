//
//  PackagesComboViewModel.swift
//  AirHotel
//
//  Created by 7943 on 2026/5/29.
//

import SwiftUI
import Combine

final class PackagesComboViewModel: ObservableObject {
    
    enum LuggageType {
        case free
        case none
        case partial
        
        //        enum LuggageType: : String {
        //        case free = "含免費托運行李"
        //        case none = "無免費託運行李"
        //        case partial = "部分不含托運行李"
        
        //        init?(note: String) {
        //            if note.contains("部分") {
        //                self = .partial
        //            } else if note.contains("無免費") {
        //                self = .none
        //            } else if note.contains("含免費") {
        //                self = .free
        //            } else {
        //                return nil
        //            }
        //        }
        
        var note: String {
            switch self {
            case .free:
                return "含免費托運行李"
            case .none:
                return "無免費託運行李"
            case .partial:
                return "部分不含托運行李"
            }
        }
        
        var imageName: String {
            switch self {
            case .free:
                return "ic_package_24_on"
            case .none, .partial:
                return "ic_package_24_off"
            }
        }
    }
    
    @Published var isShowingOvernightAlert: Bool = false
    @Published var navInfo: PackagesComboNavInfo?
    @Published var policyNotice: PackagesNoticeDetailInfo?
    @Published var systemNoticeList: [PackagesComboSystemNoticeModel] = []
    @Published var airInfoCard: PackagesComboAirInfoModel?
    @Published var hotelInfoCard: PackagesComboHotelInfoModel?
    @Published var hotelBookingRuleDesc: PackagesNoticeDetailInfo?
    @Published var totalPrice: String = ""
    @Published var amountDetail: PackagesComboAmountModel?
    
    //優惠
    @Published var discountInfoCard: PackagesComboDiscountInfoCard = PackagesComboDiscountInfoCard(
        discount: "優惠折扣買大送小優惠折扣買大送小優惠折扣買大送小優惠折扣買大送小",
        discountError: "此優惠代碼已全數兌換完畢。此優惠代碼已全數兌換完畢。此優惠代碼已全數兌換完畢。此優惠代碼已全數兌換完畢。"
    )
    
    var overnightAlertModel: DialogSwiftUIModel {
        DialogSwiftUIModel(
            imgName: "ic_night_100",
            title: "深夜抵達\n請留意入住日期！",
            isSingleButton: true,
            rightTitle: "我知道了"
        )
    }
    
    func onViewAppear() {
        let response: PackagesDynamicBundleResponse = load("Combo.json")
        isShowingOvernightAlert = response.noticeContent?.overnightMark == true
        
        setupNav(conditionDetail: response.conditionDetail)
        setupNotices(noticeContent: response.noticeContent)
        setupAirInfoCard(response: response)
        setupHotelCard(response: response)
        setupAmountDetail(response: response)
        totalPrice = response.totalPrice.map { $0.priceAddDot() } ?? ""
    }
    
    func dismissOvernightAlert() {
        isShowingOvernightAlert = false
    }
}

extension PackagesComboViewModel {
    
    private func setupNav(conditionDetail: PackagesDynamicBundleResponse.ConditionDetail?) {
        guard let conditionDetail else {
            navInfo = nil
            return
        }
        // jru: 改成用 Request 資料！「更改搜尋」也是！！！
        let departureName = conditionDetail.departureName ?? ""
        let arrivalName = conditionDetail.arrivalName ?? ""
        let departureDate = convertDateString(dateString: conditionDetail.departureDate ?? "", joinedString: "/")
        let returnDate = convertDateString(dateString: conditionDetail.returnDate ?? "", joinedString: "/")
        let roomAndPeople = "\("從request帶？")"
        navInfo = PackagesComboNavInfo(location: "\(departureName)-\(arrivalName)",
                                       date: "\(departureDate)–\(returnDate)",
                                       roomAndPeople: "\(conditionDetail.roomNumber ?? 0)間房，\(roomAndPeople)")
    }
    
    // MARK: 公告
    private func setupNotices(noticeContent: PackagesDynamicBundleResponse.NoticeContent?) {
        policyNotice = setPolicyNotice(policyList: noticeContent?.policyList)
        systemNoticeList = [
            setSystemNotice(
                contentList: noticeContent?.stopBookingText.map { [$0] },
                imageName: "ic_time_20",
                bgColor: AppColor.Surface.brandPrimaryExtraSubtle,
                strokeColor: AppColor.Border.brandPrimarySubtle
            ),
            setSystemNotice(
                contentList: noticeContent?.announceTextList,
                imageName: "ic_bell_20",
                bgColor: AppColor.Surface.brandSecondaryExtraSubtle,
                strokeColor: AppColor.Border.brandSecondarySubtle
            )
        ]
            .compactMap { $0 }
    }
    
    private func setPolicyNotice(policyList: [PackagesDynamicBundleResponse.Policy]?) -> PackagesNoticeDetailInfo? {
        guard let policyList, policyList.isEmpty == false else { return nil }
        
        let detailList = policyList.compactMap { policy -> PackagesNoticeDetail? in
            let title = policy.title ?? ""
            let content = policy.text ?? ""
            guard title.isEmpty == false || content.isEmpty == false else { return nil }
            return PackagesNoticeDetail(title: title, content: content)
        }
        
        guard detailList.isEmpty == false else { return nil }
        
        return PackagesNoticeDetailInfo(navTitle: "注意事項", noticeDetailList: detailList)
    }
    
    private func setSystemNotice(contentList: [String]?, imageName: String, bgColor: Color, strokeColor: Color) -> PackagesComboSystemNoticeModel? {
        guard let contentList, contentList.isEmpty == false else { return nil }
        
        let detailList = contentList.compactMap { content -> PackagesNoticeDetail? in
            guard content.isEmpty == false else { return nil }
            return PackagesNoticeDetail(title: "", content: content)
        }
        
        guard let firstContent = detailList.first?.content, firstContent.isEmpty == false else { return nil }
        
        return PackagesComboSystemNoticeModel(
            config: PackagesComboSystemNoticeConfig(
                imageName: imageName,
                content: firstContent,
                bgColor: bgColor,
                strokeColor: strokeColor
            ),
            detailInfo: PackagesNoticeDetailInfo(
                navTitle: "系統公告",
                noticeDetailList: detailList
            )
        )
    }
    
    // MARK: 航班
    private func setupAirInfoCard(response: PackagesDynamicBundleResponse) {
        let segmentInfoList = response.airTicketPreselection?.segmentInfoList ?? []
        let departureSegment = segmentInfoList.first?.segmentContent
        let returnSegment = segmentInfoList.dropFirst().first?.segmentContent
        let departureFlight = departureSegment?.flightList?.first
        let returnFlight = returnSegment?.flightList?.first
        
        guard departureSegment != nil || returnSegment != nil else {
            airInfoCard = nil
            return
        }
        
        let isLocDifferent = departureFlight?.arrivalLocCode != returnFlight?.departureLocCode
        
        airInfoCard = PackagesComboAirInfoModel(
            segmentInfoList: [
                setSegmentInfoModel(
                    type: "去程",
                    segment: departureSegment,
                    flight: departureFlight,
                    carrierNoticeText: segmentCarrierNotice(segment: departureSegment),
                    isDepLocHighlight: false,
                    isArrLocHighlight: isLocDifferent
                ),
                setSegmentInfoModel(
                    type: "回程",
                    segment: returnSegment,
                    flight: returnFlight,
                    carrierNoticeText: segmentCarrierNotice(segment: returnSegment),
                    isDepLocHighlight: isLocDifferent,
                    isArrLocHighlight: false
                )
            ],
            airTagList: response.airTicketPreselection?.displayTag ?? [],
            luggageType: .partial // jru:待確認
        )
    }
    
    private func setSegmentInfoModel(type: String, segment: PackagesDynamicBundleResponse.SegmentContent?, flight: PackagesDynamicBundleResponse.Flight?, carrierNoticeText: String, isDepLocHighlight: Bool, isArrLocHighlight: Bool) -> PackagesComboSegmentInfoModel {
        
        return PackagesComboSegmentInfoModel(
            type: type,
            date: formatSegmentDate(segment?.departureDateTime),
            carrierNoticeText: carrierNoticeText,
            carrierLogo: flight?.carrierLogo ?? "",
            ticketingCarrier: flight?.ticketingCarrier ?? "",
            depTime: segment?.departureTime ?? "",
            depLocation: segment?.departureLocCode ?? "",
            depTerminal: "Terminal",
            arrTime: segment?.arrivalTime ?? "",
            arrLocation: segment?.arrivalLocCode ?? "",
            arrTerminal: "Terminal",
            dateVariation: flight?.dateVariation ?? "",
            segmentTimeDesc: segment?.segmentTimeDesc ?? "",
            transitCountDesc: transitCountDescription(segment?.transitCount),
            isDepLocHighlight: isDepLocHighlight,
            isArrLocHighlight: isArrLocHighlight
        )
    }
    
    private func segmentCarrierNotice(segment: PackagesDynamicBundleResponse.SegmentContent?) -> String {
        guard let flightList = segment?.flightList, flightList.isEmpty == false else { return "" }
        
        let ticketingCarrierSet = Set(
            flightList.compactMap { flight -> String? in
                let ticketingCarrier = flight.ticketingCarrier ?? ""
                return ticketingCarrier.isEmpty ? nil : ticketingCarrier
            }
        )
        
        if ticketingCarrierSet.count >= 2 {
            return "多家航空"
        }
        
        let hasCodeShareFlight = flightList.contains {
            let ticketingCarrier = $0.ticketingCarrier ?? ""
            let operatingCarrier = $0.operatingCarrier ?? ""
            return ticketingCarrier.isEmpty == false &&
            operatingCarrier.isEmpty == false &&
            ticketingCarrier != operatingCarrier
        }
        
        if hasCodeShareFlight {
            return "共享航班"
        }
        
        return ""
    }
    
    private func formatSegmentDate(_ departureDateTime: String?) -> String {
        FormatUtil.convertStringToString(
            dateStringFrom: departureDateTime,
            dateFormatTo: "yyyy年MM月dd日 週EEEEE"
        )
    }
    
    private func transitCountDescription(_ transitCount: Int?) -> String {
        guard let transitCount else { return "" }
        return transitCount == 0 ? "直飛" : "轉機\(transitCount)次"
    }
    
    // MARK: 住宿
    private func setupHotelCard(response: PackagesDynamicBundleResponse) {
        let conditionDetail = response.conditionDetail
        let hotelPreselection = response.hotelPreselection
        let roomInfo = hotelPreselection?.roomInfo
        let hotelInfo = hotelPreselection?.hotelInfoList?.first
        
        guard hotelInfo != nil || roomInfo != nil else {
            hotelInfoCard = nil
            hotelBookingRuleDesc = nil
            return
        }
        
        hotelInfoCard = PackagesComboHotelInfoModel(
            hotelNotice: response.noticeContent?.warningTimeText ?? "",
            checkInOutDate: setCheckInOutDate(from: conditionDetail),
            hotelImg: hotelInfo?.hotelImg ?? "",
            hotelChineseName: hotelInfo?.hotelChineseName ?? "",
            hotelEnglishName: hotelInfo?.hotelEnglishName ?? "",
            hotelRating: hotelInfo?.hotelRating,
            hotelGrade: hotelInfo?.hotelGrade,
            gradeDesc: hotelInfo?.gradeDesc ?? "",
            roomDescription: roomInfo?.roomDescription ?? "",
            breakfastMark: roomInfo?.breakfastMark ?? false,
            breakfastType: roomInfo?.breakfastType ?? "",
            guaranteeMark: roomInfo?.guaranteeMark ?? false, // false:可免費取消; true:不可更改、取消及退費
            bookingRule: roomInfo?.bookingRule ?? "",
            hotelTagList: hotelPreselection?.displayTag ?? [],
            hotelGreenMark: hotelInfo?.hotelGreenMark ?? false
        )
        
        setHotelBookingRule(response: response)
    }
    
    private func setCheckInOutDate(from conditionDetail: PackagesDynamicBundleResponse.ConditionDetail?) -> String {
        let checkInDate = checkDateValue(conditionDetail?.checkInDate, secondaryValue: conditionDetail?.departureDate)
        let checkOutDate = checkDateValue(conditionDetail?.checkOutDate, secondaryValue: conditionDetail?.returnDate)
        let convertedCheckInDate = convertDateString(dateString: checkInDate, joinedString: "月")
        let convertedCheckOutDate = convertDateString(dateString: checkOutDate, joinedString: "月")
        let nightDesc = conditionDetail?.nightDesc ?? "-"
        
        return "\(convertedCheckInDate)日-\(convertedCheckOutDate)日 (\(nightDesc))"
    }
    
    private func checkDateValue(_ value: String?, secondaryValue: String?) -> String {
        let primaryValue = value ?? ""
        return primaryValue.isEmpty == false ? primaryValue : (secondaryValue ?? "")
    }
    
    private func setHotelBookingRule(response: PackagesDynamicBundleResponse) {
        let roomInfo = response.hotelPreselection?.roomInfo
        let title = roomInfo?.bookingRuleTitle ?? ""
        
        guard roomInfo != nil else {
            hotelBookingRuleDesc = nil
            return
        }
        
        if roomInfo?.bookingRule == "點此查看是否可免費取消" {
            // /Products/Hotel/IsGuarantee
            /*
             request:
             "Flow_Id": "43fedee98c3563bd5b70f5433ac61e486b5168e0",
             "Price_Id": "5g4Trg9v7Rd3qE+WXb++ZDQva2YxuPzMDfACF3jzk3E="
             */
            let flowId = response.flowId ?? ""
            let priceId = response.hotelPreselection?.priceId ?? ""
            let hotelIsGuaranteeResponse = PackagesHotelIsGuaranteeResponse(
                guaranteeMark: false,
                serviceFeeDesc: "此為機加酒服務套裝組合，需連同機票一起調整，並另收可樂旅遊服務費TWD 500/次。BBBBB",
                cancelDesc: "在2026年06月16日 18:00前可免費取消。(如有變動將另行通知)AAAAA"
            )
            
            setHotelBookingRuleDesc(
                title: title,
                serviceFeeDesc: hotelIsGuaranteeResponse.serviceFeeDesc ?? "",
                cancelDesc: hotelIsGuaranteeResponse.cancelDesc ?? ""
            )
            return
        }
        
        setHotelBookingRuleDesc(
            title: title,
            serviceFeeDesc: roomInfo?.serviceFeeDesc ?? "",
            cancelDesc: roomInfo?.cancelDesc ?? ""
        )
    }
    
    private func setHotelBookingRuleDesc(title: String, serviceFeeDesc: String, cancelDesc: String) {
        let noticeDetailList: [PackagesNoticeDetail] = [
            PackagesNoticeDetail(title: "", content: serviceFeeDesc),
            PackagesNoticeDetail(title: "", content: cancelDesc)
        ].compactMap({$0.content.isEmpty ? nil : $0})
        
        if noticeDetailList.isEmpty == false {
            hotelBookingRuleDesc = PackagesNoticeDetailInfo(
                navTitle: title,
                noticeDetailList: noticeDetailList
            )
        } else {
            hotelBookingRuleDesc = nil
        }
    }
    
    private func convertDateString(dateString: String, joinedString: String) -> String {
        return dateString.split(separator: "/").dropFirst().joined(separator: joinedString)
    }
    
    // MARK: 售價明細
    private func setupAmountDetail(response: PackagesDynamicBundleResponse) {
        let personDetailList = [
            setPersonDetail(
                appellation: "大人",
                perPrice: response.adtPerPrice,
                totalPrice: response.adtTotalPrice,
                numberOfPeople: response.conditionDetail?.adultsNumber
            ),
            setPersonDetail(
                appellation: "小孩",
                perPrice: response.chdPerPrice,
                totalPrice: response.chdTotalPrice,
                numberOfPeople: response.conditionDetail?.childNumber
            )
        ].compactMap { $0 }
        
        let discountList: [PackagesComboAmountDiscount] = [
            PackagesComboAmountDiscount(isDiscount: true,
                                        title: "優惠代碼折扣",
                                        content: "晚鳥清艙折抵800元",
                                        discount: "-$2,000"),
            PackagesComboAmountDiscount(isDiscount: false,
                                        title: "可樂旅遊幣折抵",
                                        content: "均分於所有旅客",
                                        discount: "-$120")
        ]
        
        amountDetail = personDetailList.isEmpty && discountList.isEmpty
        ? nil
        : PackagesComboAmountModel(personDetailList: personDetailList, discountList: discountList)
    }
    
    private func setPersonDetail(appellation: String, perPrice: Int?, totalPrice: Int?, numberOfPeople: Int?) -> PackagesComboAmountPersonDetail? {
        guard let perPrice, let totalPrice, let numberOfPeople, numberOfPeople > 0 else { return nil }
        
        return PackagesComboAmountPersonDetail(
            appellation: appellation,
            pricePrePerson: "$\(perPrice.priceAddDot())",
            numberOfPeople: "x\(numberOfPeople)",
            totalPrice: "$\(totalPrice.priceAddDot())"
        )
    }
    
    private func load<T: Decodable>(_ filename: String) -> T {
        let data: Data
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
}
