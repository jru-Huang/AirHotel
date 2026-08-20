//
//  Constant.swift
//  AirHotel
//
//  Created by 7943 on 2026/5/4.
//
import SwiftUI
import Foundation

let screenWidth = UIScreen.main.bounds.width

enum FontThickness {
    case medium
    case regular
    case semibold
}

extension View {
    
    func setTCFont(_ font: FontThickness , size: CGFloat) -> some View {
        switch font {
        case .regular:
            return self.font(.custom("PingFangTC-Regular", size: size))
        case .medium:
            return self.font(.custom("PingFangTC-Medium", size: size))
        case .semibold:
            return self.font(.custom("PingFangTC-Semibold", size: size))
        }
    }
    
    func titleLine(color: Color = AppColor.Surface.brandPrimaryBase) -> some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(color)
            .frame(width: 3, height: 12)
    }
    
    func setCornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    
    func onSizeChange(_ onChange: @escaping (CGSize) -> Void) -> some View {
        modifier(SizeReader(onChange: onChange))
    }
    
    func onHeightChange(_ onChange: @escaping (CGFloat) -> Void) -> some View {
        onSizeChange { onChange($0.height) }
    }
    
    //取得View頂端位置
    func onMinYChange(in space: CoordinateSpace = .global,
                      _ onChange: @escaping (CGFloat) -> Void) -> some View {
        modifier(MinYReader(space: space, onChange: onChange))
    }
    
    var safeAreaBottomInset: CGFloat {
        guard let scene = UIApplication.shared.connectedScenes.first(where: {
            $0.activationState == .foregroundActive
        }) as? UIWindowScene else {
            return .zero
        }
        
        guard let window = scene.windows.first(where: { $0.isKeyWindow }) else {
            return .zero
        }
        
        return window.safeAreaInsets.bottom
    }
}

private struct SizeReader: ViewModifier {
    
    let onChange: (CGSize) -> Void
    
    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geo in
                    Color.clear
                        .preference(
                            key: LatestSizePreferenceKey.self,
                            value: geo.size)
                }
                .allowsHitTesting(false)
            )
            .onPreferenceChange(LatestSizePreferenceKey.self, perform: onChange)
    }
}

private struct MinYReader: ViewModifier {
    
    let space: CoordinateSpace
    let onChange: (CGFloat) -> Void
    
    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geo in
                    Color.clear
                        .preference(
                            key: MinYPreferenceKey.self,
                            value: geo.frame(in: space).minY)
                }
                .allowsHitTesting(false)
            )
            .onPreferenceChange(MinYPreferenceKey.self, perform: onChange)
    }
}

private struct LatestSizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

private struct MinYPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

extension Int {
    func priceAddDot() -> String {
        
        let priceFormatter = NumberFormatter()
        priceFormatter.numberStyle = NumberFormatter.Style.decimal
        let priceAddComma = priceFormatter.string(from: self as NSNumber)
        
        let priceAddDollarSign = "\(priceAddComma ?? "")"
        return priceAddDollarSign
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

var dateFormatList: [String] = ["yyyy-MM-dd HH:mm:ss",
                                "yyyy-MM-dd'T'HH:mm:ss.SSS",
                                "yyyy-MM-dd'T'HH:mm:ss",
                                "yyyy-MM-dd'T'HH:mm:ss.SSSZ",
                                "yyyy-MM-dd'T'HH:mm:ssZ",
                                "yyyy-MM-dd HH:mm:ss Z",
                                "yyyy/MM/dd",
                                "MM/dd HH:mm"]

var calendarForDatePicker: Calendar {
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = TimeZone(abbreviation: "UTC+8:00")!
    calendar.locale = Locale(identifier: "zh_TW")
    return calendar
}

class FormatUtil: NSObject {
    static func convertStringToString(dateStringFrom: String?, dateFormatTo: String, amSymbolTo: String? = nil, pmSymbolTo: String? = nil) -> String {
        guard let dateStringFrom = dateStringFrom else {  return "" }
        var dateStringAfterTransform = ""
        let dateFormmaterConvertTo = DateFormatter()
        dateFormmaterConvertTo.setToBasic(dateFormat: dateFormatTo, amSymbol: amSymbolTo, pmSymbol: pmSymbolTo)
        
        let dateFormatterConvertFrom = DateFormatter()
        dateFormatterConvertFrom.setToBasic()
        
        dateFormatList.forEach { (dateFormat) in
            if (dateStringAfterTransform == "") {
                dateFormatterConvertFrom.dateFormat = dateFormat
                if let dateBeforeConvert = dateFormatterConvertFrom.date(from: dateStringFrom) {
                    let dateStringAfterConvert = dateFormmaterConvertTo.string(from: dateBeforeConvert)
                    dateStringAfterTransform = "\(dateStringAfterConvert)"
                }
            }
        }
        
        return dateStringAfterTransform
    }
    
    static func convertStringToDate(dateFormatFrom: String, dateString: String, amSymbolFrom: String? = nil, pmSymbolFrom: String? = nil) -> Date? {
        if ( dateString == "" ) { return nil }
        
        let dateFormatter = DateFormatter()
        dateFormatter.setToBasic(dateFormat: dateFormatFrom, amSymbol: amSymbolFrom, pmSymbol: pmSymbolFrom)
        
        let date = dateFormatter.date(from: dateString)
        return date == nil ? convertStringToDate(dateString: dateString) : date
    }
    
    static private func convertStringToDate(dateString: String?) -> Date? {
        #if DEBUG
        print("****** 字串轉時間，時間格式不正確，再確認一下！ ******")
        print("****** 字串轉時間，時間格式不正確，再確認一下！ ******")
        print("****** 字串轉時間，時間格式不正確，再確認一下！ ******")
        #endif
        guard let dateString = dateString else {  return nil }
        var dateStringToDate: Date?
        
        let dateFormatterConvertFrom = DateFormatter()
        dateFormatterConvertFrom.setToBasic()
        
        dateFormatList.forEach { (dateFormat) in
            if (dateStringToDate == nil) {
                dateFormatterConvertFrom.dateFormat = dateFormat
                if let dateBeforeConvert = dateFormatterConvertFrom.date(from: dateString) {
                    dateStringToDate = dateBeforeConvert
                }
            }
        }
        
        return dateStringToDate
    }
}

extension DateFormatter {
    func setToBasic(dateFormat: String? = nil, amSymbol: String? = nil, pmSymbol: String? = nil) {
        self.calendar = calendarForDatePicker
        self.timeZone = TimeZone(abbreviation: "UTC+8:00")
        self.locale = Locale(identifier: "zh_TW") // 語系
        self.dateFormat = dateFormat
        self.amSymbol = amSymbol
        self.pmSymbol = pmSymbol
    }
}

public struct SheetHeaderStyle {
    enum RightItem {
        case custom
    }
    
    enum MiddleItem {
        case textTitle(text: String)
        case custom
    }
    
    enum LeftItem {
        case close
        case custom
    }
    
    var navLeftType: LeftItem = .close
    var navRightType: RightItem = .custom
    var navMidType: MiddleItem = .custom
    
    var headerHeight: CGFloat = 44
    var backgroundColor: Color = AppColor.Surface.neutralWhite
    
    // Title 字型與顏色
    var textTitleFont: Font = AppTypography.D03
    var textTitleColor: Color = AppColor.Text.neutralBodyBase
    
    var rightItemWidth: CGFloat = 20
    var rightItemHeight: CGFloat = 20
    var leftItemHeight: CGFloat = 20
    var leftItemWidth: CGFloat = 20
    
    var horizontalPadding: CGFloat = 16
}

struct SheetHeaderView: View {
    
    var onTouchLeftItem: (() -> Void)?
    var style: SheetHeaderStyle
    var body: some View { content }
    
    init(style: SheetHeaderStyle, onTouchLeftItem: (() -> Void)? = nil) {
        self.style = style
        self.onTouchLeftItem = onTouchLeftItem
    }
    
    private var content: some View {
        ZStack{
            midView
            HStack(spacing: 0) {
                leftView
                Spacer()
                rightView
            }
        }
        .frame(width: .infinity, height: style.headerHeight)
        .padding(.horizontal, style.horizontalPadding)
        .background(style.backgroundColor)
    }
    
    @ViewBuilder
    private var leftView: some View {
        switch style.navLeftType {
        case .close:
            Button {
                onTouchLeftItem?()
            } label: {
                Image("ic_close_20")
                    .frame(width: style.leftItemWidth, height: style.leftItemHeight)
            }
        case .custom:
            Color.clear
                .frame(width: style.leftItemWidth)
        }
    }
    
    @ViewBuilder
    private var midView: some View {
        switch style.navMidType {
        case .textTitle(let title):
            Text(title)
                .font(style.textTitleFont)
                .foregroundStyle(style.textTitleColor)
        default:
            Color.clear
        }
    }
        
    @ViewBuilder
    private var rightView: some View {
        switch style.navRightType {
        case .custom:
            Color.clear
                .frame(width: style.rightItemWidth)
        }
    }
}
