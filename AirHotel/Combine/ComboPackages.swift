//
//  ComboPackages.swift
//  AirHotel
//
//  Created by 7943 on 2026/5/26.
//

import SwiftUI

struct ComboPackages: View {
    @StateObject private var viewModel: ComboPackagesViewModel
    
    @State private var showSearchView: Bool = false
    @State private var showAmountDetail: Bool = false
    @State private var presentNotice: PresentedNotice?
    
    let navBarHeight: CGFloat = 44
    
    init() {
        _viewModel = StateObject(wrappedValue: ComboPackagesViewModel())
    }
    
    var body: some View {
        GeometryReader { proxy in
            contentView(proxy: proxy)
        }
    }
    
    private func contentView(proxy: GeometryProxy) -> some View {
        ZStack {
            backgroundView
            mainContentView(bottomInset: proxy.safeAreaInsets.bottom)
            
            if !showSearchView {
                navContainerView
            }
            
            amountContainerView
                .zIndex(1)
            
            if showSearchView {
                changeSearchView
                    .zIndex(2)
            }
            
            noticeContainerView(maxHeight: proxy.size.height * 0.8)
                .zIndex(3)
        }
    }
    
    private var backgroundView: some View {
        AppColor.Background.pagePurple
            .ignoresSafeArea()
    }
    
    private func mainContentView(bottomInset: CGFloat) -> some View {
        VStack(spacing: 0) {
            ComboTaxNoticeView(taxNotice: viewModel.taxNotice, onTouchNotice: {
                presentNotice = PresentedNotice(noticeInfo: viewModel.taxNoticeInfo)
            })
            
            ScrollView {
                VStack(spacing: 0) {
                    ComboSystemNoticeView(systemNotice: viewModel.systemNotice1, onTouchNotice: {
                        presentNotice = PresentedNotice(noticeInfo: viewModel.systemNoticeInfo1)
                    })
                    ComboSystemNoticeView(systemNotice: viewModel.systemNotice2, onTouchNotice: {
                        presentNotice = PresentedNotice(noticeInfo: viewModel.systemNoticeInfo2)
                    })
                    packagesContentView
                }
                .padding(.bottom, bottomInset + 12)
            }
        }
        .padding(.top, navBarHeight)
    }
    
    private var packagesContentView: some View {
        VStack(spacing: 12) {
            ComboHeader()
            ComboAirCard(info: viewModel.airInfoCard)
            ComboHotelCard(info: viewModel.hotelInfoCard, onTouchNotice: {
                presentNotice = PresentedNotice(noticeInfo: viewModel.hotelCancelNotice)
            })
            ComboDiscountCard(info: $viewModel.discountInfoCard)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
    
    private var navContainerView: some View {
        VStack(spacing: 0) {
            ComboNavView(
                isShowedSearchView: $showSearchView,
                navBarHeight: navBarHeight,
                navInfo: viewModel.navInfo,
                showSearchView: { self.showSearchView = $0 }
            )
            Spacer()
        }
    }
    
    @ViewBuilder
    private var amountContainerView: some View {
        if showAmountDetail {
            amountDetailBgView
        }
        
        VStack(spacing: 0) {
            Spacer()
            
            if showAmountDetail {
                ComboAmountDetailView(
                    showAmountDetail: $showAmountDetail,
                    info: viewModel.amountInfo)
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
            
            ComboAmountBottomView(showAmountDetail: $showAmountDetail)
        }
        .animation(.easeInOut(duration: 0.3), value: showAmountDetail)
    }
    
    private var changeSearchView: some View {
        ZStack(alignment: .top) {
            searchBgView
            
            VStack(spacing: 0) {
                ComboChangeSearchNavView(
                    navBarHeight: navBarHeight,
                    onTouchBack: {
                        print("點擊返回P0機加酒首頁")
                    },
                    onTouchCancel: {
                        showSearchView = false
                    })
                SearchView()
                Spacer()
            }
        }
    }
    
    private var searchBgView: some View {
        AppColor.Surface.opacityGrayMid
            .ignoresSafeArea()
            .onTapGesture {
                showSearchView = false
            }
    }
    
    private var amountDetailBgView: some View {
        AppColor.Surface.opacityGrayMid
            .ignoresSafeArea()
            .onTapGesture {
                showAmountDetail = false
            }
    }
    
    private func noticeContainerView(maxHeight: CGFloat) -> some View {
        ZStack(alignment: .bottom) {
            if presentNotice != nil {
                noticeBgView
            }
            
            if let presentNotice {
                PackagesNoticeInfoView(
                    info: presentNotice.noticeInfo,
                    maxHeight: maxHeight,
                    onDismiss: { self.presentNotice = nil }
                )
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .animation(.easeInOut(duration: 0.3), value: presentNotice?.id)
    }
    
    private var noticeBgView: some View {
        AppColor.Surface.opacityGrayMid
            .ignoresSafeArea()
            .onTapGesture {
                presentNotice = nil
            }
    }
}

#Preview {
    ComboPackages()
}
