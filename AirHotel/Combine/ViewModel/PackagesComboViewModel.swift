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
        print(response)
        setNav(conditionDetail: response.conditionDetail)
        setNotices(noticeContent: response.noticeContent)
        setAirInfoCard(response: response)
        setHotelCard(response: response)
    }
    
    private func setNav(conditionDetail: PackagesDynamicBundleResponse.ConditionDetail?) {
        guard let conditionDetail else { return }
        // jru: 改成用 Request 資料！「更改搜尋」也是！！！
        let depName = conditionDetail.departureName ?? ""
        let arrivalName = conditionDetail.arrivalName ?? ""
        let depDate = convertDateString(dateString: conditionDetail.departureDate ?? "", joinedString: "/")
        let returnDate = convertDateString(dateString: conditionDetail.returnDate ?? "", joinedString: "/")
        let roomAndPeople = "\("從request帶？")"
        navInfo = PackagesComboNavInfo(location: "\(depName)-\(arrivalName)",
                                       date: "\(depDate)–\(returnDate)",
                                       roomAndPeople: "\(conditionDetail.roomNumber ?? 0)間房，\(roomAndPeople)")
    }
    
    private func setNotices(noticeContent: PackagesDynamicBundleResponse.NoticeContent?) {
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
    
    private func setAirInfoCard(response: PackagesDynamicBundleResponse) {
        let depSegment = response.airTicketPreselection?.segmentInfoList?[0].segmentContent
        let depFlight = depSegment?.flightList?.first
        let returnSegment = response.airTicketPreselection?.segmentInfoList?[1].segmentContent
        let returnFlight = returnSegment?.flightList?.first
        
        let depDateTime = FormatUtil.convertStringToString(dateStringFrom: depSegment?.departureDateTime, dateFormatTo: "yyyy年MM月dd日 週EEEEE")
        let returnDateTime = FormatUtil.convertStringToString(dateStringFrom: returnSegment?.departureDateTime, dateFormatTo: "yyyy年MM月dd日 週EEEEE")
        
        var depTransitCountDesc = ""
        if let transitCount = depSegment?.transitCount {
            depTransitCountDesc = transitCount == 0 ? "直飛" : "轉機\(transitCount)次"
        }else {
            depTransitCountDesc = ""
        }
        
        var returnTransitCountDesc = ""
        if let transitCount = returnSegment?.transitCount {
            returnTransitCountDesc = transitCount == 0 ? "直飛" : "轉機\(transitCount)次"
        }else {
            returnTransitCountDesc = ""
        }
        
        let isLocDiff = (depFlight?.arrivalLocCode != returnFlight?.departureLocCode)
        
        airInfoCard = PackagesComboAirInfoModel(
            segmentInfoList: [
                PackagesComboSegmentInfoModel(
                    type: "去程",
                    date: depDateTime,
                    noticeText: "？？？", //多家航空
                    carrierLogo: depFlight?.carrierLogo ?? "",
                    ticketingCarrier: depFlight?.ticketingCarrier ?? "",
                    depTime: depSegment?.departureTime ?? "",
                    depLocation: depSegment?.departureLocCode ?? "",
                    depTerminal: "Terminal",
                    arrTime: depSegment?.arrivalTime ?? "",
                    arrLocation: depSegment?.arrivalLocCode ?? "",
                    arrTerminal: "Terminal",
                    dateVariation: depFlight?.dateVariation ?? "",
                    segmentTimeDesc: depSegment?.segmentTimeDesc ?? "",
                    transitCountDesc: depTransitCountDesc,
                    isDepLocHighlight: false,
                    isArrLocHighlight: isLocDiff
                ),
                PackagesComboSegmentInfoModel(
                    type: "回程",
                    date: returnDateTime,
                    noticeText: "？？？",
                    carrierLogo: returnFlight?.carrierLogo ?? "",
                    ticketingCarrier: returnFlight?.ticketingCarrier ?? "",
                    depTime: returnSegment?.departureTime ?? "",
                    depLocation: returnSegment?.departureLocCode ?? "",
                    depTerminal: "Terminal",
                    arrTime: returnSegment?.arrivalTime ?? "",
                    arrLocation: returnSegment?.arrivalLocCode ?? "",
                    arrTerminal: "Terminal",
                    dateVariation: returnFlight?.dateVariation ?? "",
                    segmentTimeDesc: returnSegment?.segmentTimeDesc ?? "",
                    transitCountDesc: returnTransitCountDesc,
                    isDepLocHighlight: isLocDiff,
                    isArrLocHighlight: false
                )
            ],
            airTagList: response.airTicketPreselection?.displayTag ?? [],
            luggageType: .partial // jru:待確認
        )
    }
    
    private func setHotelCard(response: PackagesDynamicBundleResponse) {
        let warningTimeText = response.noticeContent?.warningTimeText ?? ""
        
        let conditionDetail = response.conditionDetail
        let checkInDate = conditionDetail?.checkInDate ?? ""
        let checkOutDate = conditionDetail?.checkOutDate ?? ""
        let checkInDateString = checkInDate.isEmpty == false ? checkInDate : conditionDetail?.departureDate ?? ""
        let checkOutDateString = checkOutDate.isEmpty == false ? checkOutDate : conditionDetail?.returnDate ?? ""
        let convertedCheckInDate = convertDateString(dateString: checkInDateString, joinedString: "月")
        let convertedCheckOutDate = convertDateString(dateString: checkOutDateString, joinedString: "月")
        let nightDesc = response.conditionDetail?.nightDesc ?? "-"
        let checkInOutDate = "\(convertedCheckInDate)日-\(convertedCheckOutDate)日 (\(nightDesc))"
        
        let hotelPreselection = response.hotelPreselection
        let roomInfo = hotelPreselection?.roomInfo
        let hotelInfo = hotelPreselection?.hotelInfoList?.first
        let hotelGrade = hotelInfo?.hotelGrade ?? 0.0
        
        hotelInfoCard = PackagesComboHotelInfoModel(
            hotelNotice: warningTimeText,
            checkInOutDate: checkInOutDate,
            hotelImg: hotelInfo?.hotelImg ?? "",
            hotelChineseName: hotelInfo?.hotelChineseName ?? "",
            hotelEnglishName: hotelInfo?.hotelEnglishName ?? "",
            hotelRating: hotelInfo?.hotelRating ?? 0.0,
            hotelGrade: hotelGrade,
            gradeDesc: hotelInfo?.gradeDesc ?? "",
            roomDescription: roomInfo?.roomDescription ?? "",
            breakfastMark: roomInfo?.breakfastMark ?? false,
            breakfastType: roomInfo?.breakfastType ?? "",
            guaranteeMark: roomInfo?.guaranteeMark ?? true, // false:可免費取消; true:不可更改、取消及退費
            bookingRule: roomInfo?.bookingRule ?? "",
            hotelTagList: hotelPreselection?.displayTag ?? [],
            hotelGreenMark: hotelInfo?.hotelGreenMark ?? false
        )
        
        if roomInfo?.bookingRule == "點此查看是否可免費取消" {
            // /Products/Hotel/IsGuarantee
            /*
            request:
                "Flow_Id": "43fedee98c3563bd5b70f5433ac61e486b5168e0",
                "Price_Id": "5g4Trg9v7Rd3qE+WXb++ZDQva2YxuPzMDfACF3jzk3E="
             */
            let flowId = response.flowId ?? ""
            let priceId = hotelPreselection?.priceId ?? ""
            var hotelIsGuaranteeResponse = PackagesHotelIsGuaranteeResponse(guaranteeMark: false, serviceFeeDesc: "此為機加酒服務套裝組合，需連同機票一起調整，並另收可樂旅遊服務費TWD 500/次。BBBBB", cancelDesc: "在2026年06月16日 18:00前可免費取消。(如有變動將另行通知)AAAAA")
            //response
            setHotelBookingRuleDesc(title: roomInfo?.bookingRuleTitle ?? "", serviceFeeDesc: hotelIsGuaranteeResponse.serviceFeeDesc ?? "", cancelDesc: hotelIsGuaranteeResponse.cancelDesc ?? "")
        }else {
            setHotelBookingRuleDesc(title: roomInfo?.bookingRuleTitle ?? "", serviceFeeDesc: roomInfo?.serviceFeeDesc ?? "", cancelDesc: roomInfo?.cancelDesc ?? "")
        }
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
