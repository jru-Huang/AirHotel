//
//  HomeAdImageViewSwiftUIView.swift
//  AirHotel
//
//  Created by 7943 on 2026/6/26.
//

import SwiftUI

struct HomeAdImageViewSwiftUIView: View {
    
    var url: String?
    var width: CGFloat?
    var height: CGFloat?
    var cornerRadius: CGFloat?
    
    var body: some View {
        
        AsyncImage(url: URL(string: url ?? "")) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width, height: height)
                    .cornerRadius(cornerRadius ?? 0)
                    .clipped()
            default:
                AppColor.Surface.neutralMid
                    .frame(width: width, height: height)
                    .cornerRadius(cornerRadius ?? 0)
                    .overlay(
                        Image("colalogo_gray")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(
                                width: min(52, width ?? 52),
                                height: min(42, height ?? 42)
                            )
                    )
            }
        }
    }
}

#Preview {
    HomeAdImageViewSwiftUIView()
}
