//
//  DiscountDemo.swift
//  AirHotel
//
//  Created by 7943 on 2026/6/2.
//

import SwiftUI

//struct DiscountDemoView: View {
//    var body: some View {
//        ZStack {
//            Color.gray.opacity(0.45).ignoresSafeArea()
//            
//            ScrollView {
//                VStack(spacing: 12) {
//                    sectionTitle("登入")
//                    
//                    HStack(spacing: 22) {
//                        tabButton("可樂旅遊幣", isSelected: true)
//                        tabButton("優惠代碼", isSelected: false)
//                    }
//                    
//                    discountCard(
//                        couponValue: "選擇或自行輸入",
//                        pointText: "歡迎多加消費以累積可樂旅遊幣！"
//                    )
//                    
//                    discountCard(
//                        couponValue: "選擇或自行輸入",
//                        pointText: "可樂旅遊幣不足，剩餘 2 枚\n折抵訂單金額須 10 枚以上"
//                    )
//                    
//                    discountCard(
//                        couponValue: "選擇或自行輸入",
//                        pointError: "您所使用的優惠代碼折扣，可樂旅遊幣無法同時使用折抵，請擇一使用"
//                    )
//                    
//                    activePointCard
//                    
//                    usedPointCard
//                }
//                .padding()
//            }
//        }
//    }
//    
//    private func sectionTitle(_ title: String) -> some View {
//        Text(title)
//            .font(.system(size: 16, weight: .medium))
//            .frame(maxWidth: .infinity)
//            .padding(.vertical, 8)
//            .background(Color.green.opacity(0.12))
//            .overlay(
//                Rectangle()
//                    .stroke(Color.green, lineWidth: 1)
//            )
//    }
//    
//    private func tabButton(_ title: String, isSelected: Bool) -> some View {
//        Text(title)
//            .font(.system(size: 15, weight: .bold))
//            .foregroundStyle(.white)
//            .frame(maxWidth: .infinity)
//            .padding(.vertical, 8)
//            .background(Color.gray.opacity(0.75))
//            .clipShape(RoundedRectangle(cornerRadius: 3))
//    }
//    
//    private func discountCard(
//        couponValue: String,
//        pointText: String? = nil,
//        pointError: String? = nil
//    ) -> some View {
//        VStack(spacing: 0) {
//            row(
//                icon: "percent",
//                title: "優惠代碼",
//                trailing: couponValue,
//                trailingColor: .gray,
//                showArrow: true
//            )
//            
//            Divider()
//            
//            HStack(alignment: .top, spacing: 8) {
//                Image(systemName: "c.circle")
//                    .foregroundStyle(.purple)
//                
//                Text("可樂旅遊幣")
//                    .font(.system(size: 14, weight: .medium))
//                    .foregroundStyle(.gray)
//                
//                Spacer()
//                
//                if let pointText {
//                    Text(pointText)
//                        .font(.system(size: 12))
//                        .foregroundStyle(.gray)
//                        .multilineTextAlignment(.trailing)
//                }
//            }
//            .padding(12)
//            
//            if let pointError {
//                Text(pointError)
//                    .font(.system(size: 12))
//                    .foregroundStyle(.red)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(.leading, 44)
//                    .padding(.trailing, 12)
//                    .padding(.bottom, 12)
//            }
//        }
//        .background(Color.white, in: RoundedRectangle(cornerRadius: 8))
//    }
//    
//    private var activePointCard: some View {
//        VStack(spacing: 0) {
//            row(
//                icon: "percent",
//                title: "優惠代碼",
//                trailing: "選擇或自行輸入",
//                trailingColor: .gray,
//                showArrow: true
//            )
//            
//            Divider()
//            
//            VStack(alignment: .leading, spacing: 8) {
//                HStack {
//                    Image(systemName: "c.circle")
//                        .foregroundStyle(.purple)
//                    
//                    Text("可樂旅遊幣")
//                        .font(.system(size: 14, weight: .medium))
//                    
//                    Spacer()
//                    
//                    Text("餘額")
//                        .font(.system(size: 12))
//                        .foregroundStyle(.gray)
//                    
//                    Text("600")
//                        .font(.system(size: 14))
//                        .foregroundStyle(.purple)
//                    
//                    Text("枚")
//                        .font(.system(size: 12))
//                        .foregroundStyle(.gray)
//                }
//                
//                TextField("請輸入欲使用的數量", text: .constant(""))
//                    .font(.system(size: 13))
//                    .padding(.horizontal, 12)
//                    .padding(.vertical, 10)
//                    .background(Color.gray.opacity(0.08), in: RoundedRectangle(cornerRadius: 4))
//                    .padding(.leading, 28)
//                
//                Text("每 10 枚可折抵訂單金額 $2")
//                    .font(.system(size: 12))
//                    .foregroundStyle(.gray)
//                    .padding(.leading, 28)
//            }
//            .padding(12)
//        }
//        .background(Color.white, in: RoundedRectangle(cornerRadius: 8))
//        .overlay(
//            RoundedRectangle(cornerRadius: 8)
//                .stroke(Color.purple, lineWidth: 2)
//        )
//    }
//    
//    private var usedPointCard: some View {
//        VStack(spacing: 0) {
//            row(
//                icon: "percent",
//                title: "優惠代碼",
//                trailing: "選擇或自行輸入",
//                trailingColor: .gray,
//                showArrow: true
//            )
//            
//            Divider()
//            
//            VStack(alignment: .leading, spacing: 8) {
//                HStack {
//                    Image(systemName: "c.circle")
//                        .foregroundStyle(.purple)
//                    
//                    Text("可樂旅遊幣")
//                        .font(.system(size: 14, weight: .medium))
//                    
//                    Spacer()
//                    
//                    Text("餘額600枚")
//                        .font(.system(size: 12))
//                }
//                
//                HStack {
//                    Text("使用5,000枚，均分於所有旅客")
//                        .font(.system(size: 12))
//                    
//                    Spacer()
//                    
//                    Image(systemName: "xmark.circle.fill")
//                        .foregroundStyle(.gray.opacity(0.4))
//                }
//                .padding(.horizontal, 12)
//                .padding(.vertical, 10)
//                .background(Color.gray.opacity(0.08), in: RoundedRectangle(cornerRadius: 4))
//                .padding(.leading, 28)
//                
//                HStack {
//                    Text("每 10 枚可折抵訂單金額 $2")
//                        .font(.system(size: 12))
//                        .foregroundStyle(.gray)
//                    
//                    Spacer()
//                    
//                    discountAmountText
//                }
//                .padding(.leading, 28)
//            }
//            .padding(12)
//        }
//        .background(Color.white, in: RoundedRectangle(cornerRadius: 8))
//    }
//    
//    private func row(
//        icon: String,
//        title: String,
//        trailing: String,
//        trailingColor: Color,
//        showArrow: Bool
//    ) -> some View {
//        HStack(spacing: 8) {
//            Image(systemName: icon)
//                .foregroundStyle(.purple)
//            
//            Text(title)
//                .font(.system(size: 14, weight: .medium))
//            
//            Spacer()
//            
//            Text(trailing)
//                .font(.system(size: 12))
//                .foregroundStyle(trailingColor)
//                .lineLimit(1)
//            
//            if showArrow {
//                Image(systemName: "chevron.right")
//                    .font(.system(size: 12))
//                    .foregroundStyle(.gray)
//            }
//        }
//        .padding(12)
//    }
//    
//    private var discountAmountText: some View {
//        HStack(spacing: 0) {
//            Text("可折抵 ")
//                .font(.system(size: 12))
//                .foregroundStyle(.gray)
//            
//            Text("$1000")
//                .font(.system(size: 12))
//                .foregroundStyle(.orange)
//            
//            Text(" 元")
//                .font(.system(size: 12))
//                .foregroundStyle(.gray)
//        }
//    }
//}

import SwiftUI

struct ComboPackagesDemo: View {
    @State private var showPriceDetail = false
    
    var body: some View {
        ZStack {
            Color.backgroundPagePurple_F8F8F8
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("這裡放你的主要內容")
                Spacer()
            }
            
            if showPriceDetail {
                Color.black.opacity(0.45)
                    .ignoresSafeArea()
                    .onTapGesture {
                        showPriceDetail = false
                    }
            }
        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            VStack(spacing: 0) {
                if showPriceDetail {
                    priceDetailView
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
                
                priceBottomView
            }
            .animation(.easeInOut(duration: 0.25), value: showPriceDetail)
        }
    }
    
    private var priceBottomView: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text("機＋酒含稅總計")
                    .font(.system(size: 10))
                    .foregroundStyle(.gray)
                
                HStack(spacing: 4) {
                    Text("$")
                        .font(.system(size: 12))
                    Text("83,880")
                        .font(.system(size: 18, weight: .semibold))
                }
                .foregroundStyle(.orange)
            }
            .padding(.leading, 14)
            
            Spacer()
            
            Button {
                showPriceDetail.toggle()
            } label: {
                HStack(spacing: 4) {
                    Text("售價明細")
                        .font(.system(size: 12))
                    Image(systemName: showPriceDetail ? "chevron.down.circle" : "chevron.up.circle")
                }
                .foregroundStyle(.purple)
            }
            .buttonStyle(.plain)
            .padding(.trailing, 14)
            
            Button {
                print("點擊訂購")
            } label: {
                Text("訂購")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.white)
                    .frame(width: 108, height: 47)
                    .background(.purple)
            }
            .buttonStyle(.plain)
        }
        .frame(height: 47)
        .background(.white)
        .overlay(alignment: .top) {
            Rectangle()
                .fill(.black.opacity(0.1))
                .frame(height: 1)
        }
    }
    
    private var priceDetailView: some View {
        VStack(spacing: 0) {
            HStack {
                Button {
                    showPriceDetail = false
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.purple)
                }
                
                Spacer()
                
                Text("售價明細")
                    .font(.system(size: 16, weight: .semibold))
                
                Spacer()
                
                Color.clear
                    .frame(width: 24, height: 24)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            
            VStack(spacing: 12) {
                priceRow(title: "大人 $17,200 x4", amount: "$68,800")
                priceRow(title: "小孩 $17,200 x1", amount: "$17,200")
                
                discountRow(
                    icon: "dollarsign.circle.fill",
                    title: "優惠代碼折扣",
                    subtitle: "晚鳥滿額折扣800元",
                    amount: "-$2,000",
                    background: .orange.opacity(0.08),
                    color: .orange
                )
                
                discountRow(
                    icon: "c.circle.fill",
                    title: "可樂旅遊幣折抵",
                    subtitle: "均分於所有旅客",
                    amount: "-$120",
                    background: .purple.opacity(0.08),
                    color: .purple
                )
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding(.horizontal, 16)
        .padding(.bottom, 0)
    }
    
    private func priceRow(title: String, amount: String) -> some View {
        HStack {
            Text(title)
                .font(.system(size: 13))
                .foregroundStyle(.gray)
            
            Spacer()
            
            Text(amount)
                .font(.system(size: 13))
                .foregroundStyle(.black.opacity(0.75))
        }
    }
    
    private func discountRow(
        icon: String,
        title: String,
        subtitle: String,
        amount: String,
        background: Color,
        color: Color
    ) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: icon)
                .foregroundStyle(color)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(color)
                
                Text(subtitle)
                    .font(.system(size: 12))
                    .foregroundStyle(.gray)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 2) {
                Text("總額折扣")
                    .font(.system(size: 10))
                    .foregroundStyle(.gray)
                
                Text(amount)
                    .font(.system(size: 13))
                    .foregroundStyle(.orange)
            }
        }
        .padding(10)
        .background(background, in: RoundedRectangle(cornerRadius: 4))
    }
}

#Preview {
//    DiscountDemoView()
    ComboPackagesDemo()
}
