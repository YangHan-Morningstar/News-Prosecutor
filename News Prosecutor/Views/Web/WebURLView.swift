//
//  WebURLView.swift
//  News Prosecutor
//
//  Created by Tony Young on 2020/7/25.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import SwiftUI

struct WebURLView: View {
    
    @ObservedObject var caseDataVM = CaseDataViewModel()
    
    @State var currentPost: NewsData?
    @State var showWebDetail = false
    @Binding var caseName: String
    
    var caseNameDict = [
        "科学": "kexue",
        "社会": "shehui",
        "食品": "shipin",
        "政治": "zhengzhi",
        "文化": "wenhua",
        "健康": "jiankang"
    ]
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            ForEach(caseDataVM.caseClassification.list) { newsDatas in
                VStack(alignment: .leading) {
                    HStack {
                        Text(self.caseName)
                            .frame(width: 40, height: 40)
                            .background(Color.blue)
                            .clipShape(Circle())
                            .padding(.leading)
                        
                        Button(action: {
                            self.showWebDetail.toggle()
                            self.currentPost = newsDatas
                        }) {
                            Text(newsDatas.title)
                                .foregroundColor(Color("background5"))
                                .padding(.leading)
                                .padding(.trailing)
                        }
                    }
                    
                    LabelledDivider(label: newsDatas.time)
                }
            }
        }
        .frame(maxWidth: screen.size.width)
        .background(Color("background1"))
        .onAppear() {
            self.caseDataVM.getData(category: self.caseNameDict[self.caseName] ?? "kexue")
        }
        .sheet(isPresented: $showWebDetail) {
            ZStack {
                WebURLDetailView(url: self.currentPost!.url)
                
                VStack {
                    HStack {
                        Spacer()
                        
                        Button(action: { self.showWebDetail.toggle() }) {
                            Image(systemName: "xmark")
                                .padding()
                                .background(BlurView(style: .systemMaterial))
                                .clipShape(Circle())
                        }
                    }
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}

//struct WebURLView_Previews: PreviewProvider {
//    static var previews: some View {
//        WebURLView(currentPost: NewsData(url: "https://www.google.com"))
//    }
//}


