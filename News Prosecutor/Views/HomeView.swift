//
//  HomeView.swift
//  News Prosecutor
//
//  Created by Tony Young on 2020/7/5.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var methodDataManager = MethodDataManager()
    @ObservedObject var learningDataManager = LearningDataManager()
        
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("新闻真实性检测")
                        .font(.title)
                        .bold()
                    
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top)
                .padding(.leading, 14)
                                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(methodDataManager.methodData) { item in
                            GeometryReader { geometry in
                                MethodView(method: item)
                                    .rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX - 30) / -20), axis: (x: 0, y: 10.0, z: 0))
                            }
                            .frame(width: 275, height: 275)
                        }
                    }
                    .padding(30)
                }
                .offset(y: -30)
                
                HStack {
                    Text("练习专区")
                        .font(.title)
                        .bold()

                    Spacer()
                }
                .padding(.leading, 30)
                .offset(y: -50)
                
                VStack {
                    ForEach(learningDataManager.learningData) { item in
                        LearningView(learning: item, width: screen.width - 60, height: 275 )
                            .offset(y: -40)
                            .padding()
                    }
                }
                                
                Spacer()

            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

let screen = UIScreen.main.bounds
