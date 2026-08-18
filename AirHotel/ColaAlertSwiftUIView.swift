//
//  ColaAlertSwiftUIView.swift
//  AirHotel
//
//  Created by 7943 on 2026/8/17.
//

import SwiftUI

struct ColaAlertSwiftUIModel {
    let title: String?
    let subtitle: String?
    let message: String
    let isSingleButton: Bool
    let cancelTitle: String
    let cancelSubtitle: String?
    let checkTitle: String
    let checkSubtitle: String?
    
    init(
        title: String? = nil,
        subtitle: String? = nil,
        message: String,
        isSingleButton: Bool = false,
        cancelTitle: String = "取消",
        cancelSubtitle: String? = nil,
        checkTitle: String = "確認",
        checkSubtitle: String? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.message = message
        self.isSingleButton = isSingleButton
        self.cancelTitle = cancelTitle
        self.cancelSubtitle = cancelSubtitle
        self.checkTitle = checkTitle
        self.checkSubtitle = checkSubtitle
    }
}

struct ColaAlertSwiftUIView: View {
    
    @State var model: ColaAlertSwiftUIModel
    
    @State private var headerHeight: CGFloat = 0
    @State private var buttonHeight: CGFloat = 0
    @State private var isBgVisible = false
    @State private var isAlertVisible = true
    
    var onCancel: (() -> Void)? = nil
    var onCheck: (() -> Void)? = nil
    var onDismiss: (() -> Void)
    
    private let alertMaxHeight: CGFloat = 450
    private let alertWidthRatio: CGFloat = 0.8
    private let dividerHeight: CGFloat = 1
    private let buttonMinHeight: CGFloat = 40
    private let messageHorizontalPadding: CGFloat = 20
    private let messageVerticalPadding: CGFloat = 36 //上: 12；下: 24
    private let dismissDuration: Double = 0.2
    
    private var alertWidth: CGFloat {
        screenWidth * alertWidthRatio
    }
    
    private var messageScrollHeight: CGFloat {
        min(calculateMsgHeight, alertMaxHeight)
    }
    
    private var shouldScrollMessage: Bool {
        let totalHeight = headerHeight + calculateMsgHeight + buttonHeight + dividerHeight
        return totalHeight > alertMaxHeight
    }
    
    var body: some View {
        ZStack {
            backgroundView
            
            if isAlertVisible {
                alertView
            }
        }
        .onAppear {
            guard isBgVisible == false else { return }
            withAnimation(.easeInOut(duration: 0.2)) {
                isBgVisible = true
            }
        }
    }
    
    private var backgroundView: some View {
        AppColor.Surface.opacityGrayMid
            .opacity(isBgVisible ? 1 : 0)
            .ignoresSafeArea()
    }
    
    private var alertView: some View {
        VStack(spacing: 0) {
            headerView
            messageView
            dividerView
            checkAndCancelButtonView
        }
        .frame(width: alertWidth)
        .fixedSize(horizontal: false, vertical: true)
        .background(AppColor.Surface.neutralWhite, in: RoundedRectangle(cornerRadius: 10))
    }
    
    private var dividerView: some View {
        Rectangle()
            .fill(AppColor.Surface.neutralSubtle)
            .frame(height: dividerHeight)
    }
    
    private var headerView: some View {
        VStack(spacing: 4) {
            if let title = model.title, !title.isEmpty {
                Text(title)
                    .font(AppTypography.T02M)
                    .foregroundStyle(AppColor.Text.neutralBodyBase)
            }
            
            if let subtitle = model.subtitle, !subtitle.isEmpty {
                Text(subtitle)
                    .font(AppTypography.T04R)
                    .foregroundStyle(AppColor.Text.neutralBodyLight)
            }
            
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(heightReader($headerHeight))
    }
    
    private var messageView: some View {
        Group {
            if shouldScrollMessage {
                ScrollView(showsIndicators: true) {
                    messageText
                }
                .frame(height: messageScrollHeight)
            } else {
                messageText
            }
        }
    }
    
    private var messageText: some View {
        Text(model.message)
            .font(AppTypography.B03R)
            .foregroundStyle(AppColor.Text.neutralBodyMid)
            .padding(.top, 12)
            .padding(.bottom, 24)
            .padding(.horizontal, messageHorizontalPadding)
            .fixedSize(horizontal: false, vertical: true)
    }
    
    private var checkAndCancelButtonView: some View {
        HStack(spacing: 0) {
            if !model.isSingleButton {
                buttonConfig(title: model.cancelTitle,
                             subtitle: model.cancelSubtitle ?? "",
                             color: AppColor.Text.neutralBodyMid,
                             action: {
                    dismissAlert {
                        onCancel?()
                    }
                })
            }
            
            Rectangle()
                .fill(AppColor.Surface.neutralSubtle)
                .frame(width: 1, height: 24)
            
            buttonConfig(title: model.checkTitle,
                         subtitle: model.checkSubtitle ?? "",
                         color: AppColor.Text.brandPrimaryDark,
                         action: {
                dismissAlert {
                    onCheck?()
                }
            })
        }
        .frame(minHeight: buttonMinHeight)
        .background(heightReader($buttonHeight))
    }
    
    private func buttonConfig(title: String,
                              subtitle: String,
                              color: Color,
                              action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            VStack(alignment: .center, spacing: 0) {
                Text(title)
                    .font(AppTypography.L02M)
                    .foregroundStyle(color)
                
                if subtitle.isEmpty == false {
                    Text(subtitle)
                        .font(AppTypography.L03R)
                        .foregroundStyle(color)
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity)
            .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, minHeight: buttonMinHeight)
    }
    
    private var calculateMsgHeight: CGFloat {
        let msgString = NSString(string: model.message)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        let msgWidth = alertWidth - (messageHorizontalPadding * 2)
        let boundingRect = msgString.boundingRect(
            with: CGSize(width: msgWidth,
                         height: .greatestFiniteMagnitude),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: [.font: AppTypography.UI.B03R,
                         .paragraphStyle: paragraphStyle],
            context: nil)
        return ceil(boundingRect.height) + messageVerticalPadding
    }
    
    private func heightReader(_ height: Binding<CGFloat>) -> some View {
        GeometryReader { proxy in
            Color.clear
                .onAppear {
                    height.wrappedValue = proxy.size.height
                }
                .onChange(of: proxy.size.height) { newValue in
                    height.wrappedValue = newValue
                }
        }
    }
    
    private func dismissAlert(completion: (() -> Void)? = nil) {
        withAnimation(nil) {
            isAlertVisible = false
        }
        
        withAnimation(.easeInOut(duration: dismissDuration)) {
            isBgVisible = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + dismissDuration) {
            onDismiss()
            completion?()
        }
    }
}

#Preview {
    ColaAlertSwiftUIView(model: ColaAlertSwiftUIModel(message: "TEST"), onDismiss: {print("")})
}
