//
//  TextClassifierManager.swift
//  News Prosecutor
//
//  Created by Tony Young on 2020/7/5.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import SwiftUI
import Combine
import NaturalLanguage

class TextClassifierViewModel: ObservableObject {
    var textModel: FakeNewsClassifier
    var englishTextModel: EnglishFakeNewsTextClassifier
    
    var result: String?
    var languageCategory: String?
    let newsCategroy = [
        "1": "假新闻",
        "0": "真新闻",
        "Fake": "假新闻",
        "True": "真新闻"
    ]
    
    init() {
        textModel = FakeNewsClassifier()
        englishTextModel = EnglishFakeNewsTextClassifier()
    }
    
    func classify(_ textContent: String) -> String? {
        if textContent != "" {
            getLanguageCategory(textContent)
            
            if languageCategory == "en" {
                guard let predictionResult = try? self.englishTextModel.prediction(text: textContent) else {
                    fatalError("Predicting errors!")
                }
                
                if let prediction = self.newsCategroy[predictionResult.label] {
                    result = prediction
                }
            } else {
                guard let predictionResult = try? self.textModel.prediction(text: textContent) else {
                    fatalError("Predicting errors!")
                }
                
                if let prediction = self.newsCategroy[predictionResult.label] {
                    result = prediction
                }
            }
        }
        
        return result
    }
    
    func getLanguageCategory(_ textContent: String) {
        let recognizer = NLLanguageRecognizer()
        
        recognizer.processString(textContent)
        
        if let lang = recognizer.dominantLanguage {
            languageCategory = lang.rawValue
        }
    }
}
