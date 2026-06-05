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
    
    init() {
        _viewModel = StateObject(wrappedValue: ComboPackagesViewModel())
    }
    
    var body: some View {
        ZStack {
            Color.backgroundPagePurple_F8F8F8
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                ComboTaxNoticeView(taxNotice: viewModel.taxNotice)
                ScrollView {
                    VStack(spacing: 0) {
                        ComboSystemNoticeView(systemNoticeList: viewModel.systemNoticeList)
                        packagesContentView
                    }
                } 
            }
            
            if isShowedSearchView == true {
                searchBgView
            }
            
            if showAmountDetail == true {
                amountDetailBgView
            }
        }
        .safeAreaInset(edge: .top, spacing: 0, content: {
            VStack(spacing: 0) {
                
                ComboNavView(isShowedSearchView: $isShowedSearchView, navInfo: viewModel.navInfo, showSearchView: { [self] isShowedSearchView in
                    self.isShowedSearchView = isShowedSearchView
                })
                
                if isShowedSearchView == true {
                    SearchView()
                }
            }
        })
        .safeAreaInset(edge: .bottom, spacing: 0) {
            VStack(spacing: 0) {
                if showAmountDetail == true {
                    ComboAmountDetailView(showAmountDetail: $showAmountDetail)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
                
                ComboAmountBottomView(showAmountDetail: $showAmountDetail)
            }
            .animation(.easeInOut(duration: 0.3), value: showAmountDetail)
        }
    }
    
    private var packagesContentView: some View {
        VStack(spacing: 12) {
            ComboSectionHeader()
            ComboAirSection(info: viewModel.airInfoCard)
            ComboHotelSection(info: viewModel.hotelInfoCard)
            ComboDiscountSection(info: $viewModel.discountInfoCard)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
    
    private var searchBgView: some View {
        Color.surfaceOpacityGrayMid_333333_50
            .ignoresSafeArea()
            .onTapGesture {
                isShowedSearchView = false
            }
    }
    
    private var amountDetailBgView: some View {
        Color.surfaceOpacityGrayMid_333333_50
            .ignoresSafeArea()
            .onTapGesture {
                showAmountDetail = false
            }
    }
}

#Preview {
    ComboPackages()
}
