//
//  CircleView.swift
//  MarvinBook
//
//  Created by Margarita Blanc on 21/06/2020.
//  Copyright © 2020 Frederic Blanc. All rights reserved.
//

import UIKit

@IBDesignable
class CircleView: UIView {

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.size.width / 2
        layer.masksToBounds = true
    }
}
