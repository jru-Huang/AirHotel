//
//  PackagesPassengerInfoOrderTermsView.swift
//  AirHotel
//
//  Created by 7943 on 2026/8/11.
//

import SwiftUI

struct PackagesPassengerInfoOrderTermsView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding var hasReadOrderTerms: Bool
    
    @State private var hasScrolledToBottom = false
    
    var infoList: [PackagesPassengerInfoModel.OrderTermsInfoModel] = []
    
    var body: some View {
        VStack(spacing: 0) {
            navTitleView
            GeometryReader { scrollGeometry in
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(spacing: 8) {
                            ForEach(infoList) { info in
                                VStack(alignment: .leading,spacing: 4) {
                                    if !info.title.isEmpty { // jru: ??
                                        Text(info.title)
                                            .font(AppTypography.T03M)
                                    }
                                    Text(info.content)
                                        .font(AppTypography.B04R)
                                }
                                .foregroundStyle(AppColor.Text.neutralBodyBase)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding(.bottom, 40)
                        .padding(.top, 16)
                        
                        Color.clear
                            .frame(height: 1)
                            .background {
                                GeometryReader { bottomGeometry in
                                    Color.clear.preference(
                                        key: OrderTermsBottomPreferenceKey.self,
                                        value: bottomGeometry.frame(in: .named("orderTermsScroll")).maxY)
                                }
                            }
                            .id("orderTermsBottom")
                    }
                    .padding(.horizontal, 20)
                    .coordinateSpace(name: "orderTermsScroll")
                    .onPreferenceChange(OrderTermsBottomPreferenceKey.self, perform: { bottomPosition in
                        if bottomPosition <= scrollGeometry.size.height {
                            hasScrolledToBottom = true
                        }
                    })
                    .overlay(alignment: .bottom) {
                        if !hasScrolledToBottom {
                            scrollInstructionHint {
                                withAnimation {
                                    proxy.scrollTo("orderTermsBottom", anchor: .bottom)
                                }
                            }
                            .padding(.bottom , 12)
                        }
                    }
                }
            }
            
            actionButtons
        }
        .background(AppColor.Background.pageWhite)
        //        .toolbar {
        //            ToolbarItem(placement: .topBarLeading) {
        //                Button {
        //                    dismiss()
        //                } label: {
        //                    Image("ic_close_20")
        //                }
        //            }
        //
        //            ToolbarItem(placement: .principal) {
        //                Text("訂購須知")
        //                    .font(AppTypography.T02M)
        //                    .foregroundStyle(AppColor.Text.neutralBodyBase)
        //            }
        //        }
    }
    
    private var navTitleView: some View {
        ZStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image("ic_close_20")
                }
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            
            Text("訂購須知")
                .font(AppTypography.D03)
                .foregroundStyle(AppColor.Text.neutralBodyBase)
        }
        .background(AppColor.Surface.neutralWhite)
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(AppColor.Border.neutralExtraSubtle)
                .frame(height: 1)
        }
    }
    
    private func scrollInstructionHint(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            HStack(spacing: 4) {
                Image("ic_down_20")
                Text("請滑動至最下方詳閱內容")
                    .font(AppTypography.L02M)
                    .foregroundStyle(AppColor.Text.neutralWhite)
            }
            .padding(.vertical, 10)
            .padding(.trailing, 28)
            .padding(.leading, 24)
            .background(AppColor.Surface.brandSecondaryBase, in: Capsule())
        }
    }
    
    private var actionButtons: some View {
        HStack(spacing: 8) {
            Button {
                hasReadOrderTerms = false
                dismiss()
            } label: {
                Text("不同意")
                    .font(AppTypography.L02M)
                    .foregroundStyle(AppColor.Text.brandPrimaryMid)
                    .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity, minHeight: 40)
            .background(AppColor.Surface.neutralWhite)
            .overlay {
                RoundedRectangle(cornerRadius: 4)
                    .strokeBorder(AppColor.Text.brandPrimaryDark, lineWidth: 1)
            }
            
            Button {
                hasReadOrderTerms = true
                dismiss()
            } label: {
                Text("同意")
                    .font(AppTypography.L02M)
                    .foregroundStyle(AppColor.Text.neutralWhite)
                    .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity, minHeight: 40)
            .background(hasScrolledToBottom ? AppColor.Text.brandPrimaryBase : AppColor.Surface.stateDisabled,
                        in: RoundedRectangle(cornerRadius: 4))
            .disabled(!hasScrolledToBottom)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 6)
        .background(AppColor.Surface.neutralWhite)
    }
}

private struct OrderTermsBottomPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .greatestFiniteMagnitude
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

#Preview {
    PackagesPassengerInfoOrderTermsView(hasReadOrderTerms: .constant(false))
}
