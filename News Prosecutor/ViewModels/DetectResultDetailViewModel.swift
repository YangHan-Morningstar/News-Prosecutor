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
}
