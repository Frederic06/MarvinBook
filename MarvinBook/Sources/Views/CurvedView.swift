//
//  CurvedView.swift
//  MarvinBook
//
//  Created by Margarita Blanc on 20/06/2020.
//  Copyright © 2020 Frederic Blanc. All rights reserved.
//

import UIKit

class CurvedView: UIView {
override func draw(_ rect: CGRect) {
    super.draw(rect)
    
    let rectShape = CAShapeLayer()
    rectShape.bounds = self.frame
    rectShape.position = self.center
    rectShape.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.bottomLeft , .bottomRight, .topLeft, .topRight], cornerRadii: CGSize(width: 20, height: 20)).cgPath

    self.layer.mask = rectShape
    }

}
