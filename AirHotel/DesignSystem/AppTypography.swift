//
//  AppTypography.swift
//  AppDesingTokens
//

import SwiftUI
import UIKit

enum AppTypography {
    static let iosFontFamily = DesignToken.globalFontFamilyIosZh
    static let lineHeightNormal = DesignToken.globalFontLineHeightNormal

    static let D01 = font(DesignToken.globalTypographyDisplayD01)
    static let D02 = font(DesignToken.globalTypographyDisplayD02)
    static let D03 = font(DesignToken.globalTypographyDisplayD03)

    static let H01 = font(DesignToken.globalTypographyHeadlineH01)
    static let H02 = font(DesignToken.globalTypographyHeadlineH02)

    static let T01 = font(DesignToken.globalTypographyTitleT01)
    static let T02 = font(DesignToken.globalTypographyTitleT02)
    static let T03M = font(DesignToken.globalTypographyTitleT03M)
    static let T03R = font(DesignToken.globalTypographyTitleT03R)
    static let T04B = font(DesignToken.globalTypographyTitleT04B)
    static let T04M = font(DesignToken.globalTypographyTitleT04M)
    static let T04R = font(DesignToken.globalTypographyTitleT04R)
    static let T05B = font(DesignToken.globalTypographyTitleT05B)
    static let T05M = font(DesignToken.globalTypographyTitleT05M)
    static let T05R = font(DesignToken.globalTypographyTitleT05R)
    static let T06 = font(DesignToken.globalTypographyTitleT06)

    static let B01 = font(DesignToken.globalTypographyBodyB01)
    static let B02 = font(DesignToken.globalTypographyBodyB02)
    static let B03 = font(DesignToken.globalTypographyBodyB03)
    static let B04R = font(DesignToken.globalTypographyBodyB04R)
    static let B04M = font(DesignToken.globalTypographyBodyB04M)
    static let B05 = font(DesignToken.globalTypographyBodyB05)
    static let B06M = font(DesignToken.globalTypographyBodyB06M)
    static let B06R = font(DesignToken.globalTypographyBodyB06R)

    static let L01 = font(DesignToken.globalTypographyLabelL01)
    static let L02M = font(DesignToken.globalTypographyLabelL02M)
    static let L02R = font(DesignToken.globalTypographyLabelL02R)
    static let L03M = font(DesignToken.globalTypographyLabelL03M)
    static let L03R = font(DesignToken.globalTypographyLabelL03R)

    static let N01R = font(DesignToken.globalTypographyNumberN01R)
    static let N01M = font(DesignToken.globalTypographyNumberN01M)
    static let N02B = font(DesignToken.globalTypographyNumberN02B)
    static let N02R = font(DesignToken.globalTypographyNumberN02R)
    static let N03B = font(DesignToken.globalTypographyNumberN03B)
    static let N03M = font(DesignToken.globalTypographyNumberN03M)
    static let N04B = font(DesignToken.globalTypographyNumberN04B)
    static let N04M = font(DesignToken.globalTypographyNumberN04M)
    static let N05B = font(DesignToken.globalTypographyNumberN05B)
    static let N05M = font(DesignToken.globalTypographyNumberN05M)
    static let N05R = font(DesignToken.globalTypographyNumberN05R)
    static let N06M = font(DesignToken.globalTypographyNumberN06M)
    static let N06R = font(DesignToken.globalTypographyNumberN06R)
    static let N07M = font(DesignToken.globalTypographyNumberN07M)
    static let N07R = font(DesignToken.globalTypographyNumberN07R)

    static let display = D01
    static let title = T01
    static let body = B02
    static let label = L02M
    static let caption = B05

    enum UI {
        static let D01 = uiFont(DesignToken.globalTypographyDisplayD01)
        static let D02 = uiFont(DesignToken.globalTypographyDisplayD02)
        static let D03 = uiFont(DesignToken.globalTypographyDisplayD03)

        static let H01 = uiFont(DesignToken.globalTypographyHeadlineH01)
        static let H02 = uiFont(DesignToken.globalTypographyHeadlineH02)

        static let T01 = uiFont(DesignToken.globalTypographyTitleT01)
        static let T02 = uiFont(DesignToken.globalTypographyTitleT02)
        static let T03M = uiFont(DesignToken.globalTypographyTitleT03M)
        static let T03R = uiFont(DesignToken.globalTypographyTitleT03R)
        static let T04B = uiFont(DesignToken.globalTypographyTitleT04B)
        static let T04M = uiFont(DesignToken.globalTypographyTitleT04M)
        static let T04R = uiFont(DesignToken.globalTypographyTitleT04R)
        static let T05B = uiFont(DesignToken.globalTypographyTitleT05B)
        static let T05M = uiFont(DesignToken.globalTypographyTitleT05M)
        static let T05R = uiFont(DesignToken.globalTypographyTitleT05R)
        static let T06 = uiFont(DesignToken.globalTypographyTitleT06)

        static let B01 = uiFont(DesignToken.globalTypographyBodyB01)
        static let B02 = uiFont(DesignToken.globalTypographyBodyB02)
        static let B03 = uiFont(DesignToken.globalTypographyBodyB03)
        static let B04R = uiFont(DesignToken.globalTypographyBodyB04R)
        static let B04M = uiFont(DesignToken.globalTypographyBodyB04M)
        static let B05 = uiFont(DesignToken.globalTypographyBodyB05)
        static let B06M = uiFont(DesignToken.globalTypographyBodyB06M)
        static let B06R = uiFont(DesignToken.globalTypographyBodyB06R)

        static let L01 = uiFont(DesignToken.globalTypographyLabelL01)
        static let L02M = uiFont(DesignToken.globalTypographyLabelL02M)
        static let L02R = uiFont(DesignToken.globalTypographyLabelL02R)
        static let L03M = uiFont(DesignToken.globalTypographyLabelL03M)
        static let L03R = uiFont(DesignToken.globalTypographyLabelL03R)

        static let N01R = uiFont(DesignToken.globalTypographyNumberN01R)
        static let N01M = uiFont(DesignToken.globalTypographyNumberN01M)
        static let N02B = uiFont(DesignToken.globalTypographyNumberN02B)
        static let N02R = uiFont(DesignToken.globalTypographyNumberN02R)
        static let N03B = uiFont(DesignToken.globalTypographyNumberN03B)
        static let N03M = uiFont(DesignToken.globalTypographyNumberN03M)
        static let N04B = uiFont(DesignToken.globalTypographyNumberN04B)
        static let N04M = uiFont(DesignToken.globalTypographyNumberN04M)
        static let N05B = uiFont(DesignToken.globalTypographyNumberN05B)
        static let N05M = uiFont(DesignToken.globalTypographyNumberN05M)
        static let N05R = uiFont(DesignToken.globalTypographyNumberN05R)
        static let N06M = uiFont(DesignToken.globalTypographyNumberN06M)
        static let N06R = uiFont(DesignToken.globalTypographyNumberN06R)
        static let N07M = uiFont(DesignToken.globalTypographyNumberN07M)
        static let N07R = uiFont(DesignToken.globalTypographyNumberN07R)

        static let display = D01
        static let title = T01
        static let body = B02
        static let label = L02M
        static let caption = B05
    }

    private static func font(_ typography: [String: Any]) -> Font {
        let style = AppTypographyStyle(typography)
        let fontName = "\(style.fontFamily)-\(style.weight.postScriptSuffix)"

        if UIFont(name: fontName, size: style.pointSize) != nil {
            return .custom(fontName, size: style.pointSize)
        }

        return .system(size: style.pointSize, weight: style.weight.swiftUIWeight)
    }

    private static func uiFont(_ typography: [String: Any]) -> UIFont {
        let style = AppTypographyStyle(typography)
        let fontName = "\(style.fontFamily)-\(style.weight.postScriptSuffix)"

        if let font = UIFont(name: fontName, size: style.pointSize) {
            return font
        }

        return .systemFont(ofSize: style.pointSize, weight: style.weight.uiKitWeight)
    }
}

private struct AppTypographyStyle {
    let fontFamily: String
    let pointSize: CGFloat
    let weight: AppFontWeight

    init(_ typography: [String: Any]) {
        fontFamily = typography["fontFamily"] as? String ?? DesignToken.globalFontFamilyIosZh
        pointSize = CGFloat(typography["fontSize"] as? Int ?? DesignToken.globalFontSize16)
        weight = AppFontWeight(rawValue: typography["fontWeight"] as? Int ?? DesignToken.globalFontWeightRegular)
    }
}

private enum AppFontWeight {
    case regular
    case medium
    case semibold

    init(rawValue: Int) {
        switch rawValue {
        case DesignToken.globalFontWeightMedium:
            self = .medium
        case DesignToken.globalFontWeightSemibold:
            self = .semibold
        default:
            self = .regular
        }
    }

    var postScriptSuffix: String {
        switch self {
        case .regular:
            return "Regular"
        case .medium:
            return "Medium"
        case .semibold:
            return "Semibold"
        }
    }

    var swiftUIWeight: Font.Weight {
        switch self {
        case .regular:
            return .regular
        case .medium:
            return .medium
        case .semibold:
            return .semibold
        }
    }

    var uiKitWeight: UIFont.Weight {
        switch self {
        case .regular:
            return .regular
        case .medium:
            return .medium
        case .semibold:
            return .semibold
        }
    }
}
