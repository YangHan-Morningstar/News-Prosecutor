//
//  WebURLView.swift
//  News Prosecutor
//
//  Created by Tony Young on 2020/7/25.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import SwiftUI

struct WebURLView: View {
    
    var posts = [
        NewsData(url: "https://www.google.com"),
        NewsData(url: "https://www.apple.com.cn"),
        NewsData(url: "https://edition.cnn.com/2020/07/18/europe/black-forest-rambo-grm-intl-scli/index.html"),
        NewsData(url: "http://www.piyao.org.cn/2019-07/08/c_1210185213.htm"),
        NewsData(url: "http://www.piyao.org.cn/2019-08/06/c_1210231086.htm"),
        NewsData(url: "http://www.piyao.org.cn/2020-05/12/c_1210615383.htm"),
        NewsData(url: "http://www.piyao.org.cn/2020-05/22/c_1210629071.htm"),
        NewsData(url: "http://49.233.24.205/index.html"),
        NewsData(url: "http://www.piyao.org.cn/2020-05/22/c_1210629071.htm"),
        NewsData(url: "http://www.piyao.org.cn/2020-05/22/c_1210629071.htm"),
        NewsData(url: "http://www.piyao.org.cn/2020-05/22/c_1210629071.htm"),
        NewsData(url: "http://www.piyao.org.cn/2020-05/22/c_1210629071.htm"),
        NewsData(url: "http://www.piyao.org.cn/2020-05/22/c_1210629071.htm"),
        NewsData(url: "http://www.piyao.org.cn/2020-05/22/c_1210629071.htm"),
        NewsData(url: "http://www.piyao.org.cn/2020-05/22/c_1210629071.htm"),
        NewsData(url: "http://www.piyao.org.cn/2020-05/22/c_1210629071.htm"),
        NewsData(url: "http://www.piyao.org.cn/2020-05/22/c_1210629071.htm"),
        NewsData(url: "http://www.piyao.org.cn/2020-05/22/c_1210629071.htm"),
        NewsData(url: "http://www.piyao.org.cn/2020-05/22/c_1210629071.htm"),
        NewsData(url: "http://www.piyao.org.cn/2020-05/22/c_1210629071.htm"),
        NewsData(url: "http://www.piyao.org.cn/2020-05/22/c_1210629071.htm"),
        NewsData(url: "http://www.piyao.org.cn/2020-05/22/c_1210629071.htm"),
        NewsData(url: "http://www.piyao.org.cn/2020-05/22/c_1210629071.htm"),
        NewsData(url: "http://www.piyao.org.cn/2020-05/22/c_1210629071.htm"),
        NewsData(url: "http://www.piyao.org.cn/2020-05/22/c_1210629071.htm"),
        NewsData(url: "http://www.piyao.org.cn/2020-05/22/c_1210629071.htm"),
        NewsData(url: "http://www.piyao.org.cn/2020-05/22/c_1210629071.htm"),
        NewsData(url: "http://www.piyao.org.cn/2020-05/22/c_1210629071.htm"),
        NewsData(url: "http://www.piyao.org.cn/2020-05/22/c_1210629071.htm"),
        NewsData(url: "http://www.piyao.org.cn/2020-05/22/c_1210629071.htm"),
        NewsData(url: "http://www.piyao.org.cn/2020-05/22/c_1210629071.htm"),
        NewsData(url: "http://www.piyao.org.cn/2020-05/22/c_1210629071.htm"),
        NewsData(url: "http://www.piyao.org.cn/2020-05/22/c_1210629071.htm"),
        NewsData(url: "http://www.piyao.org.cn/2020-05/22/c_1210629071.htm"),
        NewsData(url: "http://www.piyao.org.cn/2020-05/22/c_1210629071.htm")
    ]
    
    @State var currentPost: NewsData?
    
    @State var showWebDetail = false
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            ForEach(posts) { post in
                Button(action: {
                    self.showWebDetail.toggle()
                    self.currentPost = post
                }) {
                    VStack {
                        Text(post.url)
                            .foregroundColor(Color("background5"))
                        // LabelledDivider(label: "or")
                    }
                }
            }
        }
        .frame(maxWidth: screen.size.width)
        .background(Color("background1"))
        .sheet(isPresented: $showWebDetail) {
            ZStack {
                WebURLDetailView(url: self.currentPost!.url)
                
                VStack {
                    HStack {
                        Spacer()
                        
                        Button(action: { self.showWebDetail.toggle() }) {
                            Image(systemName: "xmark")
                                .padding()
                                .background(BlurView(style: .systemMaterial))
                                .clipShape(Circle())
                        }
                    }
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}

struct WebURLView_Previews: PreviewProvider {
    static var previews: some View {
        WebURLView(currentPost: NewsData(url: "https://www.google.com"))
    }
}

import Foundation

struct NewsData: Identifiable {
    var id = UUID()
    var url: String
}
