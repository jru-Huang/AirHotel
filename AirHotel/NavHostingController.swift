import SwiftUI

struct NavigationBarButtonConfiguration {
    let image: UIImage?
    let title: String?
    let tintColor: UIColor?
    let action: (() -> Void)?

    init(image: UIImage? = nil,
         title: String? = nil,
         tintColor: UIColor? = nil,
         action: (() -> Void)? = nil) {
        self.image = image
        self.title = title
        self.tintColor = tintColor
        self.action = action
    }
}

/// 共用的 UIHostingController 包裝，確保 SwiftUI 畫面在 UIKit 導覽中維持標題與返回樣式
final class NavigationTitleHostingController<Content: View>: UIHostingController<Content> {

    enum Visibility {
        case inherit
        case show
        case hide
    }

    enum LeftBarButtonStyle {
        case custom(NavigationBarButtonConfiguration)
        case back(action: (() -> Void)? = nil)
        case close(action: (() -> Void)? = nil)
    }

    enum RightBarButtonStyle {
        case none
        case custom(NavigationBarButtonConfiguration)
        case favorite(action: (() -> Void)? = nil)
    }

    private let navigationTitle: String
    private let hidesBackTitle: Bool
    private let navBarVisibility: Visibility
    private let tabBarVisibility: Visibility
    private let navBarTintColor: UIColor?
    private let navBarBackgroundColor: UIColor?
    private let showsNavBarShadow: Bool
    private let leftBarButtonStyle: LeftBarButtonStyle
    private let rightBarButtonStyle: RightBarButtonStyle
    private var leftBarButtonHandler: NavigationBarButtonHandler?
    private var rightBarButtonHandler: NavigationBarButtonHandler?
    private let firebaseScreenName: String?
    private let firebaseScreenClass: String?

    init(rootView: Content,
         navigationTitle: String,
         hidesBackTitle: Bool = true,
         navBarVisibility: Visibility = .inherit,
         tabBarVisibility: Visibility = .inherit,
         navBarTintColor: UIColor? = UIColor.purple,//.Primary_Primary_84329B,
         navBarBackgroundColor: UIColor? = .white,
         showsNavBarShadow: Bool = true,
         leftBarButtonStyle: LeftBarButtonStyle = .back(),
         rightBarButtonStyle: RightBarButtonStyle = .none,
         firebaseScreenName: String? = nil,
         firebaseScreenClass: String? = nil) {
        self.navigationTitle = navigationTitle
        self.hidesBackTitle = hidesBackTitle
        self.navBarVisibility = navBarVisibility
        self.tabBarVisibility = tabBarVisibility
        self.navBarTintColor = navBarTintColor
        self.navBarBackgroundColor = navBarBackgroundColor
        self.showsNavBarShadow = showsNavBarShadow
        self.leftBarButtonStyle = leftBarButtonStyle
        self.rightBarButtonStyle = rightBarButtonStyle
        self.firebaseScreenName = firebaseScreenName
        self.firebaseScreenClass = firebaseScreenClass
        super.init(rootView: rootView)
        applyNavigationConfiguration()
    }

    @available(*, unavailable)
    required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyNavigationConfiguration()
        applyNavBarVisibilityIfNeeded()
        applyTabBarVisibilityIfNeeded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let firebaseScreenName, !firebaseScreenName.isEmpty else { return }
        
//        FirebaseAnalyticsManager.setScreen(
//            name: firebaseScreenName,
//            screenClass: firebaseScreenClass ?? navigationTitle
//        )
    }

    private func applyNavigationConfiguration() {
        navigationItem.title = navigationTitle
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.backButtonDisplayMode = .minimal
        applyNavBarAppearanceIfNeeded()
        applyLeftBarButtonIfNeeded()
        applyRightBarButtonIfNeeded()
    }
    
    private func applyNavBarVisibilityIfNeeded() {
        switch navBarVisibility {
        case .inherit:
            break
        case .show:
            navigationController?.setNavigationBarHidden(false, animated: false)
        case .hide:
            navigationController?.setNavigationBarHidden(true, animated: false)
        }
    }
    
    private func applyTabBarVisibilityIfNeeded() {
        guard let tabBar = tabBarController?.tabBar else { return }
        
        switch tabBarVisibility {
        case .inherit:
            break
        case .show:
            tabBar.isHidden = false
        case .hide:
            tabBar.isHidden = true
        }
    }

    private func applyNavBarAppearanceIfNeeded() {
        guard let navigationBar = navigationController?.navigationBar else { return }

        if let navBarTintColor {
            navigationBar.tintColor = navBarTintColor
        }

        guard let navBarBackgroundColor else { return }

        let titleColor = UIColor.purple//Primary_Primary_84329B
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = navBarBackgroundColor
        appearance.titleTextAttributes = [.foregroundColor: titleColor]
        appearance.largeTitleTextAttributes = [.foregroundColor: titleColor]
        appearance.shadowColor = .clear

        navigationBar.barStyle = .default
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        if #available(iOS 15.0, *) {
            navigationBar.compactScrollEdgeAppearance = appearance
        }
        if showsNavBarShadow {
            navigationBar.setShadow(offset: CGSize(width: 0, height: 1), opacity: 0.2, shadowRadius: 2)
        } else {
            navigationBar.setShadow(offset: CGSize(width: 0, height: 0), opacity: 0.0, shadowRadius: 0)
        }
    }

    private func applyLeftBarButtonIfNeeded() {
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.hidesBackButton = true
        navigationItem.leftItemsSupplementBackButton = false

        guard let leftBarButtonConfiguration = adjustLeftBarButtonConfiguration() else {
            navigationItem.leftBarButtonItem = nil
            navigationItem.leftBarButtonItems = []
            leftBarButtonHandler = nil
            return
        }

        let handler = NavigationBarButtonHandler(action: leftBarButtonConfiguration.action)
        leftBarButtonHandler = handler

        let barButtonItem: UIBarButtonItem
        if let image = leftBarButtonConfiguration.image {
            barButtonItem = UIBarButtonItem(image: image, style: .plain, target: handler, action: #selector(NavigationBarButtonHandler.handleTap))
        } else {
            barButtonItem = UIBarButtonItem(title: leftBarButtonConfiguration.title, style: .plain, target: handler, action: #selector(NavigationBarButtonHandler.handleTap))
        }

        if let tintColor = leftBarButtonConfiguration.tintColor {
            barButtonItem.tintColor = tintColor
        }

        navigationItem.backBarButtonItem = nil
        navigationItem.leftBarButtonItems = [barButtonItem]
        navigationItem.leftBarButtonItem = barButtonItem
        if #available(iOS 26.0, *) {
            navigationItem.leftBarButtonItem?.hidesSharedBackground = true
        }
    }

    private func applyRightBarButtonIfNeeded() {
        guard let rightBarButtonConfiguration = adjustRightBarButtonConfiguration() else {
            navigationItem.rightBarButtonItem = nil
            rightBarButtonHandler = nil
            return
        }

        let handler = NavigationBarButtonHandler(action: rightBarButtonConfiguration.action)
        rightBarButtonHandler = handler

        let barButtonItem: UIBarButtonItem
        if let image = rightBarButtonConfiguration.image {
            barButtonItem = UIBarButtonItem(image: image, style: .plain, target: handler, action: #selector(NavigationBarButtonHandler.handleTap))
        } else {
            barButtonItem = UIBarButtonItem(title: rightBarButtonConfiguration.title, style: .plain, target: handler, action: #selector(NavigationBarButtonHandler.handleTap))
        }

        if let tintColor = rightBarButtonConfiguration.tintColor {
            barButtonItem.tintColor = tintColor
        }

        navigationItem.rightBarButtonItem = barButtonItem
        if #available(iOS 26.0, *) {
            navigationItem.rightBarButtonItem?.hidesSharedBackground = true
        }
    }

    private func adjustLeftBarButtonConfiguration() -> NavigationBarButtonConfiguration? {
        switch leftBarButtonStyle {
        case .custom(let configuration):
            return configuration
        case .back(let action):
            return NavigationBarButtonConfiguration(
                image: UIImage(named: "arrow_back_purple_small"),
                tintColor: UIColor.purple,//.Primary_Primary_84329B,
                action: action ?? { [weak navigationController] in
                    navigationController?.popViewController(animated: true)
                }
            )
        case .close(let action):
            return NavigationBarButtonConfiguration(
                image: UIImage(named: "close"),
                tintColor: UIColor.purple,//.Primary_Primary_84329B,
                action: action ?? { [weak self] in
                    self?.dismiss(animated: true)
                }
            )
        }
    }

    private func adjustRightBarButtonConfiguration() -> NavigationBarButtonConfiguration? {
        switch rightBarButtonStyle {
        case .none:
            return nil
        case .custom(let configuration):
            return configuration
        case .favorite(let action):
            return NavigationBarButtonConfiguration(
                image: UIImage(named: "favorite_list"),
                tintColor: UIColor.purple,//.Primary_Primary_84329B,
                action: action
            )
        }
    }
}

private final class NavigationBarButtonHandler: NSObject {
    private let action: (() -> Void)?

    init(action: (() -> Void)?) {
        self.action = action
    }

    @objc func handleTap() {
        action?()
    }
}

extension UIView {
    func setShadow(offset:CGSize,opacity:Float,shadowRadius:CGFloat) {
        self.layer.masksToBounds = false
        self.clipsToBounds = false
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
