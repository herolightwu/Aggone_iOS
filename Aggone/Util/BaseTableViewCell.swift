//
//  BaseTableViewCell.swift
//  Aggone
//
//  Created by MeiXiang Wu on 4/12/20.
//  Copyright © 2020 tiexiong. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    func getTypeName(type: Int)->String {
        switch type{
            case Constants.PLAYER:
                return getString(key:"player");
            case Constants.COACH:
                return getString(key:"coach");
            case Constants.TEAM_CLUB:
                return getString(key:"team_club");
            case Constants.AGENT:
                return getString(key:"agent");
            case Constants.STAFF:
                return getString(key:"staff");
            default:
                return getString(key:"company");
        }
    }
    
    func getString(key: String)->String {
        return NSLocalizedString(key, comment: "")
    }
}
