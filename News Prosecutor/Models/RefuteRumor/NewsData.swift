//
//  NewsData.swift
//  News Prosecutor
//
//  Created by Tony Young on 2020/8/4.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import Foundation

struct NewsData: Decodable, Identifiable {
    var id: Int
    var title: String
    var time: String
    var url: String
    var pic: String
}
