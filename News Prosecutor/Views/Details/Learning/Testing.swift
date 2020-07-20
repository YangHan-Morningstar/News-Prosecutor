//
//  Testing.swift
//  News Prosecutor
//
//  Created by Tony Young on 2020/7/6.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import SwiftUI

struct Testing: View {
    
    @EnvironmentObject var questionManager: QuestionViewModel
    @State private var image: UIImage?
    @State private var showingAlert = false
    @State var isAnswerRight = true
    @State var showingLottieAnimation = false
    @Binding var showingDetail: Bool
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack(spacing: 30) {
                    ZStack {
                        Text(questionManager.questionData[questionManager.counter < questionManager.sum ? questionManager.counter : questionManager.sum - 1].text)
                            .font(.system(size: 20, weight: .bold))
                            .padding(.top, 30)
                            .offset(y: questionManager.questionData[questionManager.counter < questionManager.sum ? questionManager.counter : questionManager.sum - 1].ifImage ? screen.height : 0)
                        
                        Image(questionManager.questionData[questionManager.counter < questionManager.sum ? questionManager.counter : questionManager.sum - 1].image)
                            .resizable()
                            .cornerRadius(30)
                            .padding()
                            .frame(height: 260)
                            .offset(y: questionManager.questionData[questionManager.counter < questionManager.sum ? questionManager.counter : questionManager.sum - 1].ifImage ? 0 : screen.height)
                    }
                    
                    AnswerButton(answer: "真新闻", showingAlert: $showingAlert, isAnswerRight: $isAnswerRight, showingLottieAnimation: $showingLottieAnimation).environmentObject(questionManager)
                    
                    AnswerButton(answer: "假新闻", showingAlert: $showingAlert, isAnswerRight: $isAnswerRight, showingLottieAnimation: $showingLottieAnimation).environmentObject(questionManager)
                    
                    CustomProgressView(percent: CGFloat(questionManager.counter) / CGFloat(questionManager.sum), width: questionManager.calPercent())
                    
                }
                .padding(.top, 30)
                .padding(.horizontal, 30)
                
                if showingLottieAnimation {
                    if isAnswerRight {
                        LottieView(filename: "433-checked-done")
                            .frame(width: 200, height: 200)
                    } else {
                        LottieView(filename: "14651-error-animation")
                            .frame(width: 200, height: 200)
                    }
                }
            }
        }
        .alert(isPresented: $showingAlert) {
            return Alert(title: Text("测试结果"), message: Text("您本次答对了\(questionManager.getScore())%的题哦"), dismissButton: .default(Text("完成"), action: {self.showingDetail.toggle()}))
        }
    }
}
