//
//  User.swift
//  Aggone
//
//  Created by tiexiong on 5/15/18.
//  Copyright © 2018 tiexiong. All rights reserved.
//

import Foundation

public class User {
    public var id           : String = ""
    public var username     : String = ""
    public var email        : String = ""
    public var photo_url    : String = ""
    public var type         : Int = Constants.PLAYER
    public var sport        : Int = Constants.DefaultSport
    public var city         : String = ""
    public var country      : String = ""
    public var club         : String = ""
    public var category     : String = ""
    public var position     : String = ""
    public var contract     : String = ""
    public var gender       : Int = Constants.GENDER_MAN
    public var age          : Int = Constants.AGE_DEFAULT
    public var year         : Int = 1970
    public var month        : Int = 1
    public var day          : Int = 1
    public var height       : Int = Constants.HEIGHT_DEFAULT
    public var weight       : Int = Constants.WEIGHT_DEFAULT
    public var phone        : String = ""
    public var web_url      : String = ""
    public var desc_str     : String = ""
    public var available_club : Int = 0
    public var recommends   : Int = 0
    
    var dictionary: [String:Any] {
        return [
                 "id" : id,
                 "username" : username,
                 "email" : email,
                 "photo_url" : photo_url,
                 "group_id" : type,
                 "sport_id" : sport,
                 "city" : city,
                 "country" : country,
                 "club" : club,
                 "category" : category,
                 "position" : position,
                 "contract" : contract,
                 "gender_id" : gender,
                 "age" : age,
                 "year" : year,
                 "month" : month,
                 "day" : day,
                 "height" : height,
                 "weight" : weight,
                 "phone" : phone,
                 "web_url" : web_url,
                 "desc_str" : desc_str,
                 "available_club":available_club,
                 "recommends" : recommends
        ]
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
            case "username":
                self.username = value as! String
            case "email":
                self.email = value as! String
            case "photo_url":
                self.photo_url = value as! String
            case "group_id":
                self.type = Utils.AnyToInt(value: value)
            case "sport_id":
                self.sport = Utils.AnyToInt(value: value)
            case "city":
                self.city = value as! String
            case "country":
                self.country = value as! String
            case "club":
                self.club = value as! String
            case "category":
                self.category = value as! String
            case "position":
                self.position = value as! String
            case "contract":
                self.contract = value as! String
            case "gender_id":
                self.gender = Utils.AnyToInt(value: value)
            case "age":
                self.age = Utils.AnyToInt(value: value)
            case "year":
                self.year = Utils.AnyToInt(value: value)
            case "month":
                self.month = Utils.AnyToInt(value: value)
            case "day":
                self.day = Utils.AnyToInt(value: value)
            case "height":
                self.height = Utils.AnyToInt(value: value)
            case "weight":
                self.weight = Utils.AnyToInt(value: value)
            case "phone":
                    self.phone = value as! String
            case "web_url":
                    self.web_url = value as! String
            case "desc_str":
                self.desc_str = value as! String
            case "available_club":
                self.available_club = Utils.AnyToInt(value: value)
            case "recommends":
                self.recommends = Utils.AnyToInt(value: value)
            default:
                break;
            }
        }
    }
}
