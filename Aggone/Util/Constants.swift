//
//  Constants.swift
//  Marifa
//
//  Created by tiexiong on 2/23/18.
//  Copyright © 2018 zhang. All rights reserved.
//

import Foundation

public class Constants {
    public static var GOOGLEPLACE_APIKEY = "AIzaSyCkeiATyIb-f2HILgjSE4tuzJDDoWLkcdQ"
    public static var YOUTUBE_APIKEY = "AIzaSyCkeiATyIb-f2HILgjSE4tuzJDDoWLkcdQ"
    
    public static var LOGIN_ISLOGGEDIN = "login_isloggedin"
    public static var LOGIN_EMAIL = "login_email"
    public static var LOGIN_PASSWORD = "login_password"
    public static var PUSH_TOKEN = "push_token"
    
    public static let SIGNUP_EMAIL       : Int = 0;
    public static let SIGNUP_SOCIAL      : Int = 1;
    
    public static var FIREBASE_CHAT = "Chat"
    public static var FIREBASE_CONTACT = "Contact"
    public static var FIREBASE_NOTIFICATION = "Notification"
    public static var FIREBASE_TIMESTAMP = "timestamp"
    public static var FIREBASE_TEXT = 0
    public static var FIREBASE_IMAGE = 1
    
    public static let MAX_DESCRIPTION : Int = 5
    public static let MAX_SKILL : Int = 5
    
    public static let PLAYER : Int = 1
    public static let COACH : Int = 2
    public static let TEAM_CLUB : Int = 3
    public static let AGENT : Int = 4
    public static let STAFF : Int = 5
    public static let COMPANY : Int = 6
    
    public static let NORMAL : Int = 0
    public static let YOUTUBE : Int = 1
    public static let NEWS : Int = 2
    
    //Gender
    public static let GENDER_MAN          : Int = 0
    public static let GENDER_WOMAN        : Int = 1
    public static let GENDER_OTHER        : Int = 2
    
    //Audience
    public static let AUDIENCE_TODAY      : Int = 0
    public static let AUDIENCE_WEEK       : Int = 1
    public static let AUDIENCE_MONTH      : Int = 2
    
    //Story reply type
    public static let REPLY_TYPE_TEXT  : Int = 1
    public static let REPLY_TYPE_IMAGE : Int = 2

    //Story show mode
    public static let STORY_SHOW_SELF  : Int = 0
    public static let STORY_SHOW_OTHER : Int = 1
    
    //MIN and MAX
    public static let AGE_MIN        : Int = 10
    public static let AGE_MAX        : Int = 100
    public static let AGE_DEFAULT    : Int = 20
    public static let WEIGHT_MIN     : Int = 10
    public static let WEIGHT_MAX     : Int = 160
    public static let WEIGHT_DEFAULT : Int = 80
    public static let HEIGHT_MIN     : Int = 100
    public static let HEIGHT_MAX     : Int = 300
    public static let HEIGHT_DEFAULT : Int = 180
    
    //Feed property
    public static let FEED_PUBLIC    : Int = 0
    public static let FEED_PRIVATE   : Int = 1
    
    public static let PRIZE1                      : Int = 0
    public static let PRIZE2                      : Int = 1
    public static let PRIZE3                      : Int = 2
    public static let PRIZE4                      : Int = 3
    public static let PRIZE5                      : Int = 4
    public static let PRIZE6                      : Int = 5
    
    public static let DESCRIPTION1                : Int = 0
    public static let DESCRIPTION2                : Int = 1
    public static let DESCRIPTION3                : Int = 2
    public static let DESCRIPTION4                : Int = 3
    public static let DESCRIPTION5                : Int = 4
    public static let DESCRIPTION6                : Int = 5
    
    public static let DESCRIPTION7                : Int = 6
    public static let DESCRIPTION8                : Int = 7
    public static let DESCRIPTION9                : Int = 8
    public static let DESCRIPTION10               : Int = 9
    public static let DESCRIPTION11               : Int = 10
    public static let DESCRIPTION12               : Int = 11
    
    public static let DESCRIPTION13               : Int = 12
    public static let DESCRIPTION14               : Int = 13
    public static let DESCRIPTION15               : Int = 14
    public static let DESCRIPTION16               : Int = 15
    public static let DESCRIPTION17               : Int = 16
    public static let DESCRIPTION18               : Int = 17
    
    public static let DESCRIPTION19               : Int = 18
    public static let DESCRIPTION20               : Int = 19
    public static let DESCRIPTION21               : Int = 20
    public static let DESCRIPTION22               : Int = 21
    public static let DESCRIPTION23               : Int = 22
    public static let DESCRIPTION24               : Int = 23
    
    public static let CDESCRIPTION1                : Int = 24
    public static let CDESCRIPTION2                : Int = 25
    public static let CDESCRIPTION3                : Int = 26
    public static let CDESCRIPTION4                : Int = 27
    public static let CDESCRIPTION5                : Int = 28
    public static let CDESCRIPTION6                : Int = 29
    
    public static let CDESCRIPTION7                : Int = 30
    public static let CDESCRIPTION8                : Int = 31
    public static let CDESCRIPTION9                : Int = 32
    public static let CDESCRIPTION10               : Int = 33
    public static let CDESCRIPTION11               : Int = 34
    public static let CDESCRIPTION12               : Int = 35
    
    public static let CDESCRIPTION13               : Int = 36
    public static let CDESCRIPTION14               : Int = 37
    public static let CDESCRIPTION15               : Int = 38
    public static let CDESCRIPTION16               : Int = 39
    public static let CDESCRIPTION17               : Int = 40
    public static let CDESCRIPTION18               : Int = 41
    
    public static let CDESCRIPTION19               : Int = 42
    public static let CDESCRIPTION20               : Int = 43
    public static let CDESCRIPTION21               : Int = 44
    public static let CDESCRIPTION22               : Int = 45
    public static let CDESCRIPTION23               : Int = 46
    public static let CDESCRIPTION24               : Int = 47
    
    //sport
    public static let DefaultSport              : Int = 500
    public static let Football                  : Int = 1000
    public static let Basketball                : Int = 1001
    public static let American_Football         : Int = 1002
    public static let Cricket                   : Int = 1003
    public static let Tennis                    : Int = 1004
    public static let Rugby                     : Int = 1005
    public static let Golf                      : Int = 1006
    public static let BaseBall                  : Int = 1007
    public static let Ice_Hockey                : Int = 1008
    public static let Field_Hockey              : Int = 1009
    public static let VolleyBall                : Int = 1010
    public static let Handball                  : Int = 1011
    public static let Badminton                 : Int = 1012
    public static let Squash                    : Int = 1013
    public static let TableTennis               : Int = 1014
    public static let Boxing                    : Int = 1015
    public static let MartialArt                : Int = 1016
    public static let MMA                       : Int = 1017
    public static let KickBoxing                : Int = 1018
    public static let Wrestling                 : Int = 1019
    public static let Gymnastic                 : Int = 1020
    public static let Athletics                 : Int = 1021
    public static let Fencing                   : Int = 1022
    public static let Judo                      : Int = 1023
    public static let Swimming                  : Int = 1024
    public static let WaterSports               : Int = 1025
    public static let WaterPolo                 : Int = 1026
    public static let AutoRacing                : Int = 1027
    public static let MotoRacing                : Int = 1028
    public static let Cycling                   : Int = 1029
    public static let Equestrianism             : Int = 1030
    public static let PoloSport                 : Int = 1031
    public static let Dance                     : Int = 1032
    public static let Softball                  : Int = 1033
    public static let SepakTakraw               : Int = 1034
    public static let Korfball                  : Int = 1035
    public static let Floorball                 : Int = 1036
    public static let Climbing                  : Int = 1037
    public static let Mountaineering            : Int = 1038
    public static let Canyoning                 : Int = 1039
    public static let Trail                     : Int = 1040
    public static let Triathlon                 : Int = 1041
    public static let Archery                   : Int = 1042
    public static let Snowboarding              : Int = 1043
    public static let Skiing                    : Int = 1044
    public static let IceSkating                : Int = 1045
    public static let Petanque                  : Int = 1046
    public static let SkateBoard                : Int = 1047
    public static let Weightlifting             : Int = 1048
    public static let Crossfit_Fitness          : Int = 1049
    public static let Bowling                   : Int = 1050
    public static let Surf                      : Int = 1051
    public static let Sailing                   : Int = 1052
    public static let Canoeing                  : Int = 1053
    public static let Rowing                    : Int = 1054
    public static let Air_Sports                : Int = 1055
    public static let WinterSports              : Int = 1056
    
    public static let STATS_COACH               : Int = 1060
    
    public static let PERFORMANCE          : String = "Performance"
    public static let RANKING              : String = "Ranking"
    public static let DISCIPLINE           : String = "Discipline"
        
    public static let WORLD : Int = 0
    public static let MY : Int = 1
    
    public static let STATS_GAMES_PLAYED        : String = "Games_played"
    public static let STATS_RACES               : String = "Races"
    public static let STATS_VICTORIES           : String = "Victories"
    public static let STATS_DEFEATS             : String = "Defeats"
    public static let STATS_DRAWS               : String = "Draws"

        
}
