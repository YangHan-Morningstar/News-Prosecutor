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
    var chineseTextModel: FakeNewsClassifier
    var englishTextModel: EnglishFakeNewsTextClassifier
    var textCategoryClassifierModel: NewsCategoryClassifier
    
    var session: URLSession
    var url: String
    
    var result: String?
    var languageCategory: String?
    let newsDetectResultDict = [
        "Fake": "假新闻",
        "True": "真新闻",
        "true": "真新闻",
        "fake": "假新闻"
    ]
    @Published var adviceData: Advice = Advice(list: [])
    
    init() {
        chineseTextModel = FakeNewsClassifier()
        englishTextModel = EnglishFakeNewsTextClassifier()
        textCategoryClassifierModel = NewsCategoryClassifier()
        session = URLSession(configuration: .default)
        url = "http://81.70.41.11:8888/search"
    }
    
    func classify(_ textContent: String) -> String? {
        if textContent != "" {
            getLanguageCategory(textContent)
            
            if languageCategory == "en" {
                guard let predictionResult = try? self.englishTextModel.prediction(text: textContent) else {
                    fatalError("Predicting errors!")
                }
                
                if let prediction = self.newsDetectResultDict[predictionResult.label] {
                    result = prediction
                }
            } else {
                guard let news_category = try? self.textCategoryClassifierModel.prediction(text: textContent) else {
                    fatalError("Predicting errors!")
                }
                
                if news_category.label != "时政" && news_category.label != "科技" && news_category.label != "教育" {
                    result = "不在模型检测的新闻种类内"
                    return result
                }
                
                guard let predictionResult = try? self.chineseTextModel.prediction(text: textContent) else {
                    fatalError("Predicting errors!")
                }
                
                if let prediction = self.newsDetectResultDict[predictionResult.label] {
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
    
    func getAdviceData(content: String) {
        let text = SearchedAdvice(language: languageCategory!, content: content)
        //var json: Advice = Advice(list: [])
        
        guard let encodedText = try? JSONEncoder().encode(text) else {
            print("Failed to encode order")
            return
        }
        
        var request = URLRequest(url: URL(string: url)!)
        request.setValue(nil, forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encodedText
        
        URLSession.shared.dataTask(with: request) { data, response, err in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            
            let json = try! JSONDecoder().decode(Advice.self, from: data!)
            
            DispatchQueue.main.async {
                self.adviceData = json
            }
        }
        .resume()
    }
}
