//
//  ItemColor.swift
//  SimpleToDoList
//
//  Created by HereTrix on 1/21/15.
//  Copyright (c) 2015 HereTrix. All rights reserved.
//

import Foundation
import UIKit

enum ItemColor: Int{
    case Default = 0, Red, Green, Blue, Yellow
    
    func colorValue() -> UIColor{
        switch self{
            case .Red :
                return UIColor.redColor()
                
            case .Green:
                return UIColor.greenColor()
                
            case .Blue:
                return UIColor.blueColor()
                
            default:
                return UIColor.blackColor()
        }
    }
    
    func description() -> String{
        switch self{
            case .Red :
                return "Red"
                
            case .Green:
                return "Green"
                
            case .Blue:
                return "Blue"
                
            default:
                return "Default"
        }
    }
}