import SwiftUI

struct ColaCoinModel {
    let useCoinMark: Bool
    let remark: String
    let currentColaCoins: String
    let optionMark: Bool
    let redeemRatio: Int
}
struct ColaCoinInputSwiftUIView: View {
    
    enum RedeemMode: String {
        case allCustomers = "均分"
        case oneCustomer = "首位"
    }
    
    enum RadioState: String {
        case disabled = "radio_btn_02_disabled"
        case on = "radio_btn_02_on"
        case off = "radio_btn_02_off"
    }
    
    @State private var isBgVisible: Bool = false
    @State private var isCoinViewVisible = true
    @State private var inputCoins = ""
    @State private var selectedMode: RedeemMode?
    @State private var isOverLimit = false
    
    let model: ColaCoinModel
    
    var onDismiss: (()->Void)? = nil
    var onUse: ((Int, RedeemMode?)->Void)? = nil
    
    private var coinCount: Int {
        (Int(inputCoins) ?? 0) * 10
    }
    
    private var hasInputCoins: Bool {
        inputCoins.isEmpty == false && coinCount > 0
    }
    
    private var canSelectRedeemMode: Bool {
        hasInputCoins && isOverLimit == false
    }
    
    private var canUseCoins: Bool {
        guard canSelectRedeemMode else { return false }
        return model.optionMark ? selectedMode != nil : true
    }
    
    private let hideDuration: Double = 0.2
    
    var body: some View {
        ZStack {
            backgroundView
            
            if isCoinViewVisible {
                coinView
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.25)) {
                isBgVisible = true
                isCoinViewVisible = true
            }
        }
    }
    
    private var backgroundView: some View {
        AppColor.Surface.opacityGrayMid
            .ignoresSafeArea()
            .opacity(isBgVisible ? 1 : 0)
    }
    
    private var coinView: some View {
        VStack(spacing: 0) {
            headerSection
            
            inputSection
            
            if model.optionMark {
                optionSection
            }
            actionSection
            
        }
        .frame(width: screenWidth * 0.85)
        .background(AppColor.Surface.neutralWhite, in: RoundedCorner(radius: 20, corners: [.topLeft, .topRight, .bottomLeft, .bottomRight]))
    }
    
    private var headerSection: some View {
        Text("可樂旅遊幣")
            .font(AppTypography.T02M)
            .foregroundStyle(AppColor.Text.neutralBodyBase)
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
    }
    
    private var inputSection: some View {
        VStack(alignment: .trailing, spacing: 4) {
            HStack(spacing: 8) {
                HStack(spacing: 0) {
                    ZStack(alignment: .trailing) {
                        if inputCoins.isEmpty {
                            Text("請輸入欲使用的數量")
                                .font(AppTypography.B03R)
                                .foregroundStyle(AppColor.Text.neutralCaption)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .allowsHitTesting(false)
                        }
                        
                        TextField("", text: $inputCoins)
                            .font(AppTypography.T03M)
                            .foregroundColor(AppColor.Text.neutralBodyBase)
                    }
                    .tint(AppColor.Border.brandPrimaryDark)
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.trailing)
                    .onChange(of: inputCoins) { newValue in
                        inputCoins = String(newValue.prefix(18))
                        
                        let enteredCoins = Double(inputCoins) ?? 0.0
                        let currentColaCoins = Double(model.currentColaCoins.removeCharacters()) ?? 0.0
                        isOverLimit = enteredCoins > currentColaCoins / 10
                    }
                    
                    if !inputCoins.isEmpty {
                        HStack(spacing: 4) {
                            Text("0")
                                .font(AppTypography.T03M)
                                .foregroundStyle(AppColor.Text.neutralBodyBase)
                                .allowsHitTesting(false)
                            
                            Text("枚")
                                .font(AppTypography.T03M)
                                .foregroundStyle(AppColor.Text.neutralBodyBase)
                                .padding(.trailing, 4)
                        }
                        
                    }
                }
                
                if !inputCoins.isEmpty {
                    Text("/\(model.currentColaCoins)枚")
                        .font(AppTypography.B06R)
                        .foregroundStyle(isOverLimit == false ? AppColor.Text.neutralBodyLight : AppColor.Text.stateError)
                }
                
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .overlay {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(AppColor.Border.neutralExtraSubtle)
            }
            
            Text(isOverLimit ? "請修正為\(model.currentColaCoins)枚以下" : "")
                .font(AppTypography.N07R)
                .foregroundStyle(AppColor.Text.stateError)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
    
    private var optionSection: some View {
        VStack(spacing: 12) {
            optionRow(title: "均分於所有旅客",
                      subtitle: "每位旅客折抵數量需為 10 的倍數且數量相同，若有溢折金額將再均分給剩餘旅客",
                      redeemMode: .allCustomers)
            
            dividerView
            optionRow(title: "全部用於旅客 1",
                      redeemMode:.oneCustomer)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
    }
    
    private func optionRow(title: String, subtitle: String? = nil, redeemMode: RedeemMode) -> some View {
        Button {
            selectedMode = redeemMode
        } label: {
            HStack(alignment: .top, spacing: 12) {
                Image(radioState(for: redeemMode).rawValue)
                VStack(spacing: 4) {
                    Text(title)
                        .font(AppTypography.B03R)
                        .foregroundStyle(isOverLimit == true ? AppColor.Text.stateDisabled : (inputCoins.isEmpty ? AppColor.Text.stateDisabled : AppColor.Text.neutralBodyBase))
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if let subtitle {
                        Text(subtitle)
                            .font(AppTypography.B05R)
                            .foregroundStyle(isOverLimit == true ? AppColor.Text.stateDisabled : (inputCoins.isEmpty ? AppColor.Text.stateDisabled : AppColor.Text.neutralBodyMid))
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                }
            }
        }
        .disabled(canSelectRedeemMode == false)
    }
    
    private var actionSection: some View {
        
        HStack(spacing: 1) {
            Button {
                dismiss(completion: {
                    onDismiss?()
                })
            } label: {
                Text("取消")
                    .font(AppTypography.L02M)
                    .foregroundStyle(AppColor.Text.neutralBodyMid)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            
            Button {
                dismiss {
                    onDismiss?()
                    onUse?(coinCount, selectedMode)
                }
            } label: {
                Text("使用")
                    .font(AppTypography.L02M)
                    .foregroundStyle(canUseCoins ? AppColor.Text.brandPrimaryDark : AppColor.Text.neutralCaption)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .disabled(canUseCoins == false)
            
        }
        .overlay(alignment: .top, content: {
            dividerView
        })
        .overlay {
            Rectangle()
                .padding(.vertical, 10)
                .frame(width: 1)
                .foregroundStyle(AppColor.Surface.neutralSubtle)
        }
    }
    
    private var dividerView: some View {
        Rectangle()
            .frame(height: 1)
            .foregroundStyle(AppColor.Surface.neutralSubtle)
    }
    
    private func radioState(for mode: RedeemMode) -> RadioState {
        if canSelectRedeemMode == false {
            return .disabled
        }
        
        return selectedMode == mode ? .on : .off
    }
    
    private func dismiss(completion: (() -> Void)? = nil) {
        withAnimation(nil) {
            isCoinViewVisible = false
        }
        
        withAnimation(.easeIn(duration: hideDuration)) {
            isBgVisible = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + hideDuration) {
            completion?()
        }
    }
}

extension String {
    func removeCharacters() -> String {
        let allowedCharacterSet = CharacterSet(charactersIn: "0123456789.").inverted
        return self.components(separatedBy: allowedCharacterSet).joined()
    }
}

#Preview {
    ColaCoinInputSwiftUIView(model: ColaCoinModel(useCoinMark: true, remark: "每 10 枚可折抵訂單金額 $3", currentColaCoins: "13,727", optionMark: true, redeemRatio: 3))
}

