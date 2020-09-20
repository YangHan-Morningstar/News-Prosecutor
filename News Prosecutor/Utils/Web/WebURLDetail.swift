//
//  WebURLDetailView.swift
//  News Prosecutor
//
//  Created by Tony Young on 2020/7/25.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import SwiftUI

struct WebURLDetail: View {
    
    @Binding var currentPost: NewsData?
    
    var body: some View {
        WebView(urlDoDisplay: URL(string: currentPost!.url)!)
            .edgesIgnoringSafeArea(.all)
    }
}

//struct WebURLDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        WebURLDetail(url: "https://www.google.com")
//    }
//}
