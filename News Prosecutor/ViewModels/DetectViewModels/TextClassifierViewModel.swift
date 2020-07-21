//
//  TextClassifierManager.swift
//  News Prosecutor
//
//  Created by Tony Young on 2020/7/5.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import SwiftUI
import Combine

class TextClassifierViewModel: ObservableObject {
    var textModel: FakeNewsClassifier
    var result: String?
    let newsCategroy = [
        "1": "假新闻",
        "0": "真新闻",
    ]
    
    init() {
        textModel = FakeNewsClassifier()
    }
    
    func classify(_ textContent: String) -> String? {
        if textContent != "" {
            guard let predictionResult = try? self.textModel.prediction(text: textContent) else {
                fatalError("Predicting errors!")
            }
            
            if let prediction = self.newsCategroy[predictionResult.label] {
                result = prediction
            }
        }
        
        return result
    }
}
