//
//  Audience.swift
//  Aggone
//
//  Created by MeiXiang Wu on 4/2/20.
//  Copyright © 2020 tiexiong. All rights reserved.
//

import Foundation

public class Audience {
    public var view_video : Int = 0
    public var star_video : Int = 0
    public var total_profile: Int = 0
    public var nPlayer: Int = 0
    public var nCoach: Int = 0
    public var nAgent: Int = 0
    public var nClub: Int = 0
    public var nStaff: Int = 0
    public var nCompany: Int = 0
    
    var dictionary: [String:Any] {
        return ["view_video" : view_video,
                "star_video" : star_video,
                "total_profile" : total_profile,
                "player" : nPlayer,
                "coach" : nCoach,
                "agent" : nAgent,
                "club" : nClub,
                "staff" : nStaff,
                "company" : nCompany,
        ]
    }
    
    init() {}
    
    init(dictionary:[String:Any]) {
        for (key, value) in dictionary {
            if let _ = value as? NSNull {
                continue
            }
            switch key {
            case "view_video":
                self.view_video = Utils.AnyToInt(value: value)
            case "star_video":
                self.star_video = Utils.AnyToInt(value: value)
            case "total_profile":
                self.total_profile = Utils.AnyToInt(value: value)
            case "player":
                self.nPlayer = Utils.AnyToInt(value: value)
            case "coach":
                self.nCoach = Utils.AnyToInt(value: value)
            case "agent":
                self.nAgent = Utils.AnyToInt(value: value)
            case "club":
                self.nClub = Utils.AnyToInt(value: value)
            case "staff":
                self.nStaff = Utils.AnyToInt(value: value)
            case "company":
                self.nCompany = Utils.AnyToInt(value: value)
            default:
                break;
            }
        }
    }
}
