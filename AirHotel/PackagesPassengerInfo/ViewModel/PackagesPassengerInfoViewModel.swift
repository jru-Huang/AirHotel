//
//  PackagesPassengerInfoViewModel.swift
//  AirHotel
//
//  Created by 7943 on 2026/8/6.
//

import SwiftUI
import Combine // Combine, ObservableObject

class PackagesPassengerInfoViewModel: ObservableObject {
    
    @Published var lineNotice: PackagesDynamicBundleSystemNoticeModel?
    @Published var systemNotice: PackagesDynamicBundleSystemNoticeModel?
    
    func onViewAppear() {
        setupNotice()
        setupLineNotice()
    }
    
    func presentNoticeInfo(_ noticeInfo: PackagesNoticeDetailInfo) {
//        guard let provider = navigationProvider else { return }
//        
//        let view = PackagesNoticeInfoView(
//            info: noticeInfo,
//            onDismiss: { [weak provider] in
//                provider?.dismiss(animated: false, completion: nil)
//            }
//        )
//        let hostingController = NavigationTitleHostingController(
//            rootView: view,
//            navigationTitle: "",
//            navBarVisibility: .hide,
//            navBarBackgroundColor: UIColor.clear
//        )
//        hostingController.view.backgroundColor = .clear
//        hostingController.modalPresentationStyle = .overFullScreen
//        provider.present(hostingController, animated: false, completion: nil)
    }
}

extension PackagesPassengerInfoViewModel {
    
    // MARK: 公告
    private func setupNotice() {
        lineNotice =  PackagesDynamicBundleSystemNoticeModel(
            config: PackagesDynamicBundleSystemNoticeConfig(
                imageName: "ic_line_20",
                content: "此單【目前符合】LINE POINTS 回饋資格！",
                bgColor: AppColor.Surface.marketGreenSubtle,
                strokeColor: AppColor.Border.marketGreenMid
            ),
            detailInfo: nil
        )
    }
    
    private func setupLineNotice() {
        let content = "春節期間（2/8–2/14），官網與系統皆正常運作，客服服務時間為 09:00–18:00，如有急件需求可透過線上客服聯繫，感謝您的體諒與支持，祝您新春愉快。"
        systemNotice = PackagesDynamicBundleSystemNoticeModel(
            config: PackagesDynamicBundleSystemNoticeConfig(
                imageName: "ic_bell_20",
                content: content,
                bgColor: AppColor.Surface.brandSecondaryExtraSubtle,
                strokeColor: AppColor.Border.brandSecondarySubtle
            ),
            detailInfo: PackagesNoticeDetailInfo(
                navTitle: "系統公告",
                noticeDetailList: [PackagesNoticeDetail(title: "", content: content)]
            )
        )
    }
}
