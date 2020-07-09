//
//  DetectRingView.swift
//  News Prosecutor
//
//  Created by Tony Young on 2020/7/9.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import SwiftUI

struct DetectRingView: View {
    
    var color1 = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
    var color2 = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
    var method: Method
    @State var percent: CGFloat = 0
    
    var body: some View {
        HStack(spacing: 12) {
            RingView(color1: color1, color2: color2, width: 44, height: 44, methodName: method.title, show: .constant(true), percent: percent)
            
            VStack(alignment: .leading, spacing: 4.0) {
                Text(method.title)
                    .bold()
                    .modifier(FontModifier(style: .subheadline))
                
                Text("历史记录中真假新闻百分比")
                    .modifier(FontModifier(style: .caption))
            }
            .modifier(FontModifier())
        }
        .padding(8)
        .background(Color("background3"))
        .cornerRadius(20)
        .modifier(ShadowModifier())
    }
}
