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
    @Binding var showingDetail: Bool
    
    var counter = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                ZStack {
                    Text(questionManager.questionData[questionManager.counter].text)
                        .font(.system(size: 20, weight: .bold))
                        .padding(.top, 30)
                        .offset(y: questionManager.questionData[questionManager.counter].ifImage ? screen.height : 0)
                    
                    Image(questionManager.questionData[questionManager.counter].image)
                        .resizable()
                        .cornerRadius(30)
                        .padding()
                        .frame(height: 260)
                        .offset(y: questionManager.questionData[questionManager.counter].ifImage ? 0 : screen.height)
                }
                
                AnswerButton(answer: "真新闻", showingAlert: $showingAlert).environmentObject(questionManager)
                
                AnswerButton(answer: "假新闻", showingAlert: $showingAlert).environmentObject(questionManager)
                
            }
            .padding(.top, 30)
            .padding(.horizontal, 30)
        }
        .alert(isPresented: $showingAlert) {
            
            return Alert(title: Text("测试结果"), message: Text("您本次答对了\(questionManager.getScore())%的题哦"), dismissButton: .default(Text("完成"), action: {self.showingDetail.toggle()}))
        }
    }
}
