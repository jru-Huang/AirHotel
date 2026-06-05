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
    
    func titleLine(color: Color = Color.surfaceBrandPrimaryBase_9A56D3) -> some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(color)
            .frame(width: 3, height: 12)
    }
    
    func setCornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
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

extension Color {
    static let textNeutralBodyBase_333333: Color = Color(red: 0.2, green: 0.2, blue: 0.2)
    static let textNeutralSubtitle_B2B2B2: Color = Color(red: 0.7, green: 0.7, blue: 0.7)
    static let borderNeutralExSubtle_E4E4E4: Color = Color(red: 0.89, green: 0.89, blue: 0.89)
    static let surfaceNeutralSubtle_F2F2F2: Color = Color(red: 0.95, green: 0.95, blue: 0.95)
    static let textNeutralBodyLight_9B9B9B: Color = Color(red: 0.61, green: 0.61, blue: 0.61)
    static let textNeutralBodyMid_666666: Color = Color(red: 0.4, green: 0.4, blue: 0.4)
    static let surfaceNeutralExSubtle_F8F8F8: Color = Color(red: 0.97, green: 0.97, blue: 0.97)
    static let surfaceBrandSecondaryBase_00A3E0: Color = Color(red: 0, green: 0.64, blue: 0.88)
    static let backgroundPagePurple_F8F8F8: Color = Color(red: 0.97, green: 0.97, blue: 0.98)
    static let surfaceMarketOrangeExSubtle_FFF3E9: Color = Color(red: 1, green: 0.95, blue: 0.91)
    static let surfaceMarketOrangeSubtle_FFCEBA: Color = Color(red: 1, green: 0.81, blue: 0.73)
    static let surfaceBrandPrimaryExSubtle_F1F1F8: Color = Color(red: 0.95, green: 0.95, blue: 0.97)
    static let borderBrandPrimarySubtle_D4C2FF: Color = Color(red: 0.83, green: 0.76, blue: 1)
    static let surfaceBrandSecondaryExSubtle_F3FCFF: Color = Color(red: 0.95, green: 0.99, blue: 1)
    static let borderBrandSecondarySubtle_91CBF4: Color = Color(red: 0.57, green: 0.8, blue: 0.96)
    static let borderNeutralSubtle_D6D6D6: Color = Color(red: 0.84, green: 0.84, blue: 0.84)
    static let gray700_434343: Color = Color(red: 0.26, green: 0.26, blue: 0.26)
    static let textBrandPrimaryDark_84329B: Color = Color(red: 0.52, green: 0.2, blue: 0.61)
    static let surfaceBrandPrimaryBase_9A56D3: Color = Color(red: 0.6, green: 0.34, blue: 0.83)
    static let borderBrandPrimaryExSubtle_F8F8FA: Color = Color(red: 0.97, green: 0.97, blue: 0.98)
    static let textBrandPrimaryBase_9A56D3: Color = Color(red: 0.6, green: 0.34, blue: 0.83)
    static let textBrandSecondaryBase_00A3E0: Color = Color(red: 0, green: 0.64, blue: 0.88)
    static let surfaceNeutralMid_D6D6D6: Color = Color(red: 0.84, green: 0.84, blue: 0.84)
    static let textMarketOrangeMid_FF8212: Color = Color(red: 1, green: 0.51, blue: 0.07)
    static let borderNeutralBase_9B9B9B: Color = Color(red: 0.61, green: 0.61, blue: 0.61)
    static let textMarketOrangeDark_FC4C02: Color = Color(red: 0.99, green: 0.3, blue: 0.01)
    static let textStateDisabled_C3C3C3: Color = Color(red: 0.76, green: 0.76, blue: 0.76)
    static let textStateError_D6001C: Color = Color(red: 0.84, green: 0, blue: 0.11)
    static let textNeutralCaption_C3C3C3: Color = Color(red: 0.76, green: 0.76, blue: 0.76)
    static let surfaceOpacityGrayMid_333333_50: Color = Color(red: 0.2, green: 0.2, blue: 0.2).opacity(0.5)
    static let textMarketOrangeBase_FF6F00: Color = Color(red: 1, green: 0.44, blue: 0)
    static let borderMarketOrangeSubtle_FFBA9E: Color = Color(red: 1, green: 0.73, blue: 0.62)
}

extension UIFont {
    convenience init(thickness: FontThickness, size: CGFloat) {
        switch thickness {
        case .medium:
            self.init(name: "PingFangTC-Medium", size: size)!
        case .regular:
            self.init(name: "PingFangTC-Regular", size: size)!
        case .semibold:
            self.init(name: "PingFangTC-Semibold", size: size)!
       }
    }
}

