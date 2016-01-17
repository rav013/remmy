//
//  CustomProgressView.swift
//  UIExamples
//
//  Created by Rafal Szastok on 06/09/15.
//  Copyright © 2015 Rafal Szastok. All rights reserved.
//

import Foundation
import UIKit

class LoadingProgressView : UIView {
    
    @IBOutlet weak var progressElementWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var progressElement: UIView!
    
    
    enum AnimationType : Int {
        case FirstProgress
        case SecondProgress
        case Finish
    }
    
    private struct Consts {
        static let XibName = "LoadingProgressView"
        
        // Height
        static let DefaultHeight:CGFloat = 3
        static let ErrorHeight:CGFloat = 40
        
        // Animation
        static let AnimationQuant = 0.05
        static let FirstSecondAnimationProportions = 0.8
        static let FirstAnimationDuration = 2.5
        static let SecondAnimationDuration = 0.3
        static let HideAnimationDuration = 0.5
    }
    private var heightConstraint: NSLayoutConstraint?
    private var successfull:Bool = false
    private var startWidth:CGFloat = 0
    private var targetWidth:CGFloat = 0
    private var currentAnimationTime:Double = 0
    private var targetAnimationTime:Double = 0
    private var animationType: AnimationType = .FirstProgress
    private var isAnimating = false
    
    static func loadingProgressViewToTopOfView(containerView:UIView) -> LoadingProgressView? {
        let viewArray = NSBundle.mainBundle().loadNibNamed(Consts.XibName, owner: self, options: nil)
        if let resultView = viewArray.first as? LoadingProgressView {
            resultView.heightConstraint = containerView.addSubviewStretchedWithConstantOnHeight(resultView,
                height:Consts.DefaultHeight)
            return resultView
        }
        return nil
    }
    
    private func _animate() {
        //log("_animate started t=\(animationType.rawValue) ct=\(currentAnimationTime) tt=\(targetAnimationTime)")
        
        if isAnimating {
            return
        }
        
        if currentAnimationTime >= targetAnimationTime {
            if animationType == .SecondProgress {
                _animateEnd()
            }
            return
        }
        
        currentAnimationTime += Consts.AnimationQuant
        
        let percent = currentAnimationTime / targetAnimationTime
        let currentPosition = startWidth * CGFloat(1-percent) + targetWidth * CGFloat(percent)
        progressElementWidthConstraint.constant = currentPosition
        
        isAnimating = true
        UIView.animateWithDuration(Consts.AnimationQuant,
            delay: 0.0,
            options: .CurveLinear,
            animations: { () -> Void in
                self.layoutIfNeeded()
            }, completion:{ (completed:Bool) -> (Void) in
                self.isAnimating = false
                self._animate()
        })
    }
    
    private func _animateEnd() {
        animationType = .Finish
        UIView.animateWithDuration(Consts.HideAnimationDuration, animations: { () -> Void in
            if !self.successfull {
                self.progressElement.backgroundColor = UIColor(netHex: 0xddf61343)
                if let heightC = self.heightConstraint {
                    heightC.constant = Consts.ErrorHeight
                }
            } else {
                self.alpha = 0.0
            }
            self.superview?.layoutIfNeeded()
        })
    }
    
    func slowLoading() {
        if animationType == .FirstProgress {
            targetAnimationTime = Consts.FirstAnimationDuration
            targetWidth = self.frame.width * CGFloat(Consts.FirstSecondAnimationProportions)
            _animate()
        }
    }
    
    func finishAnimation(success:Bool) {
        successfull = success
        
        animationType = .SecondProgress
        
        let percent = targetAnimationTime>0 ? currentAnimationTime / targetAnimationTime : 0
        let currentPosition = startWidth * CGFloat(1-percent) + targetWidth * CGFloat(percent)
        startWidth = currentPosition
        currentAnimationTime = 0
        targetAnimationTime = Consts.SecondAnimationDuration
        targetWidth = self.frame.width
        _animate()
    }
    
}