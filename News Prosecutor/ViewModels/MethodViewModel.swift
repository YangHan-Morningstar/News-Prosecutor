//
//  MethodDataManager.swift
//  News Prosecutor
//
//  Created by Tony Young on 2020/7/5.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import SwiftUI
import Combine

class MethodViewModel: ObservableObject {
    @Published var methodData: [Method] = []
    
    init() {
        methodData.append(Method(title: "文本新闻检测", text: "输入新闻标题或者内容", image: Image("文本搜索")))
        methodData.append(Method(title: "图片新闻检测", text: "拍摄或从图库导入图片", image: Image("图片搜索")))
    }
}
