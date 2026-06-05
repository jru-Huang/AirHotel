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

