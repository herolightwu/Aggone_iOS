//
//  Career.swift
//  Aggone
//
//  Created by tiexiong on 5/30/18.
//  Copyright © 2018 tiexiong. All rights reserved.
//

import Foundation

public class Career {
    public var id           : String = ""
    public var user_id      : String = ""
    public var position     : String = ""
    public var sport        : String = ""
    public var club         : String = ""
    public var logo         : String = ""
    public var location     : String = ""
    public var year         : Int = 1970
    public var month        : Int = 1
    public var day          : Int = 1
    public var tyear        : Int = 1970
    public var tmonth       : Int = 1
    public var tday         : Int = 1
    
    var dictionary: [String:Any] {
        return ["id" : id,
                "user_id" : user_id,
                "position" : position,
                "sport_id" : sport,
                "club" : club,
                "logo" : logo,
                "location" : location,
                "year" : year,
                "month" : month,
                "day" : day,
                "tyear" : tyear,
                "tmonth" : tmonth,
                "tday" : tday]
    }
    
    init() {}
    
    init(dictionary:[String:Any]) {
        for (key, value) in dictionary {
            if let _ = value as? NSNull {
                continue
            }
            switch key {
            case "id":
                self.id = "\(Utils.AnyToInt(value: value))"
            case "user_id":
                self.user_id = "\(Utils.AnyToInt(value: value))"
            case "position":
                self.position = value as! String
            case "sport_id":
                self.sport = value as! String
            case "club":
                self.club = value as! String
            case "logo":
                self.logo = value as! String
            case "location":
                self.location = value as! String
            case "year":
                self.year = Utils.AnyToInt(value: value)
            case "month":
                self.month = Utils.AnyToInt(value: value)
            case "day":
                self.day = Utils.AnyToInt(value: value)
            case "tyear":
                self.tyear = Utils.AnyToInt(value: value)
            case "tmonth":
                self.tmonth = Utils.AnyToInt(value: value)
            case "tday":
                self.tday = Utils.AnyToInt(value: value)
            default:
                break;
            }
        }
    }
}
