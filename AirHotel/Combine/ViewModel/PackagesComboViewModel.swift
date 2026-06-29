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
    
    enum BookingRuleKey: String {
        case Refundable
        case NonRefundable
        
        var imageName: String {
            switch self {
            case .Refundable:
                "ic_check_16"
            case .NonRefundable:
                "ic_cancel_16"
            }
        }
    }
    
    @Published var navInfo: PackagesComboNavInfo?
    @Published var policyNotice: PackagesNoticeDetailInfo?
    @Published var stopBookingNotice: (config: PackagesComboSystemNoticeConfig?, detailInfo: PackagesNoticeDetailInfo?)?
    @Published var announceNotice: (config: PackagesComboSystemNoticeConfig?, detailInfo: PackagesNoticeDetailInfo?)?
    
    //機票
    @Published var airInfoCard: PackagesComboAirInfoCard = PackagesComboAirInfoCard(
        flights: [
            PackagesComboFlightSegment(
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
            PackagesComboFlightSegment(
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
        ],
        airTagList: ["慶祝台灣隊金牌", "旅展促銷活動", "新春節團購", "春節快樂", "元宵節"],
        luggageType: .partial
    )
    
    //飯店
    @Published var hotelInfoCard: PackagesComboHotelInfoModel?
    
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
    
    // 房型取消限制說明
    let hotelCancelNotice: PackagesNoticeDetailInfo = PackagesNoticeDetailInfo(
        navTitle: "可免費取消",
        noticeDetailList:
            [
                PackagesNoticeDetail(title: "",
                                     content: "此為機加酒套裝組合，需連同機票一起調整，並另收可樂旅遊服務費TWD 500/次。 \n在2026年4月13日 18:00前可免費取消。(如有變動將另行通知)")
            ]
    )
    
    func onViewAppear() {
        let response: PackagesDynamicBundleResponse = load("Combo.json")
        print(response)
        setNav(conditionDetail: response.conditionDetail)
        setNotices(noticeContent: response.noticeContent)
        setHotelCard(response: response)
    }
    
    private func setNav(conditionDetail: PackagesDynamicBundleResponse.ConditionDetail?) {
        guard let conditionDetail else { return }
        // 改成用 Request 資料！「更改搜尋」也是！！！
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
    
    private func setHotelCard(response: PackagesDynamicBundleResponse) {
        let warningTimeText = response.noticeContent?.warningTimeText ?? ""
        
        let checkInDate = convertDateString(dateString: response.conditionDetail?.checkInDate ?? "", joinedString: "月")
        let checkOutDate = convertDateString(dateString: response.conditionDetail?.checkOutDate ?? "", joinedString: "月")
        let nightDesc = response.conditionDetail?.nightDesc ?? "-"
        let checkInOutDate = "\(checkInDate)日-\(checkOutDate)日 (\(nightDesc)晚)"
        
        let hotelPreselection = response.hotelPreselection
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
            hotelStar: "\(Int(hotelGrade))星飯店",
            roomDescription: hotelPreselection?.roomInfo?.roomDescription ?? "",
            hasBreakfast: false,
            bookingRuleKey: .Refundable,
            bookingRule: "可免費取消", //"不可更改、取消及退費"
            hotelTagList: hotelPreselection?.displayTag ?? [],
            hotelGreenMark: hotelInfo?.hotelGreenMark ?? false
        )
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
