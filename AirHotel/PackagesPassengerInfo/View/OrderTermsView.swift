//
//  OrderTermsView.swift
//  AirHotel
//
//  Created by 7943 on 2026/8/11.
//

import SwiftUI

struct OrderTermsView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding var hasReadOrderTerms: Bool
    
    @State private var hasScrolledToBottom = false
    
    var body: some View {
        VStack(spacing: 0) {
            
            GeometryReader { scrollGeometry in
                ScrollViewReader { proxy in
                    ScrollView {
                        Text("一、會員服務內容\n1. 本網站上公佈的價格，包含套裝行程、飯店、與平假日的價格。不同出發日價格依天數、日期、人數、房型而不同，在網頁上看到的價格，為行程參考價，在確認付款網頁中的價格，才為實際售價，請在付款前仔細查看。對於旅客自行與飯店或交通公司達成的協議，與未包含於行程中的消費，本網站恕不負責。\n2. 本套裝商品售價：機票部分價格皆已包含機場稅費及燃油附加費；訂房部分則已含服務費及當地常規的消費稅，但不包含部分城市政府或酒店可能於不特定期間徵收非常規的特別稅等費用，例如城市稅(City tax)、渡假村及設施使用費(Resort fee)、中國政府調節基金、日本溫泉稅‧‧‧等。此外，床頭小費、行李小費、客房服務費、旅客自行與航空公司達成的協議或其他私人消費支出，應由旅客自行負責。\n3. 機位及訂房價格時有變動，訂購流程中，如有發生異動，頁面會跳出告示視窗，您可選擇接受新價格或重新搜尋，最終價格依訂購頁面最新資訊為準。二、會員服務內容\n• 本商品僅適用線上付款，恕不受理其他付款方式及分開付款。\n• 已選擇商品並填寫訂購資料後，送出訂單資料之前，請您詳細檢查『航班資訊』、『票價資訊和行李規定』以及『飯店資訊』，確認符合需求再作訂購。\n• 確認訂購後，您須即時於線上刷卡付款，易遊網將以您所提供的信用卡帳戶進行授權（銀行會有信用卡授權記錄），授權成功即進行機位及飯店預訂作業；倘若機位及飯店預訂失敗，易遊網將經由銀行辦理解除授權(約3~7個工作天，實際天數視各發卡行而定)。\n• 機位和飯店預訂成功後，將於您的信用卡帳戶直接收取已授權的金額，並發送付款成功確認函到您的E-Mail信箱。\n•  訂購成功確認後，易遊網將開立機票行程單及住宿券，並寄送到您的E-Mail信箱。\n•  完成訂購後，若因非旅客個人因素之不可抗力事件（如颱風、火山爆發等）或突發狀況（如機械故障、回航延誤）而導致班機取消或嚴重延誤，請旅客於第一時間告知易遊網，並盡速提供相關證明文件，以利易遊網為您爭取訂單取消免罰（但仍需以航空公司及飯店回覆為準）。若為非台灣上班時間，請即撥打住宿券上之緊急聯絡電話請求協助。遇狀況時，請務必即時採取以上行動，以免因NoShow而無法爭取退費。\n 附註： 開票完成後，您可返回會員中心享用易遊網的線上選位功能。但仍有部分航空公司並未提供免費預先選位服務，遇無法選位或選位失敗時，建議您於出發日前24至48小時內到航空公司官網預辦線上報到劃位。")
                            .font(AppTypography.B04R)
                            .foregroundStyle(AppColor.Text.neutralBodyBase)
                        
                        
                        Color.clear
                            .frame(height: 40)
                            .background {
                                GeometryReader { bottomGeometry in
                                    Color.clear.preference(
                                        key: OrderTermsBottomPreferenceKey.self,
                                        value: bottomGeometry.frame(in: .named("orderTermsScroll")).maxY)
                                }
                            }
                            .id("orderTermsBottom")
                    }
                    .padding(.horizontal, 20)
                    .coordinateSpace(name: "orderTermsScroll")
                    .onPreferenceChange(OrderTermsBottomPreferenceKey.self, perform: { bottomPosition in
                        if bottomPosition <= scrollGeometry.size.height {
                            hasScrolledToBottom = true
                        }
                    })
                    .overlay(alignment: .bottom) {
                        if !hasScrolledToBottom {
                            scrollInstructionHint {
                                withAnimation {
                                    proxy.scrollTo("orderTermsBottom", anchor: .bottom)
                                }
                            }
                            .padding(.bottom , 12)
                        }
                    }
                }
            }
            
            actionButtons
        }
        .padding(.top, 16)
        .padding(.bottom, 40)
        .background(AppColor.Background.pageWhite)
    }
    
    private func scrollInstructionHint(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            HStack(spacing: 4) {
                Image("ic_down_20")
                Text("請滑動至最下方詳閱內容")
                    .font(AppTypography.L02M)
                    .foregroundStyle(AppColor.Text.neutralWhite)
            }
            .padding(.vertical, 10)
            .padding(.trailing, 28)
            .padding(.leading, 24)
            .background(AppColor.Surface.brandSecondaryBase, in: Capsule())
        }
    }
    
    private var actionButtons: some View {
        HStack(spacing: 8) {
            Button {
                hasReadOrderTerms = false
                dismiss()
            } label: {
                Text("不同意")
                    .font(AppTypography.L02M)
                    .foregroundStyle(AppColor.Text.brandPrimaryMid)
                    .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity, minHeight: 40)
            .background(AppColor.Surface.neutralWhite)
            .overlay {
                RoundedRectangle(cornerRadius: 4)
                    .strokeBorder(AppColor.Text.brandPrimaryDark, lineWidth: 1)
            }
            
            Button {
                hasReadOrderTerms = true
                dismiss()
            } label: {
                Text("同意")
                    .font(AppTypography.L02M)
                    .foregroundStyle(AppColor.Text.neutralWhite)
                    .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity, minHeight: 40)
            .background(hasScrolledToBottom ? AppColor.Text.brandPrimaryDark : AppColor.Surface.stateDisabled)
            .disabled(!hasScrolledToBottom)
            
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 6)
        .background(AppColor.Surface.neutralWhite)
        
    }
}

private struct OrderTermsBottomPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .greatestFiniteMagnitude
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

#Preview {
    OrderTermsView(hasReadOrderTerms: .constant(false))
}
