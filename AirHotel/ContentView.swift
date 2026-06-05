//
//  ContentView.swift
//  AirHotel
//
//  Created by 7943 on 2026/5/4.
//

import UIKit
import UserNotifications
import SwiftUI

/// 抽象化 UIKit 導覽相關的協議，提供共用的導航能力

//protocol NavigationProvider: AnyObject {
//    var navigationController: UINavigationController? { get }
//    var isNeedToPopVCWhenLoginClose: Bool { get set }
//
//    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
//    func dismiss(animated flag: Bool, completion: (() -> Void)?)
//
//    /// 登入成功時的回呼，讓外部可追蹤狀態
//    func onLoginSuccess()
//    /// 統一處理 API 錯誤的介面
////    func onApiErrorHandle(apiError: APIError, handleType: APIErrorHandleType)
//    /// 顯示文字提示或 Toast
//    func toast(text: String)
//}

//final class AppNavigationProvider: NavigationProvider {
//    weak var navigationController: UINavigationController?
//    var isNeedToPopVCWhenLoginClose = false
//
//    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
//        navigationController?.present(viewControllerToPresent, animated: flag, completion: completion)
//    }
//
//    func dismiss(animated flag: Bool, completion: (() -> Void)?) {
//        navigationController?.dismiss(animated: flag, completion: completion)
//    }
//
//    func onLoginSuccess() { }
//
//    func toast(text: String) {
//        print(text)
//    }
//}

//struct RootNavigationContainer: UIViewControllerRepresentable {
//    func makeUIViewController(context: Context) -> UINavigationController {
//        let provider = AppNavigationProvider()
//        let rootView = ContentView(provider: provider)
//        let rootHostingController = UIHostingController(rootView: rootView)
//        let navigationController = UINavigationController(rootViewController: rootHostingController)
//
//        provider.navigationController = navigationController
//        return navigationController
//    }
//
//    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) { }
//}

struct ContentView: View {
//    let provider: NavigationProvider

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("機加酒") {
//                    SearchView()
//                    BookingConfirmView()
                    ComboPackages()
                }
            }
        }
//        Button("組合頁") {
//            let hostingController = NavigationTitleHostingController(
//                rootView: BookingConfirmView(),
//                navigationTitle: "組合頁面",
//                navBarVisibility: .show,
//                tabBarVisibility: .hide,
//                rightBarButtonStyle: .favorite(action: {
//                    print("DEBUG: 收藏按鈕被按下")
//                })
//            )
//            hostingController.hidesBottomBarWhenPushed = true
//            provider.navigationController?.pushViewController(hostingController, animated: true)
//        }
    }
}

//#Preview {
//    ContentView(provider: AppNavigationProvider())
//}
