//
//  PackagesPassengerInfoViewModel.swift
//  AirHotel
//
//  Created by 7943 on 2026/8/6.
//

import SwiftUI
import Combine // Combine, ObservableObject

enum PackagesPassengerInfoSubmitResult: Equatable {
    case success
    case incompleteTravelerInfo
    case orderTermsNotAccepted
}

class PackagesPassengerInfoViewModel: ObservableObject {
    
    @Published var lineNotice: PackagesDynamicBundleSystemNoticeModel?
    @Published var systemNotice: PackagesDynamicBundleSystemNoticeModel?
    @Published var info: PackagesPassengerInfoModel?
    @Published var remainingCountdownSeconds = 0
    @Published var isShowingExpireTimeDialog = false
    @Published var hasTravelerInfoError = false
    
    private var countdownTimer: Timer?
    
    deinit {
        countdownTimer?.invalidate()
    }
    
    func onViewAppear() {
        setupNotice()
        setupLineNotice()
        updateCountdown(endDateTime: "2026-08-11T15:53:30")
        setInfo()
    }
    
    func dismissExpireTimeDialog() {
        isShowingExpireTimeDialog = false
    }
    
    func submitResult(hasAgreedOrderTerms: Bool) -> PackagesPassengerInfoSubmitResult {
        
        let isTravelerInfoCompleted = info?.travelerInfo.travelerList.allSatisfy { !$0.pax.paxDetailList.isEmpty
        } ?? false
        
        hasTravelerInfoError = !isTravelerInfoCompleted
        
        guard isTravelerInfoCompleted else {
            return .incompleteTravelerInfo
        }
        
        guard hasAgreedOrderTerms else {
            return .orderTermsNotAccepted
        }
        
        return .success
    }
    
    func presentNoticeInfo(_ noticeInfo: PackagesNoticeDetailInfo) {
//        guard let provider = navigationProvider else { return }
//        
//        let view = PackagesNoticeInfoView(
//            info: noticeInfo,
//            onDismiss: { [weak provider] in
//                provider?.dismiss(animated: false, completion: nil)
//            }
//        )
//        let hostingController = NavigationTitleHostingController(
//            rootView: view,
//            navigationTitle: "",
//            navBarVisibility: .hide,
//            navBarBackgroundColor: UIColor.clear
//        )
//        hostingController.view.backgroundColor = .clear
//        hostingController.modalPresentationStyle = .overFullScreen
//        provider.present(hostingController, animated: false, completion: nil)
    }
}

extension PackagesPassengerInfoViewModel {
    
    // MARK: 公告
    private func setupNotice() {
        lineNotice =  PackagesDynamicBundleSystemNoticeModel(
            config: PackagesDynamicBundleSystemNoticeConfig(
                imageName: "ic_line_20",
                content: "此單【目前符合】LINE POINTS 回饋資格！",
                bgColor: AppColor.Surface.marketGreenSubtle,
                strokeColor: AppColor.Border.marketGreenMid
            ),
            detailInfo: nil
        )
    }
    
    private func setupLineNotice() {
        let content = "春節期間（2/8–2/14），官網與系統皆正常運作，客服服務時間為 09:00–18:00，如有急件需求可透過線上客服聯繫，感謝您的體諒與支持，祝您新春愉快。"
        systemNotice = PackagesDynamicBundleSystemNoticeModel(
            config: PackagesDynamicBundleSystemNoticeConfig(
                imageName: "ic_bell_20",
                content: content,
                bgColor: AppColor.Surface.brandSecondaryExtraSubtle,
                strokeColor: AppColor.Border.brandSecondarySubtle
            ),
            detailInfo: PackagesNoticeDetailInfo(
                navTitle: "系統公告",
                noticeDetailList: [PackagesNoticeDetail(title: "", content: content)]
            )
        )
    }
    
    // MARK: 時效
    private func updateCountdown(endDateTime: String?) {
        startCountdown(endDateTime: endDateTime)
    }
    
    private func startCountdown(endDateTime: String?) {
        invalidateCountdownTimer()
        
        let endDate = FormatUtil.convertStringToDate(
            dateFormatFrom: "yyyy-MM-dd'T'HH:mm:ss",
            dateString: endDateTime ?? ""
        )
        
        guard let endDate else {
            remainingCountdownSeconds = 0
            isShowingExpireTimeDialog = false
            return
        }
        
        updateRemainingSeconds(until: endDate)
        
        if remainingCountdownSeconds == 0 {
            isShowingExpireTimeDialog = true
            return
        }
        
        isShowingExpireTimeDialog = false
        
        let timer = Timer(timeInterval: 1, repeats: true) { [weak self] _ in
            Task { @MainActor in
                self?.handleCountdownTick(endDate: endDate)
            }
        }
        
        countdownTimer = timer
        RunLoop.main.add(timer, forMode: .common)
    }
    
    private func handleCountdownTick(endDate: Date) {
        updateRemainingSeconds(until: endDate)
        
        guard remainingCountdownSeconds == 0 else {
            return
        }
        
        invalidateCountdownTimer()
        isShowingExpireTimeDialog = true
    }
    
    private func updateRemainingSeconds(until endDate: Date) {
        remainingCountdownSeconds = max(0, Int(ceil(endDate.timeIntervalSinceNow)))
    }
    
    private func invalidateCountdownTimer() {
        countdownTimer?.invalidate()
        countdownTimer = nil
    }
    
    func setInfo() {
        info =
        PackagesPassengerInfoModel(
            airInfo: PackagesPassengerInfoModel.AirInfoModel(
                depLocation: "台北",
                returnLocation: "東京",
                airSegmentList: [
                    PackagesPassengerInfoModel.AirSegment(
                        airType: "去程",
                        date: "2026-08-11T10:45:00",
                        depAirport: "桃園機場",
                        depTerminal: "T1",
                        arrAirport: "東京羽田機場",
                        arrTerminal: "T2"),
                    PackagesPassengerInfoModel.AirSegment(
                        airType: "回程",
                        date: "2026-08-16T20:15:00",
                        depAirport: "東京羽田機場",
                        depTerminal: "T2",
                        arrAirport: "桃園機場",
                        arrTerminal: "T1")
                ]),
            hotelInfo:
                PackagesPassengerInfoModel.HotelInfoModel(
                    hotelName: "JR九州最大五星超高級日本大都會酒JR九州最大五星超高級日本大都會酒",
                    checkInDate: "09/12 (二)",
                    checkOutDate: "09/28 (二)",
                    roomDesc: "標準雙床房，非吸菸房(View will be selected by the hotel )",
                    hotelDetail:
                        PackagesPassengerInfoModel.HotelDetail(
                            hotelChineseName: "JR東日本大都會酒店 池袋JR東日本大都會酒店 池袋 ",
                            hotelEnglishName: "HOTEL METROPOLITAN TOKYO IKEBUKUROHOTEL METROPOLITAN TOKYO IKEBUKURO",
                            hotelGrade: 4.2,
                            gradeDesc: "4星級飯店",
                            hotelRating: 4,
                            hotelGreenMark: true,
                            displayTag: ["慶祝台灣隊金牌", "旅展促銷"],
                            roomDescription: "標準雙床房，非吸菸房(View will be selected by the hotel )",
                            breakfastMark: true,
                            breakfastType: "僅包含大人早餐",
                            bookingRule: "05月25日之前可免費取消",
                            guaranteeMark: false,
                            serviceFeeDesc: "● 此為機加酒套裝組合，需連同機票一起調整，並另收可樂旅遊服務費TWD 500/次。",
                            cancelDesc: "● 在2026年4月13日 18:00前可免費取消。(如有變動將另行通知)",
                            checkInTime: "16:00~23:00",
                            checkOutTime: "11:00 前",
                            checkInfo: "【入住說明】 入住手續開始時間：15:00 入住手續截止時間：00:00 退房時間：11:00\n若有額外房客入住，住宿業者會依照其規定收取費用\n辦理入住手續時可能需要出示政府核發且附有照片的證件，並以現金作為押金或提供信用卡/金融卡以支付雜費\n 住宿無法保證能符合房客所有特殊住房要求，房客須於辦理入住手續時與住宿確認；特殊入住要求可能需要加收費用\n此住宿接受信用卡、行動支付及現金等付款方式\n行動支付選項包括：PayPay\n請注意，不同國家和不同住宿的文化規範和旅客規定會有所不同，顯示的規定由住宿業者提供")
                ),
            buyerInfo:
                PackagesPassengerInfoModel.BuyerInfoModel(
                    buyerName: "王大明",
                    buyerEmail: "cola123@gmail.com",
                    buyerPhone: "0912345678",
                    noticeList: ["本系統為自動化機加酒組合訂購服務，僅提供「機票+飯店」套裝銷售，恕不適用信用卡特定合作專案、航空公司額外贈送服務，亦不提供單項加購（如：租車、當地行程）之需求。如您有特殊加購或個別專案需求，請至專屬頁面訂購或洽詢專人處理。", "後續訂購相關通知、付款成功後開立之電子機票及住宿券，將統一寄送至訂購人電子郵件信箱。請務必確認所填寫之聯絡資料正確無誤，以避免因資訊錯誤導致無法順利收取行程重要憑證。"]),
            travelerInfo: PackagesPassengerInfoModel.TravelerInfoModel(
                travelerList: [
                    PackagesPassengerInfoModel.Traveler(room: "房間1", pax: PackagesPassengerInfoModel.Pax(numberOfPeople: "2位大人", paxDetailList: [
                        PackagesPassengerInfoModel.PaxDetail(
                            paxChineseName: "吳威廉",
                            paxSurName: "WU",
                            paxGivenName: "WALLEN",
                            isRoomLeader: true),
                        PackagesPassengerInfoModel.PaxDetail(
                            paxChineseName: "林小美",
                            paxSurName: "Lin",
                            paxGivenName: "Beauty",
                            isRoomLeader: false)
                    ])),
//                    PackagesPassengerInfoModel.Traveler(room: "房間2", pax: PackagesPassengerInfoModel.Pax(numberOfPeople: "2位大人", paxDetailList: [])),
//                    PackagesPassengerInfoModel.Traveler(room: "房間3", pax: PackagesPassengerInfoModel.Pax(numberOfPeople: "2位大人", paxDetailList: []))
                ]),
            priceDetail: PackagesPassengerInfoModel.PriceInfoModel(amount: PackagesPassengerInfoModel.Amount(
                amountPrice: "$68,800", amountDetailList: [
                    PackagesPassengerInfoModel.PricePersonDetail(
                        appellation: "大人",
                        pricePrePerson: "$17,000",
                        numberOfPeople: "x2",
                        totalPrice: "$34,000"),
                    PackagesPassengerInfoModel.PricePersonDetail(
                        appellation: "大人",
                        pricePrePerson: "$17,000",
                        numberOfPeople: "x2",
                        totalPrice: "$34,000"),
                    PackagesPassengerInfoModel.PricePersonDetail(
                        appellation: "大人",
                        pricePrePerson: "$17,000",
                        numberOfPeople: "x2",
                        totalPrice: "$34,000")]),
                                                                   coupon: PackagesPassengerInfoModel.PriceItem(title: "優惠折扣", price: "-$800"),
                                                                   colaCoin: PackagesPassengerInfoModel.PriceItem(title: "可樂旅遊幣", price: "-$1,000"),
                                                                   totalTaxPrice: "$66,200"),
            orderTermsList: [
                PackagesPassengerInfoModel.OrderTermsInfoModel(title: "一、會員服務內容", content: "1. 本網站上公佈的價格，包含套裝行程、飯店、與平假日的價格。不同出發日價格依天數、日期、人數、房型而不同，在網頁上看到的價格，為行程參考價，在確認付款網頁中的價格，才為實際售價，請在付款前仔細查看。對於旅客自行與飯店或交通公司達成的協議，與未包含於行程中的消費，本網站恕不負責。\n2. 本套裝商品售價：機票部分價格皆已包含機場稅費及燃油附加費；訂房部分則已含服務費及當地常規的消費稅，但不包含部分城市政府或酒店可能於不特定期間徵收非常規的特別稅等費用，例如城市稅(City tax)、渡假村及設施使用費(Resort fee)、中國政府調節基金、日本溫泉稅‧‧‧等。此外，床頭小費、行李小費、客房服務費、旅客自行與航空公司達成的協議或其他私人消費支出，應由旅客自行負責。\n3. 機位及訂房價格時有變動，訂購流程中，如有發生異動，頁面會跳出告示視窗，您可選擇接受新價格或重新搜尋，最終價格依訂購頁面最新資訊為準。"),
                PackagesPassengerInfoModel.OrderTermsInfoModel(title: "二、會員服務內容", content: "• 本商品僅適用線上付款，恕不受理其他付款方式及分開付款。\n• 已選擇商品並填寫訂購資料後，送出訂單資料之前，請您詳細檢查『航班資訊』、『票價資訊和行李規定』以及『飯店資訊』，確認符合需求再作訂購。\n• 確認訂購後，您須即時於線上刷卡付款，易遊網將以您所提供的信用卡帳戶進行授權（銀行會有信用卡授權記錄），授權成功即進行機位及飯店預訂作業；倘若機位及飯店預訂失敗，易遊網將經由銀行辦理解除授權(約3~7個工作天，實際天數視各發卡行而定)。\n• 機位和飯店預訂成功後，將於您的信用卡帳戶直接收取已授權的金額，並發送付款成功確認函到您的E-Mail信箱。\n•  訂購成功確認後，易遊網將開立機票行程單及住宿券，並寄送到您的E-Mail信箱。\n•  完成訂購後，若因非旅客個人因素之不可抗力事件（如颱風、火山爆發等）或突發狀況（如機械故障、回航延誤）而導致班機取消或嚴重延誤，請旅客於第一時間告知易遊網，並盡速提供相關證明文件，以利易遊網為您爭取訂單取消免罰（但仍需以航空公司及飯店回覆為準）。若為非台灣上班時間，請即撥打住宿券上之緊急聯絡電話請求協助。遇狀況時，請務必即時採取以上行動，以免因NoShow而無法爭取退費。"),
                PackagesPassengerInfoModel.OrderTermsInfoModel(title: "", content: "附註： 開票完成後，您可返回會員中心享用易遊網的線上選位功能。但仍有部分航空公司並未提供免費預先選位服務，遇無法選位或選位失敗時，建議您於出發日前24至48小時內到航空公司官網預辦線上報到劃位。")]
        )
    }
}
