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
    @State private var showingAdvice = false
    @State private var textContentIsEmpty = true
    @State private var result = ""
    @State private var show = false
    @State var textInput = ""
    
    @ObservedObject var textClassifierManager = TextClassifierViewModel()
    @ObservedObject var detectResultDetailVM = DetectResultDetailViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            
            Color.black.edgesIgnoringSafeArea(.all)
            
            Color("background2")
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .edgesIgnoringSafeArea(.bottom )
            
            VStack {
                Text("使用人工智能技术进行检测")
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
            
            CustomTextField(placeholder: "请输入新闻文本", text: $textInput) {
                var booleanResult: Bool
                
                if !self.textInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    self.result = self.textClassifierManager.classify(self.textInput)!
                    
                    if self.result == "真新闻" {
                        booleanResult = true
                    } else {
                        booleanResult = false
                    }
                    
                    self.detectResultDetailVM.saveDetectResultDetail(detectResultDetail: DetectResultDetailModel(id: UUID(), methodName: "文本新闻检测", result: booleanResult))
                    
                    self.textClassifierManager.getAdviceData(content: self.textInput)
                }
                
                self.showingAlert.toggle()
            }
            .font(.subheadline)
            .padding(.trailing)
            .frame(height: 44)
            .frame(maxWidth: .infinity)
            .background(BlurView(style: .systemMaterial))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.15), radius: 20, x: 0, y: 20)
            .padding(.horizontal)
            .offset(y: 280)
            
            Button(action: {
                var booleanResult: Bool
                
                if !self.textInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    self.result = self.textClassifierManager.classify(self.textInput)!
                    
                    if self.result == "真新闻" {
                        booleanResult = true
                    } else {
                        booleanResult = false
                    }
                    
                    self.detectResultDetailVM.saveDetectResultDetail(detectResultDetail: DetectResultDetailModel(id: UUID(), methodName: "文本新闻检测", result: booleanResult))
                    
                    self.textClassifierManager.getAdviceData(content: self.textInput)
                }
                
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
            var alert: Alert
            
            if self.result == "" {
                alert = Alert(title: Text("出错啦"), message: Text("您输入的新闻文本不能为空哦"), dismissButton: .default(Text("完成")))
            } else if self.result == "不在模型检测的新闻种类内" {
                alert = Alert(title: Text("出错啦"), message: Text("您输入的新闻的种类不在当前版本的检测范围中哦"), dismissButton: .default(Text("完成"), action: {self.result = ""}))
            } else {
                alert = Alert(title: Text("检测结果"), message: Text("您输入的新闻很有可能是\(result)哦"), dismissButton: .default(Text("完成"), action: {
                    self.result = ""
                    self.showingAdvice.toggle()
                }))
            }
            
            return alert
        }
        .sheet(isPresented: $showingAdvice) {
            ZStack {
                AdviceList(adviceData: self.textClassifierManager.adviceData)
                
                VStack {
                    HStack {
                        Spacer()
                        
                        Button(action: { self.showingAdvice.toggle() }) {
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
        .onTapGesture {
            DismissKeyboardHelper.dismiss()
        }
    }
}

struct TextMethod_Previews: PreviewProvider {
    static var previews: some View {
        TextMethod()
    }
}
