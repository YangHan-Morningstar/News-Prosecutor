//
//  HotPointView.swift
//  News Prosecutor
//
//  Created by Tony Young on 2020/8/12.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct HotPointView: View {
    
    @State var currentData: NewsData?
    @State var showingDetail = false
    
    var newsData: [NewsData]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("热点推荐")
                    .font(.title)
                    .bold()
                    .padding()
                
                ForEach(newsData) { item in
                    VStack(alignment: .leading) {
                        HStack {
                            WebImage(url: URL(string: item.pic)!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 80, height: 80)
                                .cornerRadius(20)
                                .padding(.leading)
                            
                            Button(action: {
                                self.showingDetail.toggle()
                                self.currentData = item
                            }) {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(item.title)
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundColor(Color("background5"))
                                    
                                    Text(item.time)
                                        .font(.subheadline)
                                        .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                                }
                                .padding(.leading)
                                .padding(.trailing)
                            }
                        }
                        
                        LabelledDivider(label: nil)
                    }

                }
            }
            .frame(maxWidth: UIScreen.main.bounds.size.width)
            .sheet(isPresented: $showingDetail) {
                ZStack {
                    WebURLDetailView(url: self.currentData!.url)
                    
                    VStack {
                        HStack {
                            Spacer()
                            
                            Button(action: { self.showingDetail.toggle() }) {
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

