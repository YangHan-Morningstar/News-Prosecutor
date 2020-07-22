//
//  Tips.swift
//  News Prosecutor
//
//  Created by Tony Young on 2020/7/5.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import SwiftUI
import Vision

struct Tips: View {
    
    @State private var image: UIImage?
    @Binding var showDetail: Bool
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    Text("什么是虚假新闻？")
                        .font(.title).bold()
                    
                    Image(uiImage: image ?? UIImage(named: "FakeNews")!)
                        .resizable()
                        .cornerRadius(30)
                        .frame(height: 275)
                    
                    Text("虚假新闻是指为了达到某一目的而采用发布假信息达到欺骗当事者的一种舆论，未能真实反映客观事物本来面貌，带有虚假成分的报道，虚假新闻的发布需要承担民事法律责任、行政和刑事法律责任。")
                    
                    Text("如何辨别虚假新闻？")
                        .font(.title).bold()
                    
                    Text("虚假新闻的形式分为文本和图片两种，每种形式的辨别策略不同。")
                    
                    Image(uiImage: image ?? UIImage(named: "textTip")!)
                        .resizable()
                        .cornerRadius(30)
                        .frame(height: 275)
                    
                    Text("对于文本新闻，造谣者往往使用更为夸张的语气、数据等对新闻进行捏造，同时对上下文进行语义扭曲，加入自己的主观想法等等。在辨别一条文本新闻的真假时，我们可以通过字里行间的逻辑关系是否成立、语气是否过于夸张等进行辨别。")
                    
                    Image(uiImage: image ?? UIImage(named: "imageTip")!)
                        .resizable()
                        .cornerRadius(30)
                        .frame(height: 275)
                    
                    Text("对于图片新闻，造谣者最常用的手段就是使用PS对图片进行恶意修改，我们则可以对根据图片中的内容之间的逻辑关系是否成立、内容是否有PS的痕迹等方式进行辨别。")
                }
                .padding(30)
            }
            
            HStack() {
                Spacer()
                
                Button(action: {self.showDetail.toggle()}) {
                    Image(systemName: "xmark")
                        .foregroundColor(Color("background5"))
                        .font(.system(size: 16, weight: .medium))
                        .frame(width: 36, height: 36)
                        .background(BlurView(style: .systemMaterial))
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                }
            }
            .padding(30)
        }
    }
}

struct Tips_Previews: PreviewProvider {
    static var previews: some View {
        Tips(showDetail: .constant(true))
    }
}
