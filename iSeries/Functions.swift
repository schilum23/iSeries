//
//  Functions.swift
//  iPokerlist
//
//  Created by Oliver Rosner on 08.03.15.
//  Copyright (c) 2015 Oliver Rosner. All rights reserved.
//

import UIKit

class Functions: NSObject {
   
}

// String
public func vString(value: AnyObject?, dateFormat: String = "dd.MM.yyyy") -> String {
    
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = dateFormat
    
    
    if let objectValue: NSDate = value as? NSDate {
        return dateFormatter.stringFromDate(objectValue)
    }
    
    if let returnValue: AnyObject = value {
        return "\(returnValue)"
    }
    
    return ""
    
}

// Integer
public func vInt(value: AnyObject?) -> Int {
    
    if let objectValue: AnyObject = value {
        if let returnValue = NSNumberFormatter().numberFromString("\(objectValue)") {
            return returnValue.integerValue
        }
    }
    
    return 0
    
}

// Double
public func vDouble(value: AnyObject?) -> Double {

    let formatter = NSNumberFormatter()
    formatter.locale = NSLocale(localeIdentifier: "en_EN")
    
    if let objectValue: AnyObject = value {
        if let returnValue = formatter.numberFromString("\(objectValue)") {
            return returnValue.doubleValue
        }
        
        formatter.locale = NSLocale(localeIdentifier: "de_DE")
        if let returnValue = formatter.numberFromString("\(objectValue)") {
            return returnValue.doubleValue
        }
    }
    return 0
    
}

// Date
public func vDate(value: AnyObject?) -> NSDate {
    
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
    
    if let objectValue: AnyObject = value {
        
        if let returnValue = objectValue as? NSDate {
            return returnValue
        }
        
        if let returnValue = dateFormatter.dateFromString("\(objectValue)") {
            return returnValue
        }
        
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        if let returnValue = dateFormatter.dateFromString("\(objectValue)") {
            return returnValue
        }
        
        dateFormatter.dateFormat = "dd.MM.yyyy"
        if let returnValue = dateFormatter.dateFromString("\(objectValue)") {
            return returnValue
        }
        
      
    }
    
    return NSDate(timeIntervalSince1970: 0)
    
}

// Boolean
public func vBool(value: AnyObject?) -> Bool {
    
    if let objectValue: AnyObject = value {
        
        if let returnValue = objectValue as? Bool {
            return returnValue
        }
        
        if let returnValue = NSNumberFormatter().numberFromString("\(objectValue)") {
            return (returnValue.integerValue == 1)
        }
        
        if "\(objectValue)".lowercaseString == "true" || "\(objectValue)".lowercaseString == "yes" {
            return true
        }
    }
    
    return false
    
}

// Get JSON Data
func getJSONData(link: String) -> NSData? {
    
    let tempPath = NSURL(string: link.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
    if let path = tempPath {
        
        if let data = NSData(contentsOfURL: path) {
            return data
        }
    }
    
    print("ERROR: JSON String \(link) liefert keine Daten.")
    
    return nil
    
}

// For any hex code 0xXXXXXX and alpha value, return a matching UIColor
func UIColorFromHex(rgbValue: UInt32, alpha: Double = 1.0) -> UIColor {
    let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
    let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
    let blue = CGFloat(rgbValue & 0xFF)/256.0
    
    return UIColor(red:red, green: green, blue: blue, alpha: CGFloat(alpha))
}

func getImage(imageName: String, factor: CGFloat?=0) -> UIImage? {
    
    var image: UIImage? = UIImage(named: "\(imageName).jpg")

    if factor != 0 && image != nil {
        image = imageResize(image, factor: (factor! / image!.size.height))
    }
    
    return image
    
}

// Image resize
func imageResize (image: UIImage?, factor: CGFloat) -> UIImage? {
    
    if image == nil {
        return nil
    }
    
    let hasAlpha = false
    let scale: CGFloat = 0.0
    let size = CGSize(width: image!.size.width * factor, height: image!.size.height * factor)
    
    UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
    image!.drawInRect(CGRect(origin: CGPointZero, size: size))
    
    let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return scaledImage
}

// Dictionary JSON
func getDictionary(wsLink: String, paramter: String) -> [[String:NSObject]] {
    
    let tempLink = wsLink + paramter
    let tempPath = NSURL(string: tempLink.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
    do {
        if let path = tempPath {
            
            if let temp = NSData(contentsOfURL: path) {
                if let arayJSON = try NSJSONSerialization.JSONObjectWithData(temp, options: .MutableContainers) as? [[String:NSObject]] {
                    return arayJSON
                }
            }
            
        }
    } catch {
        return [[String:NSObject]]()
    }
    
    return [[String:NSObject]]()
}




