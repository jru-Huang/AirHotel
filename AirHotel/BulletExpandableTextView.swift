//
//  BulletExpandableTextItem.swift
//  AirHotel
//
//  Created by 7943 on 2026/8/10.
//

import SwiftUI

struct BulletExpandableTextItem {
    
    struct ExpandableTextStyle {
        let font: Font
        let uiFont: UIFont
        let color: Color
    }
    
    var textList: [String]
    var lineLimit: Int
    
    var backgroundColor: Color = AppColor.Surface.neutralExtraSubtle
    
    var textStyle: ExpandableTextStyle
    var moreTextStyle: ExpandableTextStyle
    
    var verticalPadding: CGFloat = 8
    var horizontalPadding: CGFloat = 8
    
    var moreText = " 顯示更多"
    var ellipsisText = "..."
    
    init(textList: [String],
         lineLimit: Int,
         backgroundColor: Color = AppColor.Surface.neutralExtraSubtle,
         textStyle: ExpandableTextStyle = ExpandableTextStyle(font: AppTypography.B05R,
                                                                uiFont: AppTypography.UI.B05R,
                                                                color: AppColor.Text.neutralBodyMid),
         moreTextStyle: ExpandableTextStyle = ExpandableTextStyle(font: AppTypography.L03R,
                                                                  uiFont: AppTypography.UI.L03R,
                                                                  color: AppColor.Text.brandSecondaryBase),
         verticalPadding: CGFloat = 8,
         horizontalPadding: CGFloat = 8,
         moreText: String = " 顯示更多",
         ellipsisText: String = "...") {
        self.textList = textList
        self.lineLimit = lineLimit
        self.backgroundColor = backgroundColor
        self.textStyle = textStyle
        self.moreTextStyle = moreTextStyle
        self.verticalPadding = verticalPadding
        self.horizontalPadding = horizontalPadding
        self.moreText = moreText
        self.ellipsisText = ellipsisText
    }
}

struct BulletExpandableTextView: View {
    
    private enum VisibleBullet {
        case full(String)
        case clipped(String)
    }
    
    @State private var isExpanded = false
    @State private var containerWidth: CGFloat = 0
    
    var item: BulletExpandableTextItem
    
    private var shouldShowMore: Bool {
        !isExpanded && totalLineCount > item.lineLimit
    }
    
    private var visibleBullets: [VisibleBullet] {
        guard !isExpanded else {
            return item.textList.map { .full($0) }
        }
        
        guard containerWidth > 0 else {
            return item.textList.map { .full($0) }
        }
        
        var result: [VisibleBullet] = []
        var usedLines = 0
        
        for text in item.textList {
            let lineCount = lineCount(for: text)
            
            if usedLines + lineCount < item.lineLimit {
                // 加上這筆之後，還沒超過限制，那完整顯示。
                result.append(.full(text))
                usedLines += lineCount
            } else if usedLines + lineCount == item.lineLimit {
                // 加上這筆剛好等於就限制。
                if shouldShowMore {
                    let clippedText = clippedText(text, maxLines: lineCount)
                    result.append(.clipped(clippedText))
                } else {
                    result.append(.full(text))
                }
                break
            } else {
                // 加上這筆會超過限制，所以只能顯示這筆的一部分。
                let remainingLines = item.lineLimit - usedLines
                
                guard remainingLines > 0 else { break }
                
                let clippedText = clippedText(text, maxLines: remainingLines)
                result.append(.clipped(clippedText))
                break
            }
        }
        
        return result
    }
    
    private var totalLineCount: Int {
        guard containerWidth > 0 else { return 0 }
        
        return item.textList.reduce(0) { partialResult, text in
            partialResult + lineCount(for: text)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(Array(visibleBullets.enumerated()), id: \.offset) { _, bullet in
                HStack(alignment: .top, spacing: 0) {
                    Text("• ")
                        .font(item.textStyle.font)
                        .foregroundStyle(item.textStyle.color)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    switch bullet {
                    case .full(let text):
                        Text(text)
                            .font(item.textStyle.font)
                            .foregroundStyle(item.textStyle.color)
                            .fixedSize(horizontal: false, vertical: true)
                        
                    case .clipped(let text):
                        collapsedLastItem(text)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, item.verticalPadding)
        .padding(.horizontal, item.horizontalPadding)
        .background(item.backgroundColor)
        .background {
            GeometryReader { proxy in
                Color.clear
                    .onAppear {
                        containerWidth = proxy.size.width - item.horizontalPadding * 2
                    }
                    .onChange(of: proxy.size.width) { newValue in
                        containerWidth = newValue - item.horizontalPadding * 2
                    }
            }
        }
    }
    
    private func collapsedLastItem(_ text: String) -> some View {
        (
            Text(text)
                .font(item.textStyle.font)
                .foregroundColor(item.textStyle.color)
            +
            Text(item.moreText)
                .font(item.moreTextStyle.font)
                .foregroundColor(item.moreTextStyle.color)
        )
        .fixedSize(horizontal: false, vertical: true)
        .onTapGesture {
            withAnimation(.easeInOut) {
                isExpanded = true
            }
        }
    }
    
    private func clippedText(_ text: String, maxLines: Int) -> String {
        guard containerWidth > 0, maxLines > 0 else { return "" }
        
        let bulletWidth = measureWidth("• ", font: item.textStyle.uiFont)
        let tailWidth =
            measureWidth(item.ellipsisText, font: item.textStyle.uiFont) +
            measureWidth(item.moreText, font: item.moreTextStyle.uiFont)
        
        let normalLineWidth = containerWidth - bulletWidth
        let lastLineWidth = normalLineWidth - tailWidth
        
        guard normalLineWidth > 0, lastLineWidth > 0 else { return "" }
        
        var result = ""
        
        for character in text {
            let next = result + String(character)
            
            if fits(next, maxLines: maxLines, normalLineWidth: normalLineWidth, lastLineWidth: lastLineWidth) {
                result = next
            } else {
                break
            }
        }
        
        return result.trimmingCharacters(in: .whitespacesAndNewlines) + item.ellipsisText
    }
    
    private func fits(_ text: String, maxLines: Int, normalLineWidth: CGFloat, lastLineWidth: CGFloat) -> Bool {
        if maxLines == 1 {
            return measureWidth(text, font: item.textStyle.uiFont) <= lastLineWidth
        }
        
        let singleLineHeight = measureHeight(
            "樣本高度",
            font: item.textStyle.uiFont,
            width: .greatestFiniteMagnitude
        )

        let firstPartMaxHeight = singleLineHeight * CGFloat(maxLines - 1)
        
        
        let textHeight = measureHeight(
            text,
            font: item.textStyle.uiFont,
            width: normalLineWidth
        )
        
        if textHeight <= firstPartMaxHeight {
            return true
        }
        
        var firstPart = ""
        var remainingText = text
        
        for character in text {
            let next = firstPart + String(character)
            let height = measureHeight(
                next,
                font: item.textStyle.uiFont,
                width: normalLineWidth
            )
            
            if height > firstPartMaxHeight {
                break
            }
            
            firstPart = next
            remainingText.removeFirst()
        }
        
        return measureWidth(remainingText, font: item.textStyle.uiFont) <= lastLineWidth
    }
    
    private func lineCount(for text: String) -> Int {
        let bulletWidth = measureWidth("• ", font: item.textStyle.uiFont)
        let availableWidth = containerWidth - bulletWidth
        
        guard availableWidth > 0 else { return 1 }
        
        let singleLineHeight = measureHeight(
            "樣本高度",
            font: item.textStyle.uiFont,
            width: .greatestFiniteMagnitude
        )
        
        let textHeight = measureHeight(
            text,
            font: item.textStyle.uiFont,
            width: availableWidth
        )
        
        return max(1, Int(ceil(textHeight / singleLineHeight)))
    }
    
    private func measureWidth(_ text: String, font: UIFont) -> CGFloat {
        (text as NSString).size(
            withAttributes: [.font: font]
        ).width
    }
    
    private func measureHeight(_ text: String, font: UIFont, width: CGFloat) -> CGFloat {
        let rect = (text as NSString).boundingRect(
            with: CGSize(width: width, height: .greatestFiniteMagnitude),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: [.font: font],
            context: nil
        )
        
        return ceil(rect.height)
    }
}


#Preview {
    BulletExpandableTextView(item: BulletExpandableTextItem(textList: ["本系統為自動化機加酒組合訂購服務，僅提供「機票+飯店」套裝銷售，恕不適用信用卡特定合作專案、航空公司額外贈送服務，亦不提供單項加購（如：租車、當地行程）之需求。如您有特殊加購或個別專案需求，請至專屬頁面訂購或洽詢專人處理。"], lineLimit: 4))
}

/*
struct ExpandableText: View {
    let text: String
    var lineLimit: Int = 4

    @State private var isExpanded = false
    @State private var limitedTextHeight: CGFloat = 0
    @State private var fullTextHeight: CGFloat = 0

    private var isTruncated: Bool {
        fullTextHeight > limitedTextHeight + 0.5
    }

    var body: some View {
        Text(text)
            .font(AppTypography.B05R)
            .foregroundStyle(AppColor.Text.neutralBodyMid)
            .lineLimit(isExpanded ? nil : lineLimit)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background {
                // 取得限制後高度
                GeometryReader { limitedProxy in
                    Color.clear
                        .preference(
                            key: LimitedTextHeightKey.self,
                            value: limitedProxy.size.height //畫面上限制 4 行的 Text，實際寬度
                        )

                    // 用相同寬度測量完整文字
                    Text(text)
                        .font(AppTypography.B05R)
                        .lineLimit(nil)
                        .frame(
                            width: limitedProxy.size.width, //測量完整文字時，也必須使用完全相同的寬度
                            alignment: .leading
                        )
                        .fixedSize(horizontal: false, vertical: true)
                        .hidden()
                        .background {
                            GeometryReader { fullProxy in
                                Color.clear
                                    .preference(
                                        key: FullTextHeightKey.self,
                                        value: fullProxy.size.height
                                    )
                            }
                        }
                }
            }
            .padding(.vertical, 8)
            .padding(.leading, 4)
            .padding(.trailing, 8)
            .background(AppColor.Surface.neutralExtraSubtle)
            .overlay(alignment: .bottomTrailing) {
                if !isExpanded && isTruncated {
                    moreButton
                }
            }
            .onPreferenceChange(LimitedTextHeightKey.self) {
                limitedTextHeight = $0
            }
            .onPreferenceChange(FullTextHeightKey.self) {
                fullTextHeight = $0
            }
    }

    private var moreButton: some View {
        HStack(spacing: 4) {
            Text("…")
                .font(AppTypography.B05R)
                .foregroundStyle(AppColor.Text.neutralBodyMid)

            Button("顯示更多") {
                withAnimation {
                    isExpanded = true
                }
            }
            .font(AppTypography.L03R)
            .foregroundStyle(AppColor.Text.brandSecondaryBase)
        }
        .padding(.bottom, 8)
        .padding(.trailing, 8)
        .background(AppColor.Surface.neutralExtraSubtle)
    }
}

private struct LimitedTextHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

private struct FullTextHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}
*/
