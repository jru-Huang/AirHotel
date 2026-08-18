//
//  PackagesPassengerInfoDoubleCheckView.swift
//  AirHotel
//
//  Created by 7943 on 2026/8/17.
//

import SwiftUI

struct PackagesPassengerInfoDoubleCheckView: View {
    
    struct PassengerInfoModel: Identifiable {
        let id = UUID()
        let paxNo: String
        let gender: String
        let chineseName: String
        let surname: String
        let givenName: String
        let birthday: String
        let isRepresentative: Bool
    }
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var hasError: Bool = true
    @State private var hasAcceptedInfo: Bool = false
    @State private var presentAlert: Bool = false
    
    private var navTitle: String {
        hasError ? "旅客英文姓名重複" : "再次確認填寫資料"
    }
    
    private var leftButtonTitle: String {
        hasError ? "重選人數" : "返回修改"
    }
    
    private var rightButtonTitle: String {
        hasError ? "修改資料" : "確定"
    }
    
    var passengerList = [
        PassengerInfoModel(paxNo: "旅客1", gender: "男性", chineseName: "吳威廉", surname: "WU", givenName: "WALLEN", birthday: "1990/09/10", isRepresentative: true),
        PassengerInfoModel(paxNo: "旅客2", gender: "女性", chineseName: "吳可樂", surname: "WU", givenName: "COLA", birthday: "2000/12/01", isRepresentative: false)
    ]
    
    var onClose: (() -> Void)?
    var onEditTravelerInfo: (() -> Void)
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .bottom) {
                AppColor.Surface.opacityGrayMid
                    .ignoresSafeArea()
                    .onTapGesture(perform: close)
                
                contentView
                    .frame(maxHeight: proxy.size.height * 0.8)
            }
        }
        .overlay {
            if presentAlert {
                ColaAlertSwiftUIView(
                    model: ColaAlertSwiftUIModel(
                        title: "確定重選人數？",
                        message: "因旅客英文姓名重複，需分筆訂購。重選人數將清空資料並返回搜尋頁。"
                    ),
                    onDismiss: {
                        presentAlert = false
                    }
                )
            }
        }
    }
    
    private var contentView: some View {
        VStack(spacing: 0) {
            navTitleView
            
            ScrollView {
                VStack(spacing: 0) {
                    descriptionView
                    noticeView
                    VStack(spacing: 6) {
                        ForEach(passengerList) { passenger in
                            passengerInfoView(paxInfo: passenger)
                        }
                    }
                    .padding(.bottom, 16)
                    .padding(.horizontal, 16)
                    .background(AppColor.Surface.neutralWhite)
                    
                    buyerInfoView
                    noticeBottomView
                }
            }
            .background(AppColor.Surface.neutralWhite)
            
            if !hasError {
                acceptView
            }
            actionButtons
        }
    }
    
    private var navTitleView: some View {
        ZStack {
            HStack {
                Button {
                    close()
                } label: {
                    Image("ic_close_20")
                }
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            
            Text(navTitle)
                .font(AppTypography.D03)
                .foregroundStyle(AppColor.Text.neutralBodyBase)
        }
        .background(AppColor.Surface.neutralWhite, in: RoundedCorner(radius: 8, corners: [.topLeft, .topRight]))
    }

    private func close() {
        if let onClose {
            onClose()
        } else {
            dismiss()
        }
    }
    
    private var descriptionView: some View {
        Text("旅客英文姓、名皆須和護照上相同，並確認稱謂、手機號碼與電子郵件是否正確")
            .font(AppTypography.T03M)
            .foregroundStyle(AppColor.Text.neutralBodyBase)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 12)
            .padding(.horizontal, 16)
            .background(AppColor.Surface.neutralWhite)
    }
    
    private var noticeView: some View {
        HStack(spacing: 4) {
            Image("ic_notice_16")
            Text("如確實有兩位以上旅客姓名一模一樣，應航空公司要求需請您返回首頁 → 重新選擇人數 → 分開下單")
                .font(AppTypography.B05R)
                .foregroundStyle(AppColor.Text.brandSecondaryDark)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 8)
        .background(AppColor.Surface.brandSecondaryExtraSubtle)
        .overlay {
            RoundedRectangle(cornerRadius: 4)
                .stroke(AppColor.Border.brandSecondarySubtle, lineWidth: 1)
        }
        .padding(.bottom, 12)
        .padding(.horizontal, 16)
        .background(AppColor.Surface.neutralWhite)
    }
    
    private func passengerInfoView(paxInfo: PassengerInfoModel)-> some View {
        VStack(alignment: .leading, spacing: 0) {
           if paxInfo.isRepresentative {
                Text("入住代表人")
                    .font(AppTypography.T05M)
                    .foregroundStyle(AppColor.Border.brandPrimaryBase)
                    .padding(.horizontal, 4)
                    .background(AppColor.Surface.brandPrimarySubtle, in: RoundedRectangle(cornerRadius: 2))
            }
            
            VStack(spacing: 8) {
                passengerNameView(pax: paxInfo)
                if !hasError {
                    dashDivider
                    passengerBirthdayView(pax: paxInfo)
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
        }
        .background(hasError ? AppColor.Surface.stateError : AppColor.Surface.neutralExtraSubtle, in: RoundedRectangle(cornerRadius: 4))
    }
    
    private func passengerNameView(pax: PassengerInfoModel)-> some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 0) {
                    Text(pax.paxNo)
                        .font(AppTypography.B05R)
                    Text("/")
                        .font(AppTypography.B05R)
                    Text(pax.gender)
                        .font(AppTypography.T05B)
                }
                .foregroundStyle(AppColor.Text.neutralBodyMid)
                
                Text(pax.chineseName)
                    .font(AppTypography.T03M)
                    .foregroundStyle(AppColor.Text.neutralBodyBase)
            }
            .frame(minWidth: 72, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 2) {
                Text("英文姓")
                    .font(AppTypography.B05R)
                    .foregroundStyle(AppColor.Text.neutralBodyMid)
                Text(pax.surname)
                    .font(AppTypography.T03M)
                    .foregroundStyle(hasError ? AppColor.Text.stateError : AppColor.Text.neutralBodyBase)
            }
            .frame(minWidth: 72, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 2) {
                Text("英文名")
                    .font(AppTypography.B05R)
                    .foregroundStyle(AppColor.Text.neutralBodyMid)
                Text(pax.givenName)
                    .font(AppTypography.T03M)
                    .foregroundStyle(hasError ? AppColor.Text.stateError : AppColor.Text.neutralBodyBase)
            }
            .frame(minWidth: 72, alignment: .leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func passengerBirthdayView(pax: PassengerInfoModel)-> some View {
        HStack(spacing: 6) {
            Text("西元生日")
                .font(AppTypography.B05R)
                .foregroundStyle(AppColor.Text.neutralBodyMid)
            
            Text(pax.birthday)
                .font(AppTypography.T03M)
                .foregroundStyle(AppColor.Text.neutralBodyBase)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var dashDivider: some View {
        GeometryReader { proxy in
            Path { path in
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: proxy.size.width, y:0))
            }
            .stroke(AppColor.Border.neutralSubtle, style: StrokeStyle(lineWidth: 1, dash: [4,4]))
        }
        .frame(height: 1)
    }
    
    private var buyerInfoView: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("訂購人資料")
                .font(AppTypography.B05R)
                .foregroundStyle(AppColor.Text.neutralBodyMid)
            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 2) {
                    Text("王大明")
                    Text("/")
                    Text("男性")
                    Text("/")
                    Text("0912345678")
                }
                .font(AppTypography.B05R)
                .foregroundStyle(AppColor.Text.neutralBodyBase)
                
                Text(verbatim:"cola123@gmail.com")
                    .font(AppTypography.B03R)
                    .foregroundStyle(AppColor.Text.neutralBodyBase)
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppColor.Surface.neutralExtraSubtle)
        .padding(.bottom, 9)
        .background(AppColor.Surface.neutralWhite)
    }
    
    private var noticeBottomView: some View {
        let noticeList: [String] = [" 若英文姓名、稱謂有誤，在付款成功後，無法更改、取消或轉讓，航空公司亦有權利拒絕錯誤姓名的旅客登機。", " 完成線上刷卡付款後，將會寄送電子機票至您的信箱，若因填寫鎝誤的手機號碼或電子郵件，導致於您重複訂位，可樂旅遊將會向您收取必要的取消手續費，敬請注意！"]
        return VStack(spacing: 0) {
            ForEach(noticeList, id: \.self) { notice in
                HStack(alignment: .top, spacing: 0) {
                    Text("● ")
                    Text(notice)
                }
                .font(AppTypography.B05R)
                .foregroundStyle(AppColor.Text.neutralBodyMid)
            }
        }
        .padding(.horizontal, 12)
        .padding(.bottom, 16)
        .background(AppColor.Surface.neutralWhite)
    }
    
    private var acceptView: some View {
        HStack(alignment: .top, spacing: 8) {
            Image(hasAcceptedInfo ? "checkbox_active" : "checkbox_default")
            Text("我已詳細閱讀以上說明，並確認所填寫之訂位資料及聯絡資訊均正確無誤，若因填寫之資料有誤，導致衍生相關費用時，願自行負擔並支付所有衍生非用。")
                .font(AppTypography.B04R)
                .foregroundStyle(AppColor.Text.neutralBodyMid)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .background(AppColor.Surface.neutralWhite)
        .onTapGesture {
            hasAcceptedInfo.toggle()
        }
    }
    
    private var actionButtons: some View {
        HStack(spacing: 8) {
            Button {
                if hasError {
                    presentAlert = true
                }else {
                    onEditTravelerInfo()
                }
            } label: {
                Text(leftButtonTitle)
                    .font(AppTypography.L02M)
                    .foregroundStyle(AppColor.Text.brandPrimaryBase)
                    .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity, minHeight: 40)
            .background(AppColor.Surface.neutralWhite)
            .overlay {
                RoundedRectangle(cornerRadius: 4)
                    .strokeBorder(AppColor.Text.brandPrimaryDark, lineWidth: 1)
            }
            
            Button {
                if hasError {
                    onEditTravelerInfo()
                }else {
                    // p2->p3
                }
            } label: {
                Text(rightButtonTitle)
                    .font(AppTypography.L02M)
                    .foregroundStyle(AppColor.Text.neutralWhite)
                    .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity, minHeight: 40)
            .background(hasError ? AppColor.Text.brandPrimaryBase : hasAcceptedInfo ? AppColor.Text.brandPrimaryBase : AppColor.Surface.stateDisabled,
                        in: RoundedRectangle(cornerRadius: 4))
            .disabled(hasError ? false : !hasAcceptedInfo)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 6)
        .background(AppColor.Surface.neutralWhite)
        
    }
}

#Preview {
    PackagesPassengerInfoDoubleCheckView( onEditTravelerInfo: {})
}
