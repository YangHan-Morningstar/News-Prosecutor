//
//  CasesTitles.swift
//  News Prosecutor
//
//  Created by Tony Young on 2020/7/25.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import SwiftUI

struct CasesTitles: View {
    
    @Binding var data : CasesCard
    @Binding var hero : Bool
    @Binding var caseName: String
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            ScrollView {
                
                ZStack {
                    Image(self.data.image)
                        .resizable()
                        .frame(height: self.data.expand ? 350 : 300)
                        .cornerRadius(self.data.expand ? 0 : 30)
                        .padding(.bottom, self.data.expand ? 20 : 0)
                }
                
                if self.data.expand {
                    WebURLView(caseName: $caseName)
                }
            }
            .padding(.horizontal, self.data.expand ? 0 : 20)
            .contentShape(Rectangle())
            
            if self.data.expand {
                
                Button(action: {
                    
                    withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0)) {
                        
                        self.data.expand.toggle()
                        self.hero.toggle()
                    }
                    
                }) {
                    Image(systemName: "xmark")
                        .padding()
                        .background(BlurView(style: .systemMaterial))
                        .clipShape(Circle())
                    
                }
                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                .padding(.trailing, 10)
            }
        }
    }
}
