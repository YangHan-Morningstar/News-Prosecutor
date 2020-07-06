//
//  Question.swift
//  News Prosecutor
//
//  Created by Tony Young on 2020/7/6.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import Foundation
import SwiftUI

struct Question: Identifiable {
    var id = UUID()
    var text = ""
    var image = ""
    var answer: String
    var ifImage = false
}
