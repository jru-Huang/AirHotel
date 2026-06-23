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
    
    @Published var navInfo: PackagesComboNavInfo = PackagesComboNavInfo(location: "台北–東京", date: "01/24–01/28", roomAndPeople: "1間房，4大人1小孩")
    
    //稅收資訊公告
    @Published var taxNotice: String = "東京從2002年10月徵收住宿税。徵税標準根據住宿金額按每人每晚徵收，每晚住宿費在1萬日元以上每人每晚徵收100日元，1.5萬日元以上每人每晚徵收200日元，部分房價不包含住宿税，需客人另付前臺，具體以飯店告知為準。"
    
    // 機票更新資訊公告
    @Published var systemNotice1: PackagesComboNoticeInfo =
    PackagesComboNoticeInfo(imageName: "ic_time_20",
                        content: "有位低價機票將於 23:20 - 24:00 進行全球價格同步，暫時停止訂位，若有訂購需求，請於 23:20 前完成訂位與付款",
                        bgColor: AppColor.Surface.brandPrimaryExtraSubtle,
                        strokeColor: AppColor.Border.brandPrimarySubtle)
    
    //臨時資訊公告
    @Published var systemNotice2: PackagesComboNoticeInfo =
    PackagesComboNoticeInfo(imageName: "ic_bell_20",
                        content: "春節期間（2/8–2/14），官網與系統皆正常運作，客服服務時間為 09:00–18:00，如有急件需求可透過線上客服聯繫，感謝您的體諒與支持，祝您新春愉快。",
                        bgColor: AppColor.Surface.brandSecondaryExtraSubtle,
                        strokeColor: AppColor.Border.brandSecondarySubtle)
    
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
    @Published var hotelInfoCard: PackagesComboHotelInfoCard = PackagesComboHotelInfoCard(
        hotelNotice: "您的去程航班為 01/24 12:05 抵達，請留意入住日、回程航班為 01/28 03:05 出發請留意退房日。",
        checkInOutDate: "01月24日-01月28日 (4晚)",
        hotelName: "JR九州最大五星超高級日本大都五星超高級日本大都五星超高級會酒池袋總店會酒池袋總店啊",
        hotelSubtitle: "HOTEL METROPOLITAN TOKYO IKEBUKUROHOTE HOTEL METROPOLITAN TOKYO IKEBUKUROHOTE",
        overall: "4.3",
        hotelGrade: 3.5,
        starHotel: "4星飯店",
        hasBreakfast: false,
        bookingRuleKey: .Refundable,
        bookingRule: "可免費取消", //"不可更改、取消及退費"
        hotelTagList: ["慶祝台灣隊金牌","旅展促銷","限時早鳥優惠","週三狂歡日","慶祝台灣隊金牌2"]
    )
    
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
    
    // 稅收內容公告
    let taxNoticeInfo: PackagesNoticeDetailInfo = PackagesNoticeDetailInfo(
        navTitle: "注意事項",
        noticeInfoList:
            [
                PackagesNoticeDetail(title: "日本政府政策：酒店房租稅",
                             content: "東京從2002年10月起徵收住宿稅。徵稅標準根據住宿金額按每人每晚徵收，每晚住宿費在1萬日元以上每人每晚徵收100日元，1.5萬日元以上每人每晚徵收200日元，部分房價不包含住宿稅，需客人另付前臺，具體以飯店告知爲準。"),
                PackagesNoticeDetail(title: "日本政府政策：酒店房租稅",
                             content: "東京從2002年10月起徵收住宿稅。徵稅標準根據住宿金額按每人每晚徵收，每晚住宿費在1萬日元以上每人每晚徵收100日元，1.5萬日元以上每人每晚徵收200日元，部分房價不包含住宿稅，需客人另付前臺，具體以飯店告知爲準。"),
                PackagesNoticeDetail(title: "日本政府政策：酒店房租稅",
                             content: "東京從2002年10月起徵收住宿稅。徵稅標準根據住宿金額按每人每晚徵收，每晚住宿費在1萬日元以上每人每晚徵收100日元，1.5萬日元以上每人每晚徵收200日元，部分房價不包含住宿稅，需客人另付前臺，具體以飯店告知爲準。"),
                PackagesNoticeDetail(title: "日本政府政策：酒店房租稅",
                             content: "東京從2002年10月起徵收住宿稅。徵稅標準根據住宿金額按每人每晚徵收，每晚住宿費在1萬日元以上每人每晚徵收100日元，1.5萬日元以上每人每晚徵收200日元，部分房價不包含住宿稅，需客人另付前臺，具體以飯店告知爲準。"),
                PackagesNoticeDetail(title: "日本政府政策：酒店房租稅",
                             content: "東京從2002年10月起徵收住宿稅。徵稅標準根據住宿金額按每人每晚徵收，每晚住宿費在1萬日元以上每人每晚徵收100日元，1.5萬日元以上每人每晚徵收200日元，部分房價不包含住宿稅，需客人另付前臺，具體以飯店告知爲準。"),
                PackagesNoticeDetail(title: "日本政府政策：酒店房租稅",
                             content: "東京從2002年10月起徵收住宿稅。徵稅標準根據住宿金額按每人每晚徵收，每晚住宿費在1萬日元以上每人每晚徵收100日元，1.5萬日元以上每人每晚徵收200日元，部分房價不包含住宿稅，需客人另付前臺，具體以飯店告知爲準。"),
                PackagesNoticeDetail(title: "日本政府政策：酒店房租稅",
                             content: "東京從2002年10月起徵收住宿稅。徵稅標準根據住宿金額按每人每晚徵收，每晚住宿費在1萬日元以上每人每晚徵收100日元，1.5萬日元以上每人每晚徵收200日元，部分房價不包含住宿稅，需客人另付前臺，具體以飯店告知爲準。"),
                PackagesNoticeDetail(title: "日本政府政策：酒店房租稅",
                             content: "東京從2002年10月起徵收住宿稅。徵稅標準根據住宿金額按每人每晚徵收，每晚住宿費在1萬日元以上每人每晚徵收100日元，1.5萬日元以上每人每晚徵收200日元，部分房價不包含住宿稅，需客人另付前臺，具體以飯店告知爲準。"),
                PackagesNoticeDetail(title: "日本政府政策：酒店房租稅",
                             content: "東京從2002年10月起徵收住宿稅。徵稅標準根據住宿金額按每人每晚徵收，每晚住宿費在1萬日元以上每人每晚徵收100日元，1.5萬日元以上每人每晚徵收200日元，部分房價不包含住宿稅，需客人另付前臺，具體以飯店告知爲準。")
             
            ]
        )
    
    //系統內容公告: 有位低價
    let systemNoticeInfo1: PackagesNoticeDetailInfo = PackagesNoticeDetailInfo(
        navTitle: "系統公告",
        noticeInfoList:
            [
                PackagesNoticeDetail(title: "",
                             content: "有位低價機票將於 23:20 - 24:00 進行全球價格同步，暫時停止訂位，若有訂購需求，請於 23:20 前完成訂位與付款")
                ]
        )
    //系統內容公告: 臨時公告
    let systemNoticeInfo2: PackagesNoticeDetailInfo = PackagesNoticeDetailInfo(
        navTitle: "系統公告",
        noticeInfoList:
            [
                PackagesNoticeDetail(title: "",
                             content: "春節期間（2/8–2/14），官網與系統皆正常運作，客服服務時間為 09:00–18:00，如有急件需求可透過線上客服聯繫，感謝您的體諒與支持，祝您新春愉快。")
                ]
        )
    
    // 房型取消限制說明
    let hotelCancelNotice: PackagesNoticeDetailInfo = PackagesNoticeDetailInfo(
        navTitle: "可免費取消",
        noticeInfoList:
            [
                PackagesNoticeDetail(title: "",
                             content: "此為機加酒套裝組合，需連同機票一起調整，並另收可樂旅遊服務費TWD 500/次。 \n在2026年4月13日 18:00前可免費取消。(如有變動將另行通知)")
                ]
        )
    
    func onViewAppear() {
        let response: PackagesDynamicBundleResponse = load("Combo.json")
        print(response)
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
