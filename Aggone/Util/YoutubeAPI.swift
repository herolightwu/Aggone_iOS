//
//  YoutubeAPI.swift
//  Aggone
//
//  Created by tiexiong on 5/31/18.
//  Copyright © 2018 tiexiong. All rights reserved.
//

import Foundation
import Alamofire

public class YoutubeAPI {
    static func getTopVideos(nextPageToken : String, showLoader : Bool, completion:(videosArray : Array<Dictionary<NSObject, AnyObject>>, succses : Bool, nextpageToken : String)-> Void){
      
        
        let contryCode = "GB"
        var arrVideo: Array<Dictionary<NSObject, AnyObject>> = []
        var strURL = "https://www.googleapis.com/youtube/v3/videos?part=snippet,statistics&chart=mostPopular&maxResults=50®ionCode=\(contryCode)&key=\(Constants.YOUTUBE_APIKEY)"
        
        Alamofire.request(strURL, method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { (responseData) in
            
            let isSuccess = responseData.result.isSuccess//JSON(responseData.result.isSuccess)
            
            if isSuccess {
                
                
                
                let resultsDict = responseData.result.value as! Dictionary<NSObject, AnyObject>
                
                
                
                
                
                let items: Array<Dictionary<NSObject, AnyObject>> = resultsDict["items"] as! Array<Dictionary<NSObject, AnyObject>>
                
                
                
                for i in 0..<items.count {
                    
                    
                    
                    let snippetDict = items[i]["snippet"] as! Dictionary<NSObject, AnyObject>
                    
                    if !snippetDict["title"]! .isEqualToString("Private video") && !snippetDict["title"]! .isEqualToString("Deleted video"){
                        
                        let statisticsDict = items[i]["statistics"] as! Dictionary<NSObject, AnyObject>
                        
                        
                        
                        var videoDetailsDict = Dictionary<NSObject, AnyObject>()
                        
                        videoDetailsDict["videoTitle"] = snippetDict["title"]
                        
                        videoDetailsDict["videoSubTitle"] = snippetDict["channelTitle"]
                        
                        videoDetailsDict["channelId"] = snippetDict["channelId"]
                        
                        videoDetailsDict["imageUrl"] = ((snippetDict["thumbnails"] as! Dictionary<NSObject, AnyObject>)["high"] as! Dictionary<NSObject, AnyObject>)["url"]
                        
                        videoDetailsDict["videoId"] = items[i]["id"] as! String//PVideoViewCount
                        
                        videoDetailsDict["viewCount"] = statisticsDict["viewCount"]
                        
                        arrVideo.append(videoDetailsDict)
                        
                    }
                    
                }
                
                
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    completion(videosArray: arrVideo, succses: true,nextpageToken: self.strNextPageToken)
                    
                })
                
            } else {
                
                
                
            }
            
        })
        
    }
}
