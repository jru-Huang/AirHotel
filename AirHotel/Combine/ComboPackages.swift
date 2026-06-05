//
//  ComboPackages.swift
//  AirHotel
//
//  Created by 7943 on 2026/5/26.
//

import SwiftUI

struct ComboPackages: View {
    @StateObject private var viewModel: ComboPackagesViewModel
    
    @State private var isShowedSearchView: Bool = false
    @State private var showAmountDetail: Bool = false
    
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
            
            if !isShowedSearchView {
                navContainerView
            }
            
            amountDetailOverlayView
            amountBottomContainerView
                .zIndex(1)
            
            if isShowedSearchView {
                searchOverlayView
                    .zIndex(2)
            }
        }
    }

    private var backgroundView: some View {
        AppColor.Background.pagePurple
            .ignoresSafeArea()
    }

    private func mainContentView(bottomInset: CGFloat) -> some View {
        VStack(spacing: 0) {
            ComboTaxNoticeView(taxNotice: viewModel.taxNotice)
            
            ScrollView {
                VStack(spacing: 0) {
                    ComboSystemNoticeView(systemNoticeList: viewModel.systemNoticeList)
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
            ComboHotelCard(info: viewModel.hotelInfoCard)
            ComboDiscountCard(info: $viewModel.discountInfoCard)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }

    private var navContainerView: some View {
        VStack(spacing: 0) {
            comboNavView
            Spacer()
        }
    }

    private var comboNavView: some View {
        ComboNavView(
            isShowedSearchView: $isShowedSearchView,
            navInfo: viewModel.navInfo,
            showSearchView: { self.isShowedSearchView = $0 }
        )
    }

    @ViewBuilder
    private var amountDetailOverlayView: some View {
        if showAmountDetail {
            amountDetailBgView
        }
    }
    
    private var amountBottomContainerView: some View {
        VStack(spacing: 0) {
            Spacer()
            
            if showAmountDetail {
                ComboAmountDetailView(showAmountDetail: $showAmountDetail)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
            
            ComboAmountBottomView(showAmountDetail: $showAmountDetail)
        }
        .animation(.easeInOut(duration: 0.3), value: showAmountDetail)
    }

    private var searchOverlayView: some View {
        ZStack(alignment: .top) {
            searchBgView

            VStack(spacing: 0) {
                comboNavView
                SearchView()
                Spacer()
            }
        }
    }
    
    private var searchBgView: some View {
        AppColor.Surface.opacityGrayMid
            .ignoresSafeArea()
            .onTapGesture {
                isShowedSearchView = false
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
    ComboPackages()
}
