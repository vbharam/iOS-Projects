//
//  MaterialView.swift
//  DreamLister
//
//  Created by Vishal Bharam on 9/23/16.
//  Copyright © 2016 Codecoop. All rights reserved.
//

import UIKit

private var materialKey = false

extension UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBInspectable var materialDesign: Bool {
        
        get {
            return materialKey
        } set {
            materialKey = newValue
            
            if (materialKey) {
                self.layer.masksToBounds = false
                self.layer.cornerRadius = 3.0
                self.layer.shadowOpacity = 0.8
                self.layer.shadowRadius = 3.0
                self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
                self.layer.shadowColor = UIColor.init(red: 157/255, green: 157/255, blue: 157/255, alpha: 1.0).cgColor
            } else {
                self.layer.cornerRadius = 0.0
                self.layer.shadowOpacity = 0.0
                self.layer.shadowRadius = 0.0
                self.layer.shadowColor = nil
            }
        }
    }

}
