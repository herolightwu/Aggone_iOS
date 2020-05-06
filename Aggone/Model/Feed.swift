//
//  Feed.swift
//  Aggone
//
//  Created by tiexiong on 5/22/18.
//  Copyright © 2018 tiexiong. All rights reserved.
//

import Foundation

public class Feed {
    public var id               : String = ""
    public var type             : Int = 0
    public var user             : User!
    public var title            : String = ""
    public var video_url        : String = ""
    public var thumbnail_url    : String = ""
    public var sport            : Int = Constants.DefaultSport
    public var view_count       : Int = 0
    public var like_count       : Int = 0
    public var timestamp        : Int64 = 0
    public var shared           : Int = 0
    public var like             : Bool = false
    public var bookmark         : Bool = false
    public var tagged           : String = ""
    public var mode             : Int = 0
    public var desc_str         : String = ""
    public var articles         : String = ""
    
    var dictionary: [String:Any] {
        return ["id" : id,
                "type" : type,
                "user" : user.dictionary,
                "title" : title,
                "video_url" : video_url,
                "thumbnail_url" : thumbnail_url,
                "sport_id" : sport,
                "view_count" : view_count,
                "like_count" : like_count,
                "timestamp" : timestamp,
                "shared" : shared,
                "like" : like,
                "bookmark": bookmark,
                "tagged" : tagged,
                "mode" : mode,
                "desc_str" : desc_str,
                "articles" : articles,
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
            case "type":
                self.type = Utils.AnyToInt(value: value)
            case "user":
                self.user = User(dictionary: value as! [String:Any])
            case "title":
                self.title = value as! String
            case "video_url":
                self.video_url = value as! String
            case "thumbnail_url":
                self.thumbnail_url = value as! String
            case "sport_id":
                self.sport = Utils.AnyToInt(value: value)
            case "view_count":
                self.view_count = Utils.AnyToInt(value: value)
            case "like_count":
                self.like_count = Utils.AnyToInt(value: value)
            case "timestamp":
                self.timestamp = Utils.AnyToInt64(value: value)
            case "shared":
                self.shared = Utils.AnyToInt(value: value)
            case "like":
                self.like = value as! Bool
            case "bookmark":
                self.bookmark = value as! Bool
            case "tagged":
                self.tagged = value as! String
            case "mode":
                self.mode = Utils.AnyToInt(value: value)
            case "desc_str":
                self.desc_str = value as! String
            case "articles":
                self.articles = value as! String
            default:
                break;
            }
        }
    }
}
