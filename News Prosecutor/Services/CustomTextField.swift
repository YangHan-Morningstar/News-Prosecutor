//
//  CustomTextField.swift
//  News Prosecutor
//
//  Created by Tony Young on 2020/7/9.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import SwiftUI

struct CustomTextField: UIViewRepresentable {
    
    let placeholder: String?
    @Binding var text: String
    let onCommit: () -> Void
    
    init(placeholder: String? = nil, text: Binding<String>, onCommit: @escaping () -> Void = {}) {
        self.placeholder = placeholder
        self._text = text
        self.onCommit = onCommit
    }
    
    func makeUIView(context: Context) -> UITextField {
        let view = UITextField()
        view.placeholder = placeholder
        view.text = text
        view.delegate = context.coordinator
        return view
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
    
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        let parent: CustomTextField
        
        init(_ view: CustomTextField) {
            parent = view
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if string == "\n" {
                parent.onCommit()
                textField.text = ""
                textField.endEditing(true)
            } else {
                guard let currentText = textField.text, let currentRange = Range(range, in: currentText) else {
                    return false
                }

                parent.text = currentText.replacingCharacters(in: currentRange, with: string)
            }

            return true
        }
    }
}
