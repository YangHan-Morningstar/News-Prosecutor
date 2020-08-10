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
                    }
                    .padding(.top)
                    .padding(.leading)
                    
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
