//
//  ResizableTextField.swift
//  News Prosecutor
//
//  Created by Tony Young on 2020/7/19.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import SwiftUI

struct ResizableTextFieldHomeView: View {
    
    @State var text = ""
    @State var height: CGFloat = 0
    @State var keyboardHeight: CGFloat = 0
    
    var body: some View {
        VStack {
            HStack {
                Text("Test")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
            }
            .padding()
            .background(Color.white)
            
            ScrollView(.vertical, showsIndicators: false) {
                Text("")
            }
            
            ResizableTextField(placeholder: "Message", text: $text, height: $height)
                .frame(height: height < 100 ? height : 100)
                .padding(.horizontal)
                .background(Color.white)
                .cornerRadius(15)
        }
        .padding(.bottom, keyboardHeight )
        .background(Color.black.opacity(0.06).edgesIgnoringSafeArea(.bottom))
        .onTapGesture {
            UIApplication.shared.windows.first?.rootViewController?.view.endEditing(true)
        }
        .onAppear() {
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification, object: nil, queue: .main) { (data) in
                let height1 = data.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
                
                self.keyboardHeight = height1.cgRectValue.height - 20
            }
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidHideNotification, object: nil, queue: .main) { (_) in
                self.keyboardHeight = 0
            }
        }
    }
}

struct ResizableTextField_Previews: PreviewProvider {
    static var previews: some View {
        ResizableTextFieldHomeView()
    }
}

struct ResizableTextField: UIViewRepresentable {
    
    let placeholder: String?
    @Binding var text: String
    @Binding var height: CGFloat
    
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.isEditable = true
        view.isScrollEnabled = true
        view.text = placeholder
        view.font = .systemFont(ofSize: 18)
        view.textColor = .gray
        view.backgroundColor = .clear
        view.delegate = context.coordinator
        return view
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        DispatchQueue.main.async {
            self.height = uiView.contentSize.height
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return ResizableTextField.Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: ResizableTextField
        
        init(_ view: ResizableTextField) {
            parent = view
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if self.parent.text == "" {
                textView.text = parent.placeholder
                textView.textColor = .black
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if self.parent.text == "" {
                textView.text = parent.placeholder
                textView.textColor = .gray
            }
        }
        
        func textViewDidChange(_ textView: UITextView) {
            
            DispatchQueue.main.async {
                self.parent.height = textView.contentSize.height
                self.parent.text = textView.text
            }
        }
    }
}
