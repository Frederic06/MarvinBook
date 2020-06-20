//
//  Constants.swift
//  MarvinBook
//
//  Created by Margarita Blanc on 20/06/2020.
//  Copyright © 2020 Frederic Blanc. All rights reserved.
//

import Foundation
import UIKit

func setHalfBold(normalText:String, boldText: String, fontSize: CGFloat) -> NSAttributedString{

    let attributedString = NSMutableAttributedString(string:normalText)
    
    let font = UIFont(name: "AvenirNext-Bold", size: fontSize)

    let attrs = [NSAttributedString.Key.font : font]
    let boldString = NSMutableAttributedString(string: boldText, attributes:attrs as [NSAttributedString.Key : Any])

    attributedString.append(boldString)
    
    return attributedString
}
