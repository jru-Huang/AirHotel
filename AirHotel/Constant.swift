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

