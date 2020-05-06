//
//  String.swift
//  Marifa
//
//  Created by tiexiong on 3/1/18.
//  Copyright © 2018 zhang. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func index(of string: String, options: CompareOptions = .literal) -> Index? {
        return range(of: string, options: options)?.lowerBound
    }
    
    static func numberToUppercase(number: Int) -> String{
        let uppercases = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        return uppercases.substring(from: number, to: number+1)
    }
    
    func substring(from:Int, to:Int) -> String{
        let startIndex = self.index(self.startIndex, offsetBy: from)
        let endIndex = self.index(self.startIndex, offsetBy: to)
        let range = startIndex..<endIndex
        return String(self[range])
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType:  NSAttributedString.DocumentType.html], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    
    var html2AttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return  nil
        }
    }
    
    var htmlToString: String {
        return html2AttributedString?.string ?? ""
    }
    
    static func toInt(value:Any)-> Int {
        if let string = value as? String {
            return Int(string)!
        } else if let int = value as? Int {
            return int
        } else {
            return 0
        }
    }
}

extension NSMutableAttributedString {
    @discardableResult func bold(_ text: String) -> NSMutableAttributedString {
        let attrs: [NSAttributedStringKey: Any] = [.font: UIFont(name: "HelveticaNeue-Bold", size: 17)!]
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)
        return self
    }
    
    @discardableResult func normal(_ text: String) -> NSMutableAttributedString {
        let normal = NSAttributedString(string: text)
        append(normal)
        return self
    }
}
