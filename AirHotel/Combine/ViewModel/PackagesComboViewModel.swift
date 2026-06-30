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
    
    @Published var navInfo: PackagesComboNavInfo?
    @Published var policyNotice: PackagesNoticeDetailInfo?
    @Published var stopBookingNotice: (config: PackagesComboSystemNoticeConfig?, detailInfo: PackagesNoticeDetailInfo?)?
    @Published var announceNotice: (config: PackagesComboSystemNoticeConfig?, detailInfo: PackagesNoticeDetailInfo?)?
    @Published var airInfoCard: PackagesComboAirInfoModel?
    @Published var hotelInfoCard: PackagesComboHotelInfoModel?
    @Published var hotelBookingRuleDesc: PackagesNoticeDetailInfo?
    
    //優惠
    @Published var discountInfoCard: PackagesComboDiscountInfoCard = PackagesComboDiscountInfoCard(
        discount: "優惠折扣買大送小優惠折扣買大送小優惠折扣買大送小優惠折扣買大送小",
        discountError: "此優惠代碼已全數兌換完畢。此優惠代碼已全數兌換完畢。此優惠代碼已全數兌換完畢。此優惠代碼已全數兌換完畢。"
    )
    
    //售價明細
    @Published var amountInfo: PackagesComboAmountInfo = PackagesComboAmountInfo(
        detailInfo: [
            PackagesComboAmountDetailInfo(appellation: "大人",
                                          pricePrePerson: "$17,200",
                                          numberOfPeople: "x4",
                                          totalPrice: "$68,800"),
            PackagesComboAmountDetailInfo(appellation: "小孩",
                                          pricePrePerson: "$17,200",
                                          numberOfPeople: "x1",
                                          totalPrice: "$17,200")
        ],discountInfo: [
            PackagesComboAmountDiscountInfo(isDiscount: true,
                                            title: "優惠代碼折扣",
                                            content: "晚鳥清艙折抵800元",
                                            discount: "-$2,000"),
            PackagesComboAmountDiscountInfo(isDiscount: false,
                                            title: "可樂旅遊幣折抵",
                                            content: "均分於所有旅客",
                                            discount: "-$120")
        ])
    
    func onViewAppear() {
        let response: PackagesDynamicBundleResponse = load("Combo.json")
        setupNav(conditionDetail: response.conditionDetail)
        setupNotices(noticeContent: response.noticeContent)
        setupAirInfoCard(response: response)
        setupHotelCard(response: response)
    }
    
    private func setupNav(conditionDetail: PackagesDynamicBundleResponse.ConditionDetail?) {
        guard let conditionDetail else { return }
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
    
    private func setupNotices(noticeContent: PackagesDynamicBundleResponse.NoticeContent?) {
        if let policyList = noticeContent?.policyList, policyList.isEmpty == false {
            let detailList = policyList.compactMap { policy -> PackagesNoticeDetail? in
                PackagesNoticeDetail(title: policy.title ?? "", content: policy.text ?? "")
            }
            
            policyNotice = PackagesNoticeDetailInfo(navTitle: "注意事項", noticeDetailList: detailList)
        }
        
        if noticeContent?.stopBookingText?.isEmpty == false {
            let stopBookingNoticeConfig = setSystemNotice(
                contentList: noticeContent?.stopBookingText.map { [$0] },
                imageName: "ic_time_20",
                bgColor: AppColor.Surface.brandPrimaryExtraSubtle,
                strokeColor: AppColor.Border.brandPrimarySubtle
            )
            stopBookingNotice = (stopBookingNoticeConfig.noticeConfig, stopBookingNoticeConfig.detailInfo)
        }
        
        if noticeContent?.announceTextList?.isEmpty == false {
            let announceNoticeConfig = setSystemNotice(
                contentList: noticeContent?.announceTextList,
                imageName: "ic_bell_20",
                bgColor: AppColor.Surface.brandSecondaryExtraSubtle,
                strokeColor: AppColor.Border.brandSecondarySubtle
            )
            announceNotice = (announceNoticeConfig.noticeConfig, announceNoticeConfig.detailInfo)
        }
    }
    
    private func setSystemNotice(contentList: [String]?, imageName: String, bgColor: Color, strokeColor: Color) -> (noticeConfig: PackagesComboSystemNoticeConfig?, detailInfo: PackagesNoticeDetailInfo?) {
        
        guard let contentList else { return (nil, nil) }
        
        return (
            PackagesComboSystemNoticeConfig(
                imageName: imageName,
                content: contentList.first ?? "",
                bgColor: bgColor,
                strokeColor: strokeColor
            ),
            PackagesNoticeDetailInfo(
                navTitle: "系統公告",
                noticeDetailList: contentList.map { PackagesNoticeDetail(title: "", content: $0) }
            )
        )
    }
    
    private func setupAirInfoCard(response: PackagesDynamicBundleResponse) {
        let segmentInfoList = response.airTicketPreselection?.segmentInfoList ?? []
        let departureSegment = segmentInfoList.first?.segmentContent
        let returnSegment = segmentInfoList.dropFirst().first?.segmentContent
        let departureFlight = departureSegment?.flightList?.first
        let returnFlight = returnSegment?.flightList?.first
        let isLocDifferent = departureFlight?.arrivalLocCode != returnFlight?.departureLocCode

        airInfoCard = PackagesComboAirInfoModel(
            segmentInfoList: [
                setSegmentInfoModel(
                    type: "去程",
                    segment: departureSegment,
                    flight: departureFlight,
                    isDepLocHighlight: false,
                    isArrLocHighlight: isLocDifferent
                ),
                setSegmentInfoModel(
                    type: "回程",
                    segment: returnSegment,
                    flight: returnFlight,
                    isDepLocHighlight: isLocDifferent,
                    isArrLocHighlight: false
                )
            ],
            airTagList: response.airTicketPreselection?.displayTag ?? [],
            luggageType: .partial // jru:待確認
        )
    }
    
    private func setupHotelCard(response: PackagesDynamicBundleResponse) {
        let conditionDetail = response.conditionDetail
        let hotelPreselection = response.hotelPreselection
        let roomInfo = hotelPreselection?.roomInfo
        let hotelInfo = hotelPreselection?.hotelInfoList?.first
        
        hotelInfoCard = PackagesComboHotelInfoModel(
            hotelNotice: response.noticeContent?.warningTimeText ?? "",
            checkInOutDate: setCheckInOutDate(from: conditionDetail),
            hotelImg: hotelInfo?.hotelImg ?? "",
            hotelChineseName: hotelInfo?.hotelChineseName ?? "",
            hotelEnglishName: hotelInfo?.hotelEnglishName ?? "",
            hotelRating: hotelInfo?.hotelRating ?? 0.0,
            hotelGrade: hotelInfo?.hotelGrade ?? 0.0,
            gradeDesc: hotelInfo?.gradeDesc ?? "",
            roomDescription: roomInfo?.roomDescription ?? "",
            breakfastMark: roomInfo?.breakfastMark ?? false,
            breakfastType: roomInfo?.breakfastType ?? "",
            guaranteeMark: roomInfo?.guaranteeMark ?? true, // false:可免費取消; true:不可更改、取消及退費
            bookingRule: roomInfo?.bookingRule ?? "",
            hotelTagList: hotelPreselection?.displayTag ?? [],
            hotelGreenMark: hotelInfo?.hotelGreenMark ?? false
        )

        setHotelBookingRule(response: response)
    }

    private func setSegmentInfoModel(type: String, segment: PackagesDynamicBundleResponse.SegmentContent?, flight: PackagesDynamicBundleResponse.Flight?, isDepLocHighlight: Bool, isArrLocHighlight: Bool) -> PackagesComboSegmentInfoModel {
        PackagesComboSegmentInfoModel(
            type: type,
            date: formatSegmentDate(segment?.departureDateTime),
            noticeText: "？？？", //多家航空
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

        if roomInfo?.bookingRule == "點此查看是否可免費取消" {
            // /Products/Hotel/IsGuarantee
            /*
            request:
                "Flow_Id": "43fedee98c3563bd5b70f5433ac61e486b5168e0",
                "Price_Id": "5g4Trg9v7Rd3qE+WXb++ZDQva2YxuPzMDfACF3jzk3E="
             */
            let flowId = response.flowId ?? ""
            let priceId = response.hotelPreselection?.priceId ?? ""
            _ = flowId
            _ = priceId
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
        }
    }
    
    private func convertDateString(dateString: String, joinedString: String) -> String {
      return dateString.split(separator: "/").dropFirst().joined(separator: joinedString)
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
