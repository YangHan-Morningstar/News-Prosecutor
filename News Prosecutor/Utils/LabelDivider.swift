//
//  LabelDivider.swift
//  News Prosecutor
//
//  Created by Tony Young on 2020/8/4.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import SwiftUI

struct LabelledDivider: View {

    let label: String?
    let horizontalPadding: CGFloat
    let color: Color

    init(label: String?, horizontalPadding: CGFloat = 20, color: Color = .gray) {
        self.label = label
        self.horizontalPadding = horizontalPadding
        self.color = color
    }

    var body: some View {
        HStack {
            if label != nil {
                line
                Text(label!)
                    .foregroundColor(color)
                    .lineLimit(1)
                line
            } else {
                line
            }
        }
    }

    var line: some View {
        VStack {
            Divider()
                .background(color)
                .frame(width: (label != nil) ? UIScreen.main.bounds.size.width / 2 - 150 : UIScreen.main.bounds.size.width - 60)
        }
        .padding(horizontalPadding)
    }
}
