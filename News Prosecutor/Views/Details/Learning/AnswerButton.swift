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
        .padding(12)
        .padding(.horizontal, 30)
        .foregroundColor(.white)
        .background(Color(#colorLiteral(red: 0, green: 0.7529411765, blue: 1, alpha: 1)))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color(#colorLiteral(red: 0, green: 0.7529411765, blue: 1, alpha: 1)).opacity(0.2), radius: 20, x: 0, y: 20)
    }
}
