//
//  BaseViewController.swift
//  Aggone
//
//  Created by tiexiong on 3/20/19.
//  Copyright © 2019 tiexiong. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import JGProgressHUD
import FlagKit

extension UIViewController {
    func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }
    
    func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation: UIInterfaceOrientation) {
        lockOrientation(orientation)
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
    }
    
    @objc func actionBack(completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            if self.navigationController != nil {
                self.navigationController!.popViewController(animated: true)
            } else {
                self.dismiss(animated: true, completion: completion)
            }
        }
    }
    
    func getString(key: String)->String {
        return NSLocalizedString(key, comment: "")
    }
    
    func locale_en(for fullCountryName : String) -> String {
        let locales : String = ""
        for localeCode in NSLocale.isoCountryCodes {
            let identifier = NSLocale(localeIdentifier: "en_US")
            let identifier_fr = NSLocale(localeIdentifier: "fr_FR")
            let identifier_ch = NSLocale(localeIdentifier: "ch_CH")
            let identifier_es = NSLocale(localeIdentifier: "es_ES")
            let identifier_de = NSLocale(localeIdentifier: "de_DE")
            let identifier_it = NSLocale(localeIdentifier: "it_IT")
            let identifier_ja = NSLocale(localeIdentifier: "ja_JP")
            let identifier_pt = NSLocale(localeIdentifier: "pt_PT")
            let countryName = identifier.displayName(forKey: NSLocale.Key.countryCode, value: localeCode)
            let countryName_fr = identifier_fr.displayName(forKey: NSLocale.Key.countryCode, value: localeCode)
            let countryName_ch = identifier_ch.displayName(forKey: NSLocale.Key.countryCode, value: localeCode)
            let countryName_es = identifier_es.displayName(forKey: NSLocale.Key.countryCode, value: localeCode)
            let countryName_de = identifier_de.displayName(forKey: NSLocale.Key.countryCode, value: localeCode)
            let countryName_it = identifier_it.displayName(forKey: NSLocale.Key.countryCode, value: localeCode)
            let countryName_ja = identifier_ja.displayName(forKey: NSLocale.Key.countryCode, value: localeCode)
            let countryName_pt = identifier_pt.displayName(forKey: NSLocale.Key.countryCode, value: localeCode)
            if fullCountryName.lowercased() == countryName?.lowercased() ||
                fullCountryName.lowercased() == countryName_fr?.lowercased() ||
                fullCountryName.lowercased() == countryName_ch?.lowercased() ||
                fullCountryName.lowercased() == countryName_es?.lowercased() ||
                fullCountryName.lowercased() == countryName_de?.lowercased() ||
                fullCountryName.lowercased() == countryName_it?.lowercased() ||
                fullCountryName.lowercased() == countryName_ja?.lowercased() ||
                fullCountryName.lowercased() == countryName_pt?.lowercased(){
                return localeCode
            }
        }
        return locales
    }
    
    func getCountryFlag(countryCode : String) -> UIImage {
//        let bundle = FlagKit.assetBundle
//        let originalImage = UIImage(named: countryCode, in: bundle, compatibleWith: nil)
//        return originalImage!
        let flag = Flag(countryCode: countryCode)!
        let styledImage = flag.image(style: .roundedRect)
        return styledImage
    }
    
    func getCountryCircleFlag(countryCode : String) -> UIImage {
        let flag = Flag(countryCode: countryCode)!
        let styledImage = flag.image(style: .circle)
        return styledImage
    }
    
    func getAllSports()->[Sport] {
        var sports: [Sport] = []
        sports.append(Sport(id: Constants.Football, name: getString(key:  "football"), icon: UIImage(named: "icon_football")!))
        sports.append(Sport(id: Constants.Basketball, name: getString(key: "basketball"), icon: UIImage(named: "icon_basketball")!))
        sports.append(Sport(id: Constants.American_Football, name: getString(key: "american_football"), icon: UIImage(named: "icon_american_football")!))
        sports.append(Sport(id: Constants.Cricket, name: getString(key: "cricket"), icon: UIImage(named: "icon_cricket")!))
        sports.append(Sport(id: Constants.Tennis, name: getString(key: "tennis"), icon: UIImage(named: "icon_tennis")!))
        sports.append(Sport(id: Constants.Rugby, name: getString(key: "rugby"), icon: UIImage(named: "icon_rugby")!))
        sports.append(Sport(id: Constants.Golf, name: getString(key: "golf"), icon: UIImage(named: "icon_golf")!))
        sports.append(Sport(id: Constants.BaseBall, name: getString(key: "baseball"), icon: UIImage(named: "icon_baseball")!))
        sports.append(Sport(id: Constants.Ice_Hockey, name: getString(key: "ice_hockey"), icon: UIImage(named: "icon_ice_hockey")!))
        sports.append(Sport(id: Constants.Field_Hockey, name: getString(key: "field_hockey"), icon: UIImage(named: "icon_field_hockey")!))
        sports.append(Sport(id: Constants.VolleyBall, name: getString(key: "volleyball"), icon: UIImage(named: "icon_volleyball")!))
        sports.append(Sport(id: Constants.Handball, name: getString(key: "handball"), icon: UIImage(named: "icon_handball")!))
        sports.append(Sport(id: Constants.Badminton, name: getString(key: "badminton"), icon: UIImage(named: "icon_badminton")!))
        sports.append(Sport(id: Constants.Squash, name: getString(key: "squash"), icon: UIImage(named: "icon_squash")!))
        sports.append(Sport(id: Constants.TableTennis, name: getString(key: "table_tennis"), icon: UIImage(named: "icon_table_tennis")!))
        sports.append(Sport(id: Constants.Boxing, name: getString(key: "boxing"), icon: UIImage(named: "icon_boxing")!))
        sports.append(Sport(id: Constants.MartialArt, name: getString(key: "martial_art"), icon: UIImage(named: "icon_material_art")!))
        sports.append(Sport(id: Constants.MMA, name: getString(key: "mma"), icon: UIImage(named: "icon_mma")!))
        sports.append(Sport(id: Constants.KickBoxing, name: getString(key: "kick_boxing"), icon: UIImage(named: "icon_kick_boxing")!))
        sports.append(Sport(id: Constants.Wrestling, name: getString(key: "wrestling"), icon: UIImage(named: "icon_wrestling")!))
        sports.append(Sport(id: Constants.Gymnastic, name: getString(key: "gymnastic"), icon: UIImage(named: "icon_gymnastic")!))
        sports.append(Sport(id: Constants.Athletics, name: getString(key: "athletics"), icon: UIImage(named: "icon_athletics")!))
        sports.append(Sport(id: Constants.Fencing, name: getString(key: "fencing"), icon: UIImage(named: "icon_fencing")!))
        sports.append(Sport(id: Constants.Judo, name: getString(key: "judo"), icon: UIImage(named: "icon_judo")!))
        sports.append(Sport(id: Constants.Swimming, name: getString(key: "swimming"), icon: UIImage(named: "icon_swimming")!))
        sports.append(Sport(id: Constants.WaterSports, name: getString(key: "water_sports"), icon: UIImage(named: "icon_water_sports")!))
        sports.append(Sport(id: Constants.WaterPolo, name: getString(key: "water_polo"), icon: UIImage(named: "icon_water_polo")!))
        sports.append(Sport(id: Constants.AutoRacing, name: getString(key: "auto_racing"), icon: UIImage(named: "icon_autoracing")!))
        sports.append(Sport(id: Constants.MotoRacing, name: getString(key: "moto_racing"), icon: UIImage(named: "icon_motoracing")!))
        sports.append(Sport(id: Constants.Cycling, name: getString(key: "cycling"), icon: UIImage(named: "icon_cycling")!))
        sports.append(Sport(id: Constants.Equestrianism, name: getString(key: "equestrianism"), icon: UIImage(named: "icon_equestrianism")!))
        sports.append(Sport(id: Constants.PoloSport, name: getString(key: "polo_sport"), icon: UIImage(named: "icon_polo_sport")!))
        sports.append(Sport(id: Constants.Dance, name: getString(key:  "dance"), icon: UIImage(named: "icon_dance")!))
        sports.append(Sport(id: Constants.Softball, name: getString(key:  "softball"), icon: UIImage(named: "icon_softball")!))
        sports.append(Sport(id: Constants.SepakTakraw, name: getString(key:  "sepak_takraw"), icon: UIImage(named: "icon_sepak_takraw")!))
        sports.append(Sport(id: Constants.Korfball, name: getString(key:  "korfball"), icon: UIImage(named: "icon_korfball")!))
        sports.append(Sport(id: Constants.Floorball, name: getString(key:  "floorball"), icon: UIImage(named: "icon_floorball")!))
        sports.append(Sport(id: Constants.Climbing, name: getString(key:  "climbing"), icon: UIImage(named: "icon_climbing")!))
        sports.append(Sport(id: Constants.Mountaineering, name: getString(key:  "mountaineering"), icon: UIImage(named: "icon_mountaineering")!))
        sports.append(Sport(id: Constants.Canyoning, name: getString(key:  "canyoning"), icon: UIImage(named: "icon_canyoning")!))
        sports.append(Sport(id: Constants.Trail, name: getString(key:  "trail"), icon: UIImage(named: "icon_trail")!))
        sports.append(Sport(id: Constants.Triathlon, name: getString(key:  "triathlon"), icon: UIImage(named: "icon_triathlon")!))
        sports.append(Sport(id: Constants.Archery, name: getString(key:  "archery"), icon: UIImage(named: "icon_archery")!))
        sports.append(Sport(id: Constants.Snowboarding, name: getString(key:  "snowboarding"), icon: UIImage(named: "icon_snowboarding")!))
        sports.append(Sport(id: Constants.Skiing, name: getString(key:  "skiing"), icon: UIImage(named: "icon_skiing")!))
        sports.append(Sport(id: Constants.IceSkating, name: getString(key:  "ice_skating"), icon: UIImage(named: "icon_ice_skating")!))
        sports.append(Sport(id: Constants.Petanque, name: getString(key:  "petanque"), icon: UIImage(named: "icon_petanque")!))
        sports.append(Sport(id: Constants.SkateBoard, name: getString(key:  "skate_board"), icon: UIImage(named: "icon_skate_board")!))
        sports.append(Sport(id: Constants.Weightlifting, name: getString(key:  "weightlifting"), icon: UIImage(named: "icon_weightlifting")!))
        sports.append(Sport(id: Constants.Crossfit_Fitness, name: getString(key:  "crossfit_fitness"), icon: UIImage(named: "icon_crossfit_fitness")!))
        sports.append(Sport(id: Constants.Bowling, name: getString(key:  "bowling"), icon: UIImage(named: "icon_bowling")!))
        sports.append(Sport(id: Constants.Surf, name: getString(key:  "surf"), icon: UIImage(named: "icon_surf")!))
        sports.append(Sport(id: Constants.Sailing, name: getString(key:  "sailing"), icon: UIImage(named: "icon_sailing")!))
        sports.append(Sport(id: Constants.Canoeing, name: getString(key:  "canoeing"), icon: UIImage(named: "icon_canoeing")!))
        sports.append(Sport(id: Constants.Rowing, name: getString(key:  "rowing"), icon: UIImage(named: "icon_rowing")!))
        sports.append(Sport(id: Constants.Air_Sports, name: getString(key:  "air_sports"), icon: UIImage(named: "icon_air_sports")!))
        sports.append(Sport(id: Constants.WinterSports, name: getString(key:  "winter_sports"), icon: UIImage(named: "icon_winter_sports")!))
        
        return sports
    }
    
    static func getSportName(sport: Int)->String {
        switch (sport) {
        case Constants.Football:
            return getString(key:"football")
        case Constants.Basketball:
            return getString(key:"basketball")
        case Constants.American_Football:
            return getString(key:"american_football")
        case Constants.Cricket:
            return getString(key:"cricket")
        case Constants.Tennis:
            return getString(key:"tennis")
        case Constants.Rugby:
            return getString(key:"rugby")
        case Constants.Golf:
            return getString(key:"golf")
        case Constants.BaseBall:
            return getString(key:"baseball")
        case Constants.Ice_Hockey:
            return getString(key:"ice_hockey")
        case Constants.Field_Hockey:
            return getString(key:"field_hockey")
        case Constants.VolleyBall:
            return getString(key:"volleyball")
        case Constants.Handball:
            return getString(key:"handball")
        case Constants.Badminton:
            return getString(key:"badminton")
        case Constants.Squash:
            return getString(key:"squash")
        case Constants.TableTennis:
            return getString(key:"table_tennis")
        case Constants.Boxing:
            return getString(key:"boxing")
        case Constants.MartialArt:
            return getString(key:"martial_art")
        case Constants.MMA:
            return getString(key:"mma")
        case Constants.KickBoxing:
            return getString(key:"kick_boxing")
        case Constants.Wrestling:
            return getString(key:"wrestling")
        case Constants.Gymnastic:
            return getString(key:"gymnastic")
        case Constants.Athletics:
            return getString(key:"athletics")
        case Constants.Fencing:
            return getString(key:"fencing")
        case Constants.Judo:
            return getString(key:"judo")
        case Constants.Swimming:
            return getString(key:"swimming")
        case Constants.WaterSports:
            return getString(key:"water_sports")
        case Constants.WaterPolo:
            return getString(key:"water_polo")
        case Constants.AutoRacing:
            return getString(key:"auto_racing")
        case Constants.MotoRacing:
            return getString(key:"moto_racing")
        case Constants.Cycling:
            return getString(key:"cycling")
        case Constants.Equestrianism:
            return getString(key:"equestrianism")
        case Constants.PoloSport:
            return getString(key:"polo_sport")
        case Constants.Dance:
            return getString(key:"dance")
        case Constants.Softball:
            return getString(key:"softball")
        case Constants.SepakTakraw:
            return getString(key:"sepak_takraw")
        case Constants.Korfball:
            return getString(key:"korfball")
        case Constants.Floorball:
            return getString(key:"floorball")
        case Constants.Climbing:
            return getString(key:"climbing")
        case Constants.Mountaineering:
            return getString(key:"mountaineering")
        case Constants.Canyoning:
            return getString(key:"canyoning")
        case Constants.Trail:
            return getString(key:"trail")
        case Constants.Triathlon:
            return getString(key:"triathlon")
        case Constants.Archery:
            return getString(key:"archery")
        case Constants.Snowboarding:
            return getString(key:"snowboarding")
        case Constants.Skiing:
            return getString(key:"skiing")
        case Constants.IceSkating:
            return getString(key:"ice_skating")
        case Constants.Petanque:
            return getString(key:"petanque")
        case Constants.SkateBoard:
            return getString(key:"skate_board")
        case Constants.Weightlifting:
            return getString(key:"weightlifting")
        case Constants.Crossfit_Fitness:
            return getString(key:"crossfit_fitness")
        case Constants.Bowling:
            return getString(key:"bowling")
        case Constants.Surf:
            return getString(key:"surf")
        case Constants.Sailing:
            return getString(key:"sailing")
        case Constants.Canoeing:
            return getString(key:"canoeing")
        case Constants.Rowing:
            return getString(key:"rowing")
        case Constants.Air_Sports:
            return getString(key:"air_aports")
        case Constants.WinterSports:
            return getString(key:"winter_sports")
            
        default:
            return ""
        }
    }
    
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
    
    func getSkillValue(key: String, skills: [Skill])->Int {
        for one in skills {
            if one.key == key {
                return one.value
            }
        }
        return 0
    }
    
    static func getString(key: String)->String {
        return NSLocalizedString(key, comment: "")
    }
    
    static func getAllSkills()->[Skill] {
        var result: [Skill] = []
        
        var stat_key_str = getString(key:"stat_american_football_key")
        var stat_desc_str = getString(key: "stat_american_football")
        var stat_summ_str = getString(key: "stat_american_football_s")
        var stat_key = stat_key_str.components(separatedBy: ",")
        var stat_desc = stat_desc_str.components(separatedBy: ",")
        var stat_summ = stat_summ_str.components(separatedBy: ",")
        var i = 0;
        for skey in stat_key {
            result.append(Skill(sport: Constants.American_Football, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            i += 1
        }
        /** basketball */
        stat_key_str = getString(key:"stat_basketball_key")
        stat_desc_str = getString(key: "stat_basketball")
        stat_summ_str = getString(key: "stat_basketball_s")
        stat_key = stat_key_str.components(separatedBy: ",")
        stat_desc = stat_desc_str.components(separatedBy: ",")
        stat_summ = stat_summ_str.components(separatedBy: ",")
        i = 0;
        for skey in stat_key {
            result.append(Skill(sport: Constants.Basketball, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            i += 1
        }
        /** football */
        stat_key_str = getString(key:"stat_football_key")
        stat_desc_str = getString(key: "stat_football")
        stat_summ_str = getString(key: "stat_football_s")
        stat_key = stat_key_str.components(separatedBy: ",")
        stat_desc = stat_desc_str.components(separatedBy: ",")
        stat_summ = stat_summ_str.components(separatedBy: ",")
        i = 0;
        for skey in stat_key {
            result.append(Skill(sport: Constants.Football, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            i += 1
        }
        /** rugby */
        stat_key_str = getString(key:"stat_rugby_key")
        stat_desc_str = getString(key: "stat_rugby")
        stat_summ_str = getString(key: "stat_rugby_s")
        stat_key = stat_key_str.components(separatedBy: ",")
        stat_desc = stat_desc_str.components(separatedBy: ",")
        stat_summ = stat_summ_str.components(separatedBy: ",")
        i = 0;
        for skey in stat_key {
            result.append(Skill(sport: Constants.Rugby, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            i += 1
        }
        /** cricket */
        stat_key_str = getString(key:"stat_cricket_key")
        stat_desc_str = getString(key: "stat_cricket")
        stat_summ_str = getString(key: "stat_cricket_s")
        stat_key = stat_key_str.components(separatedBy: ",")
        stat_desc = stat_desc_str.components(separatedBy: ",")
        stat_summ = stat_summ_str.components(separatedBy: ",")
        i = 0;
        for skey in stat_key {
            result.append(Skill(sport: Constants.Cricket, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            i += 1
        }
        /** baseball */
        stat_key_str = getString(key:"stat_baseball_key")
        stat_desc_str = getString(key: "stat_baseball")
        stat_summ_str = getString(key: "stat_baseball_s")
        stat_key = stat_key_str.components(separatedBy: ",")
        stat_desc = stat_desc_str.components(separatedBy: ",")
        stat_summ = stat_summ_str.components(separatedBy: ",")
        i = 0;
        for skey in stat_key {
            result.append(Skill(sport: Constants.BaseBall, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            i += 1
        }
        /** hockey */
        stat_key_str = getString(key:"stat_hockey_key")
        stat_desc_str = getString(key: "stat_hockey")
        stat_summ_str = getString(key: "stat_hockey_s")
        stat_key = stat_key_str.components(separatedBy: ",")
        stat_desc = stat_desc_str.components(separatedBy: ",")
        stat_summ = stat_summ_str.components(separatedBy: ",")
        i = 0;
        for skey in stat_key {
            result.append(Skill(sport: Constants.Ice_Hockey, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            result.append(Skill(sport: Constants.Field_Hockey, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            i += 1
        }
        /** handball */
        stat_key_str = getString(key:"stat_handball_key")
        stat_desc_str = getString(key: "stat_handball")
        stat_summ_str = getString(key: "stat_handball_s")
        stat_key = stat_key_str.components(separatedBy: ",")
        stat_desc = stat_desc_str.components(separatedBy: ",")
        stat_summ = stat_summ_str.components(separatedBy: ",")
        i = 0;
        for skey in stat_key {
            result.append(Skill(sport: Constants.Handball, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            i += 1
        }
        /** volleyball */
        stat_key_str = getString(key: "stat_volleyball_key")
        stat_desc_str = getString(key: "stat_volleyball")
        stat_summ_str = getString(key: "stat_volleyball_s")
        stat_key = stat_key_str.components(separatedBy: ",")
        stat_desc = stat_desc_str.components(separatedBy: ",")
        stat_summ = stat_summ_str.components(separatedBy: ",")
        i = 0;
        for skey in stat_key {
            result.append(Skill(sport: Constants.VolleyBall, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            i += 1
        }
        /** tennis */
        stat_key_str = getString(key: "stat_tennis_key")
        stat_desc_str = getString(key: "stat_tennis")
        stat_summ_str = getString(key: "stat_tennis_s")
        stat_key = stat_key_str.components(separatedBy: ",")
        stat_desc = stat_desc_str.components(separatedBy: ",")
        stat_summ = stat_summ_str.components(separatedBy: ",")
        i = 0;
        for skey in stat_key {
            result.append(Skill(sport: Constants.Tennis, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            i += 1
        }
        /** badminton * squash * table tennis */
        stat_key_str = getString(key: "stat_badminton_key")
        stat_desc_str = getString(key: "stat_badminton")
        stat_summ_str = getString(key: "stat_badminton_s")
        stat_key = stat_key_str.components(separatedBy: ",")
        stat_desc = stat_desc_str.components(separatedBy: ",")
        stat_summ = stat_summ_str.components(separatedBy: ",")
        i = 0;
        for skey in stat_key {
            result.append(Skill(sport: Constants.Badminton, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            result.append(Skill(sport: Constants.Squash, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            result.append(Skill(sport: Constants.TableTennis, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            i += 1
        }
        /** golf */
        stat_key_str = getString(key: "stat_golf_key")
        stat_desc_str = getString(key: "stat_golf")
        stat_summ_str = getString(key: "stat_golf_s")
        stat_key = stat_key_str.components(separatedBy: ",")
        stat_desc = stat_desc_str.components(separatedBy: ",")
        stat_summ = stat_summ_str.components(separatedBy: ",")
        i = 0;
        for skey in stat_key {
            result.append(Skill(sport: Constants.Golf, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            i += 1
        }
        /** athletics * swimming * water sports * gymnastic * boxing * martial art *
        * wrestling * fencing * cycling * equestrianism * dance * climbing * Bowling *
        * Crossfit_Fitness * Weightlifting * KickBoxing * mma * Trail * Rowing *
        * Mountaineering * WinterSports * Air_Sports **/
        stat_key_str = getString(key: "stat_athletics_key")
        stat_desc_str = getString(key: "stat_athletics")
        stat_summ_str = getString(key: "stat_athletics_s")
        stat_key = stat_key_str.components(separatedBy: ",")
        stat_desc = stat_desc_str.components(separatedBy: ",")
        stat_summ = stat_summ_str.components(separatedBy: ",")
        i = 0;
        for skey in stat_key {
            result.append(Skill(sport: Constants.Athletics, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            result.append(Skill(sport: Constants.Swimming, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            result.append(Skill(sport: Constants.WaterSports, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            result.append(Skill(sport: Constants.Gymnastic, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            result.append(Skill(sport: Constants.Boxing, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            result.append(Skill(sport: Constants.MartialArt, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            result.append(Skill(sport: Constants.Wrestling, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            result.append(Skill(sport: Constants.Fencing, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            result.append(Skill(sport: Constants.Cycling, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            result.append(Skill(sport: Constants.Equestrianism, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            result.append(Skill(sport: Constants.Dance, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            result.append(Skill(sport: Constants.Climbing, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            result.append(Skill(sport: Constants.Bowling, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            result.append(Skill(sport: Constants.Crossfit_Fitness, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            result.append(Skill(sport: Constants.Weightlifting, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            result.append(Skill(sport: Constants.KickBoxing, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            result.append(Skill(sport: Constants.MMA, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            result.append(Skill(sport: Constants.Trail, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            result.append(Skill(sport: Constants.Rowing, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            result.append(Skill(sport: Constants.Mountaineering, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            result.append(Skill(sport: Constants.WinterSports, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            result.append(Skill(sport: Constants.Air_Sports, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            
            i += 1
        }
        /** judo */
        stat_key_str = getString(key: "stat_judo_key")
        stat_desc_str = getString(key: "stat_judo")
        stat_summ_str = getString(key: "stat_judo_s")
        stat_key = stat_key_str.components(separatedBy: ",")
        stat_desc = stat_desc_str.components(separatedBy: ",")
        stat_summ = stat_summ_str.components(separatedBy: ",")
        i = 0;
        for skey in stat_key {
            result.append(Skill(sport: Constants.Judo, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            i += 1
        }
        /** sport car * sport moto * skiing * snowboarding * skateboard * surf *
        *  IceSkating * Sailing * Canoeing * */
        stat_key_str = getString(key: "stat_racing_key")
        stat_desc_str = getString(key: "stat_racing")
        stat_summ_str = getString(key: "stat_racing_s")
        stat_key = stat_key_str.components(separatedBy: ",")
        stat_desc = stat_desc_str.components(separatedBy: ",")
        stat_summ = stat_summ_str.components(separatedBy: ",")
        i = 0;
        for skey in stat_key {
            result.append(Skill(sport: Constants.AutoRacing, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            result.append(Skill(sport: Constants.MotoRacing, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            result.append(Skill(sport: Constants.Skiing, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            result.append(Skill(sport: Constants.Snowboarding, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            result.append(Skill(sport: Constants.SkateBoard, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            result.append(Skill(sport: Constants.Surf, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            result.append(Skill(sport: Constants.IceSkating, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            result.append(Skill(sport: Constants.Sailing, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            result.append(Skill(sport: Constants.Canoeing, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            i += 1
        }
        /** korfball */
        stat_key_str = getString(key: "stat_korfball_key")
        stat_desc_str = getString(key: "stat_korfball")
        stat_summ_str = getString(key: "stat_korfball_s")
        stat_key = stat_key_str.components(separatedBy: ",")
        stat_desc = stat_desc_str.components(separatedBy: ",")
        stat_summ = stat_summ_str.components(separatedBy: ",")
        i = 0;
        for skey in stat_key {
            result.append(Skill(sport: Constants.Korfball, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            i += 1
        }
        /** softball */
        stat_key_str = getString(key: "stat_softball_key")
        stat_desc_str = getString(key: "stat_softball")
        stat_summ_str = getString(key: "stat_softball_s")
        stat_key = stat_key_str.components(separatedBy: ",")
        stat_desc = stat_desc_str.components(separatedBy: ",")
        stat_summ = stat_summ_str.components(separatedBy: ",")
        i = 0;
        for skey in stat_key {
            result.append(Skill(sport: Constants.Softball, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            i += 1
        }
        /** floorball */
        stat_key_str = getString(key: "stat_floorball_key")
        stat_desc_str = getString(key: "stat_floorball")
        stat_summ_str = getString(key: "stat_floorball_s")
        stat_key = stat_key_str.components(separatedBy: ",")
        stat_desc = stat_desc_str.components(separatedBy: ",")
        stat_summ = stat_summ_str.components(separatedBy: ",")
        i = 0;
        for skey in stat_key {
            result.append(Skill(sport: Constants.Floorball, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            i += 1
        }
        /** waterpolo */
        stat_key_str = getString(key: "stat_water_polo_key")
        stat_desc_str = getString(key: "stat_water_polo")
        stat_summ_str = getString(key: "stat_water_polo_s")
        stat_key = stat_key_str.components(separatedBy: ",")
        stat_desc = stat_desc_str.components(separatedBy: ",")
        stat_summ = stat_summ_str.components(separatedBy: ",")
        i = 0;
        for skey in stat_key {
            result.append(Skill(sport: Constants.WaterPolo, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            i += 1
        }
        /** SepakTakraw */
        stat_key_str = getString(key: "stat_sepak_takraw_key")
        stat_desc_str = getString(key: "stat_sepak_takraw")
        stat_summ_str = getString(key: "stat_sepak_takraw_s")
        stat_key = stat_key_str.components(separatedBy: ",")
        stat_desc = stat_desc_str.components(separatedBy: ",")
        stat_summ = stat_summ_str.components(separatedBy: ",")
        i = 0;
        for skey in stat_key {
            result.append(Skill(sport: Constants.SepakTakraw, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            i += 1
        }
        
        /** coach */
        stat_key_str = getString(key: "stat_coach_key")
        stat_desc_str = getString(key: "stat_coach")
        stat_summ_str = getString(key: "stat_coach_s")
        stat_key = stat_key_str.components(separatedBy: ",")
        stat_desc = stat_desc_str.components(separatedBy: ",")
        stat_summ = stat_summ_str.components(separatedBy: ",")
        i = 0;
        for skey in stat_key {
            result.append(Skill(sport: Constants.STATS_COACH, key: skey, description: stat_desc[i], summary: stat_summ[i]))
            i += 1
        }
        
        return result
    }
    
    static func getSportDefaultSkills(sport: Int) -> [Skill] {
        let skills = getAllSkills()
        var result: [Skill] = []
        for one in skills {
            if one.sport == sport {
                result.append(one)
            }
        }
        return result
    }
    
    static func getSportSkills(sport: Int, apiResult: [(String, Int)])->[Skill] {
        let result: [Skill] = getSportDefaultSkills(sport: sport)
        for skill in result {
            for one in apiResult {
                if one.0 == skill.key {
                    skill.value = skill.value + one.1
                }
            }
        }
        return result
    }
    
    func getDescriptionName(type:Int, id: Int)->String {
        if type == Constants.PLAYER {
            let name: [String] = [
                getString(key: "description_1"),
                getString(key: "description_2"),
                getString(key: "description_3"),
                getString(key: "description_4"),
                getString(key: "description_5"),
                getString(key: "description_6"),
                getString(key: "description_7"),
                getString(key: "description_8"),
                getString(key: "description_9"),
                getString(key: "description_10"),
                getString(key: "description_11"),
                getString(key: "description_12"),
                getString(key: "description_13"),
                getString(key: "description_14"),
                getString(key: "description_15"),
                getString(key: "description_16"),
                getString(key: "description_17"),
                getString(key: "description_18"),
                getString(key: "description_19"),
                getString(key: "description_20"),
                getString(key: "description_21"),
                getString(key: "description_22"),
                getString(key: "description_23"),
                getString(key: "description_24")]
            return name[id]
        } else {
            let name: [String] = [
                getString(key: "cdescription_1"),
                getString(key: "cdescription_2"),
                getString(key: "cdescription_3"),
                getString(key: "cdescription_4"),
                getString(key: "cdescription_5"),
                getString(key: "cdescription_6"),
                getString(key: "cdescription_7"),
                getString(key: "cdescription_8"),
                getString(key: "cdescription_9"),
                getString(key: "cdescription_10"),
                getString(key: "cdescription_11"),
                getString(key: "cdescription_12"),
                getString(key: "cdescription_13"),
                getString(key: "cdescription_14"),
                getString(key: "cdescription_15"),
                getString(key: "cdescription_16"),
                getString(key: "cdescription_17"),
                getString(key: "cdescription_18"),
                getString(key: "cdescription_19"),
                getString(key: "cdescription_20"),
                getString(key: "cdescription_21"),
                getString(key: "cdescription_22"),
                getString(key: "cdescription_23"),
                getString(key: "cdescription_24")]
            if id >= 24 {
                return name[id - 24]
            } else {
                return name[id]
            }
        }
    }
    
    func getDescriptions(user_id: String, ids: [Int], descriptions: [Description])->[Description] {
        var result: [Description] = []
        for id in ids {
            let description = Description()
            description.type = id
            description.value = 0
            description.user_id = user_id
            for one in descriptions {
                if one.type == id {
                    description.id = one.id
                    description.value = one.value
                }
            }
            result.append(description)
        }
        return result
    }
    
    func getThumbnailFromVideoURL(url: URL) -> UIImage? {
        let asset = AVAsset(url: url)
        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        assetImgGenerate.maximumSize = CGSize(width: 400, height: 300)
        let time = CMTimeMakeWithSeconds(1.0, 1)
        do {
            let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            let thumbnail = UIImage(cgImage: img)
            return thumbnail
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func isValidDate(year: Int, month: Int, day: Int) -> Bool {
        if year < 1900 || year > 2100 {
            return false
        }
        if month < 1 || month > 12 {
            return false
        }
        if day < 1 || day > 31 {
            return false
        }
        if day == 31 && (month == 4 || month == 6 || month == 9 || month == 11) {
            return false
        }
        if month == 2 {
            if year % 400 == 0 || (year % 100 != 0 && year & 4 == 0) {
                if day > 29 {
                    return false
                } else {
                    return true
                }
            } else {
                if day > 28 {
                    return false
                } else {
                    return true
                }
            }
        }
        return true
    }
    
    static func getChatId(a: User, b: User)->String {
        if a.id.compare(b.id) == .orderedAscending {
            return "room" + a.id + "_" + b.id
        } else {
            return "room" + b.id + "_" + a.id
        }
    }
        
    func getStatistics(user: User, skills: [Skill])->Float {
        var result: Float = 0
        var i : Int = 0
        var stat_key_str = getString(key:"stat_coach_key")
        var stat_key = stat_key_str.components(separatedBy: ",")
        if user.type == Constants.COACH || user.type == Constants.TEAM_CLUB || user.type == Constants.STAFF{
            result = Float(getSkillValue(key: stat_key[1], skills: skills))
        } else if user.sport == Constants.American_Football {
            stat_key_str = getString(key:"stat_american_football_key")
            stat_key = stat_key_str.components(separatedBy: ",")
            for i in 4..<stat_key.count{
                result += Float(getSkillValue(key: stat_key[i], skills: skills))
            }
        } else if user.sport == Constants.Basketball {
            stat_key_str = getString(key:"stat_basketball_key")
            stat_key = stat_key_str.components(separatedBy: ",")
            for i in 4..<stat_key.count{
                result += Float(getSkillValue(key: stat_key[i], skills: skills))
            }
        } else if user.sport == Constants.Korfball {
            stat_key_str = getString(key:"stat_korfball_key")
            stat_key = stat_key_str.components(separatedBy: ",")
            for i in 4..<stat_key.count{
                result += Float(getSkillValue(key: stat_key[i], skills: skills))
            }
        } else if user.sport == Constants.Football {
            stat_key_str = getString(key:"stat_football_key")
            stat_key = stat_key_str.components(separatedBy: ",")
            for i in 4..<stat_key.count-1 {
                result += Float(getSkillValue(key: stat_key[i], skills: skills))
            }
        } else if user.sport == Constants.Rugby {
            stat_key_str = getString(key:"stat_rugby_key")
            stat_key = stat_key_str.components(separatedBy: ",")
            for i in 4..<stat_key.count{
                result += Float(getSkillValue(key: stat_key[i], skills: skills))
            }
        } else if user.sport == Constants.Cricket {
            stat_key_str = getString(key:"stat_cricket_key")
            stat_key = stat_key_str.components(separatedBy: ",")
            for i in 4..<stat_key.count{
                result += Float(getSkillValue(key: stat_key[i], skills: skills))
            }
        } else if user.sport == Constants.BaseBall {
            stat_key_str = getString(key:"stat_baseball_key")
            stat_key = stat_key_str.components(separatedBy: ",")
            for i in 4..<stat_key.count{
                result += Float(getSkillValue(key: stat_key[i], skills: skills))
            }
        } else if user.sport == Constants.Softball {
            stat_key_str = getString(key:"stat_softball_key")
            stat_key = stat_key_str.components(separatedBy: ",")
            for i in 4..<stat_key.count{
                result += Float(getSkillValue(key: stat_key[i], skills: skills))
            }
        } else if user.sport == Constants.Ice_Hockey || user.sport == Constants.Field_Hockey {
            stat_key_str = getString(key:"stat_hockey_key")
            stat_key = stat_key_str.components(separatedBy: ",")
            for i in 4..<stat_key.count {
                result += Float(getSkillValue(key: stat_key[i], skills: skills))
            }
        } else if user.sport == Constants.Handball {
            stat_key_str = getString(key:"stat_handball_key")
            stat_key = stat_key_str.components(separatedBy: ",")
            for i in 4..<stat_key.count-1 {
                result += Float(getSkillValue(key: stat_key[i], skills: skills))
            }
        } else if user.sport == Constants.VolleyBall {
            stat_key_str = getString(key:"stat_volleyball_key")
            stat_key = stat_key_str.components(separatedBy: ",")
            for i in 4..<stat_key.count {
                result += Float(getSkillValue(key: stat_key[i], skills: skills))
            }
        } else if user.sport == Constants.SepakTakraw {
            stat_key_str = getString(key:"stat_sepak_takraw_key")
            stat_key = stat_key_str.components(separatedBy: ",")
            for i in 4..<stat_key.count {
                result += Float(getSkillValue(key: stat_key[i], skills: skills))
            }
        } else if user.sport == Constants.Tennis {
            stat_key_str = getString(key:"stat_tennis_key")
            stat_key = stat_key_str.components(separatedBy: ",")
            for i in 4..<stat_key.count-2 {
                result += Float(getSkillValue(key: stat_key[i], skills: skills))
            }
        } else if user.sport == Constants.Badminton || user.sport == Constants.Squash || user.sport == Constants.TableTennis {
            stat_key_str = getString(key:"stat_badminton_key")
            stat_key = stat_key_str.components(separatedBy: ",")
            for i in 4..<stat_key.count-2 {
                result += Float(getSkillValue(key: stat_key[i], skills: skills))
            }
        } else if user.sport == Constants.Golf {
            stat_key_str = getString(key:"stat_golf_key")
            stat_key = stat_key_str.components(separatedBy: ",")
            for i in 4..<stat_key.count-2 {
                result += Float(getSkillValue(key: stat_key[i], skills: skills))
            }
        } else if user.sport == Constants.Athletics || user.sport == Constants.Swimming || user.sport == Constants.WaterSports ||
        user.sport == Constants.Gymnastic || user.sport == Constants.Boxing || user.sport == Constants.MartialArt ||
        user.sport == Constants.Wrestling || user.sport == Constants.Fencing || user.sport == Constants.Cycling ||
        user.sport == Constants.Equestrianism || user.sport == Constants.Dance || user.sport == Constants.Climbing ||
        user.sport == Constants.Bowling || user.sport == Constants.Crossfit_Fitness || user.sport == Constants.Weightlifting ||
        user.sport == Constants.KickBoxing || user.sport == Constants.MMA || user.sport == Constants.Trail ||
        user.sport == Constants.Rowing || user.sport == Constants.Mountaineering || user.sport == Constants.WinterSports ||
        user.sport == Constants.Air_Sports {
            stat_key_str = getString(key:"stat_athletics_key")
            stat_key = stat_key_str.components(separatedBy: ",")
            result = Float(getSkillValue(key: stat_key[4], skills: skills))
        } else if user.sport == Constants.Judo {
            stat_key_str = getString(key:"stat_judo_key")
            stat_key = stat_key_str.components(separatedBy: ",")
            for i in 4..<stat_key.count-2 {
                result += Float(getSkillValue(key: stat_key[i], skills: skills))
            }
        } else if user.sport == Constants.AutoRacing || user.sport == Constants.MotoRacing ||
        user.sport == Constants.Skiing || user.sport == Constants.Snowboarding || user.sport == Constants.Surf ||
        user.sport == Constants.IceSkating || user.sport == Constants.Sailing || user.sport == Constants.Canoeing ||
        user.sport == Constants.SkateBoard {
            stat_key_str = getString(key:"stat_racing_key")
            stat_key = stat_key_str.components(separatedBy: ",")
            result = Float(getSkillValue(key: stat_key[4], skills: skills))
        } else if user.sport == Constants.Floorball {
            stat_key_str = getString(key:"stat_floorball_key")
            stat_key = stat_key_str.components(separatedBy: ",")
            for i in 4..<stat_key.count {
                result += Float(getSkillValue(key: stat_key[i], skills: skills))
            }
        } else if user.sport == Constants.WaterPolo {
            stat_key_str = getString(key:"stat_water_polo_key")
            stat_key = stat_key_str.components(separatedBy: ",")
            for i in 4..<stat_key.count {
                result += Float(getSkillValue(key: stat_key[i], skills: skills))
            }
        }
        return result
    }
    
    func getMatch(user: User, skills: [Skill])->Float {
        var result: Float = 0
        if (user.type == Constants.COACH || user.type == Constants.TEAM_CLUB || user.type == Constants.STAFF) {
            result = getSkillValue(key: Constants.STATS_GAMES_PLAYED, skills: skills) == 0 ? 0 :
                Float(getSkillValue(key: Constants.STATS_VICTORIES, skills: skills)) / Float(getSkillValue(key: Constants.STATS_GAMES_PLAYED, skills: skills))
        } else if (user.sport == Constants.American_Football || user.sport == Constants.Basketball ||
        user.sport == Constants.Korfball || user.sport == Constants.Football || user.sport == Constants.Rugby ||
        user.sport == Constants.Cricket || user.sport == Constants.BaseBall || user.sport == Constants.Softball ||
        user.sport == Constants.Ice_Hockey || user.sport == Constants.Field_Hockey || user.sport == Constants.VolleyBall ||
        user.sport == Constants.SepakTakraw || user.sport == Constants.Handball) {
            result = getSkillValue(key: Constants.STATS_GAMES_PLAYED, skills: skills) == 0 ? 0 : Float(getSkillValue(key: Constants.STATS_VICTORIES, skills: skills)) / Float(getSkillValue(key: Constants.STATS_GAMES_PLAYED, skills: skills))
        } else if (user.sport == Constants.Tennis || user.sport == Constants.Badminton || user.sport == Constants.Squash ||
        user.sport == Constants.Bowling || user.sport == Constants.Crossfit_Fitness || user.sport == Constants.Weightlifting ||
        user.sport == Constants.TableTennis || user.sport == Constants.Golf || user.sport == Constants.Athletics ||
        user.sport == Constants.Swimming || user.sport == Constants.KickBoxing || user.sport == Constants.WaterSports ||
        user.sport == Constants.MMA || user.sport == Constants.Trail || user.sport == Constants.Gymnastic ||
        user.sport == Constants.Rowing || user.sport == Constants.Mountaineering || user.sport == Constants.Judo ||
        user.sport == Constants.WinterSports || user.sport == Constants.Air_Sports || user.sport == Constants.Boxing ||
        user.sport == Constants.MartialArt || user.sport == Constants.Wrestling || user.sport == Constants.Fencing ||
        user.sport == Constants.Cycling || user.sport == Constants.Equestrianism || user.sport == Constants.Climbing ||
        user.sport == Constants.Dance) {
            result = getSkillValue(key: Constants.STATS_GAMES_PLAYED, skills: skills) == 0 ? 0 : Float(getSkillValue(key: Constants.STATS_VICTORIES, skills: skills)) / Float(getSkillValue(key: Constants.STATS_GAMES_PLAYED, skills: skills))
        } else if (user.sport == Constants.AutoRacing || user.sport == Constants.MotoRacing ||
        user.sport == Constants.Skiing || user.sport == Constants.Snowboarding || user.sport == Constants.Surf ||
        user.sport == Constants.IceSkating || user.sport == Constants.Sailing || user.sport == Constants.Canoeing ||
        user.sport == Constants.SkateBoard) {
            result = getSkillValue(key: Constants.STATS_RACES, skills: skills) == 0 ? 0 : Float(getSkillValue(key: Constants.STATS_VICTORIES, skills: skills)) / Float(getSkillValue(key: Constants.STATS_RACES, skills: skills))
        } else  {
            result = getSkillValue(key: Constants.STATS_GAMES_PLAYED, skills: skills) == 0 ? 0 : Float(getSkillValue(key: Constants.STATS_VICTORIES, skills: skills)) / Float(getSkillValue(key: Constants.STATS_GAMES_PLAYED, skills: skills))
        }
        return result
    }
    
    func getRatio(user: User, skills: [Skill])->Float {
        var result: Float = 0
        if (user.type == Constants.COACH || user.type == Constants.TEAM_CLUB || user.type == Constants.STAFF ) {
            result = getSkillValue(key: Constants.STATS_DEFEATS, skills: skills) == 0 ? 0 : Float(getSkillValue(key: Constants.STATS_VICTORIES, skills: skills)) / Float(getSkillValue(key: Constants.STATS_DEFEATS, skills: skills))
        } else if (user.sport == Constants.AutoRacing || user.sport == Constants.MotoRacing ||
        user.sport == Constants.Skiing || user.sport == Constants.Snowboarding || user.sport == Constants.Surf ||
        user.sport == Constants.IceSkating || user.sport == Constants.Sailing || user.sport == Constants.Canoeing ||
        user.sport == Constants.SkateBoard) {
            result = getSkillValue(key: Constants.STATS_RACES, skills: skills) == 0 ? 0 : Float(getStatistics(user: user, skills: skills)) / Float(getSkillValue(key: Constants.STATS_RACES, skills: skills))
        } else {
            result = getSkillValue(key: Constants.STATS_GAMES_PLAYED, skills: skills) == 0 ? 0 : Float(getStatistics(user: user, skills: skills)) / Float(getSkillValue(key: Constants.STATS_GAMES_PLAYED, skills: skills))
        }
        return result
    }
    
    func getLabels(user: User)->[String] {
        if (user.type == Constants.COACH || user.type == Constants.TEAM_CLUB || user.type == Constants.STAFF) {
            return [getString(key: "statistics"), getString(key: "match_win_percent"), getString(key: "ratio")]
        } else if (user.sport == Constants.American_Football || user.sport == Constants.Basketball || user.sport == Constants.Korfball ||
            user.sport == Constants.Football || user.sport == Constants.Rugby || user.sport == Constants.Cricket ||
            user.sport == Constants.BaseBall || user.sport == Constants.Softball || user.sport == Constants.Ice_Hockey ||
            user.sport == Constants.Field_Hockey || user.sport == Constants.Floorball || user.sport == Constants.WaterPolo ||
            user.sport == Constants.Handball || user.sport == Constants.VolleyBall || user.sport == Constants.SepakTakraw) {
            return [getString(key: "statistics"), getString(key: "match"), getString(key: "ratio")]
        } else {
            return [getString(key: "statistics"), getString(key: "match_win_percent"), getString(key: "ratio")]
        }
    }
    
    func getVictoryRate(user: User, skills: [Skill])->Float {
        var result: Float = 0
        if (user.type == Constants.COACH || user.type == Constants.TEAM_CLUB || user.type == Constants.STAFF) {
            result = getSkillValue(key: Constants.STATS_GAMES_PLAYED, skills: skills) == 0 ? 0 : Float(getSkillValue(key: Constants.STATS_VICTORIES, skills: skills)) / Float(getSkillValue(key: Constants.STATS_GAMES_PLAYED, skills: skills))
        } else if (user.sport == Constants.AutoRacing || user.sport == Constants.MotoRacing ||
                user.sport == Constants.Skiing || user.sport == Constants.Snowboarding || user.sport == Constants.Surf ||
                user.sport == Constants.IceSkating || user.sport == Constants.Sailing || user.sport == Constants.Canoeing ||
                user.sport == Constants.SkateBoard){
            result = getSkillValue(key: Constants.STATS_RACES, skills: skills) == 0 ? 0 : Float(getSkillValue(key: Constants.STATS_VICTORIES, skills: skills)) / Float(getSkillValue(key: Constants.STATS_RACES, skills: skills))
        } else {
            result = getSkillValue(key: Constants.STATS_GAMES_PLAYED, skills: skills) == 0 ? 0 : Float(getSkillValue(key: Constants.STATS_VICTORIES, skills: skills)) / Float(getSkillValue(key: Constants.STATS_GAMES_PLAYED, skills: skills))
        }
        return  result;
    }
    
    func getDefeatsRate(user: User, skills: [Skill])->Float {
        var result: Float = 0
        if (user.type == Constants.COACH || user.type == Constants.TEAM_CLUB || user.type == Constants.STAFF) {
            result = getSkillValue(key: Constants.STATS_GAMES_PLAYED, skills: skills) == 0 ? 0 : Float(getSkillValue(key: Constants.STATS_DEFEATS, skills: skills)) / Float(getSkillValue(key: Constants.STATS_GAMES_PLAYED, skills: skills))
        } else if (user.sport == Constants.AutoRacing || user.sport == Constants.MotoRacing ||
                user.sport == Constants.Skiing || user.sport == Constants.Snowboarding || user.sport == Constants.Surf ||
                user.sport == Constants.IceSkating || user.sport == Constants.Sailing || user.sport == Constants.Canoeing ||
                user.sport == Constants.SkateBoard){
            result = getSkillValue(key: Constants.STATS_RACES, skills: skills) == 0 ? 0 : Float(getSkillValue(key: Constants.STATS_DEFEATS, skills: skills)) / Float(getSkillValue(key: Constants.STATS_RACES, skills: skills))
        } else {
            result = getSkillValue(key: Constants.STATS_GAMES_PLAYED, skills: skills) == 0 ? 0 : Float(getSkillValue(key: Constants.STATS_DEFEATS, skills: skills)) / Float(getSkillValue(key: Constants.STATS_GAMES_PLAYED, skills: skills))
        }
        return  result;
    }
    
    func getDrawsRate(user: User, skills: [Skill])->Float {
        var result: Float = 0
        if (user.type == Constants.COACH || user.type == Constants.TEAM_CLUB || user.type == Constants.STAFF) {
            result = getSkillValue(key: Constants.STATS_GAMES_PLAYED, skills: skills) == 0 ? 0 : Float(getSkillValue(key: Constants.STATS_DRAWS, skills: skills)) / Float(getSkillValue(key: Constants.STATS_GAMES_PLAYED, skills: skills))
        } else if (user.sport == Constants.AutoRacing || user.sport == Constants.MotoRacing ||
                user.sport == Constants.Skiing || user.sport == Constants.Snowboarding || user.sport == Constants.Surf ||
                user.sport == Constants.IceSkating || user.sport == Constants.Sailing || user.sport == Constants.Canoeing ||
                user.sport == Constants.SkateBoard){
            result = getSkillValue(key: Constants.STATS_RACES, skills: skills) == 0 ? 0 : Float(getSkillValue(key: Constants.STATS_DRAWS, skills: skills)) / Float(getSkillValue(key: Constants.STATS_RACES, skills: skills))
        } else {
            result = getSkillValue(key: Constants.STATS_GAMES_PLAYED, skills: skills) == 0 ? 0 : Float(getSkillValue(key: Constants.STATS_DRAWS, skills: skills)) / Float(getSkillValue(key: Constants.STATS_GAMES_PLAYED, skills: skills))
        }
        return  result;
    }
    
    func configureStrength(sid: Int)->[String] {
        var result: [String] = []
        var strength : String = ""
        switch sid {
        case Constants.Football:
            strength = getString(key:"strength_football")
        case Constants.Basketball:
            strength = getString(key:"strength_basketball")
        case Constants.American_Football:
            strength = getString(key:"strength_american_football")
        case Constants.Cricket:
            strength = getString(key:"strength_cricket")
        case Constants.Tennis:
            strength = getString(key:"strength_tennis")
        case Constants.Rugby:
            strength = getString(key:"strength_rugby")
        case Constants.Golf:
            strength = getString(key:"strength_golf")
        case Constants.BaseBall:
            strength = getString(key:"strength_baseball")
        case Constants.Ice_Hockey:
            strength = getString(key:"strength_ice_hockey")
        case Constants.Field_Hockey:
            strength = getString(key:"strength_field_hockey")
        case Constants.VolleyBall:
            strength = getString(key:"strength_volley")
        case Constants.Handball:
            strength = getString(key:"strength_handball")
        case Constants.Badminton:
            strength = getString(key:"strength_badminton")
        case Constants.Squash:
            strength = getString(key:"strength_squash")
        case Constants.TableTennis:
            strength = getString(key:"strength_table_tennis")
        case Constants.Boxing:
            strength = getString(key:"strength_boxing")
        case Constants.MartialArt:
            strength = getString(key:"strength_martial_art")
        case Constants.MMA:
            strength = getString(key:"strength_mma")
        case Constants.KickBoxing:
            strength = getString(key:"strength_kick_boxing")
        case Constants.Wrestling:
            strength = getString(key:"strength_wrestling")
        case Constants.Gymnastic:
            strength = getString(key:"strength_gymnastic")
        case Constants.Athletics:
            strength = getString(key:"strength_athletics")
        case Constants.Fencing:
            strength = getString(key:"strength_fencing")
        case Constants.Judo:
            strength = getString(key:"strength_judo")
        case Constants.Swimming:
            strength = getString(key:"strength_swimming")
        case Constants.WaterSports:
            strength = getString(key:"strength_water_sports")
        case Constants.WaterPolo:
            strength = getString(key:"strength_water_polo")
        case Constants.AutoRacing:
            strength = getString(key:"strength_autoracing")
        case Constants.MotoRacing:
            strength = getString(key:"strength_motoracing")
        case Constants.Cycling:
            strength = getString(key:"strength_cycling")
        case Constants.Equestrianism:
            strength = getString(key:"strength_equestrian")
        case Constants.PoloSport:
            strength = getString(key:"strength_polo")
        case Constants.Dance:
            strength = getString(key:"strength_dance")
        case Constants.Softball:
            strength = getString(key:"strength_softball")
        case Constants.SepakTakraw:
            strength = getString(key:"strength_sepak_takraw")
        case Constants.Korfball:
            strength = getString(key:"strength_korfball")
        case Constants.Floorball:
            strength = getString(key:"strength_floorball")
        case Constants.Climbing:
            strength = getString(key:"strength_climbing")
        case Constants.Mountaineering:
            strength = getString(key:"strength_mountaineering")
        case Constants.Canyoning:
            strength = getString(key:"strength_canyoning")
        case Constants.Trail:
            strength = getString(key:"strength_trail")
        case Constants.Triathlon:
            strength = getString(key:"strength_triathlon")
        case Constants.Archery:
            strength = getString(key:"strength_archery")
        case Constants.Snowboarding:
            strength = getString(key:"strength_snowboarding")
        case Constants.Skiing:
            strength = getString(key:"strength_skiing")
        case Constants.IceSkating:
            strength = getString(key:"strength_ice_skating")
        case Constants.SkateBoard:
            strength = getString(key:"strength_skateborard")
        case Constants.Weightlifting:
            strength = getString(key:"strength_weightlifting")
        case Constants.Crossfit_Fitness:
            strength = getString(key:"strength_crossfit_fitness")
        case Constants.Surf:
            strength = getString(key:"strength_surf")
        case Constants.Sailing:
            strength = getString(key:"strength_sailing")
        case Constants.Canoeing:
            strength = getString(key:"strength_canoeing")
        case Constants.Rowing:
            strength = getString(key:"strength_rowing")
        case Constants.Air_Sports:
            strength = getString(key:"strength_air_sport")
        case Constants.WinterSports:
            strength = getString(key:"strength_winter_sport")
        case Constants.Bowling:
            strength = getString(key:"strength_bowls")
        default:
            strength = ""
        }
        result = strength.components(separatedBy: ",")
        return result
    }
    
    func getSkillCount(user: User)->Float {
        var result: Float = 0
        var stat_key_str = getString(key:"stat_coach_key")
        var stat_key = stat_key_str.components(separatedBy: ",")
        if user.type == Constants.COACH || user.type == Constants.TEAM_CLUB || user.type == Constants.STAFF{
            result = 1.0
        } else if user.sport == Constants.American_Football {
            stat_key_str = getString(key:"stat_american_football_key")
            stat_key = stat_key_str.components(separatedBy: ",")
            result = Float(stat_key.count - 4)
        } else if user.sport == Constants.Basketball {
            stat_key_str = getString(key:"stat_basketball_key")
            stat_key = stat_key_str.components(separatedBy: ",")
            result = Float(stat_key.count - 4)
        } else if user.sport == Constants.Korfball {
            stat_key_str = getString(key:"stat_korfball_key")
            stat_key = stat_key_str.components(separatedBy: ",")
            result = Float(stat_key.count - 4)
        } else if user.sport == Constants.Football {
            stat_key_str = getString(key:"stat_football_key")
            stat_key = stat_key_str.components(separatedBy: ",")
            result = Float(stat_key.count - 5)
        } else if user.sport == Constants.Rugby {
            stat_key_str = getString(key:"stat_rugby_key")
            stat_key = stat_key_str.components(separatedBy: ",")
            result = Float(stat_key.count - 4)
        } else if user.sport == Constants.Cricket {
            stat_key_str = getString(key:"stat_cricket_key")
            stat_key = stat_key_str.components(separatedBy: ",")
            result = Float(stat_key.count - 4)
        } else if user.sport == Constants.BaseBall {
            stat_key_str = getString(key:"stat_baseball_key")
            stat_key = stat_key_str.components(separatedBy: ",")
            result = Float(stat_key.count - 4)
        } else if user.sport == Constants.Softball {
            stat_key_str = getString(key:"stat_softball_key")
            stat_key = stat_key_str.components(separatedBy: ",")
            result = Float(stat_key.count - 4)
        } else if user.sport == Constants.Ice_Hockey || user.sport == Constants.Field_Hockey {
            stat_key_str = getString(key:"stat_hockey_key")
            stat_key = stat_key_str.components(separatedBy: ",")
            result = Float(stat_key.count - 4)
        } else if user.sport == Constants.Handball {
            stat_key_str = getString(key:"stat_handball_key")
            stat_key = stat_key_str.components(separatedBy: ",")
            result = Float(stat_key.count - 5)
        } else if user.sport == Constants.VolleyBall {
            stat_key_str = getString(key:"stat_volleyball_key")
            stat_key = stat_key_str.components(separatedBy: ",")
            result = Float(stat_key.count - 4)
        } else if user.sport == Constants.SepakTakraw {
            stat_key_str = getString(key:"stat_sepak_takraw_key")
            stat_key = stat_key_str.components(separatedBy: ",")
            result = Float(stat_key.count - 4)
        } else if user.sport == Constants.Tennis {
//            stat_key_str = getString(key:"stat_tennis_key")
//            stat_key = stat_key_str.components(separatedBy: ",")
            result = Float(2)
        } else if user.sport == Constants.Badminton || user.sport == Constants.Squash || user.sport == Constants.TableTennis {
//            stat_key_str = getString(key:"stat_badminton_key")
//            stat_key = stat_key_str.components(separatedBy: ",")
            result = Float(2)
        } else if user.sport == Constants.Golf {
            stat_key_str = getString(key:"stat_golf_key")
            stat_key = stat_key_str.components(separatedBy: ",")
            result = Float(stat_key.count - 6)
        } else if user.sport == Constants.Athletics || user.sport == Constants.Swimming || user.sport == Constants.WaterSports ||
        user.sport == Constants.Gymnastic || user.sport == Constants.Boxing || user.sport == Constants.MartialArt ||
        user.sport == Constants.Wrestling || user.sport == Constants.Fencing || user.sport == Constants.Cycling ||
        user.sport == Constants.Equestrianism || user.sport == Constants.Dance || user.sport == Constants.Climbing ||
        user.sport == Constants.Bowling || user.sport == Constants.Crossfit_Fitness || user.sport == Constants.Weightlifting ||
        user.sport == Constants.KickBoxing || user.sport == Constants.MMA || user.sport == Constants.Trail ||
        user.sport == Constants.Rowing || user.sport == Constants.Mountaineering || user.sport == Constants.WinterSports ||
        user.sport == Constants.Air_Sports {
            result = Float(1)
        } else if user.sport == Constants.Judo {
            result = Float(4)
        } else if user.sport == Constants.AutoRacing || user.sport == Constants.MotoRacing ||
        user.sport == Constants.Skiing || user.sport == Constants.Snowboarding || user.sport == Constants.Surf ||
        user.sport == Constants.IceSkating || user.sport == Constants.Sailing || user.sport == Constants.Canoeing ||
        user.sport == Constants.SkateBoard {
            result = Float(1)
        } else if user.sport == Constants.Floorball {
            stat_key_str = getString(key:"stat_floorball_key")
            stat_key = stat_key_str.components(separatedBy: ",")
            result = Float(stat_key.count - 4)
        } else if user.sport == Constants.WaterPolo {
            stat_key_str = getString(key:"stat_water_polo_key")
            stat_key = stat_key_str.components(separatedBy: ",")
            result = Float(stat_key.count - 4)
        }
        
        if result == 0 {
            result = 1.0
        }
        return result
    }
    
    func getDefeatsRate(skill_list: [[Skill]], user:User!) -> Float{
        var result:Float = 0.0
        var fDefeat:Float = 0.0
        var fSum:Float = 0.0
        for skills in skill_list {
            if user.type == Constants.COACH || user.type == Constants.TEAM_CLUB || user.type == Constants.STAFF {
                fDefeat += Float(getSkillValue(key: "Defeats", skills: skills))
                fSum += Float(getSkillValue(key: "Games_played", skills: skills))
            } else if user.sport == Constants.AutoRacing || user.sport == Constants.MotoRacing ||
                user.sport == Constants.Skiing || user.sport == Constants.Snowboarding || user.sport == Constants.Surf ||
                    user.sport == Constants.IceSkating || user.sport == Constants.Sailing || user.sport == Constants.Canoeing ||
                    user.sport == Constants.SkateBoard {
                fDefeat += Float(getSkillValue(key: "Defeats", skills: skills))
                fSum += Float(getSkillValue(key: "Races", skills: skills))
            } else {
                fDefeat += Float(getSkillValue(key: "Defeats", skills: skills))
                fSum += Float(getSkillValue(key: "Games_played", skills: skills))
            }
        }
        result = fSum == 0 ? 0 : fDefeat * 100 / fSum
        if result > 100 { result = 100 }
        return  result
    }
    
    func getDrawsRate(skill_list: [[Skill]], user:User!) -> Float{
        var result:Float = 0.0
        var fDraw:Float = 0.0
        var fSum:Float = 0.0
        for skills in skill_list {
            if (user.type == Constants.COACH || user.type == Constants.TEAM_CLUB || user.type == Constants.STAFF) {
                fDraw += Float(getSkillValue(key: "Draws", skills: skills))
                fSum += Float(getSkillValue(key: "Games_played", skills: skills))
            } else if (user.sport == Constants.AutoRacing || user.sport == Constants.MotoRacing ||
                    user.sport == Constants.Skiing || user.sport == Constants.Snowboarding || user.sport == Constants.Surf ||
                    user.sport == Constants.IceSkating || user.sport == Constants.Sailing || user.sport == Constants.Canoeing ||
                    user.sport == Constants.SkateBoard){
                fDraw += Float(getSkillValue(key: "Draws", skills: skills))
                fSum += Float(getSkillValue(key: "Races", skills: skills))
            } else {
                fDraw += Float(getSkillValue(key: "Draws", skills: skills))
                fSum += Float(getSkillValue(key: "Games_played", skills: skills))
            }
        }
        result = fSum == 0 ? 0 : fDraw * 100 / fSum
        if result > 100 { result = 100}
        return  result
    }
    
    func getVictoryRate(skill_list: [[Skill]], user:User!) -> Float{
        var result:Float = 0.0
        var fVictory:Float = 0.0
        var fSum:Float = 0.0
        for skills in skill_list {
            if (user.type == Constants.COACH || user.type == Constants.TEAM_CLUB || user.type == Constants.STAFF) {
                fVictory += Float(getSkillValue(key: "Victories", skills: skills))
                fSum += Float(getSkillValue(key: "Games_played", skills: skills))
            } else if (user.sport == Constants.AutoRacing || user.sport == Constants.MotoRacing ||
                    user.sport == Constants.Skiing || user.sport == Constants.Snowboarding || user.sport == Constants.Surf ||
                    user.sport == Constants.IceSkating || user.sport == Constants.Sailing || user.sport == Constants.Canoeing ||
                    user.sport == Constants.SkateBoard){
                fVictory += Float(getSkillValue(key: "Victories", skills: skills))
                fSum += Float(getSkillValue(key: "Races", skills: skills))
            } else {
                fVictory += Float(getSkillValue(key: "Victories", skills: skills))
                fSum += Float(getSkillValue(key: "Games_played", skills: skills))
            }
        }
        result = fSum == 0 ? 0 : fVictory * 100 / fSum
        if result > 100 { result = 100 }
        return  result
    }
    
}
