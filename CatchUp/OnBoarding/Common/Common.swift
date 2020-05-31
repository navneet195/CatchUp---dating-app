//
//  Common.swift
//  
//
//  Created by 8 on 06/02/19.
//  Copyright © 2019 . All rights reserved.
//

import Foundation
import UIKit
import Photos

class Common {
    
    static let shared = Common()
    var appName : String
    var preference : UserDefaults
    var screenWidth : CGFloat
    var screenHeight : CGFloat
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    init() {
        appName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
        preference = UserDefaults.standard
        screenWidth = UIScreen.main.bounds.size.width
        screenHeight = UIScreen.main.bounds.size.height
    }

    // MARK: - Preference -
    
    func setPreference(strKey : String, value : String) {
        
        preference.set(value, forKey: strKey)
        preference.synchronize()
    }
    
    func getPreference(strKey : String) -> String {
        
        return preference.string(forKey:strKey) ?? ""
    }
    
    // MARK: - Camera and photo library authorization -
    
    func authorizedForCamera() -> Bool {
        
        if AVCaptureDevice.authorizationStatus(for: .video) == .authorized{
            
            return true
        }
        
        return false
    }
    
    func authorizedForPhotoLibrary() -> Bool {
        
        if PHPhotoLibrary.authorizationStatus() == .authorized{
         
            return true
        }
        
        return false
    }
    
    //MARK: - Color -
    
    func uicolorFromHex(hexValue: UInt, alpha : Double?) -> UIColor {
        
        var alphaFinal = 1.0
        
        if let alpha = alpha{
            
            alphaFinal = Double(alpha)
        }
        
        return UIColor(
            red: CGFloat((hexValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hexValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hexValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alphaFinal)
        )
    }
    
    
    func uicolorFromHexWithAlpha(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 0.2)
        
    }
}
