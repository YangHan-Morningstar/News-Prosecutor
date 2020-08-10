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
    
    var session: URLSession
    var url: String
    
    var result: String?
    var languageCategory: String?
    let newsCategroy = [
        "1": "假新闻",
        "0": "真新闻",
        "Fake": "假新闻",
        "True": "真新闻"
    ]
    @Published var adviceData: Advice = Advice(list: [])
    
    init() {
        textModel = FakeNewsClassifier()
        englishTextModel = EnglishFakeNewsTextClassifier()
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
