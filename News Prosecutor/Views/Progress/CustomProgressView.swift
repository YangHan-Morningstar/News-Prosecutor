//
//  CustomProgressView.swift
//  News Prosecutor
//
//  Created by Tony Young on 2020/7/19.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import SwiftUI

struct CustomProgressView: View {
    
    var percent: CGFloat = 0
    var width: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .leading) {
            ZStack(alignment: .trailing) {
                Capsule()
                    .fill(Color("background4").opacity(0.08))
                    .frame(height: 22)
                
                Text(String(format: "%.2f", self.percent * 100) + "%")
                    .font(.caption)
                    .foregroundColor(Color.gray.opacity(0.75))
                    .padding(.trailing)
            }
            
            Capsule()
                .fill(LinearGradient(gradient: .init(colors: [Color("card2"), Color("card3")]), startPoint: .leading, endPoint: .trailing))
                .frame(width: width, height: 22)
        }
        .cornerRadius(15)
        .padding()
    }
}

struct CustomProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CustomProgressView()
    }
}
