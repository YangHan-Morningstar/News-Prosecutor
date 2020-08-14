//
//  HotPointSortView.swift
//  News Prosecutor
//
//  Created by Tony Young on 2020/8/14.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import SwiftUI

struct HotPointSortView: View {
    
    @State var index = 0
    @State var currentData: NewsData?
    @State var showWebDetail = false
    
    @ObservedObject var hotPointVM = HotPointDataViewModel()
    
    var body: some View {
        ScrollView {
            VStack() {
                HStack {
                    Text("热点排行")
                        .font(.title)
                        .bold()
                        .padding()
                    
                    Spacer()
                }
                
                HStack {
                    Button(action: {
                        self.index = 0
                        self.hotPointVM.hotPointData = Advice(list: [])
                        self.hotPointVM.getData(url: "http://81.70.41.11:8888/getInfo?search=zhou")
                    }) {
                        Text("周")
                            .padding(.vertical, 12)
                            .frame(width: (UIScreen.main.bounds.size.width / 3 - 10))
                            .background(self.index == 0 ? Color.secondary : Color.black.opacity(0.25))
                    }
                    
                    Button(action: {
                        self.index = 1
                        self.hotPointVM.hotPointData = Advice(list: [])
                        self.hotPointVM.getData(url: "http://81.70.41.11:8888/getInfo?search=yue")
                    }) {
                        Text("月")
                            .padding(.vertical, 12)
                            .frame(width: (UIScreen.main.bounds.size.width / 3 - 10))
                            .background(self.index == 1 ? Color.secondary : Color.black.opacity(0.25))
                    }
                    
                    Button(action: {
                        self.index = 2
                        self.hotPointVM.hotPointData = Advice(list: [])
                        self.hotPointVM.getData(url: "http://81.70.41.11:8888/getInfo?search=ji")
                    }) {
                        Text("季")
                            .padding(.vertical, 12)
                            .frame(width: (UIScreen.main.bounds.size.width / 3 - 10))
                            .background(self.index == 2 ? Color.secondary : Color.black.opacity(0.25))
                    }
                }
                .background(Color.black.opacity(0.5))
                .clipShape(Capsule())
                .padding()
                
                if !hotPointVM.hotPointData.list.isEmpty {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(self.hotPointVM.hotPointData.list) { newsData in
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("\(newsData.id)")
                                        .frame(width: 40, height: 40)
                                        .background(Color.blue)
                                        .clipShape(Circle())
                                    
                                    Button(action: {
                                        self.showWebDetail.toggle()
                                        self.currentData = newsData
                                    }) {
                                        Text(newsData.title)
                                            .foregroundColor(Color("background5"))
                                            .padding(.leading)
                                            .padding(.trailing)
                                    }
                                }
                                
                                LabelledDivider(label: newsData.time)
                            }
                        }
                    }
                    .padding(.leading, 20)
                    .sheet(isPresented: $showWebDetail) {
                        ZStack {
                            WebURLDetailView(url: self.currentData!.url)
                            
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
                } else {
                    LottieView(filename: "26944-loading-animation")
                        .frame(width: 200, height: 200)
                        .offset(y: 50)
                }
            }
        }
        .onAppear() {
            self.hotPointVM.getData(url: "http://81.70.41.11:8888/getInfo?search=zhou")
        }
    }
}
