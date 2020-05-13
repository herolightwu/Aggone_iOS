//
//  ViewStatic.swift
//  Aggone
//
//  Created by MeiXiang Wu on 4/2/20.
//  Copyright © 2020 tiexiong. All rights reserved.
//

import Foundation

public class ViewStatic {
    public var total : Int = 0
    public var ntoday : Int = 0
    public var nweek : Int = 0
    public var nmonth : Int = 0
    
    var dictionary: [String:Any] {
        return ["total" : total,
                "ntoday" : ntoday,
                "nweek" : nweek,
                "nmonth" : nmonth
        ]
    }
    
    init() {}
    
    init(dictionary:[String:Any]) {
        for (key, value) in dictionary {
            if let _ = value as? NSNull {
                continue
            }
            switch key {
            case "total":
                self.total = Utils.AnyToInt(value: value)
            case "ntoday":
                self.ntoday = Utils.AnyToInt(value: value)
            case "nweek":
                self.nweek = Utils.AnyToInt(value: value)
            case "nmonth":
                self.nmonth = Utils.AnyToInt(value: value)
            default:
                break;
            }
        }
    }
}
