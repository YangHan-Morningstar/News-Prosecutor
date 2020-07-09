//
//  DetectResultDetailViewModel.swift
//  News Prosecutor
//
//  Created by Tony Young on 2020/7/8.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class DetectResultDetailViewModel: ObservableObject {
    @Published var detectResultDetailArray = [DetectResultDetailModel]()
    
    func fetchAllDetectResultDetail() {
        self.detectResultDetailArray = DetectResultDetailDataManager.shared.getDetectResultDetail().map(DetectResultDetailModel.init)
    }
    
    func removeDetectResultDetail(at index: Int) {
        let detectResultDetail = detectResultDetailArray[index]
        DetectResultDetailDataManager.shared.removeDetectResultDetail(id: detectResultDetail.id)
    }
    
    func saveDetectResultDetail(detectResultDetail: DetectResultDetailModel) {
        DetectResultDetailDataManager.shared.saveDetectResultDetail(id: detectResultDetail.id, methodName: detectResultDetail.methodName, result: detectResultDetail.result)
    }
    
    func getTextPercentage() -> CGFloat {
        fetchAllDetectResultDetail()
        
        var trueNum = 0
        var sum = 0
        
        for detectResultDetail in detectResultDetailArray {
            if detectResultDetail.methodName == "文本检测" {
                if detectResultDetail.result {
                    trueNum += 1
                }
                
                sum += 1
            }
        }
        
        if sum == 0 {
            return 0
        }
        
        return CGFloat(trueNum) / CGFloat(sum)
    }
    
    func getImagePercentage() -> CGFloat {
        fetchAllDetectResultDetail()
        
        var trueNum = 0
        var sum = 0
        
        for detectResultDetail in detectResultDetailArray {
            if detectResultDetail.methodName == "图片检测" {
                if detectResultDetail.result {
                    trueNum += 1
                }
                
                sum += 1
            }
        }
        
        if sum == 0 {
            return 0
        }
        
        return CGFloat(trueNum) / CGFloat(sum)
    }
}
