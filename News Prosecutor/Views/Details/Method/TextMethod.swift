//
//  TextMethod.swift
//  News Prosecutor
//
//  Created by Tony Young on 2020/7/5.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import SwiftUI

struct TextMethod: View {
    
    @State private var showingAlert = false
    @State private var textContentIsEmpty = true
    @State private var textContent = ""
    @State private var result = ""
    @State private var show = false
    
    @ObservedObject var textClassifierManager = TextClassifierManager()
    
    var body: some View {
        ZStack(alignment: .top) {
            
            Color.black.edgesIgnoringSafeArea(.all)
            
            Color("background2")
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .edgesIgnoringSafeArea(.bottom )
            
            VStack {
                Text("使用机器学习模型进行检测")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.top, 100)
                    .multilineTextAlignment(.center)

                Text("请不要漏写、错写文字与标点符号,\n真实性由应用内置人工智能模型判断，\n仅供参考")
                    .font(.subheadline)
                    .frame(width: 300)
                    .padding(.top, 16)
                    .multilineTextAlignment(.center)
                
                Spacer()
            }
            .frame(height: 300)
            .frame(maxWidth: 600)
            .background(
                Image(uiImage: #imageLiteral(resourceName: "Blob"))
                    .offset(x: -150, y: -200)
                    .rotationEffect(Angle(degrees: show ? 360*5 : 90))
                    .blendMode(.plusDarker)
                    .animation(Animation.linear(duration: 100*8))
                    .onAppear { self.show.toggle()}
            )
            .background(
                Image(uiImage: #imageLiteral(resourceName: "Blob"))
                    .offset(x: -200, y: -250)
                    .rotationEffect(Angle(degrees: show ? 360*5 : 0), anchor: .bottomLeading)
                    .animation(Animation.linear(duration: 300*5))
            )
            .background(Color(#colorLiteral(red: 0.4117647059, green: 0.4705882353, blue: 0.9725490196, alpha: 1)))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
            
            VStack {
                HStack {
                    TextField("请输入新闻文本", text: $textContent) {
                        self.result = self.textClassifierManager.classify(self.textContent)!
                        self.textContent = ""
                    }
                    .font(.subheadline)
                    .padding(.trailing)
                    .frame(height: 44)
                    
                    Button(action: {
                        self.textContent = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                            .frame(width: 44, height: 44)
                            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                            .padding(.trailing)
                    }
                }
            }
            .frame(height: 44)
            .frame(maxWidth: .infinity)
            .background(BlurView(style: .systemMaterial))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.15), radius: 20, x: 0, y: 20)
            .padding(.horizontal)
            .offset(y: 280)

            Button(action: {
                self.result = self.textClassifierManager.classify(self.textContent)!
                self.textContent = ""
                self.showingAlert.toggle()
            }) {
                Text("开始检测")
                    .foregroundColor(.black)
            }
            .padding(12)
            .padding(.horizontal, 30)
            .background(Color(#colorLiteral(red: 0, green: 0.7529411765, blue: 1, alpha: 1)))
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: Color(#colorLiteral(red: 0, green: 0.7529411765, blue: 1, alpha: 1)).opacity(0.2), radius: 20, x: 0, y: 20)
            .offset(y: 350)
        }
        .alert(isPresented: $showingAlert) {
            return Alert(title: Text("识别结果"), message: Text("您输入的新闻很有可能是\(result)哦"), dismissButton: .default(Text("完成"), action: {}))
        }
        
    }
}

struct TextMethod_Previews: PreviewProvider {
    static var previews: some View {
        TextMethod()
    }
}