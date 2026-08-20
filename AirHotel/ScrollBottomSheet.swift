//
//  ScrollBottomSheet.swift
//  AirHotel
//
//  Created by 7943 on 2026/8/18.
//
import SwiftUI

public extension View {
    
    /* 可跳轉頁面 BottomSheet
       - isPresented：外部控制開關狀態，任何開關皆透過isPresented控制(onAppear設為true，按鈕關閉設為false)
       - sheetHeight：外部計算整個Sheet內容高度(包含scrollView/bottomButton/safeAreaBottomInset)
       - scrollContentMinY：外部偵測Sheet內ScrollView的內容頂端位置
       - isAdjustingSheetHeight：外部偵測是否正在調整Sheet高度，用於禁用scrollView的滾動
     */
    func scrollBottomSheet<SheetContent: View>(
        isPresented: Binding<Bool>,
        sheetHeight: Binding<CGFloat>,
        scrollContentMinY: Binding<CGFloat>,
        isAdjustingSheetHeight: Binding<Bool>,
        style: ScrollBottomSheetStyle = ScrollBottomSheetStyle(),
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> SheetContent
    ) -> some View {
        self.modifier(
            BottomSheetModifier(isPresented: isPresented,
                                sheetHeight: sheetHeight,
                                scrollContentMinY: scrollContentMinY,
                                isAdjustingSheetHeight: isAdjustingSheetHeight,
                                style: style,
                                onDismiss: onDismiss,
                                sheetContent: content)
        )
    }
}

/// ScrollBottomSheet 樣式設定
public struct ScrollBottomSheetStyle {
    
    public var dimmingOpacity: Double = 0.4
    public var sheetBackgroundColor: Color = AppColor.Surface.neutralWhite
    public var cornerRadius: CGFloat = 12
    
    public var presentDuration: TimeInterval = 0.3
    public var dismissDuration: TimeInterval = 0.3
    
    /// Sheet 最大高度（預設為螢幕高度 2/3）
    public var maxHeight: CGFloat = screenHeight * 0.8
    /// 關閉閾值： 拉動超過此距離才視為有關閉意圖
    public var dismissThreshold: CGFloat = 150
    /// 快速甩動閾值： 手勢停留及離開後的預測滑動距離，超過此值表示快速甩動
    public var predictedThreshold: CGFloat = 250
    /// 頂部容忍度： scrollView內容位置在此範圍內視為在頂端
    public var topTolerance: CGFloat = 1.0
    /// 是否允許點擊背景遮罩關閉sheet
    public var tapBackgroundToDismiss: Bool = true
    
    public init() {}
}

private struct BottomSheetModifier<SheetContent: View>: ViewModifier {
    
    @Binding var isPresented: Bool
    @Binding var sheetHeight: CGFloat
    @Binding var scrollContentMinY: CGFloat
    @Binding var isAdjustingSheetHeight: Bool
    
    @State private var isVisible: Bool = false
    @State private var transitToken: Int = 0
    @State private var sheetOffsetY: CGFloat = 0
    @State private var sheetDragStartTranslation: CGFloat? = nil
    
    let style: ScrollBottomSheetStyle
    let onDismiss: (() -> Void)?
    let sheetContent: () -> SheetContent
    
    private var screenHeight: CGFloat { UIScreen.main.bounds.height }
    private var finalSheetHeight: CGFloat {
        min(max(sheetHeight, 0), style.maxHeight)
    }
    private var dimmingAlpha: Double {
        guard isVisible else { return 0 }
        let progress = 1.0 - min(1.0, max(0.0, Double(sheetOffsetY / screenHeight)))
        return style.dimmingOpacity * progress
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if isVisible {
                ZStack(alignment: .bottom) {
                    Color.black
                        .opacity(dimmingAlpha)
                        .allowsHitTesting(style.tapBackgroundToDismiss && dimmingAlpha > 0.01)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            guard style.tapBackgroundToDismiss else { return }
                            isPresented = false
                        }
                    
                    sheetContent()
                        .frame(height: finalSheetHeight, alignment: .bottom)
                        .background(style.sheetBackgroundColor)
                        .setCornerRadius(style.cornerRadius, corners: [.topLeft, .topRight])
                        .offset(y: sheetOffsetY)
                        .simultaneousGesture(dragGesture)
                }
                .ignoresSafeArea()
            }
        }
        .onChange(of: isPresented) { newValue in
            if newValue {
                presentIfNeeded()
            } else {
                dismissAnimated {
                    onDismiss?()
                }
            }
        }
    }
    
    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                //檢查當前是否在頂端且有向下拖動
                let currentMinY = scrollContentMinY
                let isCurrentlyAtTop = currentMinY >= -style.topTolerance
                    
                //translation: 手指滑動的實際移動距離，數值>0代表向下滑動
                let translationY = value.translation.height
                
                //當scrollView在頂端且向下拖動時，調整 sheet 高度
                if isCurrentlyAtTop && translationY > 0 {
                    //如果是第一次到達頂端，記錄此時的 translationY
                    if sheetDragStartTranslation == nil {
                        sheetDragStartTranslation = translationY
                        //通知外部開始調整高度，以便禁用 scrollView 滾動
                        isAdjustingSheetHeight = true
                    }
                    
                    //計算相對於開始調整sheet高度時的變化量（漸進式從0開始）
                    let relativeTranslation = translationY - (sheetDragStartTranslation ?? 0)
                    //限制offset不超過finalSheetHeight（即sheet不會完全消失）
                    sheetOffsetY = min(max(relativeTranslation, 0), finalSheetHeight)
                } else if sheetOffsetY > 0 && translationY <= 0 {
                    //如果之前已經開始調整高度，但現在向上拉，則重置高度
                    sheetOffsetY = 0
                    sheetDragStartTranslation = nil
                    //通知外部停止調整高度，恢復scrollView滾動
                    isAdjustingSheetHeight = false
                }
            }
            .onEnded { (value: DragGesture.Value) in
                let startTranslation = sheetDragStartTranslation
                sheetDragStartTranslation = nil
                isAdjustingSheetHeight = false
                
                //translation: 手指滑動的實際移動距離，數值>0代表向下滑動
                let translationY = value.translation.height
                
                //檢查當前是否在頂端且有向下拖動
                let currentMinY = scrollContentMinY
                let isCurrentlyAtTop = currentMinY >= -style.topTolerance
                
                //只有在當前在頂端，且向下拖動時才處理關閉邏輯
                guard isCurrentlyAtTop && translationY > 0 else {
                    //不滿足條件，重置offset
                    if sheetOffsetY > 0 {
                        withAnimation(.easeOut(duration: 0.2)) {
                            sheetOffsetY = 0
                        }
                    }
                    return
                }
                
                //計算實際調整sheet的位移量（相對於開始調整時的位置）
                let actualDragDistance = startTranslation != nil ? translationY - (startTranslation ?? 0) : translationY
                
                //predictedEndTranslation: 預測停止位置，包含手指滑動距離及手勢放開後預測的滑動距離
                //判斷條件：1. 手指滑動距離超過關閉閾值  2. 預測位置超過快速甩動閾值
                let predictedY = value.predictedEndTranslation.height
                let actualPredictedDistance = startTranslation != nil ? predictedY - (startTranslation ?? 0) : predictedY
                
                if actualDragDistance > style.dismissThreshold || actualPredictedDistance > style.predictedThreshold {
                    //滿足關閉條件，關閉sheet
                    isPresented = false
                } else {
                    //不滿足關閉條件，回彈到原始位置
                    withAnimation(.easeOut(duration: 0.2)) {
                        sheetOffsetY = 0
                    }
                }
            }
    }
    
    private func presentIfNeeded() {
        guard !isVisible else { return }
        transitToken += 1
        
        isVisible = true
        sheetOffsetY = screenHeight
        
        withAnimation(.easeInOut(duration: style.presentDuration)) {
            sheetOffsetY = 0
        }
    }
    
    private func dismissAnimated(completion: (() -> Void)? = nil) {
        guard isVisible else {
            completion?()
            return
        }
        
        transitToken += 1
        let token = transitToken
        
        withAnimation(.easeInOut(duration: style.dismissDuration)) {
            sheetOffsetY = screenHeight
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + style.dismissDuration) {
            guard transitToken == token else { return }
            isVisible = false
            sheetOffsetY = 0
            sheetDragStartTranslation = nil
            completion?()
        }
    }
}

#Preview {
    ScrollBottomSheetPreview()
}

private struct ScrollBottomSheetPreview: View {
    @State private var isPresented = true
    @State private var sheetHeight: CGFloat = 400
    @State private var scrollContentMinY: CGFloat = 0
    @State private var isAdjustingSheetHeight = false

    var body: some View {
        Color.gray
            .scrollBottomSheet(
                isPresented: $isPresented,
                sheetHeight: $sheetHeight,
                scrollContentMinY: $scrollContentMinY,
                isAdjustingSheetHeight: $isAdjustingSheetHeight
            ) {
                Text("Bottom Sheet")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
    }
}
