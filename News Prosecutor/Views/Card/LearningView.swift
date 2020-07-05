//
//  LearningView.swift
//  News Prosecutor
//
//  Created by Tony Young on 2020/7/5.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import SwiftUI

struct LearningView: View {
    var learning: Learning
    var width: CGFloat = 275
    var height: CGFloat = 275
    
    @State var showDetail = false
    
    var body: some View {
        VStack() {
            HStack(alignment: .top) {
                Text(learning.title)
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 160, alignment: .leading)
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding(.bottom, 15)
            
            HStack {
                Text(learning.text)
                    .frame(maxWidth: 200, alignment: .leading)
                
                Spacer()
            }
            
            learning.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 210)
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: width, height: height)
        .background(learning.color)
        .cornerRadius(30)
        .shadow(color: learning.color.opacity(0.3), radius: 20, x: 0, y: 20)
        .onTapGesture {
            self.showDetail.toggle()
        }
//        .sheet(isPresented: $showDetail) {
//            if self.learning.title == "如何判断新闻真假？" {
//                Tips()
//            } else if self.learning.title == "实战一下" {
//                Testing(showingDetail: self.$showDetail).environmentObject(QuestionJudge())
//            }
//        }
    }
}

struct LearningView_Previews: PreviewProvider {
    static var previews: some View {
        LearningView(learning: Learning(title: "如何判断新闻真假？", text: "从文本与图片两个维度\n进行考虑", image: Image("learning2"), color: Color("card1")))
    }
}
