//
//  Skill.swift
//  Aggone
//
//  Created by tiexiong on 3/20/19.
//  Copyright © 2019 tiexiong. All rights reserved.
//

import Foundation

public class Skill {
    public var sport: Int = 0
    public var key: String = ""
    public var description: String = ""
    public var summary: String = ""
    public var value: Int = 0
    public var string_value: String = ""
    
    var dictionary: [String:Any] {
        return ["sport" : sport,
                "key" : key,
                "description" : description,
                "summary" : summary,
                "value" : value,
                "string_value" : string_value]
    }
    
    init() {}
    
    init(sport: Int, key: String, description: String, summary: String) {
        self.sport = sport
        self.key = key
        self.description = description
        self.summary = summary
    }
    
    init(dictionary:[String:Any]) {
        for (key, value) in dictionary {
            if let _ = value as? NSNull {
                continue
            }
            switch key {
            case "sport":
                self.sport = Utils.AnyToInt(value: value)
            case "key":
                self.key = value as! String
            case "description":
                self.description = value as! String
            case "summary":
                self.summary = value as! String
            case "value":
                self.value = Utils.AnyToInt(value: value)
            case "string_value":
                self.string_value = value as! String
            default:
                break;
            }
        }
    }
}
