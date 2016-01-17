//
//  UIView+Layout.swift
//  Quiz
//
//  Created by Rafal Szastok on 17/01/16.
//  Copyright © 2016 Rafal Szastok. All rights reserved.
//

import UIKit

extension UIView {
    
    func addSubviewStretchedWithConstantOnHeight(subview : UIView, height:CGFloat) -> NSLayoutConstraint? {
        subview.translatesAutoresizingMaskIntoConstraints = false
        let horizontalFormat = "H:|[subview]|"
        let verticalTopFormat = "V:|[subview(\(height))]"
        let viewsDict =  ["subview" : subview]
        
        self.addSubview(subview)
        
        self.addViewWithLayoutFormat(horizontalFormat, views: viewsDict)
        if let heightConstraints = self.addViewWithLayoutFormat(verticalTopFormat, views: viewsDict) {
            if heightConstraints.count == 2 {
                if heightConstraints.first?.constant == height {
                    return heightConstraints[0]
                } else {
                    return heightConstraints[1]
                }
            }
        }
        return nil
    }
    
    func addSubviewStretched(subview : UIView?) -> Void {
        if let view = subview {
            view.translatesAutoresizingMaskIntoConstraints = false
            let horizontalFormat : String = "H:|[subview]|"
            let verticalFormat : String = "V:|[subview]|"
            let viewsDict =  ["subview" : view]
            
            self.addSubview(view)
            
            self.addViewWithLayoutFormat(horizontalFormat, views: viewsDict)
            self.addViewWithLayoutFormat(verticalFormat, views: viewsDict)
        }
    }
    
    func addSubviewWithInsets(subview : UIView?, insets: UIEdgeInsets) -> Void {
        if let view = subview {
            view.translatesAutoresizingMaskIntoConstraints = false
            let horizontalFormat : String = "H:|-(left)-[subview]-(right)-|"
            let verticalFormat : String = "V:|-(top)-[subview]-(bottom)-|"
            let viewsDict =  ["subview" : view]
            let metrics = [
                "left":insets.left,
                "right":insets.right,
                "top":insets.top,
                "bottom":insets.bottom
            ]
            self.addSubview(view)
            
            let constraintsH = NSLayoutConstraint.constraintsWithVisualFormat(horizontalFormat, options: NSLayoutFormatOptions(), metrics: metrics, views: viewsDict)
            let constraintsV = NSLayoutConstraint.constraintsWithVisualFormat(verticalFormat, options: NSLayoutFormatOptions(), metrics: metrics, views: viewsDict)
            
            self.addConstraints(constraintsH)
            self.addConstraints(constraintsV)
        }
    }
    
    
    func addViewWithLayoutFormat(format : String, views : [String : UIView]) -> [NSLayoutConstraint]? {
        let constraints = NSLayoutConstraint.constraintsWithVisualFormat(format,
            options: NSLayoutFormatOptions(),
            metrics: nil,
            views: views)
        self.addConstraints(constraints)
        
        return constraints
    }
    
}