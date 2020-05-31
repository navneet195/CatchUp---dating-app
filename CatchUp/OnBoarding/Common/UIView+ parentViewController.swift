
//
//  UIView+ parentViewController.swift
//  Docplexus
//
//  Created by Rushikesh Talokar on 07/09/16.
//  Copyright © 2016 Docplexus. All rights reserved.
//


import Foundation
import UIKit

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    var isIPhone4: Bool {
        if UIScreen.main.bounds.size.height < 568.0 {
            return true
        }else {
            return false
        }
    }
    var isIphone5: Bool {
        if UIScreen.main.bounds.size.height == 568.0 {
            return true
        }else {
            return false
        }
    }
    var isIphone6: Bool {
        if UIScreen.main.bounds.size.height == 667.0 {
            return true
        }else {
            return false
        }
    }
    var isIphone6s: Bool {
        if UIScreen.main.bounds.size.height >= 736.0 {
            return true
        }else {
            return false
        }
    }
    func addDashedBorder() {
        let color = UIColor.white.cgColor
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [4,4]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
    
    @IBInspectable var shadow: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue == true {
                self.addShadow()
            }
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            
            // Don't touch the masksToBound property if a shadow is needed in addition to the cornerRadius
            if shadow == false {
                self.layer.masksToBounds = true
            }
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    
    func addShadow(shadowColor: CGColor = UIColor.black.cgColor,
                   shadowOffset: CGSize = CGSize(width: 0.0, height: 0.0),
                   shadowOpacity: Float = 0.2,
                   shadowRadius: CGFloat = 2.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
    
    
    
    func addBigShadow(shadowColor: CGColor = UIColor.black.cgColor,
                      shadowOffset: CGSize = CGSize(width: 1.0, height: 1.0),
                      shadowOpacity: Float = 0.2,
                      shadowRadius: CGFloat = 2.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
    
    func setCornerRadius(){
        
        
        //  self.addShadow()
        self.cornerRadius = 2
        self.shadow = true
        boostPerformance()
        
    }
    
    func setCornerwithRadius( radious : Float){
        
        
        self.addBigShadow()
        self.cornerRadius = CGFloat(radious)
        self.shadow = true
        boostPerformance()
        
    }
    
    func cornerwithBackgroundColor(color : UIColor){
        
        self.backgroundColor = color
        self.layer.cornerRadius = 0
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
        boostPerformance()
    }
    func setCornerRadiuswithoutShadow(){
        
        self.layer.cornerRadius = 2
        self.clipsToBounds = true
        boostPerformance()
    }
    func resizeToFitwith(containerView : UIView , bottomPadding : CGFloat ) {
        var width: CGFloat = 0
        var height: CGFloat = 0
        for currentView in containerView.subviews {

            var currentViewHeight : CGFloat = 0.0
            
            if let tableView = currentView as? UITableView {
                
                // to consider "details not available lable height"
                var noDataLableHeight : CGFloat = 0
                if let noDataLable = tableView.backgroundView?.subviews[0] {
                
                    noDataLableHeight = noDataLable.frame.height + 4 // 4 for bottom padding
                }
                
                currentViewHeight = tableView.contentSize.height+tableView.contentInset.bottom+tableView.contentInset.top + noDataLableHeight
   
                
            } else {
                
                currentViewHeight = currentView.frame.height
            }
            let newWidth = currentView.frame.origin.x + currentView.frame.width
            
            let newHeight = currentView.frame.origin.y + currentViewHeight
            width = max(width, newWidth)
            height = max(height, newHeight)
            
        }
        // for bottom padding add 8
        height = height + bottomPadding
        frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width , height: height)
    }
    func setHeightContrainwith(height : CGFloat ){
        DispatchQueue.main.asyncAfter(deadline: .now() ) {
            // remove any height contrain on view
            
            
            for constraint in self.constraints {
                
                
                if constraint.firstAttribute == NSLayoutConstraint.Attribute.height {
                    
                    self.removeConstraint(constraint)
                }
                
            }
            
            // add height contrain
            let heightConstraint = NSLayoutConstraint(
                item: self ,
                attribute: NSLayoutConstraint.Attribute.height,
                relatedBy: NSLayoutConstraint.Relation.equal,
                toItem: nil,
                attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                multiplier: 1,
                constant: height)
            heightConstraint.priority = UILayoutPriority(rawValue: 750)   // heigh periority
            self.addConstraints([heightConstraint])
        }
        
    }
    func boostPerformance() {
        layer.masksToBounds = false
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    func removeSubViews(){
    
        subviews.forEach({ $0.removeFromSuperview() })
    }
     var nibName: String {
        return String(describing: self)
    }
    func setGradientBackground(colorTop: UIColor,colorBottom: UIColor ) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ colorTop, colorBottom]
        gradientLayer.locations = [ 0.0, 1.0]
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
        
    }
}
