//
//  DismissKeyboardHelper.swift
//  News Prosecutor
//
//  Created by Tony Young on 2020/7/12.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import UIKit

class DismissKeyboardHelper {
    static func dismiss() {
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        
        keyWindow!.endEditing(true)
    }
}
