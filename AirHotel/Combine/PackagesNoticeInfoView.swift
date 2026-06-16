//
//  PackagesNoticeInfoView.swift
//  AirHotel
//
//  Created by 7943 on 2026/6/8.
//

import SwiftUI

struct PackagesNoticeInfoView: View {
    
    private let hideDuration: Double = 0.2
    
    let info: NoticeDetailInfo
    var onDismiss: (() -> Void)
    
    @State private var showContent: Bool = false
    
    var body: some View {
        GeometryReader { proxy in
            let maxHeight = proxy.size.height * 0.8
            
            ZStack {
                backgroundView
                content(maxHeight: maxHeight)
            }
            .onAppear {
                withAnimation(.easeOut(duration: 0.25)) {
                    showContent = true
                }
            }
        }
    }
    
    private var backgroundView: some View {
        AppColor.Surface.opacityGrayMid
            .ignoresSafeArea()
            .onTapGesture {
                dismiss()
            }
            .opacity(showContent ? 1 : 0)
    }
    
    private func content(maxHeight: CGFloat) -> some View {
        ZStack(alignment: .bottom) {
            Color.clear
            
            VStack(spacing: 0) {
                noticeView(maxHeight: maxHeight)
                closeButtonView
            }
            .frame(maxHeight: maxHeight, alignment: .bottom)
        }
        .offset(y: showContent ? 0 : 40)
        .opacity(showContent ? 1 : 0)
    }
    
    private func noticeView(maxHeight: CGFloat) -> some View {
        VStack(spacing: 0) {
            noticeHeaderView
            noticeContentView(noticeInfoList: info.noticeInfoList, maxHeight: maxHeight)
        }
        .frame(maxWidth: .infinity)
        .background(AppColor.Surface.neutralWhite)
        .clipShape(RoundedCorner(radius: 8, corners: [.topLeft, .topRight]))
    }
    
    private var noticeHeaderView: some View {
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
            
            Text(info.navTitle)
                .font(AppTypography.D03)
                .foregroundStyle(AppColor.Text.neutralBodyBase)
        }
        .background(AppColor.Surface.neutralWhite)
    }
    
    private func noticeContentView(noticeInfoList: [NoticeDetail], maxHeight: CGFloat) -> some View {
        ScrollView {
            noticeContentBody(noticeInfoList: noticeInfoList)
        }
        .frame(maxHeight: maxHeight)
        .fixedSize(horizontal: false, vertical: true)
        .background(AppColor.Surface.neutralWhite)
    }
    
    private func noticeContentBody(noticeInfoList: [NoticeDetail]) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(noticeInfoList) { notice in
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 4) {
                        if notice.title.isEmpty == false {
                            titleLine()
                            Text(notice.title)
                                .font(AppTypography.T03M)
                                .foregroundStyle(AppColor.Text.neutralBodyBase)
                        }
                    }
                    
                    Text(notice.content)
                        .font(AppTypography.B03)
                        .foregroundStyle(AppColor.Text.neutralBodyBase)
                }
            }
        }
        .padding(.top, 16)
        .padding(.horizontal, 20)
        .padding(.bottom, 40)
    }
    
    private var closeButtonView: some View {
        Button {
            dismiss()
        } label: {
            Text("關閉")
                .font(AppTypography.L02M)
                .foregroundStyle(AppColor.Text.neutralWhite)
                .frame(maxWidth: .infinity)
                .frame(height: 40)
        }
        .background(AppColor.Surface.brandSecondaryBase)
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
    PackagesNoticeInfoView(info: NoticeDetailInfo(navTitle: "注意事項",
                                                  noticeInfoList:
                                                     [
                                                         NoticeDetail(title: "日本政府政策：酒店房租稅",
                                                                      content: "東京從2002年10月起徵收住宿稅。徵稅標準根據住宿金額按每人每晚徵收，每晚住宿費在1萬日元以上每人每晚徵收100日元，1.5萬日元以上每人每晚徵收200日元，部分房價不包含住宿稅，需客人另付前臺，具體以飯店告知爲準。"),
                                                         NoticeDetail(title: "日本政府政策：酒店房租稅",
                                                                      content: "東京從2002年10月起徵收住宿稅。徵稅標準根據住宿金額按每人每晚徵收，每晚住宿費在1萬日元以上每人每晚徵收100日元，1.5萬日元以上每人每晚徵收200日元，部分房價不包含住宿稅，需客人另付前臺，具體以飯店告知爲準。"),
                                                         NoticeDetail(title: "日本政府政策：酒店房租稅",
                                                                      content: "東京從2002年10月起徵收住宿稅。徵稅標準根據住宿金額按每人每晚徵收，每晚住宿費在1萬日元以上每人每晚徵收100日元，1.5萬日元以上每人每晚徵收200日元，部分房價不包含住宿稅，需客人另付前臺，具體以飯店告知爲準。")
                                                      
                                                     ]
                                                 ),
//                           maxHeight: 560,
                           onDismiss: {print("點擊關閉")})
}
