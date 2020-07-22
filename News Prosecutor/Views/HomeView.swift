//
//  HomeView.swift
//  News Prosecutor
//
//  Created by Tony Young on 2020/7/5.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @State var showDetectRingView = false
    
    @ObservedObject var methodDataManager = MethodViewModel()
    @ObservedObject var learningDataManager = LearningViewModel()
        
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("新闻真实性检测")
                        .font(.title)
                        .bold()
                    
                    Spacer()
                    
                    Button(action: { self.showDetectRingView.toggle() }) {
                        Image(systemName: "clock")
                            .foregroundColor(Color("background5"))
                            .font(.system(size: 26, weight: .medium))
                            .frame(width: 26, height: 26)
                            .background(BlurView(style: .systemMaterial))
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                    }
                    .sheet(isPresented: $showDetectRingView) {
                        DetectRingView(showDetectRing: self.$showDetectRingView)
                            .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
                    }
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
