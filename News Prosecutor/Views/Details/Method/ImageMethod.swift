//
//  ImageMethod.swift
//  News Prosecutor
//
//  Created by Tony Young on 2020/7/5.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import SwiftUI
import CoreML
import Vision

struct ImageMethod: View {
    @State private var showingAlert = false
    @State private var showSheet: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    
    @State private var image: UIImage?
    @State private var imageClassfyResult: [String?] = []
    
    @State private var show = false
    @State var showImage = false
    
    @ObservedObject var imageClassifierManager = ImageViewModel()
    @ObservedObject var detectResultDetailVM = DetectResultDetailViewModel()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                
                Color.black.edgesIgnoringSafeArea(.all)
                
                Color("background2")
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .edgesIgnoringSafeArea(.bottom)
                
                VStack {
                    Text("使用人工智能技术进行检测")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.top, 100)
                        .multilineTextAlignment(.center)

                    Text("请不要随意上传与新闻无关的图片,\n真实性由应用内置人工智能模型判断，\n仅供参考")
                        .font(.subheadline)
                        .frame(width: 300)
                        .padding(.top, 16)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                }
                .frame(height: 300)
                .frame(maxWidth: 600)
                .background(
                    Image("h")
                        .offset(x: -150, y: -200)
                        .rotationEffect(Angle(degrees: show ? 360*5 : 90))
                        .animation(Animation.linear(duration: 100*8))
                        .onAppear { self.show.toggle()}
                )
                .background(
                    Image("l")
                        .offset(x: -200, y: -250)
                        .rotationEffect(Angle(degrees: show ? 360*5 : 0), anchor: .bottomLeading)
                        .animation(Animation.linear(duration: 300*5))
                )
                .background(Color("card6"))
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
                
                Image(uiImage: image ?? UIImage(named: "DefaultImage")!)
                     .resizable()
                     .frame(height: 260)
                     .frame(maxWidth: .infinity)
                     .cornerRadius(30)
                     .padding()
                     .offset(y: 240)
                     .opacity(showImage ? 1 : 0)
                     .animation(.easeInOut(duration: 0.8))
                
                Button(action: {self.showSheet = true}) {
                    Text("点击此处选择图片")
                        .opacity(showImage ? 0 : 1)
                        .animation(.easeInOut(duration: 1.6))
                }
                .frame(height: 260)
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .padding(.horizontal)
                .offset(y: 270)
                .actionSheet(isPresented: $showSheet) {
                    ActionSheet(title: Text("从图库中选择或者使用照相机进行拍摄"), buttons: [
                        .default(Text("图库")) {
                            self.showImagePicker = true
                            self.sourceType = .photoLibrary
                        },
                        .default(Text("照相机")) {
                            self.showImagePicker = true
                            self.sourceType = .camera
                        },
                        .cancel(Text("取消"))
                        ]
                    )
                }
                
                Button("删除图片") {
                    
                    if self.image == nil {
                        self.showingAlert.toggle()
                    } else {
                        self.showImage.toggle()
                        
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8) {
                            self.image = nil
                        }
                    }
                }
                .padding(12)
                .padding(.horizontal, 30)
                .background(Color(#colorLiteral(red: 0, green: 0.7529411765, blue: 1, alpha: 1)))
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .shadow(color: Color(#colorLiteral(red: 0, green: 0.7529411765, blue: 1, alpha: 1)).opacity(0.2), radius: 20, x: 0, y: 20)
                .offset(y: 550)
                
                Button("开始检测") {
                    var booleanResult: Bool
                    
                    if let userPickedImage = self.image {
                        guard let ciimage = CIImage(image: userPickedImage) else {
                            fatalError("Converting UIImage to CIImage Failed.")
                        }
                        
                        self.imageClassfyResult = self.imageClassifierManager.classify(ciimage)
                        
                        if self.imageClassfyResult[0]! == "真新闻" {
                            booleanResult = true
                        } else {
                            booleanResult = false
                        }
                        
                        self.detectResultDetailVM.saveDetectResultDetail(detectResultDetail: DetectResultDetailModel(id: UUID(), methodName: "图片新闻检测", result: booleanResult))
                    }
                    
                    self.showingAlert.toggle()
                }
                .padding(12)
                .padding(.horizontal, 30)
                .background(Color(#colorLiteral(red: 0, green: 0.7529411765, blue: 1, alpha: 1)))
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .shadow(color: Color(#colorLiteral(red: 0, green: 0.7529411765, blue: 1, alpha: 1)).opacity(0.2), radius: 20, x: 0, y: 20)
                .offset(y: 620)
                
                Spacer()
            }
            .navigationBarTitle("Camera")
            .navigationBarHidden(true)
            .alert(isPresented: $showingAlert) {
                var alert: Alert
                
                if image == nil {
                    alert = Alert(title: Text("出错啦"), message: Text("您的图片不能为空哦"), dismissButton: .default(Text("完成")))
                } else {
                    alert = Alert(title: Text("识别结果"), message: Text("您的输入图片中的新闻有\(imageClassfyResult[1]!)%的概率是\(imageClassfyResult[0]!)哦"), dismissButton: .default(Text("完成"), action: {
                        self.showImage.toggle()
                        self.imageClassifierManager.result = []
                        self.imageClassfyResult = []
                        
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8) {
                            self.image = nil
                        }
                    }))
                }
                
                return alert
            }
            
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: self.$image, isShown: self.$showImagePicker, showImage: self.$showImage, sourceType: self.sourceType)
        }
    }
}

struct ImageMethod_Previews: PreviewProvider {
    static var previews: some View {
        ImageMethod()
    }
}
