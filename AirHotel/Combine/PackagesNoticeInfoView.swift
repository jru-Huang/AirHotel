//
//  PackagesNoticeInfoView.swift
//  AirHotel
//
//  Created by 7943 on 2026/6/8.
//

import SwiftUI

struct PackagesNoticeInfoView: View {
    let info: NoticeDetailInfo
    var onDismiss: (() -> Void)
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .bottom) {
                backgroundView

                noticeView(maxHeight: proxy.size.height * 0.8)
            }
        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            closeButtonView
                .background(AppColor.Surface.brandSecondaryBase)
        }
    }

    private var backgroundView: some View {
        AppColor.Surface.opacityGrayMid
            .ignoresSafeArea()
            .onTapGesture {
                onDismiss()
            }
    }

    private func noticeView(maxHeight: CGFloat) -> some View {
        VStack(spacing: 0) {
            headerView
            contentView(noticeInfoList: info.noticeInfoList, maxHeight: maxHeight)
        }
        .frame(maxWidth: .infinity)
        .background(AppColor.Surface.neutralWhite)
        .clipShape(RoundedCorner(radius: 8, corners: [.topLeft, .topRight]))
        .ignoresSafeArea(edges: .bottom)
    }
    
    private var headerView: some View {
        ZStack {
            HStack {
                Button {
                    onDismiss()
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
    }
    
    private func contentView(noticeInfoList: [NoticeDetail], maxHeight: CGFloat) -> some View {
        ScrollView {
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
        .frame(maxHeight: maxHeight)
        .fixedSize(horizontal: false, vertical: true)
        .background(AppColor.Surface.neutralWhite)
    }
    
    private var closeButtonView: some View {
        Button {
            onDismiss()
        } label: {
            Text("關閉")
                .font(AppTypography.L02M)
                .foregroundStyle(AppColor.Text.neutralWhite)
                .frame(maxWidth: .infinity)
                .frame(height: 40)
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
                                                 ), onDismiss: {print("點擊關閉")})
}
