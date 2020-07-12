//
//  DetectRingView.swift
//  News Prosecutor
//
//  Created by Tony Young on 2020/7/9.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import SwiftUI

struct DetectRingView: View {
    
    @Binding var showDetectRing: Bool
    
    @ObservedObject var methodVM = MethodViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("下述是你在过去检测功能的使用中，文本新闻和图片新闻中各自真假新闻的百分比，有助于你提前了解你新闻获取渠道的真实性。")
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .font(.subheadline)
                .padding(.top, 30)
                .padding(.horizontal, 30)
            
            VStack {
                DetectRingDetail(color1: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), color2: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), method: methodVM.methodData[0], showDetectRing: $showDetectRing)
                    .padding(.top, 30)
                    .padding(.bottom, 30)
                
                DetectRingDetail(color1: #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1), color2: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), method: methodVM.methodData[1], showDetectRing: $showDetectRing)
            }
            
            Spacer()
        }
        .cornerRadius(30)
        .shadow(radius: 20)
    }
}



struct DetectRingDetail: View {
    var color1 = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
    var color2 = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
    var method: Method
    
    @State var percent: CGFloat = 0
    @Binding var showDetectRing: Bool
    
    @ObservedObject var detectResultDetailVM = DetectResultDetailViewModel()
    
    var body: some View {
        HStack(spacing: 20) {
            RingView(color1: color1, color2: color2, width: 88, height: 88, methodName: method.title, show: $showDetectRing, percent: percent)
                .animation(Animation.easeInOut.delay(0.3))
                .onAppear() {
                    if self.method.title == "文本新闻检测" {
                        self.percent = self.detectResultDetailVM.getTextPercentage()
                    } else if self.method.title == "图片新闻检测" {
                        self.percent = self.detectResultDetailVM.getImagePercentage()
                    }
                }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(method.title)
                    .fontWeight(.bold)
                
                Text("真实新闻所占比")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .lineSpacing(4)
            }
            .padding(20)
            .background(Color("background3"))
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 10)
        }
    }
}
