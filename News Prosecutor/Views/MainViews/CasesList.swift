//
//  CasesList.swift
//  News Prosecutor
//
//  Created by Tony Young on 2020/7/25.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import SwiftUI

struct CasesList: View {
    
    @State var data = [
        CasesCard(image: "政治", expand: false),
        CasesCard(image: "科学", expand: false),
        CasesCard(image: "文化", expand: false),
        CasesCard(image: "社会", expand: false),
        CasesCard(image: "健康", expand: false),
        CasesCard(image: "食品", expand: false)
    ]
    
    @State var hero = false
    @State var showingHotPointRecommand = false
    @State var showingHotPointSort = false
    
    @ObservedObject var hotPointVM = HotPointDataViewModel()
    
    var body: some View {
        VStack{
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    HStack{
                        VStack(alignment: .leading, spacing: 12) {
                            Text("官方辟谣数据")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                        
                        Spacer()
                        
                        Button(action: { self.showingHotPointSort.toggle() }) {
                            Image(systemName: "chart.pie")
                                .foregroundColor(Color("background5"))
                                .font(.system(size: 26, weight: .medium))
                                .frame(width: 26, height: 26)
                                .background(BlurView(style: .systemMaterial))
                                .clipShape(Circle())
                                .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                        }
                        .padding(.trailing, 5)
                        .sheet(isPresented: $showingHotPointSort) {
                            ZStack {
                                HotPointSortView()
                                
                                VStack {
                                    HStack {
                                        Spacer()
                                        
                                        Button(action: { self.showingHotPointSort.toggle() }) {
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
                        
                        Button(action: {
                            self.hotPointVM.getData(url: "http://81.70.41.11:8888/hot")
                            self.showingHotPointRecommand.toggle()
                        }) {
                            Image(systemName: "pin.circle")
                                .foregroundColor(Color("background5"))
                                .font(.system(size: 26, weight: .medium))
                                .frame(width: 26, height: 26)
                                .background(BlurView(style: .systemMaterial))
                                .clipShape(Circle())
                                .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                        }
                        .sheet(isPresented: $showingHotPointRecommand) {
                            ZStack {
                                HotPointRecommandView(newsData: self.hotPointVM.hotPointData.list)
                                
                                VStack {
                                    HStack {
                                        Spacer()
                                        
                                        Button(action: { self.showingHotPointRecommand.toggle() }) {
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
                    .padding(.horizontal)
                    .padding(.top)
                    
                    VStack(spacing: 15) {
                        
                        ForEach(0..<self.data.count) {i in
                            
                            GeometryReader {g in
                                
                                CasesTitles(data: self.$data[i], hero: self.$hero, caseName: self.$data[i].image)
                                    .offset(y: self.data[i].expand ? -g.frame(in: .global).minY : 0)
                                    .opacity(self.hero ? (self.data[i].expand ? 1 : 0) : 1)
                                    .onTapGesture {
                                        
                                        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0)) {
                                            
                                            if !self.data[i].expand {
                                                self.hero.toggle()
                                                self.data[i].expand.toggle()
                                            }
                                        }
                                        
                                }
                                
                            }
                            .frame(height: self.data[i].expand ? UIScreen.main.bounds.height : 300)
                        }
                    }
                }
                
            }
            .statusBar(hidden: hero ? true : false)
        }
    }
}

struct CasesCard : Identifiable {
    var id = UUID()
    var image : String
    var expand : Bool
}
