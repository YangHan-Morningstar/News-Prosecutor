//
//  AnswerButton.swift
//  News Prosecutor
//
//  Created by Tony Young on 2020/7/6.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import SwiftUI

struct AnswerButton: View {
    
    var answer: String
    
    @EnvironmentObject var questionManager: QuestionViewModel
    @Binding var showingAlert: Bool
    @Binding var isAnswerRight: Bool
    @Binding var showingLottieAnimation: Bool
    
    var body: some View {
        Button(answer) {
            if self.questionManager.questionData[self.questionManager.counter].answer == self.answer {
                self.isAnswerRight = true
                
                self.questionManager.count(ifTrue: true)
                
                self.showingLottieAnimation.toggle()
                
            } else {
                self.isAnswerRight = false
                
                self.questionManager.count(ifTrue: false)
                
                self.showingLottieAnimation.toggle()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.showingLottieAnimation.toggle()
                
                if self.questionManager.counter == self.questionManager.sum {
                    self.showingAlert.toggle()
                }
            }
        }
        .frame(width: 200, height: 50)
        .foregroundColor(.white)
        .font(.headline)
        .background(Color.blue)
        .cornerRadius(10)
    }
}
