//
//  Result.swift
//  Aggone
//
//  Created by tiexiong on 5/24/18.
//  Copyright © 2018 tiexiong. All rights reserved.
//

import Foundation

public class Result {
    public var id: String = ""
    public var user_id: String = ""
    public var value_type: Int = 0
    public var club: String = ""
    public var sport: Int = 0
    public var type: String = ""
    public var value: Int = 0
    public var year: Int = 0
    public var month: Int = 0
    
    
    var dictionary: [String:Any] {
        return [        "id" : id,
                        "user_id" : user_id,
                        "year" : year,
                        "month" : month,
                        "value_type" : value_type,
                        "club" : club,
                        "sport_id" : sport,
                        "type" : type,
                        "value" : value]
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
            case "year":
                self.year = Utils.AnyToInt(value: value)
            case "month":
                self.month = Utils.AnyToInt(value: value)
            case "value_type":
                self.value_type = Utils.AnyToInt(value: value)
            case "club":
                self.club = value as! String
            case "sport_id":
                self.sport = String.toInt(value: value)
            case "type":
                self.type = value as! String
            case "value":
                self.value = Utils.AnyToInt(value: value)
            default:
                break;
            }
        }
    }
}
