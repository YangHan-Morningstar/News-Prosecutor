//
//  HotPointDataViewModel.swift
//  News Prosecutor
//
//  Created by Tony Young on 2020/8/12.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import Foundation

class HotPointDataViewModel: ObservableObject {
    @Published var hotPointData: Advice
    
    var session: URLSession
    
    init() {
        hotPointData = Advice(list: [])
        session = URLSession(configuration: .default)
    }
    
    func getData(url: String) {
        DecodeTask(url)
    }
    
    func DecodeTask(_ url: String) {
        
        session.dataTask(with: URL(string: url)!) { (data, _, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }

            let json = try! JSONDecoder().decode(Advice.self, from: data!)
            
            DispatchQueue.main.async {
                self.hotPointData = json
            }
        }
        .resume()
    }
}
