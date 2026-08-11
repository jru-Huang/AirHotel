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
    let leftTitle: String
    let rightTitle: String
    
    init(imgName: String,
         title: String? = nil,
         message: String? = nil,
         isSingleButton: Bool = false,
         leftTitle: String = "重新整理",
         rightTitle: String = "繼續瀏覽") {
        
        self.imgName = imgName
        self.title = title
        self.message = message
        self.isSingleButton = isSingleButton
        self.leftTitle = leftTitle
        self.rightTitle = rightTitle
    }
}

struct DialogSwiftUIView: View {
    
    @State private var isBgVisible: Bool = false
    @State private var isDialogVisible = true
    
    let model: DialogSwiftUIModel
    
    var onLeftAction: (()->Void)? = nil
    var onRightAction: (()->Void)? = nil
    
    private let hideDuration: Double = 0.2
    
    var body: some View {
        ZStack {
            backgroundView
            
            if isDialogVisible {
                dialogView
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.25)) {
                isBgVisible = true
                isDialogVisible = true
            }
        }
    }
    
    private var backgroundView: some View {
        AppColor.Surface.opacityGrayMid
            .ignoresSafeArea()
            .opacity(isBgVisible ? 1 : 0)
    }
    
    private var dialogView: some View {
        VStack(alignment: .center, spacing: 20) {
            contentView
            buttonView
        }
        .padding(20)
        .frame(maxWidth: screenWidth * 0.8)
        .background(AppColor.Surface.neutralWhite, in: RoundedRectangle(cornerRadius: 8))
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
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                    .frame(maxWidth: .infinity)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
    
    private var buttonView: some View {
        HStack(spacing: 8) {
            
            // Left Button
            if !model.isSingleButton {
                Button {
                    dismiss(completion: {
                        onLeftAction?()
                    })
                    
                } label: {
                    Text(model.leftTitle)
                        .font(AppTypography.L02M)
                        .foregroundStyle(AppColor.Text.brandSecondaryBase)
                        .frame(maxWidth: .infinity)
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
                dismiss(completion: {
                    onRightAction?()
                })
                
            } label: {
                Text(model.rightTitle)
                    .font(AppTypography.L02M)
                    .foregroundStyle(AppColor.Text.neutralWhite)
                    .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: 40, alignment: .center)
            .background(AppColor.Surface.brandSecondaryBase, in: RoundedRectangle(cornerRadius: 4))
            
        }
    }
    
    private func dismiss(completion: (() -> Void)? = nil) {
        withAnimation(nil) {
            isDialogVisible = false
        }
        
        withAnimation(.easeIn(duration: hideDuration)) {
            isBgVisible = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + hideDuration) {
            completion?()
        }
    }
}


#Preview {
    DialogSwiftUIView(model: DialogSwiftUIModel(imgName: "Hotel", title: "標題標題標題", message: "內容內容內容內容內容內容內容"), onLeftAction: {}, onRightAction: {})
}
