//
//  DetectResultDetailModel.swift
//  News Prosecutor
//
//  Created by Tony Young on 2020/7/8.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct DetectResultDetailModel {
    var id: UUID
    var methodName: String
    var result: Bool
    
    init(id: UUID, methodName: String, result: Bool) {
        self.id = id
        self.methodName = methodName
        self.result = result
    }
    
    init(detectResultDetail: DetectResultDetail) {
        self.id = detectResultDetail.id ?? UUID()
        self.methodName = detectResultDetail.methodName ?? ""
        self.result = detectResultDetail.result
    }
}
