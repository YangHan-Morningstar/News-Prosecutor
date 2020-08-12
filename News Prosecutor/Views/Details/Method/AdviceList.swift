//
//  AdviceList.swift
//  News Prosecutor
//
//  Created by Tony Young on 2020/8/10.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import SwiftUI

struct AdviceList: View {
    
    @State var currentPost: NewsData?
    @State var showWebDetail = false
    
    var adviceData: Advice = Advice(list: [])
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("相关辟谣数据")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                ForEach(adviceData.list) { newsDatas in
                    VStack(alignment: .leading) {
                        HStack {
                            Text("辟谣")
                                .frame(width: 40, height: 40)
                                .background(Color.blue)
                                .clipShape(Circle())
                                .padding(.leading)
                            
                            Button(action: {
                                self.showWebDetail.toggle()
                                self.currentPost = newsDatas
                            }) {
                                Text(newsDatas.title)
                                    .foregroundColor(Color("background5"))
                                    .padding(.leading)
                                    .padding(.trailing)
                            }
                        }
                        
                        LabelledDivider(label: newsDatas.time)
                    }
                }
            }
            .frame(maxWidth: screen.size.width)
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
}

struct AdviceList_Previews: PreviewProvider {
    static var previews: some View {
        AdviceList()
    }
}
