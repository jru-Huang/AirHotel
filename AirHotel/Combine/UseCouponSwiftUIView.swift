//
//  UseCouponSwiftUIView.swift
//  AirHotel
//
//  Created by 7943 on 2026/7/20.
//

import SwiftUI

struct UseCouponSwiftUIView: View {
    
    @State private var couponCode: String = ""
    
    var useCoupon: ((String)->Void)?
    
    var body: some View {
        VStack(spacing: 0) {
            inputView
            noticeView
            
            ScrollView {
                availableCouponCountsView
                    .padding(.top, 12)
                LazyVStack(spacing: 8) {
                    ForEach(0...3, id: \.self) { _ in
                        couponCard
                    }
                }
                .padding(.bottom, 12)
            }
            .background(AppColor.Surface.neutralExtraSubtle)
        }
    }
    
    private var inputView: some View {
        
        HStack(spacing: 8) {
            Image("ic_edit_16")
                .padding(.leading, 12)
            
            TextField("",
                      text: $couponCode,
                      prompt: couponPrompt)
            .font(AppTypography.B03R)
            .foregroundStyle(AppColor.Text.neutralBodyBase)
            .tint(AppColor.Text.brandPrimaryDark)
            .padding(.vertical, 5)
            
            if !couponCode.isEmpty {
                Button {
                    couponCode = ""
                } label: {
                    Image("ic_delete_16")
                }
            }
        }
        .padding(.trailing, 76 + 8)
        .frame(height: 30)
        .background(AppColor.Surface.neutralExtraSubtle, in: RoundedRectangle(cornerRadius: 24))
        .overlay {
            RoundedRectangle(cornerRadius: 24)
                .stroke(AppColor.Border.neutralSubtle, lineWidth: 1)
        }
        .overlay(alignment: .bottomTrailing, content: {
            Button {
                useCoupon?(couponCode)
            } label: {
                Text("使用")
                    .font(AppTypography.L02M)
                    .foregroundStyle(AppColor.Text.neutralWhite)
                    .frame(width: 76)
                    .frame(maxHeight: .infinity)
            }
            .background(couponCode.isEmpty ? AppColor.Surface.stateDisabled : AppColor.Surface.brandPrimaryMid, in: RoundedRectangle(cornerRadius: 24))
        })
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(AppColor.Surface.neutralWhite)
    }
    
    private var couponPrompt: Text {
        if #available(iOS 17.0, *) {
            return Text("輸入優惠代碼")
                .foregroundStyle(AppColor.Text.neutralCaption)
        } else {
            return Text("輸入優惠代碼")
                .foregroundColor(AppColor.Text.neutralCaption)
        }
    }
    
    private var noticeView: some View {
        Text("每組優惠代碼皆有適用條件，使用前請詳閱活動網頁說明。\n僅適用官網或APP發行的優惠代碼，實體禮券請撥打禮券上的聯絡電話，由專人為您服務。")
            .font(AppTypography.B05R)
            .foregroundStyle(AppColor.Text.neutralBodyMid)
            .multilineTextAlignment(.leading)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity)
            .background(AppColor.Surface.neutralSubtle)
        
    }
    
    private var availableCouponCountsView: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 2) {
                Text("目前有")
                    .font(AppTypography.B05R)
                    .foregroundStyle(AppColor.Text.neutralBodyMid)
                Text("(3)")
                    .font(AppTypography.B05R)
                    .foregroundStyle(AppColor.Text.brandPrimaryBase)
                Text("組可使用的優惠代碼")
                    .font(AppTypography.B05R)
                    .foregroundStyle(AppColor.Text.neutralBodyMid)
            }
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(AppColor.Surface.neutralExtraSubtle)
    }
    
    private var couponCard: some View {
        Button {
            
        } label: {
            HStack(spacing: 7) {
                VStack(spacing: 12) {
                    couponDetail
                    couponRule
                }
                Image("radio_btn_02_on")
            }
            .padding(16)
        }
        .overlay(alignment: .leading) {
            Rectangle()
                .fill(AppColor.Border.brandPrimarySubtle)
                .frame(width: 4, alignment: .leading)
            
        }
        .background(AppColor.Surface.neutralWhite)
        .clipShape(RoundedRectangle(cornerRadius: 2))
        .padding(.horizontal, 16)
    }
    
    private var couponDetail: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("App限定")
                .font(AppTypography.T05M)
                .foregroundStyle(AppColor.Text.neutralWhite)
                .padding(.vertical, 2)
                .padding(.horizontal, 6)
                .background(AppColor.Surface.marketOrangeDark, in: RoundedRectangle(cornerRadius: 4))
            
            Text("總折抵金額1,000元")
                .font(AppTypography.T01M)
                .foregroundStyle(AppColor.Text.marketOrangeDark)
            
            Text("刷彰化銀行無限卡/無限卡/商旅御璽卡．國外短線團體行程折2000元")
                .font(AppTypography.T03M)
                .foregroundStyle(AppColor.Text.neutralBodyBase)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
            
            Text("2026/08/01 23:59 前下單使用")
                .font(AppTypography.N06R)
                .foregroundStyle(AppColor.Text.neutralBodyMid)
        }
    }
    
    private var couponRule: some View {
        HStack(spacing: 8) {
            Button {
                
            } label: {
                
                HStack(spacing: 0) {
                    Image("ic_info_14")
                    Text("使用規則")
                        .font(AppTypography.L03R)
                        .foregroundStyle(AppColor.Text.neutralBodyMid)
                }
            }
            
            Text("限用一次")
                .font(AppTypography.T06R)
                .foregroundStyle(AppColor.Text.brandPrimaryBase)
                .padding(.vertical, 2)
                .padding(.horizontal, 4)
                .overlay {
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(AppColor.Border.brandPrimarySubtle, lineWidth: 1)
                }
            Spacer()
        }
    }
}


struct CouponView: View {
    @State private var couponCode = ""
    @State private var selectedId: UUID?
    
    let coupons: [Coupon] = Coupon.mock
    
    var body: some View {
        VStack(spacing: 0) {
            navView
            
            inputView
            
            noticeView
            
            availableCouponView
            
            ScrollView {
                LazyVStack(spacing: 8) {
                    ForEach(coupons) { coupon in
                        CouponCard(
                            coupon: coupon,
                            isSelected: selectedId == coupon.id
                        ) {
                            selectedId = coupon.id
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
            }
            
            confirmButton
        }
        .background(Color(.systemGroupedBackground))
    }
}

private extension CouponView {
    
    var navView: some View {
        ZStack {
            Text("使用優惠代碼")
                .font(.headline)
            
            HStack {
                Button {
                    
                } label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(.purple)
                }
                
                Spacer()
                
                Button("使用說明") {
                    
                }
                .font(.footnote)
                .foregroundStyle(.purple)
            }
            .padding(.horizontal, 16)
        }
        .frame(height: 44)
        .background(.white)
    }
}

private extension CouponView {
    
    var inputView: some View {
        HStack(spacing: 8) {
            
            TextField("輸入優惠代碼", text: $couponCode)
                .padding(.horizontal, 12)
                .frame(height: 36)
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 18))
            
            Button("使用") {
                
            }
            .frame(width: 72, height: 36)
            .background(Color(.systemGray5))
            .foregroundStyle(.white)
            .clipShape(Capsule())
        }
        .padding(16)
        .background(.white)
    }
}

private extension CouponView {
    
    var noticeView: some View {
        VStack(alignment: .leading, spacing: 4) {
            
            Text("• 每組優惠代碼皆有適用條件，使用前請詳閱活動網頁說明。")
            Text("• 僅適用官網或APP發行的優惠代碼，實體禮券請撥打客服上的聯絡電話，由專人為您服務。")
            
        }
        .font(.footnote)
        .foregroundStyle(.secondary)
        .padding(.horizontal, 16)
        .padding(.bottom, 12)
        .background(.white)
    }
}

private extension CouponView {
    
    var availableCouponView: some View {
        HStack {
            Text("目前有")
            Text("3")
                .foregroundStyle(.orange)
            Text("組可使用的優惠代碼")
            
            Spacer()
        }
        .font(.footnote)
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
    }
}

struct CouponCard: View {
    
    let coupon: Coupon
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        
        Button(action: onTap) {
            
            HStack(alignment: .top, spacing: 12) {
                
                VStack(alignment: .leading, spacing: 6) {
                    
                    if coupon.isAppOnly {
                        
                        Text("App限定")
                            .font(.caption2)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(.orange)
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                    }
                    
                    Text(coupon.title)
                        .font(.headline)
                        .foregroundStyle(.orange)
                    
                    Text(coupon.content)
                        .font(.subheadline)
                        .foregroundStyle(.primary)
                    
                    Text(coupon.expireDate)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    HStack {
                        
                        Image(systemName: "info.circle")
                        
                        Text("使用規則")
                        
                        Text(coupon.rule)
                            .foregroundStyle(.purple)
                        
                        Spacer()
                    }
                    .font(.caption)
                    .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .font(.title3)
                    .foregroundStyle(isSelected ? .blue : .gray)
            }
            .padding(16)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .buttonStyle(.plain)
    }
}

private extension CouponView {
    
    var confirmButton: some View {
        
        Button {
            
        } label: {
            Text("確定")
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .background(Color.blue)
        }
        .buttonStyle(.plain)
    }
}

struct Coupon: Identifiable {
    
    let id = UUID()
    
    let isAppOnly: Bool
    let title: String
    let content: String
    let expireDate: String
    let rule: String
}

extension Coupon {
    
    static let mock: [Coupon] = [
        .init(
            isAppOnly: true,
            title: "總折抵金額1,000元",
            content: "刷彰化銀行無限卡 / 商旅御璽卡，國外短線團體行程折2000元",
            expireDate: "2026/08/01 23:59 前下單使用",
            rule: "限用一次"
        ),
        .init(
            isAppOnly: false,
            title: "總折抵金額1,000元",
            content: "刷彰化銀行無限卡 / 商旅御璽卡，國外短線團體行程折2000元",
            expireDate: "2026/08/01 23:59 前下單使用",
            rule: "可重複使用"
        ),
        .init(
            isAppOnly: false,
            title: "總折抵金額1,000元",
            content: "刷彰化銀行無限卡 / 商旅御璽卡，國外短線團體行程折2000元",
            expireDate: "2026/08/01 23:59 前下單使用",
            rule: "限用一次"
        )
    ]
}

#Preview {
    CouponView()
}

#Preview {
    UseCouponSwiftUIView()
}
