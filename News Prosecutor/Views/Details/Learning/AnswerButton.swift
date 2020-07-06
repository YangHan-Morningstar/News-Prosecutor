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
    
    @EnvironmentObject var questionManager: QuestionManager
    @Binding var showingAlert: Bool
    
    var body: some View {
        Button(answer) {
            if self.questionManager.questionData[self.questionManager.counter].answer == self.answer {
                if self.questionManager.counter + 1 == self.questionManager.sum {
                    self.showingAlert.toggle()
                } else {
                    self.questionManager.count(ifTrue: true)
                }
            } else {
                if self.questionManager.counter + 1 == self.questionManager.sum {
                    self.showingAlert.toggle()
                } else {
                    self.questionManager.count(ifTrue: false)
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
