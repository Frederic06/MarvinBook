//
//  TitleLabel.swift
//  MarvinBook
//
//  Created by Margarita Blanc on 20/06/2020.
//  Copyright © 2020 Frederic Blanc. All rights reserved.
//

import UIKit

class TitleLabel: UILabel {
    
        required init(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)!
            self.commonInit()

        }

        override init(frame: CGRect) {
            super.init(frame: frame)
            self.commonInit()
        }
        func commonInit(){
            
            let normalText = "Marvin"

            let boldText  = "Book"

            let attributedString = NSMutableAttributedString(string:normalText)

            let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)]
            let boldString = NSMutableAttributedString(string: boldText, attributes:attrs)

            attributedString.append(boldString)
            
            self.attributedText = attributedText
            
        }
    }
