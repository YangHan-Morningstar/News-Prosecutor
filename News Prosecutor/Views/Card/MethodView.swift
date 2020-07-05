//
//  MethodView.swift
//  News Prosecutor
//
//  Created by Tony Young on 2020/7/5.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import SwiftUI

struct MethodView: View {
    var method: Method
    var width: CGFloat = 275
    var height: CGFloat = 275
    
    @State var showDetail = false
    
    var body: some View {
        ZStack(alignment: .top) {
            method.image
                .resizable()
                .frame(width: width, height: height)
            
            VStack(alignment: .leading) {
                Text(method.title)
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 160, alignment: .leading)
                    .padding(.bottom, 10)
                    .foregroundColor(.white)
                
                Spacer()
                                    
                Text(method.text)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            .padding(.top)
            .offset(y: -20)
        }
        .frame(width: width, height: height)
        .cornerRadius(30)
        .onTapGesture {
            self.showDetail.toggle()
        }
        .sheet(isPresented: $showDetail) {
            if self.method.title == "文本新闻检测" {
                TextMethod()
            } else if self.method.title == "图片新闻检测" {
                ImageMethod()
            }
        }
    }
}

struct MethodView_Previews: PreviewProvider {
    static var previews: some View {
        MethodView(method: Method(title: "文本新闻检测", text: "输入新闻标题或者内容", image: Image("文本搜索")))
    }
}
