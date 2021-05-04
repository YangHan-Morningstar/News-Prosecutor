//
//  SwiftUILoginPageWithLeanCloudApp.swift
//  SwiftUILoginPageWithLeanCloud
//
//  Created by Ailln on 2020/12/22.
//

import SwiftUI
import LeanCloud

@main
struct SwiftUILoginPageWithLeanCloudApp: App {
    init() {
        // leancloud 应用 Keys 中
        let appid = "CfIVA9UP8TyuBKl2o6CDEOoo-gzGzoHsz"
        let appkey = "P5o8deXSnERlf8cJo4WLo7ze"
        let url = "https://cfiva9up.lc-cn-n1-shared.com"
        
        do { try LCApplication.default.set(id: appid, key: appkey, serverURL: url) }
        catch { print(error) }
    }

    var body: some Scene {
        WindowGroup {
            //ContentView()
        }
    }
}

struct Validation<Value>: ViewModifier {
    var value: Value
    var validator: (Value) -> Bool
    
    func body(content: Content) -> some View {
        Group {
            if validator(value) {
                content
                Image(systemName: "checkmark.circle.fill").foregroundColor(.green).padding()
            } else {
                content
                Image(systemName: "xmark.octagon.fill").foregroundColor(.red).padding()
            }
        }
    }
}
