//
//  DialogSwiftUIView.swift
//  AirHotel
//
//  Created by 7943 on 2026/6/25.
//

import SwiftUI

struct DialogSwiftUIModel {
    let imgName: String
    let title: String?
    let message: String?
    let isSingleButton: Bool
    let leftTitle: String?
    let rightTitle: String
    
    init(imgName: String,
         title: String? = nil,
         content: String? = nil,
         isSingleButton: Bool = true,
         leftTitle: String? = nil,
         rightTitle: String = "重新整理") {
        
        self.imgName = imgName
        self.title = title
        self.message = content
        self.isSingleButton = isSingleButton
        self.leftTitle = leftTitle
        self.rightTitle = rightTitle
    }
}

struct DialogSwiftUIView: View {
    
    @State var model: DialogSwiftUIModel
    
    @State private var showContent: Bool = false
    
    let onDismiss: (() -> Void)
    let onLeftAction: (()->Void)? = nil
    let onRightAction: (()->Void)? = nil
    
    private let hideDuration: Double = 0.2
    
    var body: some View {
        ZStack {
            backgroundView
            dialogView
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.25)) {
                showContent = true
            }
        }
    }
    
    private var backgroundView: some View {
        AppColor.Surface.opacityGrayMid
            .ignoresSafeArea()
            .opacity(showContent ? 1 : 0)
    }
    
    private var dialogView: some View {
        VStack(alignment: .center, spacing: 20) {
            contentView
            buttonView
        }
        .padding(20)
        .frame(maxWidth: screenWidth * 0.8)
        .background(AppColor.Surface.neutralWhite, in: RoundedRectangle(cornerRadius: 8))
        .opacity(showContent ? 1 : 0)
    }
    
    private var contentView: some View {
        VStack(alignment: .center, spacing: 8){
            Image(model.imgName)
            titleAndMsgView
        }
        .frame(maxWidth: .infinity)
        .background(AppColor.Surface.neutralWhite)
    }
    
    private var titleAndMsgView: some View {
        VStack(spacing: 6) {
            if let title = model.title, !title.isEmpty {
                Text(title)
                    .font(AppTypography.T02M)
                    .foregroundStyle(AppColor.Text.neutralBodyBase)
                    .multilineTextAlignment(.center)
            }
            
            if let content = model.message, !content.isEmpty {
                Text(content)
                    .font(AppTypography.B03R)
                    .foregroundStyle(AppColor.Text.neutralBodyMid)
                    .multilineTextAlignment(.leading)
            }
        }
    }
    
    private var buttonView: some View {
        HStack(spacing: 8) {
            
            // Left Button
            if !model.isSingleButton {
                Button {
                    onLeftAction?()
                } label: {
                    Text(model.leftTitle ?? "")
                        .font(AppTypography.L02M)
                        .foregroundStyle(AppColor.Text.brandSecondaryBase)
                }
                .frame(maxWidth: .infinity, maxHeight: 40, alignment: .center)
                .background(AppColor.Surface.neutralWhite, in: RoundedRectangle(cornerRadius: 4))
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(AppColor.Border.brandSecondaryBase, lineWidth: 1)
                )
            }
            
            // Right Button
            Button {
                onRightAction?()
            } label: {
                Text(model.rightTitle)
                    .font(AppTypography.L02M)
                    .foregroundStyle(AppColor.Text.neutralWhite)
            }
            .frame(maxWidth: .infinity, maxHeight: 40, alignment: .center)
            .background(AppColor.Surface.brandSecondaryBase, in: RoundedRectangle(cornerRadius: 4))
            
        }
    }
    
    private func dismiss() {
        withAnimation(.easeIn(duration: hideDuration)) {
            showContent = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + hideDuration) {
            onDismiss()
        }
    }
}

#Preview {
    DialogSwiftUIView(model: DialogSwiftUIModel(imgName: "Hotel", title: "標題標題標題", content: "內容內容內容內容內容內容內容"), onDismiss: {})
}
