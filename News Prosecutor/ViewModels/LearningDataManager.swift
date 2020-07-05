//
//  LearningDataManager.swift
//  News Prosecutor
//
//  Created by Tony Young on 2020/7/5.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import SwiftUI
import Combine

class LearningDataManager: ObservableObject {
    @Published var learningData: [Learning] = []
    
    init() {
        learningData.append(Learning(title: "如何判断新闻真假？", text: "从文本与图片两个维度\n进行考虑", image: Image("learning2"), color: Color("card1")))
        learningData.append(Learning(title: "实战一下", text: "通过做几道题提高\n辨别能力", image: Image("learning1"), color: Color("card2")))
    }
}
