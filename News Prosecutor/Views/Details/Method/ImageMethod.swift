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
            VStack {
                VStack {
                    Text("使用人工智能技术进行检测")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.top, screen.size.height / 15)
                        .multilineTextAlignment(.center)

                    Text("请不要随意上传与新闻无关的图片,\n真实性由应用内置人工智能模型判断，\n仅供参考")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .frame(width: 300)
                        .padding(.top, 16)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                }
                .frame(height: screen.size.height / 3)
                .frame(maxWidth: 600)
                .background(Color("card6"))
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
                .padding(.bottom, -60)
                
                ZStack(alignment: .center) {
                    Button(action: {self.showSheet = true}) {
                        VStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 2)
                                    .frame(width: 30, height: 4)
                                
                                RoundedRectangle(cornerRadius: 2)
                                    .frame(width: 4, height: 30)
                            }
                            
                            Text("点击此处选择图片")
                        }
                        .foregroundColor(Color("secondary"))
                        .opacity(showImage ? 0 : 1)
                    }
                    .padding(.horizontal)
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

                    
                    ZStack(alignment: .topTrailing) {
                        Image(uiImage: self.image ?? UIImage(named: "DefaultImage")!)
                            .resizable()
                            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                        
                        Button(action: {
                            self.showImage.toggle()
                             
                             DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8) {
                                 self.image = nil
                             }
                        }) {
                            Image(systemName: "xmark")
                                .padding()
                                .background(BlurView(style: .systemMaterial))
                                .clipShape(Circle())
                                .padding()
                        }
                    }
                    .frame(height: 260)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(30)
                    .padding()
                    .opacity(showImage ? 1 : 0)
                    .animation(.easeInOut(duration: 0.8))
                }
        
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
                .foregroundColor(.white)
                .background(Color(#colorLiteral(red: 0, green: 0.7529411765, blue: 1, alpha: 1)))
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .shadow(color: Color(#colorLiteral(red: 0, green: 0.7529411765, blue: 1, alpha: 1)).opacity(0.2), radius: 20, x: 0, y: 20)
                
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
