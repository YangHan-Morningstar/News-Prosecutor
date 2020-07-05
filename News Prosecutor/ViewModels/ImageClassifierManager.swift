//
//  ImageClassifierManager.swift
//  News Prosecutor
//
//  Created by Tony Young on 2020/7/5.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import SwiftUI
import Combine
import CoreML
import Vision

class ImageClassifierManager: ObservableObject {
    var imageModel: FakeNewsImageClassifier
    var result: String?
    let newsCategroy = [
        "truth_pic": "真新闻",
        "rumor_pic": "假新闻"
    ]
    
    init() {
        imageModel = FakeNewsImageClassifier()
    }
    
    func classify(_ image: CIImage) -> String? {
        // 获取模型
        guard let model = try? VNCoreMLModel(for: FakeNewsImageClassifier().model) else {
            fatalError("Loading CoreML Model Failed.")
        }
        
        // 创立请求
        let request = VNCoreMLRequest(model: model){ (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model failed to process the image.")
            }
            if let firstResult = results.first {
                self.result = self.newsCategroy[firstResult.identifier]
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do{
            try handler.perform([request])
        } catch {
            print(error)
        }
        
        return result
    }
}
