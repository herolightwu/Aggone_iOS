//
//  API.swift
//  Aggone
//
//  Created by tiexiong on 5/15/18.
//  Copyright © 2018 tiexiong. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import YoutubeKit
import OneSignal

public class API {
    public static var baseUrl                       : String! = "https://www.aggone.org/"  //"https://rocmail10.com/"
    public static var imgDirUrl                     : String! = "uploads/images/"
    public static var videoDirUrl                   : String! = "uploads/videos/"
    public static var resumeDirUrl                  : String! = "uploads/resumes/"
    public static var articleDirUrl                 : String! = "uploads/articles/"
    public static var storyDirUrl                   : String! = "uploads/stories/"
    private static var apiUrl                       : String! = baseUrl + "api/"
    private static var loginWithEmailAndPassword   : String! = apiUrl + "user/login_email_password"
    private static var loginWithSocial             : String! = apiUrl + "user/login_social"
    private static var signupWithEmailAndPassword  : String! = apiUrl + "user/signup_email_password"
    private static var getUserByEmail              : String! = apiUrl + "user/get_user_by_email"
    private static var getUserByName               : String! = apiUrl + "user/get_user_by_name"
    private static var getAllUsers                 : String! = apiUrl + "user/get_all_user"
    private static var getUsersByType              : String! = apiUrl + "user/get_users_by_type"
    private static var searchUsers                 : String! = apiUrl + "user/search_users"
    private static var updateUser                  : String! = apiUrl + "user/update_user"
    private static var getTaggedUsers              : String! = apiUrl + "user/get_tagged_users"
    private static var resetPassword               : String! = apiUrl + "user/reset_password"
    private static var forgotPassword              : String! = apiUrl + "user/forgot_password"
    private static var filterUser                  : String! = apiUrl + "user/get_user_by_filter"
    private static var changePassword              : String! = apiUrl + "user/change_password"
    private static var updateUserField             : String! = apiUrl + "user/update_user_field"
    private static var uploadResume                : String! = apiUrl + "user/upload_resume"
    private static var viewProfile                 : String! = apiUrl + "user/view_profile"
    private static var getAllFeeds                 : String! = apiUrl + "feed/get_all_feeds"
    private static var getAllFeedsByUserid         : String! = apiUrl + "feed/get_all_feeds_by_user"
    private static var getSportsFeeds              : String! = apiUrl + "feed/get_sports_feeds"
    private static var getMyFeeds                  : String! = apiUrl + "feed/get_my_feeds"
    private static var saveFeed                    : String! = apiUrl + "feed/save_feed"
    private static var addViewFeed                 : String! = apiUrl + "feed/add_view_feed"
    private static var deleteFeed                  : String! = apiUrl + "feed/delete_feed"
    private static var privateFeed                 : String! = apiUrl + "feed/private_feed"
    private static var uploadFile                  : String! = apiUrl + "feed/upload_file"
    private static var uploadArticles              : String! = apiUrl + "feed/upload_articles"
    private static var searchVideoFeeds            : String! = apiUrl + "feed/search_video_feeds"
    private static var uploadImage                 : String! = apiUrl + "user/upload_image"
    private static var recommendUser               : String! = apiUrl + "user/recommend_user"
    private static var reportUser                  : String! = apiUrl + "user/report_user"

    private static var addLikeFeed                 : String! = apiUrl + "like/like_feed"
    private static var reportFeed                  : String! = apiUrl + "feed/report_feed";

    private static var saveResult                  : String! = apiUrl + "result/save_result"
    private static var deleteUserClubSummary       : String! = apiUrl + "result/delete_user_club_summary"
    private static var getYearResultSummary        : String! = apiUrl + "result/get_year_summary"
    private static var getUserResultSummary        : String! = apiUrl + "result/get_user_summary"
    private static var getClubMonthResultSummary   : String! = apiUrl + "result/get_club_month_summary"
    private static var getSportResultSummary       : String! = apiUrl + "result/get_sport_summary"
    private static var getClubSummary              : String! = apiUrl + "result/get_club_summary"
    private static var getClubYearSummary          : String! = apiUrl + "result/get_club_year_summary"
    private static var deleteClubYearSummary       : String! = apiUrl + "result/delete_club_year_summary"
    private static var adjustStatValue             : String! = apiUrl + "result/adjust_summary";
    private static var getSummaryByClub            : String! = apiUrl + "result/get_summary_by_club";

    private static var getAllAdmobs                : String! = apiUrl + "admob/get_all_admobs"
    private static var saveAdmob                   : String! = apiUrl + "admob/save_admob"
    private static var filterAdmobs                : String! = apiUrl + "admob/filter_admobs"
    private static var deleteAdmob                 : String! = apiUrl + "admob/delete_admob"

    private static var getAllCareersByUserid       : String! = apiUrl + "career/get_all_careers_by_userid"
    private static var saveCareer                  : String! = apiUrl + "career/save_career"
    private static var updateCareer                : String! = apiUrl + "career/update_career"
    private static var deleteCareer                : String! = apiUrl + "career/delete_career"

    private static var getAllDescriptionsByUserid  : String! = apiUrl + "description/get_all_descriptions_by_userid"
    private static var saveDescription             : String! = apiUrl + "description/save_description"
    private static var updateDescription           : String! = apiUrl + "description/update_description"

    private static var getAllPrizesByUserid        : String! = apiUrl + "prize/get_all_prizes_by_user"
    private static var savePrize                   : String! = apiUrl + "prize/save_prize"
    private static var updatePrize                 : String! = apiUrl + "prize/update_prize"
    private static var deletePrize                 : String! = apiUrl + "prize/delete_prize"
    private static var getAllMessage               : String! = apiUrl + "message/get_all_messages_by_roomid"
    private static var saveMessage                 : String! = apiUrl + "message/add_message"
    private static var getContact                  : String! = apiUrl + "contact/get_contact_by_userid"

    private static var getFollower                 : String! = apiUrl + "follow/get_follower"
    private static var checkFollow                 : String! = apiUrl + "follow/check_follow"
    private static var deleteFollow                : String! = apiUrl + "follow/delete_follow"
    private static var getFollowing                : String! = apiUrl + "follow/get_following"
    private static var addFollow                   : String! = apiUrl + "follow/add_follow"

    private static var addBlock                    : String! = apiUrl + "block/add_block"
    private static var deleteBlock                 : String! = apiUrl + "block/remove_block"
    private static var getBlocks                   : String! = apiUrl + "block/get_blocked_users"

    private static var saveBookmark                : String! = apiUrl + "bookmark/save_bookmark"
    private static var getBookmarks                : String! = apiUrl + "bookmark/get_bookmarks"
    private static var deleteBookmark              : String! = apiUrl + "bookmark/delete_bookmark"

    private static var getAllResumes                : String! = apiUrl + "user/get_all_resumes"
    private static var deleteResume                 : String! = apiUrl + "user/delete_resume"

    private static var getStrengths                 : String! = apiUrl + "user/get_strengths"
    private static var saveStrengths                : String! = apiUrl + "user/save_strengths"

    private static var getTeamMembers               : String! = apiUrl + "user/get_team_members"
    private static var joinTeam                     : String! = apiUrl + "user/join_team"
    private static var leaveTeam                    : String! = apiUrl + "user/leave_team"

    private static var getAllNotis                  : String! = apiUrl + "alarm/get_all_notifications"
    private static var removeNoti                   : String! = apiUrl + "alarm/remove_notification"
    private static var chatNotification             : String! = apiUrl + "alarm/push_chat_notification"

    private static var uploadStory                  : String! = apiUrl + "story/upload_story"
    private static var saveStory                    : String! = apiUrl + "story/save_story"
    private static var getAllStory                  : String! = apiUrl + "story/get_all_story"
    private static var getStoriesByUser             : String! = apiUrl + "story/get_stories_user"
    private static var viewStory                    : String! = apiUrl + "story/view_story"
    private static var replyStory                   : String! = apiUrl + "story/reply_story"
    private static var getStoryViews                : String! = apiUrl + "story/get_story_views"
    private static var getStoryMsg                  : String! = apiUrl + "story/get_story_msg"
    private static var deleteStory                  : String! = apiUrl + "story/delete_story"
    private static var getStoryViewStatics          : String! = apiUrl + "story/get_view_statics"
    private static var getAudience                  : String! = apiUrl + "user/get_audience"
    private static var reportStory                  : String! = apiUrl + "story/report_story";
    
    public static func loginWithEmailAndPassword(email:String, password:String, onSuccess:@escaping ((_ user:User)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        
        let push_id = OneSignal.getPermissionSubscriptionState()?.subscriptionStatus.userId ?? ""
        let parameters = ["email" : email,
                          "password" : password,
                          "push_token" : push_id]
        let headers = ["Content-Type":"application/json"]
        Alamofire.request(loginWithEmailAndPassword, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        let token = json["token"] as! String
                        UserDefaults.standard.set(token, forKey: Constants.PUSH_TOKEN)
                        let user_dic = json["user"] as! [String:Any]
                        let user = User(dictionary: user_dic)
                        onSuccess(user)
                    } else {
                        let error = json["error"] as! String
                        onFailed(error)
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func loginWithSocial(email:String, username:String, photo_url:String, onSuccess:@escaping ((_ user:User)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let push_id = OneSignal.getPermissionSubscriptionState()?.subscriptionStatus.userId ?? ""
        let parameters = ["email" : email,
                          "username" : username,
                          "photo_url" : photo_url,
                          "push_token" : push_id]
        let headers = ["Content-Type":"application/json"]
        Alamofire.request(loginWithSocial, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        let token = json["token"] as! String
                        UserDefaults.standard.set(token, forKey: Constants.PUSH_TOKEN)
                        let user_dic = json["user"] as! [String:Any]
                        let user = User(dictionary: user_dic)
                        onSuccess(user)
                    } else {
                        let error = json["error"] as! String
                        onFailed(error)
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func signupWithEmailAndPassword(email:String, password:String, onSuccess:@escaping ((_ user:User)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let push_id = OneSignal.getPermissionSubscriptionState()?.subscriptionStatus.userId ?? ""
        let parameters = ["email":email,
                          "password":password,
                          "push_token" : push_id
        ]
        let headers = ["Content-Type":"application/json"]
        Alamofire.request(signupWithEmailAndPassword, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        let token = json["token"] as! String
                        UserDefaults.standard.set(token, forKey: Constants.PUSH_TOKEN)
                        let user_dic = json["user"] as! [String:Any]
                        let user = User(dictionary: user_dic)
                        onSuccess(user)
                    } else {
                        let error = json["error"] as! String
                        onFailed(error)
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func forgotPassword(email:String, onSuccess:@escaping ((_ result:Bool)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let parameters = ["email":email]
        let headers = ["Content-Type":"application/json"]
        Alamofire.request(forgotPassword, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        onSuccess(true)
                    } else {
                        onFailed("Something went wrong")
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func resetPassword(email:String, password:String, onSuccess:@escaping ((_ result:Bool)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {        
        let parameters = ["email":email,
                          "password":password]
        let headers = ["Content-Type":"application/json"]
        Alamofire.request(resetPassword, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        onSuccess(true)
                    } else {
                        onFailed("Something went wrong")
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func changePassword(password: String, onSuccess:@escaping ((_ result:Bool)->(Void)), onFailed : @escaping ((_ error:String)->(Void))){
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let parameters = ["password":password]
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(changePassword, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        onSuccess(true)
                    } else {
                        onFailed("Something went wrong")
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func getUserByEmail(email:String, onSuccess:@escaping ((_ user:User)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        
        let parameters = ["email":email]
        let headers = ["Content-Type":"application/json"]
        Alamofire.request(getUserByEmail, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        let user_dic = json["user"] as! [String:Any]
                        let user = User(dictionary: user_dic)
                        onSuccess(user)
                    } else {
                        let error = json["error"] as! String
                        onFailed(error)
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func getUserByName(name:String, onSuccess:@escaping ((_ user:User)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        
        let parameters = ["name":name.lowercased()]
        let headers = ["Content-Type":"application/json"]
        Alamofire.request(getUserByName, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        let user_dic = json["user"] as! [String:Any]
                        let user = User(dictionary: user_dic)
                        onSuccess(user)
                    } else {
                        let error = json["error"] as! String
                        onFailed(error)
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func getUserByFilter(sport:Int, gender: Int, type:Int, name:String, city:String, country: String, age:Int, height:Int, weight:Int, onSuccess:@escaping ((_ user:[User])->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let parameters = ["sport_id":String(sport),
                          "group_id":String(type),
                          "gender_id": String(gender),
                          "name":name,
                          "city":city,
                          "country": country,
                          "age":String(age),
                          "height":String(height),
                          "weight":String(weight)]
        let headers = ["Authorization" : "Bearer " + sToken,
                      "Content-Type" : "application/json"]
        Alamofire.request(filterUser, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    var result:[User] = []
                    let count = json["count"] as! Int
                    let users = json["users"] as! [[String:Any]]
                    if count > 0 {
                        for index in 0...count-1 {
                            let user_dic = users[index]
                            let user = User(dictionary: user_dic)
                            result.append(user)
                        }
                        result.reverse()
                    }
                    onSuccess(result)
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func getTaggedUsers(tagged:String, onSuccess:@escaping ((_ user:[User])->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let parameters = ["tagged": tagged]
        let headers = ["Authorization" : "Bearer " + sToken,
                      "Content-Type" : "application/json"]
        Alamofire.request(getTaggedUsers, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    var result:[User] = []
                    let users = json["users"] as! [[String:Any]]
                    let count = users.count
                    if count > 0 {
                        for index in 0...count-1 {
                            let user_dic = users[index]
                            let user = User(dictionary: user_dic)
                            result.append(user)
                        }
                        result.reverse()
                    }
                    onSuccess(result)
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func getAllUsers( onSuccess:@escaping ((_ user:[User])->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(getAllUsers, method: HTTPMethod.post, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    var result:[User] = []
                    let count = json["count"] as! Int
                    let users = json["users"] as! [[String:Any]]
                    if count > 0 {
                        for index in 0...count-1 {
                            let user_dic = users[index]
                            let user = User(dictionary: user_dic)
                            result.append(user)
                        }
                        result.reverse()
                    }
                    onSuccess(result)
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func searchUsers(keyword : String, onSuccess:@escaping ((_ user:[User])->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let parameters = ["name" : keyword]
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(searchUsers, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    var result:[User] = []
                    let count = json["count"] as! Int
                    let users = json["users"] as! [[String:Any]]
                    if count > 0 {
                        for index in 0...count-1 {
                            let user_dic = users[index]
                            let user = User(dictionary: user_dic)
                            result.insert(user, at: 0)
                        }
                        result.reverse()
                    }
                    onSuccess(result)
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func getFollowing(onSuccess:@escaping ((_ user:[User])->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(getFollowing, method: HTTPMethod.post, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    var result:[User] = []
                    let count = json["count"] as! Int
                    let users = json["followings"] as! [[String:Any]]
                    if count > 0 {
                        for index in 0...count-1 {
                            let user_dic = users[index]
                            let user = User(dictionary: user_dic)
                            result.append(user)
                        }
                        result.reverse()
                    }
                    onSuccess(result)
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func getBlocks(onSuccess:@escaping ((_ user:[User])->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(getBlocks, method: HTTPMethod.post, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    var result:[User] = []
                    let count = json["count"] as! Int
                    let users = json["blocks"] as! [[String:Any]]
                    if count > 0 {
                        for index in 0...count-1 {
                            let user_dic = users[index]
                            let user = User(dictionary: user_dic)
                            result.append(user)
                        }
                        result.reverse()
                    }
                    onSuccess(result)
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func getFollower(onSuccess:@escaping ((_ user:[User])->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(getFollower, method: HTTPMethod.post, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    var result:[User] = []
                    let count = json["count"] as! Int
                    let users = json["followers"] as! [[String:Any]]
                    if count > 0 {
                        for index in 0...count-1 {
                            let user_dic = users[index]
                            let user = User(dictionary: user_dic)
                            result.append(user)
                        }
                        result.reverse()
                    }
                    onSuccess(result)
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func updateUser(user:User, onSuccess:@escaping ((_ user:User)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let parameters = user.dictionary
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(updateUser, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        let user_dic = json["user"] as! [String:Any]
                        let user = User(dictionary: user_dic)
                        onSuccess(user)
                    } else {
                        let error = json["error"] as! String
                        onFailed(error)
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func updateUserFields(fieldname: String, fieldvalue: String, onSuccess:@escaping ((_ user:User)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let parameters = ["key":fieldname, "value" : fieldvalue]
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(updateUserField, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        let user_dic = json["user"] as! [String:Any]
                        let user = User(dictionary: user_dic)
                        onSuccess(user)
                    } else {
                        let error = json["error"] as! String
                        onFailed(error)
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func searchVideoFeeds(keyword: String, onSuccess:@escaping ((_ feeds:[Feed])->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        let parameters = ["name" : keyword.lowercased()]
        Alamofire.request(searchVideoFeeds, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    var result: [Feed] = []
                    let count = json["count"] as! Int
                    let feeds = json["feeds"] as! [[String:Any]]
                    if count > 0 {
                        for index in 0...count-1 {
                            let feed_dic = feeds[index]
                            let feed = Feed(dictionary: feed_dic)
                            result.append(feed)
                        }
                    }
                    onSuccess(result)
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func getSportsFeed(
        page: Int,
        sport: String,
        user_id: String,
        onSuccess:@escaping ((_ feeds:[Feed])->(Void)),
        onFailed : @escaping ((_ error:String)->(Void))) {
        
        let parameters = ["page":"\(page)", "sport_id":sport]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(getSportsFeeds, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                if let json = response.result.value as? [String:Any] {
                    var result: [Feed] = []
                    let count = json["count"] as! Int
                    let data = json["feeds"] as! [String:Any]
                    let feeds = data["data"] as! [[String:Any]]
                    if count > 0 {
                        for index in 0...count-1 {
                            let feed_dic = feeds[index]
                            let feed = Feed(dictionary: feed_dic)
                            result.append(feed)
                        }
                    }
                    onSuccess(result)
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func getMyFeeds(
        page: Int,
        sport: String,
        onSuccess:@escaping ((_ feeds:[Feed])->(Void)),
        onFailed : @escaping ((_ error:String)->(Void))) {
        
        let parameters = ["page":"\(page)", "sport_id":sport]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(getMyFeeds, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                if let json = response.result.value as? [String:Any] {
                    var result: [Feed] = []
                    let count = json["count"] as! Int
                    let data = json["feeds"] as! [String:Any]
                    let feeds = data["data"] as! [[String:Any]]
                    if count > 0 {
                        for index in 0...count-1 {
                            let feed_dic = feeds[index]
                            let feed = Feed(dictionary: feed_dic)
                            result.append(feed)
                        }
                    }
                    onSuccess(result)
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
//    public static func getAllFeeds(page: Int,
//        u_id: String,
//        onSuccess:@escaping ((_ feeds:[Feed])->(Void)),
//        onFailed : @escaping ((_ error:String)->(Void))) {
//
//        let parameters = ["page":"\(page)", "u_id":u_id]
//        let headers = ["Content-Type":"application/json"]
//        Alamofire.request(getAllFeeds, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
//            .responseJSON { (response) in
//
//                if let json = response.result.value as? [String:Any] {
//                    var result: [Feed] = []
//                    let count = json["count"] as! Int
//                    let feeds = json["feeds"] as! [[String:Any]]
//                    if count > 0 {
//                        for index in 0...count-1 {
//                            let feed_dic = feeds[index]
//                            let feed = Feed(dictionary: feed_dic)
//                            result.append(feed)
//                        }
//                    }
//                    onSuccess(result)
//                } else {
//                    onFailed("Connection error")
//                }
//        }
//    }
    
    public static func getAllFeedsByUserid(page: Int, user_id:String, onSuccess:@escaping ((_ feeds:[Feed])->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let parameters = ["user_id":user_id, "page":String(page)]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(getAllFeedsByUserid, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                if let json = response.result.value as? [String:Any] {
                    var result: [Feed] = []
                    let count = json["count"] as! Int
                    let data = json["feeds"] as! [String:Any]
                    let feeds = data["data"] as! [[String:Any]]
                    if count > 0 {
                        for index in 0...count-1 {
                            let feed_dic = feeds[index]
                            let feed = Feed(dictionary: feed_dic)
                            result.append(feed)
                        }
                    }
                    onSuccess(result)
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func recommendUser(uid:String, onSuccess:@escaping ((_ result:Int)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        
        let parameters = ["user_id":uid]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(recommendUser, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        onSuccess(json["count"] as! Int)
                    } else {
                        let error = json["error"] as! String
                        onFailed(error)
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func deleteFeed(feed_id:String, onSuccess:@escaping ((_ result:Bool)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        
        let parameters = ["feed_id":feed_id]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(deleteFeed, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        onSuccess(true)
                    } else {
                        let error = json["error"] as! String
                        onFailed(error)
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func addLikeFeed(feed:Feed, user:User, onSuccess:@escaping ((_ result:Bool)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let parameters = ["feed_id":feed.id]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(addLikeFeed, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        onSuccess(json["result"] as! Bool)
                    } else {
                        let error = json["error"] as! String
                        onFailed(error)
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func privateFeed(feed_id: String, flag: Bool, onSuccess:@escaping ((_ result:Bool)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        var val = Constants.FEED_PRIVATE
        if !flag {
            val = Constants.FEED_PUBLIC
        }
        let parameters = ["feed_id":feed_id, "val" : "\(val)"]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(addLikeFeed, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        onSuccess(true)
                    } else {
                        let error = json["error"] as! String
                        onFailed(error)
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func reportUser(uid: String, content: String, onSuccess:@escaping ((_ result:Bool)->(Void)), onFailed : @escaping ((_ error:String)->(Void)))  {
        
        let parameters = ["user_id":uid, "report" : content]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(reportUser, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        onSuccess(true)
                    } else {
                        let error = json["error"] as! String
                        onFailed(error)
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func reportFeed(fid: String, content: String, onSuccess:@escaping ((_ result:Bool)->(Void)), onFailed : @escaping ((_ error:String)->(Void)))  {
        
        let parameters = ["feed_id":fid, "report" : content]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(reportFeed, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        onSuccess(true)
                    } else {
                        let error = json["error"] as! String
                        onFailed(error)
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func uploadFile(name:String, video:Data, thumbnail:Data, onSuccess:@escaping ((_ video_url:String, _ thumbnail_url:String)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let parameters = ["name":name]
        let headers = ["Content-type": "multipart/form-data"]
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(video,
                                     withName: "video",
                                     fileName: "video.mp4",
                                     mimeType: "video/mp4")
            multipartFormData.append(thumbnail,
                                     withName: "thumbnail",
                                     fileName: "image.png",
                                     mimeType: "image/png")
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key as String)
            }
        }, usingThreshold: UInt64.init(), to: uploadFile, method: .post, headers: headers, encodingCompletion: { result in
            switch result{
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    print(progress)
                })
                
                upload.responseJSON { response in
                    if let json = response.result.value as? [String:Any] {
                        let status = json["status"] as! Bool
                        if status == true {
                            onSuccess(json["video_url"] as! String, json["thumbnail_url"] as! String)
                        } else {
                            onFailed(json["error"] as! String)
                        }
                    } else {
                        onFailed("Connection error")
                    }
                }
            case .failure(let error):
                onFailed(error as! String)
            }
        })
    }
    
    public static func uploadFile(name:String, video:Data, onSuccess:@escaping ((_ video_url:String)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let parameters = ["name":name]
        let headers = ["Content-type": "multipart/form-data"]
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(video,
                                     withName: "video",
                                     fileName: "video.mp4",
                                     mimeType: "video/mp4")
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: .utf8)!, withName: key as String)
            }
        }, usingThreshold: UInt64.init(), to: uploadFile, method: .post, headers: headers, encodingCompletion: { result in
            switch result{
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    print(progress)
                })

                upload.responseJSON { response in
                    if let json = response.result.value as? [String:Any] {
                        let status = json["status"] as! Bool
                        if status == true {
                            onSuccess(json["video_url"] as! String)
                        } else {
                            onFailed(json["error"] as! String)
                        }
                    } else {
                        onFailed("Connection error")
                    }
                }
            case .failure(let error):
                onFailed(error as! String)
            }
        })
    }
    
    public static func uploadArticles(name:String, images:[Data], onSuccess:@escaping ((_ image_url:String)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let parameters = ["name":name]
        let headers = ["Content-type": "multipart/form-data"]
        Alamofire.upload(multipartFormData: { multipartFormData in
            var i : Int = 0
            for image in images {
                multipartFormData.append(image,
                    withName: "image\(i)",
                    fileName: "image\(i).png",
                    mimeType: "image/png")
                i += 1
            }
            
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: .utf8)!, withName: key as String)
            }
        }, usingThreshold: UInt64.init(), to: uploadArticles, method: .post, headers: headers, encodingCompletion: { result in
            switch result{
            case .success(let upload, _, _):

                upload.uploadProgress(closure: { (progress) in
                    print(progress)
                })
                upload.responseJSON { response in
                    if let json = response.result.value as? [String:Any] {
                        let status = json["status"] as! Bool
                        if status == true {
                            onSuccess(json["paths"] as! String)
                        } else {
                            onFailed(json["error"] as! String)
                        }
                    } else {
                        onFailed("Connection error")
                    }
                }
            case .failure(let error):
                onFailed(error as! String)
            }
        })
    }
    
    public static func uploadImage(name:String, image:Data, onSuccess:@escaping ((_ image_url:String)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
//        let parameters = ["name":name]
        let headers = ["Content-type": "multipart/form-data"]
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(image,
                                     withName: "image",
                                     fileName: "image.png",
                                     mimeType: "image/png")
//            for (key, value) in parameters {
//                multipartFormData.append(value.data(using: .utf8)!, withName: key as String)
//            }
            multipartFormData.append(name.data(using: .utf8)!, withName: "name")
        }, usingThreshold: UInt64.init(), to: uploadImage, method: .post, headers: headers, encodingCompletion: { result in
            switch result{
            case .success(let upload, _, _):

                upload.uploadProgress(closure: { (progress) in
                    print(progress)
                })
                upload.responseJSON { response in
                    if let json = response.result.value as? [String:Any] {
                        let status = json["status"] as! Bool
                        if status == true {
                            onSuccess(json["image_url"] as! String)
                        } else {
                            onFailed(json["error"] as! String)
                        }
                    } else {
                        onFailed("Connection error")
                    }
                }
            case .failure(let error):
                onFailed(error as! String)
            }
        })
    }
    
    public static func uploadResume(name:String, pdf_file:Data, onSuccess:@escaping ((_ pdf_url:String)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-type": "multipart/form-data"]
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(pdf_file,
                                     withName: "pdf",
                                     fileName: name,
                                     mimeType: "application/pdf")
            multipartFormData.append(name.data(using: .utf8)!, withName: "name")
        }, usingThreshold: UInt64.init(), to: uploadResume, method: .post, headers: headers, encodingCompletion: { result in
            switch result{
            case .success(let upload, _, _):

                upload.uploadProgress(closure: { (progress) in
                    print(progress)
                })

                upload.responseJSON { response in
                    if let json = response.result.value as? [String:Any] {
                        let status = json["status"] as! Bool
                        if status == true {
                            onSuccess(json["resume_url"] as! String)
                        } else {
                            onFailed(json["error"] as! String)
                        }
                    } else {
                        onFailed("Connection error")
                    }
                }
            case .failure(let error):
                onFailed(error as! String)
            }
        })
    }
    
    public static func saveFeed(feed:Feed, onSuccess:@escaping ((_ feed:Feed)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let parameters = feed.dictionary
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(saveFeed, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        let feed_dic = json["feed"] as! [String:Any]
                        let feed = Feed(dictionary: feed_dic)
                        onSuccess(feed)
                    } else {
                        let error = json["error"] as! String
                        onFailed(error)
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func addViewFeed(feed:Feed, onSuccess:@escaping ((_ feed:Feed)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let parameters = feed.dictionary
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(addViewFeed, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        let feed_dic = json["feed"] as! [String:Any]
                        let feed = Feed(dictionary: feed_dic)
                        onSuccess(feed)
                    } else {
                        let error = json["error"] as! String
                        onFailed(error)
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func getYearResultSummary(user:User, year:Int, onSuccess:@escaping ((_ result:[[(String, Int)]])->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        
        let parameters = ["user_id":user.id, "sport_id":String(user.sport), "year":String(year)]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(getYearResultSummary, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    var result: [[(String, Int)]] = []
                    if status == true {
                        let summary = json["result"] as! [Any]
                        for one in summary {
                            var item: [(String, Int)] = []
                            if let dict = one as? Dictionary<String, Any> {
                                for (key, value) in dict {
                                    item.append((key, Utils.AnyToInt(value: value)))
                                }
                            }
                            result.append(item)
                        }
                    }
                    onSuccess(result)
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func getSportResultSummary(user:User, onSuccess:@escaping ((_ result:[(String, Int)])->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let parameters = ["user_id":user.id, "sport_id":String(user.sport)]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(getSportResultSummary, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    var result: [(String, Int)] = []
                    if status == true {
                        if let summary = json["result"] as? [String:Any] {
                            for (key, value) in summary {
                                result.append((key , Utils.AnyToInt(value: value)))
                            }
                        }
                        
                    }
                    onSuccess(result)
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func getUserResultSummary(user:User, onSuccess:@escaping ((_ result:[(String, [(String, Int)], [(String, [String])])])->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let parameters = ["user_id":user.id, "club":user.club]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(getUserResultSummary, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    var result: [(String, [(String, Int)], [(String, [String])])] = []
                    if status == true {
                        let clubs = json["result"] as! [Any]
                        for obj in clubs {
                            if let dict = obj as? Dictionary<String, Any> {
                                for (key, value) in dict {
                                    var one: [(String, Int)] = []
                                    let data = value as! [String: Any]
                                    let skills = data["data"] as! [String : Any]
                                    for (kkey, kvalue) in skills {
                                        one.append((kkey , Utils.AnyToInt(value:kvalue)))
                                    }
                                    let years = data["years"] as! [Any]
                                    var two : [(String, [String])] = []
                                    for yobj in years {
                                        if let ydict = yobj as? Dictionary<String, Any> {
                                            for (ykey, yvalue) in ydict {
                                                let months = yvalue as! [Int]
                                                var month_vals : [String] = []
                                                for m_val in months {
                                                    month_vals.append("\(m_val)")
                                                }
                                                two.append((ykey, month_vals))
                                            }
                                        }
                                        
                                    }
                                    result.append((key, one, two))
                                }
                            }
                        }
                    }
                    onSuccess(result)
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func getClubYearSummary(user:User, onSuccess:@escaping ((_ result:[(String, [(String, Int)], [(String, [String])])])->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let parameters = ["user_id":user.id]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(getClubYearSummary, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    var result: [(String, [(String, Int)], [(String, [String])])] = []
                    if status == true {
                        let clubs = json["result"] as! [Any]
                        for obj in clubs {
                            if let dict = obj as? Dictionary<String, Any> {
                                for (key, value) in dict {
                                    var one: [(String, Int)] = []
                                    let data = value as! [String: Any]
                                    let skills = data["data"] as! [String : Any]
                                    for (kkey, kvalue) in skills {
                                        one.append((kkey , Utils.AnyToInt(value:kvalue)))
                                    }
                                    let years = data["years"] as! [Any]
                                    var two : [(String, [String])] = []
                                    for yobj in years {
                                        if let ydict = yobj as? Dictionary<String, Any> {
                                            for (ykey, yvalue) in ydict {
                                                let months = yvalue as! [Int]
                                                var month_vals : [String] = []
                                                for m_val in months {
                                                    month_vals.append("\(m_val)")
                                                }
                                                two.append((ykey, month_vals))
                                            }
                                        }
                                        
                                    }
                                    result.append((key, one, two))
                                }
                            }
                        }
                        
                    }
                    onSuccess(result)
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func getClubMonthResultSummary(user:User, club:String, year:Int, month:Int, onSuccess:@escaping ((_ result: [(String, Int)])->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let parameters = ["user_id":user.id, "sport_id":String(user.sport), "club":club, "year":String(year), "month":String(month)]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(getClubMonthResultSummary, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    var result: [(String, Int)] = []
                    if status == true {
                        if let dict = json["result"] as? Dictionary<String, Any> {
                            for (key, value) in dict {
                                result.append((key, Utils.AnyToInt(value: value)))
                            }
                        }
                    }
                    onSuccess(result)
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func getClubSummary(user_id:String, onSuccess:@escaping ((_ result:[(String,[[(String, Int)]])])->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        
        let parameters = ["user_id":user_id]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(getClubSummary, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    var result: [(String,[[(String, Int)]])] = []
                    let results = json["result"] as! [String:Any]
                    for (key, value) in results {
                        var one : [[(String , Int)]] = []
                        let data = value as! [Any]
                        for kvalue in data {
                            var two : [(String, Int)] = []
                            if let dict = kvalue as? Dictionary<String, Any> {
                                for (kkey, kkvalue) in dict {
                                    two.append((kkey, Utils.AnyToInt(value: kkvalue)))
                                }
                            }
                            one.append(two)
                        }
                        result.append((key, one))
                    }
                    onSuccess(result)
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func getSummaryByClub(user_id:String, onSuccess:@escaping ((_ result:[(String,[[(String, Int)]], [(String, [(String, Int)])])])->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        
        let parameters = ["user_id":user_id]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(getSummaryByClub, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    var result: [(String,[[(String, Int)]],[(String, [(String, Int)])])] = []
                    let clubs = json["result"] as! [[String: Any]]
                    for obj in clubs {
                        let club_name = obj["name"] as! String
                        var club_summary: [[(String, Int)]] = []
                        let summary = obj["data"] as! [Any]
                        for s_obj in summary {
                            var one: [(String, Int)] = []
                            if let dict = s_obj as? Dictionary<String, Any> {
                                for (key, value) in dict {
                                    one.append((key , Utils.AnyToInt(value:value)))
                                }
                            }
                            club_summary.append(one)
                        }
                        
                        var years_stats:[(String, [(String, Int)])] = []
                        let years_array = obj["years"] as! [[String:Any]]
                        for one_data in years_array {
                            var one : [(String , Int)] = []
                            let one_name = one_data["name"] as! Int
                            let one_stat = one_data["value"] as! [String:Any]
                            for (kkey, kkvalue) in one_stat {
                                one.append((kkey, Utils.AnyToInt(value: kkvalue)))
                            }
                            years_stats.append(("\(one_name)", one))
                        }
                        result.append((club_name, club_summary, years_stats))
                    }
                    onSuccess(result)
                } else {
                    onFailed("Connection error")
                }
        }
    }
        
    public static func saveResult(result:Result, onSuccess:@escaping ((_ result:Result)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let parameters = result.dictionary
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(saveResult, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        let result_dic = json["result"] as! [String:Any]
                        let result = Result(dictionary: result_dic)
                        onSuccess(result)
                    } else {
                        let error = json["error"] as! String
                        onFailed(error)
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func deleteUserClubSummary(user_id: String, club: String, onSuccess:@escaping ((_ result:Bool)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let parameters = ["user_id":user_id, "club": club]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(deleteUserClubSummary, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        onSuccess(true)
                    } else {
                        let error = json["error"] as! String
                        onFailed(error)
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func deleteClubYearSummary(user_id: String!, club: String, onSuccess:@escaping ((_ result:Bool)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let sub_str = club.components(separatedBy: "-")
        let parameters = ["user_id":user_id, "club": sub_str[1], "year": sub_str[0]]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(deleteClubYearSummary, method: HTTPMethod.post, parameters: parameters as Parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        onSuccess(true)
                    } else {
                        let error = json["error"] as! String
                        onFailed(error)
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func adjustStatValue(result:Result, onSuccess:@escaping ((_ result:Bool)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let parameters = result.dictionary
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(adjustStatValue, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        onSuccess(true)
                    } else {
                        let error = json["error"] as! String
                        onFailed(error)
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func getAllAdmobs(onSuccess:@escaping ((_ feeds:[Admob])->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(getAllAdmobs, method: HTTPMethod.post, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    var result: [Admob] = []
                    let count = json["count"] as! Int
                    let admobs = json["admobs"] as! [[String:Any]]
                    if count > 0 {
                        for index in 0...count-1 {
                            let admob_dic = admobs[index]
                            let admob = Admob(dictionary: admob_dic)
                            result.append(admob)
                        }
                        result.reverse()
                    }
                    onSuccess(result)
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func filterAdmobs(sport:Int, city: String, country: String, onSuccess:@escaping ((_ feeds:[Admob])->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let parameters = ["sport_id":"\(sport)", "city": city, "country": country]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(filterAdmobs, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    var result: [Admob] = []
                    let count = json["count"] as! Int
                    let admobs = json["admobs"] as! [[String:Any]]
                    if count > 0 {
                        for index in 0...count-1 {
                            let admob_dic = admobs[index]
                            let admob = Admob(dictionary: admob_dic)
                            result.append(admob)
                        }
                        result.reverse()
                    }
                    
                    onSuccess(result)
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func saveAdmob(admob:Admob, onSuccess:@escaping ((_ admob:Admob)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        
        let parameters = admob.dictionary
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(saveAdmob, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        let admob_dic = json["admob"] as! [String:Any]
                        let admob = Admob(dictionary: admob_dic)
                        onSuccess(admob)
                    } else {
                        let error = json["error"] as! String
                        onFailed(error)
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func deleteAdvert(ad_id: String, onSuccess:@escaping ((_ result:Bool)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        
        let parameters = ["admob_id": ad_id]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(deleteAdmob, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        onSuccess(true)
                    } else {
                        onSuccess(false)
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func getAllPrizeByUserid(user_id:String, onSuccess:@escaping ((_ prizes:[Prize])->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let parameters = ["user_id":user_id]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(getAllPrizesByUserid, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                if let json = response.result.value as? [String:Any] {
                    var result: [Prize] = []
                    let count = json["count"] as! Int
                    let prizes = json["prizes"] as! [[String:Any]]
                    if count > 0 {
                        for index in 0...count-1 {
                            let prize_dic = prizes[index]
                            let prize = Prize(dictionary: prize_dic)
                            result.append(prize)
                        }
                    }
                    result.reverse()
                    onSuccess(result)
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func updatePrize(prize:Prize, onSuccess:@escaping ((_ prize:Prize)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        
        let parameters = prize.dictionary
        let headers = ["Content-Type":"application/json"]
        Alamofire.request(updatePrize, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        let prize_dic = json["prize"] as! [String:Any]
                        let prize = Prize(dictionary: prize_dic)
                        onSuccess(prize)
                    } else {
                        let error = json["error"] as! String
                        onFailed(error)
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func savePrize(prize:Prize, onSuccess:@escaping ((_ prize:Prize)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        
        let parameters = prize.dictionary
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(savePrize, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        let prize_dic = json["prize"] as! [String:Any]
                        let prize = Prize(dictionary: prize_dic)
                        onSuccess(prize)
                    } else {
                        let error = json["error"] as! String
                        onFailed(error)
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func deletePrize(prize:Prize, onSuccess:@escaping ((_ result:Bool)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        
        let parameters = ["prize_id":prize.id]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(deletePrize, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        onSuccess(true)
                    } else {
                        let error = json["error"] as! String
                        onFailed(error)
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    
    public static func getAllCareerByUserid(user_id:String, onSuccess:@escaping ((_ careers:[Career])->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let parameters = ["user_id":user_id]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(getAllCareersByUserid, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                if let json = response.result.value as? [String:Any] {
                    var result: [Career] = []
                    let count = json["count"] as! Int
                    let careers = json["careers"] as! [[String:Any]]
                    if count > 0 {
                        for index in 0...count-1 {
                            let career_dic = careers[index]
                            let career = Career(dictionary: career_dic)
                            result.append(career)
                        }
                        result.reverse()
                    }
                    onSuccess(result)
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func updateCareer(career:Career, onSuccess:@escaping ((_ career:Career)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        
        let parameters = career.dictionary
        let headers = ["Content-Type":"application/json"]
        Alamofire.request(updateCareer, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        let career_dic = json["career"] as! [String:Any]
                        let career = Career(dictionary: career_dic)
                        onSuccess(career)
                    } else {
                        let error = json["error"] as! String
                        onFailed(error)
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func saveCareer(career:Career, onSuccess:@escaping ((_ career:Career)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        
        let parameters = career.dictionary
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(saveCareer, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        let career_dic = json["career"] as! [String:Any]
                        let career = Career(dictionary: career_dic)
                        onSuccess(career)
                    } else {
                        let error = json["error"] as! String
                        onFailed(error)
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func deleteCareer(career_id:String, onSuccess:@escaping ((_ response:Bool)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let parameters = ["career_id":career_id]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(deleteCareer, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        onSuccess(true)
                    } else {
                        let error = json["error"] as! String
                        onFailed(error)
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func getAllDescriptionsByUserid(user_id:String, onSuccess:@escaping ((_ careers:[Description])->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let parameters = ["user_id":user_id]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(getAllDescriptionsByUserid, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                if let json = response.result.value as? [String:Any] {
                    var result: [Description] = []
                    let count = json["count"] as! Int
                    let descriptions = json["descriptions"] as! [[String:Any]]
                    if count > 0 {
                        for index in 0...count-1 {
                            let description_dic = descriptions[index]
                            let description = Description(dictionary: description_dic)
                            result.append(description)
                        }
                        result.reverse()
                    }
                    onSuccess(result)
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func updateDescription(description:Description, onSuccess:@escaping ((_ description:Description)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        
        let parameters = description.dictionary
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(updateDescription, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        let description_dic = json["description"] as! [String:Any]
                        let description = Description(dictionary: description_dic)
                        onSuccess(description)
                    } else {
                        let error = json["error"] as! String
                        onFailed(error)
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func checkFollow(user_id:String, onSuccess:@escaping ((_ result:Bool)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let parameters = ["user_id":user_id]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(checkFollow, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        let result = json["result"] as! Bool
                        if result == true {
                            onSuccess(true)
                        } else {
                            onSuccess(false)
                        }
                    } else {
                        let error = json["error"] as! String
                        onFailed(error)
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func addFollow(user_id:String, onSuccess:@escaping ((_ result:Bool)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let parameters = ["user_id":user_id]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(addFollow, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        onSuccess(true)
                    } else {
                        let error = json["error"] as! String
                        onFailed(error)
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func addBlock(blocked_user_id:String, onSuccess:@escaping ((_ result:Bool)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let parameters = ["blocked_user_id":blocked_user_id]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(addBlock, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        onSuccess(true)
                    } else {
                        let error = json["error"] as! String
                        onFailed(error)
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func deleteFollow(user_id:String, onSuccess:@escaping ((_ result:Bool)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let parameters = ["user_id":user_id]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(deleteFollow, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        onSuccess(true)
                    } else {
                        let error = json["error"] as! String
                        onFailed(error)
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func deleteBlock(blocked_user_id:String, onSuccess:@escaping ((_ result:Bool)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        
        let parameters = ["blocked_user_id":blocked_user_id]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(deleteBlock, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        onSuccess(true)
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func saveBookmark(feed_id:String, onSuccess:@escaping ((_ result:Bool)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let parameters = ["feed_id":feed_id]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(saveBookmark, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        onSuccess(true)
                    } else {
                        onSuccess(false)
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func getBookmarks(user_id:String, onSuccess:@escaping ((_ feeds:[Feed])->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(getBookmarks, method: HTTPMethod.post, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    var result: [Feed] = []
                    let count = json["count"] as! Int
                    let feeds = json["bookmarks"] as! [[String:Any]]
                    if count > 0 {
                        for index in 0...count-1 {
                            let feed_dic = feeds[index]
                            let feed = Feed(dictionary: feed_dic)
                            result.append(feed)
                        }
//                        result.reverse()
                    }
                    onSuccess(result)
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func getAllResumes(user_id:String, onSuccess:@escaping ((_ resumes:[Resume])->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let parameters = ["user_id":user_id]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(getAllResumes, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    var result: [Resume] = []
                    let count = json["count"] as! Int
                    let resumes = json["resumes"] as! [[String:Any]]
                    if count > 0 {
                        for index in 0...count-1 {
                            let resume_dic = resumes[index]
                            let feed = Resume(dictionary: resume_dic)
                            result.append(feed)
                        }
                        result.reverse()
                    }
                    onSuccess(result)
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func deleteResume(r_id:String, onSuccess:@escaping ((_ result:Bool)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let parameters = ["id":r_id]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(deleteResume, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        onSuccess(true)
                    } else {
                        onFailed("Unknown error")
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func getStrengths(uid:String, onSuccess:@escaping ((_ result:[String])->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let parameters = ["uid":uid]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(getStrengths, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        var result : [String] = []
                        let strengths = json["strength"] as! String
                        if strengths.count > 0 {
                            result = strengths.components(separatedBy: ",")
                        }
                        onSuccess(result)
                    } else {
                        onFailed("Unknown error")
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func saveStrengths(data:String, onSuccess:@escaping ((_ result:Bool)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let parameters = ["strength":data]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(saveStrengths, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        onSuccess(true)
                    } else {
                        onFailed("Unknown error")
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func joinTeam(team_id:String, user_id: String, onSuccess:@escaping ((_ result:Bool)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let parameters = ["team_id":team_id, "user_id": user_id]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(joinTeam, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        onSuccess(true)
                    } else {
                        onFailed("Failed join")
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func leaveTeam(team_id:String, user_id: String, onSuccess:@escaping ((_ result:Bool)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let parameters = ["team_id":team_id, "user_id": user_id]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(leaveTeam, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        onSuccess(true)
                    } else {
                        onFailed("Failed leave")
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func getTeamMembers(team_id:String, onSuccess:@escaping ((_ result:[User])->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let parameters = ["team_id":team_id]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(getTeamMembers, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        var result: [User] = []
                        let team = json["team"] as! [[String:Any]]
                        if team.count > 0 {
                            for index in 0...team.count-1 {
                                let user_dic = team[index]["user"] as! [String: Any]
                                let user = User(dictionary: user_dic)
                                result.append(user)
                            }
                            result.reverse()
                        }                        
                        onSuccess(result)
                    } else {
                        onFailed("Failed")
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func getAllNotifications(onSuccess:@escaping ((_ result:[Notification])->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(getAllNotis, method: HTTPMethod.post, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        var result: [Notification] = []
                        let notis = json["data"] as! [[String:Any]]
                        if notis.count > 0 {
                            for index in 0...notis.count-1 {
                                let notis_dic = notis[index]
                                let noti = Notification(dictionary: notis_dic)
                                result.append(noti)
                            }
                            result.reverse()
                        }
                        onSuccess(result)
                    } else {
                        onFailed("Failed")
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func removeNotification(noti_id: String, onSuccess:@escaping ((_ result:Bool)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let parameters = ["id":noti_id]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(removeNoti, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        onSuccess(true)
                    } else {
                        onFailed("Failed")
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func pushChatNotification(user_id: String, msg: String, onSuccess:@escaping ((_ result:Bool)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let parameters = ["user_id": user_id, "msg": msg]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(chatNotification, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        onSuccess(true)
                    } else {
                        onFailed("Failed")
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func uploadStory(name:String, image:Data, onSuccess:@escaping ((_ image_url:String)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let parameters = ["name":name]
        let headers = ["Content-type": "multipart/form-data"]
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(image,
                                     withName: "image",
                                     fileName: "image.png",
                                     mimeType: "image/png")
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
        }, usingThreshold: UInt64.init(), to: uploadStory, method: .post, headers: headers, encodingCompletion: { result in
            switch result{
            case .success(let upload, _, _):

                upload.uploadProgress(closure: { (progress) in
//                    print(progress)
                })

                upload.responseJSON { response in
                    if let json = response.result.value as? [String:Any] {
                        let status = json["status"] as! Bool
                        if status == true {
                            onSuccess(json["image_url"] as! String)
                        } else {
                            onFailed(json["error"] as! String)
                        }
                    } else {
                        onFailed("Connection error")
                    }
                }
            case .failure(let error):
                onFailed(error as! String)
            }
        })
    }
    
    public static func saveStory(story: Story, onSuccess:@escaping ((_ result:Story)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let parameters = story.dictionary
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(saveStory, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        let story_dic = json["story"] as! [String:Any]
                        let result = Story(dictionary: story_dic)
                        updateLastStory(st: result)
                        onSuccess(result)
                    } else {
                        onFailed("Failed")
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func getAllStory(onSuccess:@escaping ((_ result:Bool)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        AppData.last_stories.removeAll()
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(getAllStory, method: HTTPMethod.post, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        let stories = json["story"] as! [[String:Any]]
                        if stories.count > 0 {
                            for index in 0...stories.count-1 {
                                let story_dic = stories[index]
                                let one = Story(dictionary: story_dic)
                                updateLastStory(st: one)
                            }
                        }
                        onSuccess(true)
                    } else {
                        onFailed("Failed")
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func getStoriesByUser(uid: String, onSuccess:@escaping ((_ result:[Story])->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let parameters = ["user_id" : uid]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(getStoriesByUser, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        let story_dic = json["story"] as! [[String:Any]]
                        var result: [Story] = []
                        for st in story_dic {
                            let sst = Story(dictionary: st)
                            result.append(sst)
                        }
                        onSuccess(result)
                    } else {
                        onFailed("Failed")
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func viewStory(sid: String, onSuccess:@escaping ((_ result:Bool)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let parameters = ["story_id" : sid]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(viewStory, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        onSuccess(true)
                    } else {
                        onSuccess(false)
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func replyStory(sid: String, type: Int, msg: String, onSuccess:@escaping ((_ result:Bool)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let parameters = ["story_id" : sid, "reply_type" : "\(type)", "content" : msg]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(replyStory, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        onSuccess(true)
                    } else {
                        onSuccess(false)
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func getStoryViews(sid: String, onSuccess:@escaping ((_ result:([StoryView], Int))->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let parameters = ["story_id" : sid]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(getStoryViews, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        var views: [StoryView] = []
                        let story_views = json["storyviews"] as! [[String:Any]]
                        if story_views.count > 0{
                            for index in 0...story_views.count-1 {
                                let view_dic = story_views[index]
                                let one = StoryView(dictionary: view_dic)
                                views.append(one)
                            }
                            views.reverse()
                        }                        
                        let count = Utils.AnyToInt(value: json["view_count"])
                        onSuccess((views, count))
                    } else {
                        onSuccess(([], 0))
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func getStoryMsg(sid: String, uid: String, onSuccess:@escaping ((_ result:[StoryMsg])->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let parameters = ["story_id" : sid, "user_id" : uid]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(getStoryMsg, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        var result : [StoryMsg] = []
                        let story_msgs = json["storymsg"] as! [[String:Any]]
                        if story_msgs.count > 0 {
                            for index in 0...story_msgs.count-1 {
                                let msg_dic = story_msgs[index]
                                let one = StoryMsg(dictionary: msg_dic)
                                result.append(one)
                            }
                            result.reverse()
                        }
                        onSuccess(result)
                    } else {
                        onSuccess([])
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func deleteStory(sid: String, onSuccess:@escaping ((_ result:Bool)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let parameters = ["story_id" : sid]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(deleteStory, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        onSuccess(true)
                    } else {
                        onSuccess(false)
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func viewProfile(uid: String, onSuccess:@escaping ((_ result:Int)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let parameters = ["user_id" : uid]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(viewProfile, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        let count = json["recommend"] as! Int
                        onSuccess(count)
                    } else {
                        onSuccess(0)
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func getStoryViewStatics(basetime: Int64, onSuccess:@escaping ((_ result:ViewStatic)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let parameters = ["basetime" : "\(basetime)"]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(getStoryViewStatics, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        let st_dic = json["result"] as! [String: Any]
                        let result = ViewStatic(dictionary: st_dic)
                        onSuccess(result)
                    } else {
                        onFailed("Error")
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func getAudienceStatics(onSuccess:@escaping ((_ result:Audience)->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(getAudience, method: HTTPMethod.post, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        let st_dic = json["result"] as! [String: Any]
                        let result = Audience(dictionary: st_dic)
                        onSuccess(result)
                    } else {
                        onFailed("Error")
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func reportStory(sid: String, content: String, onSuccess:@escaping ((_ result:Bool)->(Void)), onFailed : @escaping ((_ error:String)->(Void)))  {
        
        let parameters = ["story_id":sid, "report" : content]
        let sToken = UserDefaults.standard.string(forKey: Constants.PUSH_TOKEN) ?? ""
        let headers = ["Authorization" : "Bearer " + sToken,
                       "Content-Type":"application/json"]
        Alamofire.request(reportStory, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                if let json = response.result.value as? [String:Any] {
                    let status = json["status"] as! Bool
                    if status == true {
                        onSuccess(true)
                    } else {
                        let error = json["error"] as! String
                        onFailed(error)
                    }
                } else {
                    onFailed("Connection error")
                }
        }
    }
    
    public static func getYoutubeList(key:String, onSuccess:@escaping ((_ videos:[YoutubeVideoInfo])->(Void)), onFailed : @escaping ((_ error:String)->(Void))) {
        

        let request = SearchListRequest(part: [.id, .snippet], filter: nil, channelID: nil, channelType: nil, eventType: nil, maxResults: 20, onBehalfOfContentOwner: nil, order: .relevance, pageToken: nil, publishedAfter: nil, publishedBefore: nil, searchQuery: key, regionCode: nil, safeSearch: nil, topicID: nil, resourceType: nil, videoCaption: nil, videoCategoryID: nil, videoDefinition: nil, videoDimension: nil, videoDuration: nil, videoEmbeddable: nil, videoLicense: nil, videoSyndicated: nil, videoType: nil)

        ApiSession.shared.send(request) { result in
            
            switch result {
            case .success(let response):
                print(response)
                var videos: [YoutubeVideoInfo] = []
                for item in response.items {
                    let video: YoutubeVideoInfo = YoutubeVideoInfo()
                    if item.id.videoID == nil {
                        continue
                    }
                    video.id = item.id.videoID!
                    video.title = item.snippet.title
                    video.description = item.snippet.description
                    if item.snippet.thumbnails.default.url != nil {
                        video.thumbnailUrl = item.snippet.thumbnails.high.url!
                    }
                    videos.append(video)
                }
                onSuccess(videos)
            case .failed( _):
                onFailed("Empty")
            }
        }
    }
    
    private static func updateLastStory(st: Story){
        if st.user != nil {
            if let ls_story = AppData.last_stories[st.user.sport] {
                if ls_story.timebeg < st.timebeg {
                    AppData.last_stories[st.user.sport] = st
                }
            } else {
                AppData.last_stories[st.user.sport] = st
            }
        }
    }
}
