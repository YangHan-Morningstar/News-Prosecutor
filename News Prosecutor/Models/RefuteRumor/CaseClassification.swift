//
//  CaseClassification.swift
//  News Prosecutor
//
//  Created by Tony Young on 2020/8/4.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import Foundation

struct CaseClassification: Decodable {
    var type: String
    var list: [NewsData]
}
