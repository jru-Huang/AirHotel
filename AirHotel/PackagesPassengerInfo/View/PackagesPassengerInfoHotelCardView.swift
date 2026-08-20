//
//  PackagesPassengerInfoHotelCardView.swift
//  AirHotel
//
//  Created by 7943 on 2026/8/14.
//

import SwiftUI

struct PackagesPassengerInfoHotelCardView: View {
   
    @Binding var sheetHeight: CGFloat
    @Binding var scrollContentMinY: CGFloat
    @Binding var isAdjustingSheetHeight: Bool

    let detail: PackagesPassengerInfoModel.HotelDetail
    let sheetStyle: ScrollBottomSheetStyle
    let onClose: () -> Void
    
    private let closeButtonHeight: CGFloat = 40
    
    var body: some View {
        VStack(spacing: 0) {
            navTitleView
            
            if #available(iOS 16.4, *) {
                scrollContentView
                    .scrollBounceBehavior(.basedOnSize)
                    .scrollDisabled(isAdjustingSheetHeight && scrollContentMinY >= -sheetStyle.topTolerance)
            } else {
                scrollContentView
            }
            
            closeView(action: onClose)
        }
    }
    
    private var navTitleView: some View {
        var sheetHeaderStyle: SheetHeaderStyle {
            var style = SheetHeaderStyle()
            style.navMidType = .textTitle(text: "入住資訊")
            return style
        }
        
        return SheetHeaderView(style: sheetHeaderStyle, onTouchLeftItem: {
            onClose()
        })
    }
    
    private var scrollContentView: some View {
        ScrollView {
            VStack(spacing: 9) {
                hotelNameSection
                roomDescSection
                bookingRuleSection
                checkInOutSection
                checkInInfoSection
            }
            .frame(maxWidth: .infinity)
            .onHeightChange { height in
                guard height > 0 else { return }
                //先取得scrollView內部contentHeight，再計算sheet總高度
                let calculatedHeight: CGFloat = height + closeButtonHeight + safeAreaBottomInset
                sheetHeight = calculatedHeight
            }
            .onMinYChange(in: .named("scroll")) { value in
                scrollContentMinY = value
            }
        }
        .background(AppColor.Background.pageGray)
        .coordinateSpace(name: "scroll")
    }
    
    private var hotelNameSection: some View {
        Text(detail.hotelChineseName)
            .frame(height: 180)
    }
    
    private var roomDescSection: some View {
        HStack(alignment: .top, spacing: 12) {
            Image("Hotel")
                .frame(width: 58, height: 58)
                .clipShape(RoundedRectangle(cornerRadius: 4))
            
            VStack(alignment: .leading, spacing: 6) {
                Text(detail.roomDescription)
                    .font(AppTypography.B04M)
                    .foregroundStyle(AppColor.Text.neutralBodyBase)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(spacing: 2) {
                    if detail.breakfastMark {
                        Image("ic_breakfast_16_gray") // jur: icon名修改
                    }else {
                        Image("ic_np_breakfast_16_gray")
                    }
                    Text(detail.breakfastType)
                        .font(AppTypography.B05R)
                        .foregroundStyle(AppColor.Text.neutralBodyMid)
                }
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(AppColor.Surface.neutralWhite)
    }
    
    private var bookingRuleSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("取消/更改說明")
                .font(AppTypography.T04M)
                .foregroundStyle(AppColor.Text.neutralBodyBase)
            HStack(spacing: 2) {
                Image("ic_check_16_green")
                Text(detail.bookingRule)
                    .font(AppTypography.B05R)
                    .foregroundStyle(AppColor.Text.stateSuccess)
            }
            
            let ruleList = [detail.serviceFeeDesc, detail.cancelDesc]
            VStack(alignment: .leading, spacing: 0) {
                ForEach(ruleList, id: \.self) { rule in
                    HStack(alignment: .top, spacing: 6) {
                        Text("•")
                        Text(rule)
                    }
                    .font(AppTypography.B05R)
                    .foregroundStyle(AppColor.Text.neutralBodyMid)
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(AppColor.Surface.neutralSubtle)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(AppColor.Surface.neutralWhite)
    }
    
    private var checkInOutSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("入住退房時間")
                .font(AppTypography.T04M)
                .foregroundStyle(AppColor.Text.neutralBodyBase)
            HStack(spacing: 8) {
                Circle()
                    .fill(AppColor.Icon.brandPrimaryMid)
                    .frame(width: 4, height: 4)
                Text("入住時間")
                    .font(AppTypography.T03R)
                    .foregroundStyle(AppColor.Text.neutralBodyMid)
                Text(detail.checkInTime)
                    .font(AppTypography.N05R)
                    .foregroundStyle(AppColor.Text.neutralBodyBase)
            }
            
            HStack(spacing: 8) {
                Circle()
                    .fill(AppColor.Icon.brandPrimaryMid)
                    .frame(width: 4, height: 4)
                Text("退房時間")
                    .font(AppTypography.T03R)
                    .foregroundStyle(AppColor.Text.neutralBodyMid)
                Text(detail.checkOutTime)
                    .font(AppTypography.N05R)
                    .foregroundStyle(AppColor.Text.neutralBodyBase)
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(AppColor.Surface.neutralWhite)
    }
    
    private var checkInInfoSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("入住資訊")
                .font(AppTypography.T04M)
                .foregroundStyle(AppColor.Text.neutralBodyBase)
            Text(detail.checkInfo)
                .font(AppTypography.B05R)
                .foregroundStyle(AppColor.Text.neutralBodyMid)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(AppColor.Surface.neutralWhite)
    }
    
    private func closeView(action: @escaping () -> Void) -> some View {
        VStack(spacing: 0) {
            Button(action: action) {
                Text("關閉")
                    .font(AppTypography.L02M)
                    .foregroundStyle(AppColor.Text.neutralWhite)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(height: 40)
            .background(AppColor.Surface.brandSecondaryBase)
            
            AppColor.Surface.brandSecondaryBase
                .frame(height: safeAreaBottomInset)
        }
    }
}

#Preview {
    PackagesPassengerInfoHotelCardView(
        sheetHeight: .constant(100),
        scrollContentMinY: .constant(0),
        isAdjustingSheetHeight: .constant(false),
        detail: PackagesPassengerInfoModel.HotelDetail(
        hotelChineseName: "JR東日本大都會酒店 池袋 ",
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
        checkInfo: "【入住說明】 入住手續開始時間：15:00 入住手續截止時間：00:00 退房時間：11:00\n若有額外房客入住，住宿業者會依照其規定收取費用\n辦理入住手續時可能需要出示政府核發且附有照片的證件，並以現金作為押金或提供信用卡/金融卡以支付雜費\n 住宿無法保證能符合房客所有特殊住房要求，房客須於辦理入住手續時與住宿確認；特殊入住要求可能需要加收費用\n此住宿接受信用卡、行動支付及現金等付款方式\n行動支付選項包括：PayPay\n請注意，不同國家和不同住宿的文化規範和旅客規定會有所不同，顯示的規定由住宿業者提供"),
                                       
      sheetStyle: ScrollBottomSheetStyle(),
        onClose: {})
}
