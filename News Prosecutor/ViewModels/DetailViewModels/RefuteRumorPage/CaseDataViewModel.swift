//
//  CaseDataViewModel.swift
//  News Prosecutor
//
//  Created by Tony Young on 2020/8/4.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import Foundation
import SwiftUI

class CaseDataViewModel: ObservableObject {
    @Published var caseClassification: CaseClassification
    
    var session: URLSession
    var url: String = ""
    
    init() {
        caseClassification = CaseClassification(type: "", list: [])
        session = URLSession(configuration: .default)
    }
    
    func getData(category: String) {
        url = "http://81.70.41.11:8888/getInfo?search=\(category)"
        
        DecodeTask()
    }
    
    func DecodeTask() {
        
        session.dataTask(with: URL(string: url)!) { (data, _, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }

            let json = try! JSONDecoder().decode(CaseClassification.self, from: data!)
            
            DispatchQueue.main.async {
                self.caseClassification = json
            }
        }
        .resume()
    }

}
