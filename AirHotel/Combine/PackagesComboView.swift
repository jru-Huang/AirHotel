//
//  ComboPackages.swift
//  AirHotel
//
//  Created by 7943 on 2026/5/26.
//

import SwiftUI

struct PackagesComboView: View {
    @StateObject private var viewModel: PackagesComboViewModel
    
    @State private var showSearchView: Bool = false
    @State private var showAmountDetail: Bool = false
    @State private var presentNotice: PackagesNoticeInfo?
    
    let navBarHeight: CGFloat = 44
    
    init() {
        _viewModel = StateObject(wrappedValue: PackagesComboViewModel())
    }
    
    var body: some View {
        GeometryReader { proxy in
            contentView(proxy: proxy)
        }
        //        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.onViewAppear()
        }
    }
}

extension PackagesComboView {
    
    private func contentView(proxy: GeometryProxy) -> some View {
        ZStack {
            backgroundView
            mainContentView(bottomInset: proxy.safeAreaInsets.bottom)
            navContainerView
            
            amountContainerView
                .zIndex(1)
            
            searchContainerView
                .zIndex(2)
            
            if let presentNotice {
                PackagesNoticeInfoView(
                    info: presentNotice.noticeInfo,
                    onDismiss: { self.presentNotice = nil }
                )
                .zIndex(3)
            }
        }
    }
    
    private var backgroundView: some View {
        AppColor.Background.pagePurple
            .ignoresSafeArea()
    }
    
    private func mainContentView(bottomInset: CGFloat) -> some View {
        VStack(spacing: 0) {
            if let policyNotice = viewModel.policyNotice {
                PackagesComboPolicyNoticeView(notice: policyNotice.noticeDetailList.first?.content ?? "", onTouchNotice: {
                    presentNotice = PackagesNoticeInfo(noticeInfo: policyNotice)
                })
            }
            
            ScrollView {
                VStack(spacing: 0) {
                    if let stopBookingNotice = viewModel.stopBookingNotice {
                        PackagesComboSystemNoticeView(systemNoticeConfig: stopBookingNotice.config!, onTouchNotice: {
                            presentNotice = PackagesNoticeInfo(noticeInfo: stopBookingNotice.detailInfo!)
                        })
                    }
                    
                    if let announceNotice = viewModel.announceNotice {
                        PackagesComboSystemNoticeView(systemNoticeConfig: announceNotice.config!, onTouchNotice: {
                            presentNotice = PackagesNoticeInfo(noticeInfo: announceNotice.detailInfo!)
                        })
                    }
                    
                    packagesContentView
                }
                .padding(.bottom, bottomInset + 12)
            }
        }
        .padding(.top, navBarHeight)
    }
    
    private var packagesContentView: some View {
        VStack(spacing: 12) {
            PackagesComboHeader()
            
            PackagesComboAirCard(info: viewModel.airInfoCard)
            
            if let hotelInfo = viewModel.hotelInfoCard {
                PackagesComboHotelCard(info: hotelInfo, onTouchNotice: {
                    presentNotice = PackagesNoticeInfo(noticeInfo: viewModel.hotelCancelNotice)
                })
            }
            
            PackagesComboDiscountCard(info: $viewModel.discountInfoCard)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
    
    private var navContainerView: some View {
        VStack(spacing: 0) {
            PackagesComboNavView(
                navBarHeight: navBarHeight,
                navInfo: viewModel.navInfo,
                onTouchBack: {},
                onTouchSearch: { self.showSearchView.toggle() },
                onTouchTrace: {}
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
                PackagesComboAmountDetailView(
                    showAmountDetail: $showAmountDetail,
                    info: viewModel.amountInfo)
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
            
            PackagesComboAmountBottomView(showAmountDetail: $showAmountDetail)
        }
        .animation(.easeInOut(duration: 0.3), value: showAmountDetail)
    }
    
    private var searchContainerView: some View {
        ZStack(alignment: .top) {
            if showSearchView {
                searchBgView
            }
            
            if showSearchView {
                changeSearchView
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: showSearchView)
    }
    
    private var changeSearchView: some View {
        VStack(spacing: 0) {
            PackagesComboChangeSearchNavView(
                navBarHeight: navBarHeight,
                onTouchCancel: {
                    showSearchView = false
                })
            SearchView()
            Spacer()
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
}

#Preview {
    PackagesComboView()
}
