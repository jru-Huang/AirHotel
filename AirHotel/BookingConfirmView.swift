//
//  BookingConfirmView.swift
//  AirHotel
//
//  Created by 7943 on 2026/5/28.
//

import SwiftUI

struct BookingConfirmView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            Color(.systemGroupedBackground).ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 8) {
                    headerView
                    noticeList
                    bookingContent
                }
                .padding(.horizontal, 12)
                .padding(.bottom, 90)
            }
            
            bottomBar
        }
    }
    
    private var headerView: some View {
        VStack(spacing: 4) {
            Text("台北–東京")
                .font(.headline)
            
            Text("01/24–01/28｜1間房，4大人1小孩")
                .font(.caption2)
                .foregroundStyle(.gray)
        }
        .padding(.vertical, 8)
    }
    
    private var noticeList: some View {
        VStack(spacing: 6) {
            noticeRow(icon: "megaphone", text: "東京從2022年10月徵收住宿稅，微妙標準根據...")
            noticeRow(icon: "sparkles", text: "有他低價提醒您 23:20 – 24:00 進行全銀價格同步...")
            noticeRow(icon: "bell", text: "春節期間（2/8–2/14），官網與系統皆正常運作...")
        }
    }
    
    private func noticeRow(icon: String, text: String) -> some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
                .font(.caption)
                .foregroundStyle(.purple)
            
            Text(text)
                .font(.caption2)
                .foregroundStyle(.black.opacity(0.75))
                .lineLimit(1)
            
            Spacer()
        }
        .padding(8)
        .background(Color.purple.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 6))
    }
    
    private var bookingContent: some View {
        VStack(spacing: 12) {
            titleRow
            
            flightSection
            
            hotelSection
            
            couponSection
            
            pointSection
        }
    }
    
    private var titleRow: some View {
        HStack {
            Text("機加酒精選組合")
                .font(.subheadline.bold())
            
            Spacer()
            
            Button("分享") {}
                .buttonStyle(.bordered)
                .font(.caption)
            
            Button("收藏") {}
                .buttonStyle(.bordered)
                .font(.caption)
        }
        .padding(.vertical, 8)
    }
    
    private var flightSection: some View {
        card {
            VStack(alignment: .leading, spacing: 12) {
                sectionHeader(title: "已選航班", buttonTitle: "更換航班")
                
                flightInfo(
                    tag: "去程",
                    date: "2026年01月24日 週六",
                    start: "12:05",
                    startAirport: "TPE T1",
                    duration: "3小時25分\n直飛",
                    end: "15:30",
                    endAirport: "HND T1"
                )
                
                Divider()
                
                flightInfo(
                    tag: "回程",
                    date: "2026年01月28日 週三",
                    start: "03:05",
                    startAirport: "HND T1",
                    duration: "3小時15分\n直飛",
                    end: "06:20",
                    endAirport: "TPE T1"
                )
                
                HStack {
                    Text("國泰台灣航空｜旅展促銷")
                        .font(.caption2)
                        .foregroundStyle(.orange)
                    Spacer()
                    Text("行李資訊及票規")
                        .font(.caption2)
                        .foregroundStyle(.purple)
                }
            }
        }
    }
    
    private func flightInfo(
        tag: String,
        date: String,
        start: String,
        startAirport: String,
        duration: String,
        end: String,
        endAirport: String
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(tag)
                    .font(.caption2.bold())
                    .foregroundStyle(.white)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 3)
                    .background(Color.purple)
                    .clipShape(RoundedRectangle(cornerRadius: 3))
                
                Text(date)
                    .font(.caption)
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text(start)
                        .font(.headline)
                    Text(startAirport)
                        .font(.caption2)
                        .foregroundStyle(.gray)
                }
                
                Spacer()
                
                VStack {
                    Text(duration)
                        .font(.caption2)
                        .foregroundStyle(.gray)
                        .multilineTextAlignment(.center)
                    
                    Rectangle()
                        .fill(Color.gray.opacity(0.4))
                        .frame(width: 60, height: 1)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text(end)
                        .font(.headline)
                    Text(endAirport)
                        .font(.caption2)
                        .foregroundStyle(.gray)
                }
            }
        }
    }
    
    private var hotelSection: some View {
        card {
            VStack(alignment: .leading, spacing: 10) {
                sectionHeader(title: "已選住宿", buttonTitle: "更換住宿")
                
                Text("您的回程航班為 01/28 03:05 出發，請留意退房日。")
                    .font(.caption)
                    .foregroundStyle(.orange)
                
                Label("入住退房日　01月24日–01月28日（4晚）", systemImage: "bed.double.fill")
                    .font(.caption)
                    .foregroundStyle(.gray)
                
                HStack(alignment: .top, spacing: 10) {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 78, height: 62)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("JR東日本大都會酒店 池袋")
                            .font(.subheadline.bold())
                        
                        Text("HOTEL METROPOLITAN TOKYO IKEBUKUROHOTE...")
                            .font(.caption2)
                            .foregroundStyle(.gray)
                        
                        HStack(spacing: 4) {
                            Text("4.2")
                                .font(.caption2)
                                .foregroundStyle(.white)
                                .padding(.horizontal, 4)
                                .background(Color.purple)
                            Text("★★★★")
                                .font(.caption2)
                                .foregroundStyle(.yellow)
                            Text("4星飯店")
                                .font(.caption2)
                                .foregroundStyle(.gray)
                        }
                    }
                }
                
                Text("標準雙床房，非吸菸房")
                    .font(.caption)
                
                HStack {
                    Text("含早餐或餐點")
                        .font(.caption2)
                        .foregroundStyle(.gray)
                    Spacer()
                    Text("更換房型 〉")
                        .font(.caption)
                }
            }
        }
    }
    
    private var couponSection: some View {
        card {
            HStack {
                Label("優惠代碼", systemImage: "ticket")
                    .font(.subheadline)
                    .foregroundStyle(.purple)
                Spacer()
                Text("選擇或自行輸入 〉")
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
        }
    }
    
    private var pointSection: some View {
        card {
            HStack {
                Label("可樂旅遊幣", systemImage: "c.circle")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                Spacer()
                Text("歡迎參加消費以累積可樂旅遊幣")
                    .font(.caption2)
                    .foregroundStyle(.gray)
            }
        }
    }
    
    private func sectionHeader(title: String, buttonTitle: String) -> some View {
        HStack {
            Text(title)
                .font(.subheadline.bold())
            Spacer()
            Button(buttonTitle) {}
                .font(.caption)
                .foregroundStyle(.purple)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .overlay(
                    Capsule()
                        .stroke(Color.purple, lineWidth: 1)
                )
        }
    }
    
    private func card<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading) {
            content()
        }
        .padding(12)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    private var bottomBar: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text("機＋酒含稅總計")
                    .font(.caption2)
                    .foregroundStyle(.gray)
                Text("$ 86,000")
                    .font(.headline.bold())
                    .foregroundStyle(.orange)
            }
            
            Spacer()
            
            Button("售價明細") {}
                .font(.caption)
                .foregroundStyle(.purple)
            
            Button {
                
            } label: {
                Text("訂購")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(width: 96, height: 54)
                    .background(Color.purple)
            }
        }
        .padding(.leading, 12)
        .background(Color.white)
    }
}

#Preview {
    BookingConfirmView()
}
