import UIKit

public extension UIColor {
    /// Initialize with a hex string.
    /// Supports formats: #RRGGBB, RRGGBB, #AARRGGBB, AARRGGBB
    /// - Parameter hex: The hex string (大小寫皆可，可含 #)。
    convenience init(hexColor: String, defaultAlpha: CGFloat = 1.0, fallback: UIColor = .clear) {
        guard let color = UIColor.parseHexColor(hexColor, defaultAlpha: defaultAlpha) else {
            self.init(cgColor: fallback.cgColor)
            return
        }

        self.init(cgColor: color.cgColor)
    }

    /// Initialize with a hex integer 0xRRGGBB
    /// - Parameters:
    ///   - hex: e.g. 0xFF9900 (不含 alpha)
    ///   - alpha: 透明度，預設 1.0
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let r = CGFloat((hex >> 16) & 0xFF) / 255.0
        let g = CGFloat((hex >> 8) & 0xFF) / 255.0
        let b = CGFloat(hex & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b, alpha: max(0.0, min(1.0, alpha)))
    }

    /// Factory from hex string. If no alpha is provided (6 digits), use `defaultAlpha`.
    /// - Parameters:
    ///   - hex: 字串格式 #RRGGBB / RRGGBB / #AARRGGBB / AARRGGBB
    ///   - defaultAlpha: 若字串無 alpha 時使用
    static func hexColor(_ hex: String, defaultAlpha: CGFloat = 1.0) -> UIColor? {
        UIColor.parseHexColor(hex, defaultAlpha: defaultAlpha)
    }

    /// Non-optional factory from hex string with fallback.
    /// - Parameters:
    ///   - hex: 字串格式 #RRGGBB / RRGGBB / #AARRGGBB / AARRGGBB
    ///   - defaultAlpha: 若字串無 alpha 時使用
    ///   - fallback: 當解析失敗時回傳此顏色（預設 .clear）
    /// - Returns: UIColor（不為可選）
    static func hexColor(_ hex: String, defaultAlpha: CGFloat = 1.0, fallback: UIColor = .clear) -> UIColor {
        if let color = self.hexColor(hex, defaultAlpha: defaultAlpha) {
            return color
        } else {
            return fallback
        }
    }

    /// Factory from hex integer 0xRRGGBB
    /// - Parameters:
    ///   - hex: 整數 0xRRGGBB
    ///   - alpha: 透明度，預設 1.0
    static func hexColor(_ hex: Int, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(hex: hex, alpha: alpha)
    }

    private static func parseHexColor(_ hex: String, defaultAlpha: CGFloat) -> UIColor? {
        var cleaned = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if cleaned.hasPrefix("#") { cleaned.removeFirst() }

        guard cleaned.count == 6 || cleaned.count == 8 else { return nil }

        var value: UInt64 = 0
        guard Scanner(string: cleaned).scanHexInt64(&value) else { return nil }

        let r, g, b, a: CGFloat
        if cleaned.count == 8 {
            a = CGFloat((value & 0xFF00_0000) >> 24) / 255.0
            r = CGFloat((value & 0x00FF_0000) >> 16) / 255.0
            g = CGFloat((value & 0x0000_FF00) >> 8) / 255.0
            b = CGFloat(value & 0x0000_00FF) / 255.0
        } else {
            a = max(0.0, min(1.0, defaultAlpha))
            r = CGFloat((value & 0xFF00_00) >> 16) / 255.0
            g = CGFloat((value & 0x00FF_00) >> 8) / 255.0
            b = CGFloat(value & 0x0000_FF) / 255.0
        }

        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}

#if DEBUG
// Usage examples:
// let c1 = UIColor.hexColor("#FF9900")
// let c2 = UIColor.hexColor("#80FF9900") // with alpha
// let c3 = UIColor(hex: 0xFF9900)
// let c4 = UIColor.hexColor(0xFF9900, alpha: 0.5)
// let c5 = UIColor.hexColor("#BADHEX", defaultAlpha: 1.0, fallback: .orange) // non-optional
// let c6 = UIColor(hex: "#BADHEX", defaultAlpha: 1.0, fallback: .orange) // non-optional init
#endif
