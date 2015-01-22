//
//  NSDate+FormattingExtensions.swift
//  SimpleToDoList
//
//  Created by HereTrix on 1/21/15.
//  Copyright (c) 2015 HereTrix. All rights reserved.
//

import Foundation

extension NSDate{
    func formattedString() -> String!{
        var formatter: NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "dd/MM/YYYY HH:mm"
        return formatter.stringFromDate(self)
    }
}