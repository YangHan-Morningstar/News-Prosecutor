//
//  QuestionManager.swift
//  News Prosecutor
//
//  Created by Tony Young on 2020/7/6.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import Foundation

class QuestionManager: Identifiable, ObservableObject {
    @Published var questionData = [Question]()
    @Published var score: Int
    @Published var sum: Int
    @Published var counter: Int
    
    init() {
        questionData = []
        score = 0
        sum = 6
        counter = 0
        
        getQuestions()
    }
    
    func getQuestions() {
        
        var newQuestion: Question
        
        for i in 0..<sum {
            if i <= sum / 2 - 1 {
                let textQuestion = textQuestions[Int.random(in: 0..<textQuestions.count)]
                newQuestion = Question(text: textQuestion[0], answer: textQuestion[1])
            } else {
                let imageQuestion = imageQuestions[Int.random(in: 0..<imageQuestions.count)]
                newQuestion = Question(image: imageQuestion[0], answer: imageQuestion[1], ifImage: true)
            }

            questionData.append(newQuestion)
        }
    }
    
    func count(ifTrue: Bool) {
        if ifTrue {
           score += 1
        }
        counter += 1
    }
    
    func getScore() -> String {
        return String(format: "%.2f", Float(score) * 100 / Float(sum))
    }
}
