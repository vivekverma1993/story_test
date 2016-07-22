//
//  Globals.swift
//  test
//
//  Created by vivek verma on 22/07/16.
//  Copyright © 2016 roposo. All rights reserved.
//

import UIKit

class Globals: NSObject {
    
    //Mark: - Global fonts
    
    struct uifonts {
        static var REGULAR_LARGE_FONT : UIFont = UIFont.init(name: fonts.REGULARFONT, size: 20)!
    }
    
    struct fonts {
        static var LIGHTFONT : String = "Roboto-Light"
        static var REGULARFONT : String = "Roboto-Regular"
        static var BOLDFONT : String = "Roboto-Bold"
    }
    
    //Mark: - Global colors
    
    struct colors {
        static var REDCOLOR : UIColor = UIColor(red:0.82, green:0.11, blue:0.11, alpha:1.0)
        static var upperViewColor : UIColor = UIColor(red:0.9, green:0.94, blue:0.96, alpha:1.0)
        static var TEXTCOLOR : UIColor = UIColor.darkGrayColor()
    }
    
    
    //Mark: - method to check existence of a dictionary inside a dictionary
    
    static func checkKeyExistsForDictionary(dict: NSDictionary, key: NSString) -> NSDictionary{
        var val : NSDictionary = NSDictionary()
        if let value = dict.objectForKey(key) as? NSDictionary{
            val = value as NSDictionary
        }
        
        return val
    }
    
    
    //Mark: - method to check existence of a key in a dictionary
    
    
    static func checkKeyExists(dict : NSDictionary, key: NSString) -> String{
        var val = ""
        if let value = dict.objectForKey(key) as? NSString{
            val = value as String
        }
            
        else if let value = dict.objectForKey(key) as? NSNumber{
            val = "\(value)"
        }
            
        else if let value = dict.objectForKey(key) as? Bool{
            val = "\(value)"
        }
        
        return val
        
        
    }
}
