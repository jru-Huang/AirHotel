//
//  AppColor.swift
//  AppDesingTokens
//

import SwiftUI
import UIKit

enum AppColor {
    enum Background {
        static let pagePurple = Color(uiColor: DesignToken.systemBackgroundPagePurple)
        static let pageGray = Color(uiColor: DesignToken.systemBackgroundPageGray)
        static let pageWhite = Color(uiColor: DesignToken.systemBackgroundPageWhite)
    }

    enum Surface {
        static let brandPrimaryDark = Color(uiColor: DesignToken.systemSurfaceBrandPrimaryDark)
        static let brandPrimaryBase = Color(uiColor: DesignToken.systemSurfaceBrandPrimaryBase)
        static let brandPrimaryMid = Color(uiColor: DesignToken.systemSurfaceBrandPrimaryMid)
        static let brandPrimarySubtle = Color(uiColor: DesignToken.systemSurfaceBrandPrimarySubtle)
        static let brandPrimaryExtraSubtle = Color(uiColor: DesignToken.systemSurfaceBrandPrimaryExtraSubtle)

        static let brandSecondaryBase = Color(uiColor: DesignToken.systemSurfaceBrandSecondaryBase)
        static let brandSecondaryMid = Color(uiColor: DesignToken.systemSurfaceBrandSecondaryMid)
        static let brandSecondarySubtle = Color(uiColor: DesignToken.systemSurfaceBrandSecondarySubtle)
        static let brandSecondaryExtraSubtle = Color(uiColor: DesignToken.systemSurfaceBrandSecondaryExtraSubtle)

        static let marketOrangeDark = Color(uiColor: DesignToken.systemSurfaceMarketOrangeDark)
        static let marketOrangeBase = Color(uiColor: DesignToken.systemSurfaceMarketOrangeBase)
        static let marketOrangeMid = Color(uiColor: DesignToken.systemSurfaceMarketOrangeMid)
        static let marketOrangeSubtle = Color(uiColor: DesignToken.systemSurfaceMarketOrangeSubtle)
        static let marketOrangeExtraSubtle = Color(uiColor: DesignToken.systemSurfaceMarketOrangeExtraSubtle)

        static let marketGreenSubtle = Color(uiColor: DesignToken.systemSurfaceMarketGreenSubtle)

        static let marketYellowMid = Color(uiColor: DesignToken.systemSurfaceMarketYellowMid)

        static let neutralDark = Color(uiColor: DesignToken.systemSurfaceNeutralDark)
        static let neutralBase = Color(uiColor: DesignToken.systemSurfaceNeutralBase)
        static let neutralMid = Color(uiColor: DesignToken.systemSurfaceNeutralMid)
        static let neutralSubtle = Color(uiColor: DesignToken.systemSurfaceNeutralSubtle)
        static let neutralExtraSubtle = Color(uiColor: DesignToken.systemSurfaceNeutralExtraSubtle)
        static let neutralWhite = Color(uiColor: DesignToken.systemSurfaceNeutralWhite)

        static let opacityGrayDark = Color(uiColor: DesignToken.systemSurfaceOpacityGrayDark)
        static let opacityGrayBase = Color(uiColor: DesignToken.systemSurfaceOpacityGrayBase)
        static let opacityGrayMid = Color(uiColor: DesignToken.systemSurfaceOpacityGrayMid)
        static let opacityGraySubtle = Color(uiColor: DesignToken.systemSurfaceOpacityGraySubtle)
        static let opacityWhiteBase = Color(uiColor: DesignToken.systemSurfaceOpacityWhiteBase)

        static let stateError = Color(uiColor: DesignToken.systemSurfaceStateError)
        static let stateSuccess = Color(uiColor: DesignToken.systemSurfaceStateSuccess)
        static let stateDisabled = Color(uiColor: DesignToken.systemSurfaceStateDisabled)
    }

    enum Text {
        static let brandPrimaryDark = Color(uiColor: DesignToken.systemTextBrandPrimaryDark)
        static let brandPrimaryBase = Color(uiColor: DesignToken.systemTextBrandPrimaryBase)
        static let brandPrimaryMid = Color(uiColor: DesignToken.systemTextBrandPrimaryMid)
        static let brandPrimarySubtle = Color(uiColor: DesignToken.systemTextBrandPrimarySubtle)

        static let brandSecondaryDark = Color(uiColor: DesignToken.systemTextBrandSecondaryDark)
        static let brandSecondaryBase = Color(uiColor: DesignToken.systemTextBrandSecondaryBase)
        static let brandSecondaryMid = Color(uiColor: DesignToken.systemTextBrandSecondaryMid)
        static let brandSecondarySubtle = Color(uiColor: DesignToken.systemTextBrandSecondarySubtle)

        static let marketOrangeDark = Color(uiColor: DesignToken.systemTextMarketOrangeDark)
        static let marketOrangeBase = Color(uiColor: DesignToken.systemTextMarketOrangeBase)
        static let marketOrangeMid = Color(uiColor: DesignToken.systemTextMarketOrangeMid)
        static let marketOrangeSubtle = Color(uiColor: DesignToken.systemTextMarketOrangeSubtle)
        static let marketOrangeExtraSubtle = Color(uiColor: DesignToken.systemTextMarketOrangeExtraSubtle)

        static let marketGreenBase = Color(uiColor: DesignToken.systemTextMarketGreenBase)
        static let marketGreenDark = Color(uiColor: DesignToken.systemTextMarketGreenDark)
        static let marketYellowBase = Color(uiColor: DesignToken.systemTextMarketYellowBase)

        static let neutralBodyBase = Color(uiColor: DesignToken.systemTextNeutralBodyBase)
        static let neutralBodyMid = Color(uiColor: DesignToken.systemTextNeutralBodyMid)
        static let neutralBodyLight = Color(uiColor: DesignToken.systemTextNeutralBodyLight)
        static let neutralCaption = Color(uiColor: DesignToken.systemTextNeutralCaption)
        static let neutralSubtle = Color(uiColor: DesignToken.systemTextNeutralSubtle)
        static let neutralWhite = Color(uiColor: DesignToken.systemTextNeutralWhite)

        static let stateError = Color(uiColor: DesignToken.systemTextStateError)
        static let stateSuccess = Color(uiColor: DesignToken.systemTextStateSuccess)
        static let stateDisabled = Color(uiColor: DesignToken.systemTextStateDisabled)
        static let stateDisabledLight = Color(uiColor: DesignToken.systemTextStateDisabledLight)
        static let stateDisabledWhite = Color(uiColor: DesignToken.systemTextStateDisabledWhite)
    }

    enum Border {
        static let brandPrimaryDark = Color(uiColor: DesignToken.systemBorderBrandPrimaryDark)
        static let brandPrimaryBase = Color(uiColor: DesignToken.systemBorderBrandPrimaryBase)
        static let brandPrimaryMid = Color(uiColor: DesignToken.systemBorderBrandPrimaryMid)
        static let brandPrimarySubtle = Color(uiColor: DesignToken.systemBorderBrandPrimarySubtle)
        static let brandPrimaryExtraSubtle = Color(uiColor: DesignToken.systemBorderBrandPrimaryExtraSubtle)

        static let brandSecondaryDark = Color(uiColor: DesignToken.systemBorderBrandSecondaryDark)
        static let brandSecondaryBase = Color(uiColor: DesignToken.systemBorderBrandSecondaryBase)
        static let brandSecondaryMid = Color(uiColor: DesignToken.systemBorderBrandSecondaryMid)
        static let brandSecondarySubtle = Color(uiColor: DesignToken.systemBorderBrandSecondarySubtle)

        static let marketOrangeDark = Color(uiColor: DesignToken.systemBorderMarketOrangeDark)
        static let marketOrangeBase = Color(uiColor: DesignToken.systemBorderMarketOrangeBase)
        static let marketOrangeMid = Color(uiColor: DesignToken.systemBorderMarketOrangeMid)
        static let marketOrangeSubtle = Color(uiColor: DesignToken.systemBorderMarketOrangeSubtle)

        static let marketGreenBase = Color(uiColor: DesignToken.systemBorderMarketGreenBase)
        static let marketGreenMid = Color(uiColor: DesignToken.systemBorderMarketGreenMid)

        static let neutralDark = Color(uiColor: DesignToken.systemBorderNeutralDark)
        static let neutralBase = Color(uiColor: DesignToken.systemBorderNeutralBase)
        static let neutralMid = Color(uiColor: DesignToken.systemBorderNeutralMid)
        static let neutralSubtle = Color(uiColor: DesignToken.systemBorderNeutralSubtle)
        static let neutralExtraSubtle = Color(uiColor: DesignToken.systemBorderNeutralExtraSubtle)
        static let neutralWhite = Color(uiColor: DesignToken.systemBorderNeutralWhite)

        static let stateError = Color(uiColor: DesignToken.systemBorderStateError)
        static let stateSuccess = Color(uiColor: DesignToken.systemBorderStateSuccess)
        static let stateDisabled = Color(uiColor: DesignToken.systemBorderStateDisabled)
    }

    enum Icon {
        static let brandPrimaryDark = Color(uiColor: DesignToken.systemIconBrandPrimaryDark)
        static let brandPrimaryBase = Color(uiColor: DesignToken.systemIconBrandPrimaryBase)
        static let brandPrimaryMid = Color(uiColor: DesignToken.systemIconBrandPrimaryMid)
        static let brandPrimarySubtle = Color(uiColor: DesignToken.systemIconBrandPrimarySubtle)

        static let brandSecondaryDark = Color(uiColor: DesignToken.systemIconBrandSecondaryDark)
        static let brandSecondaryBase = Color(uiColor: DesignToken.systemIconBrandSecondaryBase)
        static let brandSecondaryMid = Color(uiColor: DesignToken.systemIconBrandSecondaryMid)
        static let brandSecondarySubtle = Color(uiColor: DesignToken.systemIconBrandSecondarySubtle)

        static let marketOrangeDark = Color(uiColor: DesignToken.systemIconMarketOrangeDark)
        static let marketOrangeBase = Color(uiColor: DesignToken.systemIconMarketOrangeBase)
        static let marketOrangeMid = Color(uiColor: DesignToken.systemIconMarketOrangeMid)
        static let marketOrangeSubtle = Color(uiColor: DesignToken.systemIconMarketOrangeSubtle)

        static let marketGreenBase = Color(uiColor: DesignToken.systemIconMarketGreenBase)
        static let marketGreenDark = Color(uiColor: DesignToken.systemIconMarketGreenDark)
        static let marketYellowBase = Color(uiColor: DesignToken.systemIconMarketYellowBase)
        static let marketYellowDark = Color(uiColor: DesignToken.systemIconMarketYellowDark)

        static let neutralDark = Color(uiColor: DesignToken.systemIconNeutralDark)
        static let neutralBase = Color(uiColor: DesignToken.systemIconNeutralBase)
        static let neutralMid = Color(uiColor: DesignToken.systemIconNeutralMid)
        static let neutralSubtle = Color(uiColor: DesignToken.systemIconNeutralSubtle)
        static let neutralExtraSubtle = Color(uiColor: DesignToken.systemIconNeutralExtraSubtle)
        static let neutralWhite = Color(uiColor: DesignToken.systemIconNeutralWhite)

        static let stateError = Color(uiColor: DesignToken.systemIconStateError)
        static let stateSuccess = Color(uiColor: DesignToken.systemIconStateSuccess)
        static let stateDisabled = Color(uiColor: DesignToken.systemIconStateDisabled)
    }
    
    // UI代表UIKit 使用
    enum UI {
        enum Background {
            static let pagePurple = DesignToken.systemBackgroundPagePurple
            static let pageGray = DesignToken.systemBackgroundPageGray
            static let pageWhite = DesignToken.systemBackgroundPageWhite
        }

        enum Surface {
            static let brandPrimaryDark = DesignToken.systemSurfaceBrandPrimaryDark
            static let brandPrimaryBase = DesignToken.systemSurfaceBrandPrimaryBase
            static let brandPrimaryMid = DesignToken.systemSurfaceBrandPrimaryMid
            static let brandPrimarySubtle = DesignToken.systemSurfaceBrandPrimarySubtle
            static let brandPrimaryExtraSubtle = DesignToken.systemSurfaceBrandPrimaryExtraSubtle

            static let brandSecondaryBase = DesignToken.systemSurfaceBrandSecondaryBase
            static let brandSecondaryMid = DesignToken.systemSurfaceBrandSecondaryMid
            static let brandSecondarySubtle = DesignToken.systemSurfaceBrandSecondarySubtle
            static let brandSecondaryExtraSubtle = DesignToken.systemSurfaceBrandSecondaryExtraSubtle

            static let marketOrangeDark = DesignToken.systemSurfaceMarketOrangeDark
            static let marketOrangeBase = DesignToken.systemSurfaceMarketOrangeBase
            static let marketOrangeMid = DesignToken.systemSurfaceMarketOrangeMid
            static let marketOrangeSubtle = DesignToken.systemSurfaceMarketOrangeSubtle
            static let marketOrangeExtraSubtle = DesignToken.systemSurfaceMarketOrangeExtraSubtle

            static let marketGreenSubtle = DesignToken.systemSurfaceMarketGreenSubtle

            static let marketYellowMid = DesignToken.systemSurfaceMarketYellowMid

            static let neutralDark = DesignToken.systemSurfaceNeutralDark
            static let neutralBase = DesignToken.systemSurfaceNeutralBase
            static let neutralMid = DesignToken.systemSurfaceNeutralMid
            static let neutralSubtle = DesignToken.systemSurfaceNeutralSubtle
            static let neutralExtraSubtle = DesignToken.systemSurfaceNeutralExtraSubtle
            static let neutralWhite = DesignToken.systemSurfaceNeutralWhite

            static let opacityGrayDark = DesignToken.systemSurfaceOpacityGrayDark
            static let opacityGrayBase = DesignToken.systemSurfaceOpacityGrayBase
            static let opacityGrayMid = DesignToken.systemSurfaceOpacityGrayMid
            static let opacityGraySubtle = DesignToken.systemSurfaceOpacityGraySubtle
            static let opacityWhiteBase = DesignToken.systemSurfaceOpacityWhiteBase

            static let stateError = DesignToken.systemSurfaceStateError
            static let stateSuccess = DesignToken.systemSurfaceStateSuccess
            static let stateDisabled = DesignToken.systemSurfaceStateDisabled
        }

        enum Text {
            static let brandPrimaryDark = DesignToken.systemTextBrandPrimaryDark
            static let brandPrimaryBase = DesignToken.systemTextBrandPrimaryBase
            static let brandPrimaryMid = DesignToken.systemTextBrandPrimaryMid
            static let brandPrimarySubtle = DesignToken.systemTextBrandPrimarySubtle

            static let brandSecondaryDark = DesignToken.systemTextBrandSecondaryDark
            static let brandSecondaryBase = DesignToken.systemTextBrandSecondaryBase
            static let brandSecondaryMid = DesignToken.systemTextBrandSecondaryMid
            static let brandSecondarySubtle = DesignToken.systemTextBrandSecondarySubtle

            static let marketOrangeDark = DesignToken.systemTextMarketOrangeDark
            static let marketOrangeBase = DesignToken.systemTextMarketOrangeBase
            static let marketOrangeMid = DesignToken.systemTextMarketOrangeMid
            static let marketOrangeSubtle = DesignToken.systemTextMarketOrangeSubtle
            static let marketOrangeExtraSubtle = DesignToken.systemTextMarketOrangeExtraSubtle

            static let marketGreenBase = DesignToken.systemTextMarketGreenBase
            static let marketGreenDark = DesignToken.systemTextMarketGreenDark
            static let marketYellowBase = DesignToken.systemTextMarketYellowBase

            static let neutralBodyBase = DesignToken.systemTextNeutralBodyBase
            static let neutralBodyMid = DesignToken.systemTextNeutralBodyMid
            static let neutralBodyLight = DesignToken.systemTextNeutralBodyLight
            static let neutralCaption = DesignToken.systemTextNeutralCaption
            static let neutralSubtle = DesignToken.systemTextNeutralSubtle
            static let neutralWhite = DesignToken.systemTextNeutralWhite

            static let stateError = DesignToken.systemTextStateError
            static let stateSuccess = DesignToken.systemTextStateSuccess
            static let stateDisabled = DesignToken.systemTextStateDisabled
            static let stateDisabledLight = DesignToken.systemTextStateDisabledLight
            static let stateDisabledWhite = DesignToken.systemTextStateDisabledWhite
        }

        enum Border {
            static let brandPrimaryDark = DesignToken.systemBorderBrandPrimaryDark
            static let brandPrimaryBase = DesignToken.systemBorderBrandPrimaryBase
            static let brandPrimaryMid = DesignToken.systemBorderBrandPrimaryMid
            static let brandPrimarySubtle = DesignToken.systemBorderBrandPrimarySubtle
            static let brandPrimaryExtraSubtle = DesignToken.systemBorderBrandPrimaryExtraSubtle

            static let brandSecondaryDark = DesignToken.systemBorderBrandSecondaryDark
            static let brandSecondaryBase = DesignToken.systemBorderBrandSecondaryBase
            static let brandSecondaryMid = DesignToken.systemBorderBrandSecondaryMid
            static let brandSecondarySubtle = DesignToken.systemBorderBrandSecondarySubtle

            static let marketOrangeDark = DesignToken.systemBorderMarketOrangeDark
            static let marketOrangeBase = DesignToken.systemBorderMarketOrangeBase
            static let marketOrangeMid = DesignToken.systemBorderMarketOrangeMid
            static let marketOrangeSubtle = DesignToken.systemBorderMarketOrangeSubtle

            static let marketGreenBase = DesignToken.systemBorderMarketGreenBase
            static let marketGreenMid = DesignToken.systemBorderMarketGreenMid

            static let neutralDark = DesignToken.systemBorderNeutralDark
            static let neutralBase = DesignToken.systemBorderNeutralBase
            static let neutralMid = DesignToken.systemBorderNeutralMid
            static let neutralSubtle = DesignToken.systemBorderNeutralSubtle
            static let neutralExtraSubtle = DesignToken.systemBorderNeutralExtraSubtle
            static let neutralWhite = DesignToken.systemBorderNeutralWhite

            static let stateError = DesignToken.systemBorderStateError
            static let stateSuccess = DesignToken.systemBorderStateSuccess
            static let stateDisabled = DesignToken.systemBorderStateDisabled
        }

        enum Icon {
            static let brandPrimaryDark = DesignToken.systemIconBrandPrimaryDark
            static let brandPrimaryBase = DesignToken.systemIconBrandPrimaryBase
            static let brandPrimaryMid = DesignToken.systemIconBrandPrimaryMid
            static let brandPrimarySubtle = DesignToken.systemIconBrandPrimarySubtle

            static let brandSecondaryDark = DesignToken.systemIconBrandSecondaryDark
            static let brandSecondaryBase = DesignToken.systemIconBrandSecondaryBase
            static let brandSecondaryMid = DesignToken.systemIconBrandSecondaryMid
            static let brandSecondarySubtle = DesignToken.systemIconBrandSecondarySubtle

            static let marketOrangeDark = DesignToken.systemIconMarketOrangeDark
            static let marketOrangeBase = DesignToken.systemIconMarketOrangeBase
            static let marketOrangeMid = DesignToken.systemIconMarketOrangeMid
            static let marketOrangeSubtle = DesignToken.systemIconMarketOrangeSubtle

            static let marketGreenBase = DesignToken.systemIconMarketGreenBase
            static let marketGreenDark = DesignToken.systemIconMarketGreenDark
            static let marketYellowBase = DesignToken.systemIconMarketYellowBase
            static let marketYellowDark = DesignToken.systemIconMarketYellowDark

            static let neutralDark = DesignToken.systemIconNeutralDark
            static let neutralBase = DesignToken.systemIconNeutralBase
            static let neutralMid = DesignToken.systemIconNeutralMid
            static let neutralSubtle = DesignToken.systemIconNeutralSubtle
            static let neutralExtraSubtle = DesignToken.systemIconNeutralExtraSubtle
            static let neutralWhite = DesignToken.systemIconNeutralWhite

            static let stateError = DesignToken.systemIconStateError
            static let stateSuccess = DesignToken.systemIconStateSuccess
            static let stateDisabled = DesignToken.systemIconStateDisabled
        }
    }
}
