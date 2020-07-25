//
//  Home.swift
//  News Prosecutor
//
//  Created by Tony Young on 2020/7/25.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            HomeView().tabItem {
                Image(systemName: "magnifyingglass")
                Text("检查")
            }
            
            CasesList().tabItem {
                Image(systemName: "list.bullet")
                Text("辟谣案例")
            }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
