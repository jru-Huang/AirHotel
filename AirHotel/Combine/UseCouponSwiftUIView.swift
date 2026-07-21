//
//  UseCouponSwiftUIView.swift
//  AirHotel
//
//  Created by 7943 on 2026/7/20.
//

import SwiftUI

enum CouponState {
    case available
    case unAvailable
}

struct CouponModel {
    let note: String = "· 每組優惠代碼皆有適用條件，使用前請詳閱活動網頁說明。\n· 僅適用官網或APP發行的優惠代碼，實體禮券請撥打禮券上的聯絡電話，由專人為您服務。"
    let availableCouponList: [UseCouponModel] = [
        UseCouponModel(isAppOnly: true, discount: "總折抵金額1,000元", couponTitle: "刷彰化銀行無限卡/商旅御璽卡．國外短線團體行程折2000元", dateline: "2026/08/01 23:59 前下單使用", usedTimesTag: "限用一次", couponState: .available, promoCode: "1"),
        UseCouponModel(isAppOnly: false, discount: "每人可折抵金額20元", couponTitle: "玉山國旅卡，長線團體行程折扣", dateline: "2026/08/01", usedTimesTag: "可重複使用", couponState: .available, promoCode: "2"),
        UseCouponModel(isAppOnly: true, discount: "訂購過內外團體旅遊是用行程，大人、小孩佔床/加床之團費折3％", couponTitle: "國泰世華CUBE卡友優惠，團體旅遊行程折3％", dateline: "2026/07/01-2026/08/31", usedTimesTag: "不符合訂購使用條件", couponState: .available, promoCode: "3")
    ]
    let unAvailableCouponList: [UseCouponModel]  = [
        UseCouponModel(isAppOnly: true, discount: "總折抵金額1,000元", couponTitle: "刷彰化銀行無限卡/商旅御璽卡．國外短線團體行程折2000元", dateline: "2026/08/01 23:59 前下單使用", usedTimesTag: "限用一次", couponState: .unAvailable, promoCode: "1x"),
        UseCouponModel(isAppOnly: false, discount: "每人可折抵金額20元", couponTitle: "玉山國旅卡，長線團體行程折扣", dateline: "2026/08/01", usedTimesTag: "可重複使用", couponState: .unAvailable, promoCode: "2x"),
        UseCouponModel(isAppOnly: true, discount: "訂購過內外團體旅遊是用行程，大人、小孩佔床/加床之團費折3％", couponTitle: "國泰世華CUBE卡友優惠，團體旅遊行程折3％", dateline: "2026/07/01-2026/08/31", usedTimesTag: "不符合訂購使用條件", couponState: .unAvailable, promoCode: "3x")
    ]
}

struct UseCouponModel: Identifiable, Hashable {
    let isAppOnly: Bool
    let discount: String
    let couponTitle: String
    let dateline: String
    let usedTimesTag: String
    let couponState: CouponState
    let promoCode: String //唯一值？
    
    var id: String { promoCode }
}

struct UseCouponSwiftUIView: View {
    
    enum TagText: String {
        case onlyOne = "限用一次"
        case repeated = "可重複使用"
        case disable = "不符合訂購使用條件"
        
        var tagTextColor: Color {
            switch self {
            case .onlyOne:
                return AppColor.Text.brandPrimaryBase
            case .repeated:
                return AppColor.Text.neutralBodyMid
            case .disable:
                return AppColor.Text.neutralBodyLight
            }
        }
        
        var tagBorderColor: Color {
            switch self {
            case .onlyOne:
                return AppColor.Border.brandPrimarySubtle
            case .repeated, .disable:
                return AppColor.Border.neutralSubtle
            }
        }
        
        var tagBgColor: Color {
            switch self {
            case .onlyOne, .repeated:
                return .clear
            case .disable:
                return AppColor.Surface.stateDisabled
            }
        }
    }
    
    @State private var inputPromoCode: String = ""
    @State private var selectedPromoCode: String?
    
    let couponModel: CouponModel
    
    var body: some View {
        VStack(spacing: 0) {
            inputView
            
            if !couponModel.note.isEmpty {
                noticeView
            }
            
            if couponModel.availableCouponList.isEmpty && couponModel.unAvailableCouponList.isEmpty {
                emptyCouponView
            }else {
                couponInfoView
            }
            
            confirmButton
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.keyboard)
    }
    
    private var inputView: some View {
        VStack(spacing: 4) {
            HStack(spacing: 8) {
                Image("ic_edit_16")
                    .padding(.leading, 12)
                
                TextField("",
                          text: $inputPromoCode,
                          prompt: couponPrompt)
                .font(AppTypography.B03R)
                .foregroundStyle(AppColor.Text.neutralBodyBase)
                .tint(AppColor.Text.brandPrimaryDark)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 5)
                
                if !inputPromoCode.isEmpty {
                    Button {
                        inputPromoCode = ""
                    } label: {
                        Image("ic_delete_16")
                    }
                    .buttonStyle(.plain)
                }
                
                useButton
            }
            .frame(height: 30)
            .background {
                ZStack {
                    Capsule()
                        .fill(AppColor.Surface.neutralExtraSubtle)
                    
                    Capsule()
                        .stroke(AppColor.Border.neutralSubtle, lineWidth: 1)
                }
            }
            .clipShape(Capsule())
            
            inputError
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(AppColor.Surface.neutralWhite)
    }
    
    private var couponPrompt: Text {
        if #available(iOS 17.0, *) {
            return Text("輸入優惠代碼")
                .foregroundStyle(AppColor.Text.neutralCaption)
        } else {
            return Text("輸入優惠代碼")
                .foregroundColor(AppColor.Text.neutralCaption)
        }
    }
    
    private var useButton: some View {
        Button {
            print("DEBUG: 使用優惠碼 \(inputPromoCode)")
            inputPromoCode  = ""
        } label: {
            Text("使用")
                .font(AppTypography.L02M)
                .foregroundStyle(AppColor.Text.neutralWhite)
                .frame(width: 76)
                .frame(maxHeight: .infinity)
        }
        .buttonStyle(.plain)
        .background(inputPromoCode.isEmpty ? AppColor.Surface.stateDisabled : AppColor.Surface.brandPrimaryMid, in: Capsule())
        .contentShape(Capsule())
        .allowsHitTesting(!inputPromoCode.isEmpty)
    }
    
    private var inputError: some View {
        Text("不符合優惠代碼使用條件，請確認出發/使用日期是否為不適用出發/使用日期內（YYYY/MM/DD～YYYY/MM/DD)。")
            .font(AppTypography.B05R)
            .foregroundStyle(AppColor.Text.stateError)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var noticeView: some View {
        Text(couponModel.note)
            .font(AppTypography.B05R)
            .foregroundStyle(AppColor.Text.neutralBodyMid)
            .multilineTextAlignment(.leading)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity)
            .background(AppColor.Surface.neutralSubtle)
        
    }
    
    private var couponInfoView: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 8) {
                
                if !couponModel.availableCouponList.isEmpty {
                    availableCoupon(count: couponModel.availableCouponList.count)
                    LazyVStack(spacing: 8) {
                        ForEach(couponModel.availableCouponList) { model in
                            couponCard(model: model)
                        }
                    }
                }
                
                if !couponModel.unAvailableCouponList.isEmpty {
                    unavailableCouponTitleView
                    LazyVStack(spacing: 8) {
                        ForEach(couponModel.unAvailableCouponList) { model in
                            couponCard(model: model)
                        }
                    }
                }
            }
            .padding(.vertical, 12)
        }
        .padding(.horizontal, 16)
        .background(AppColor.Background.pagePurple)
    }
    
    private func availableCoupon(count: Int) -> some View {
        HStack(spacing: 2) {
            Text("目前有")
                .font(AppTypography.B05R)
                .foregroundStyle(AppColor.Text.neutralBodyMid)
            Text("(\(count))")
                .font(AppTypography.B05R)
                .foregroundStyle(AppColor.Text.brandPrimaryBase)
            Text("組可使用的優惠代碼")
                .font(AppTypography.B05R)
                .foregroundStyle(AppColor.Text.neutralBodyMid)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var unavailableCouponTitleView: some View {
        Text("無法使用的優惠代碼")
            .font(AppTypography.B05R)
            .foregroundStyle(AppColor.Text.neutralBodyLight)
    }
    
    private func couponCard(model: UseCouponModel) -> some View {
        let isEnabled = model.couponState == .available
        let isSelected = selectedPromoCode == model.promoCode
        
        return  Button {
            selectedPromoCode = model.promoCode
        } label: {
            HStack(spacing: 7) {
                VStack(spacing: 12) {
                    couponDetail(model: model)
                    couponRule(model: model)
                }
                Image(isEnabled ? (isSelected ? "radio_btn_02_on" : "radio_btn_02_off") : "radio_btn_02_disable")
            }
            .padding(16)
        }
        .overlay(alignment: .leading) {
            Rectangle()
                .fill(isEnabled ? AppColor.Border.brandPrimarySubtle : AppColor.Border.stateDisabled)
                .frame(width: 4, alignment: .leading)
            
        }
        .background(isEnabled ? AppColor.Surface.neutralWhite : AppColor.Surface.neutralSubtle)
        .clipShape(RoundedRectangle(cornerRadius: 2))
        .disabled(!isEnabled)
    }
    
    private func couponDetail(model: UseCouponModel) -> some View {
        let isEnabled = model.couponState == .available
        
        return VStack(alignment: .leading, spacing: 4) {
            if model.isAppOnly {
                Text("App限定")
                    .font(AppTypography.T05M)
                    .foregroundStyle(AppColor.Text.neutralWhite)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 6)
                    .background(isEnabled ? AppColor.Surface.marketOrangeDark : AppColor.Surface.stateDisabled, in: RoundedRectangle(cornerRadius: 4))
            }
            
            if !model.discount.isEmpty {
                Text(model.discount)
                    .font(AppTypography.T01M)
                    .foregroundStyle(isEnabled ? AppColor.Text.marketOrangeDark : AppColor.Text.neutralBodyMid)
                    .multilineTextAlignment(.leading)
            }
            
            if !model.couponTitle.isEmpty {
                Text(model.couponTitle)
                    .font(AppTypography.T03M)
                    .foregroundStyle(isEnabled ? AppColor.Text.neutralBodyBase : AppColor.Text.neutralBodyLight)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
            }
            
            if !model.dateline.isEmpty {
                Text(model.dateline)
                    .font(AppTypography.N06R)
                    .foregroundStyle(isEnabled ? AppColor.Text.neutralBodyMid : AppColor.Text.neutralBodyLight)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func couponRule(model: UseCouponModel) -> some View {
        HStack(spacing: 8) {
            Button {
                
            } label: {
                
                HStack(spacing: 0) {
                    Image("ic_info_14")
                    Text("使用規則")
                        .font(AppTypography.L03R)
                        .foregroundStyle(AppColor.Text.neutralBodyMid)
                }
            }
            
            if let tag = TagText(rawValue: model.usedTimesTag) {
                Text(tag.rawValue)
                    .font(AppTypography.T06R)
                    .foregroundStyle(tag.tagTextColor)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 4)
                    .background(tag.tagBgColor)
                    .overlay {
                        RoundedRectangle(cornerRadius: 2)
                            .stroke(tag.tagBorderColor, lineWidth: 1)
                    }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var confirmButton: some View {
        Button {
            let selectedCoupon = couponModel.availableCouponList.first(where: {$0.promoCode == selectedPromoCode})
            let promoCode = selectedCoupon?.promoCode ?? ""
            let couponDiscount = selectedCoupon?.discount ?? ""
            print("DEBUG: \(promoCode), \(couponDiscount)")
        } label: {
            Text("確定")
                .font(AppTypography.L02M)
                .foregroundStyle(AppColor.Text.neutralWhite)
                .frame(maxWidth: .infinity)
        }
        .frame(height: 40)
        .background(AppColor.Surface.brandSecondaryBase)
    }
    
    private var emptyCouponView: some View {
        VStack(spacing: 6) {
            Image("ic_ticket_100")
                .padding(.bottom, 2)
            Text("沒有可使用的優惠代碼")
                .font(AppTypography.T02M)
                .foregroundStyle(AppColor.Text.neutralBodyMid)
            Text("優惠代碼依活動不定期發放，未顯示表示無相關優惠折扣可使用")
                .font(AppTypography.B03R)
                .foregroundStyle(AppColor.Text.neutralBodyLight)
                .multilineTextAlignment(.center)
        }
        .padding(.top, 60)
        .padding(.horizontal, 80)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(AppColor.Background.pagePurple)
    }
}

#Preview {
    UseCouponSwiftUIView(couponModel: CouponModel())
}
