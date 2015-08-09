//
//  Seasons.swift
//  iSeries
//
//  Created by Oliver Rosner on 18.07.15.
//  Copyright © 2015 Oliver Rosner. All rights reserved.
//

import UIKit

class Seasons: NSObject {
    
    var SEA_ID: String = ""
    var SEA_Created: NSDate = NSDate()
    var SEA_Changed: NSDate = NSDate()
    var SEA_SER: String = ""
    var SEA_Name_German: String = ""
    var SEA_Name_English: String = ""
    var SEA_Number: Int = 0
    var SEA_OrderNumber: Int = 0
    var SEA_EpisodesCount: Int = 0
    var SEA_Description_German: String = ""
    var SEA_Description_English: String = ""
    var SEA_NumberText: String = ""
    
    // MARK: - Init / Coder
    override init() {
        super.init()
    }
    
    init(wsData: [String:NSObject]) {
        super.init()
        
        self.SEA_ID = vString(wsData["SEA_ID"])
        self.SEA_Created = vDate(wsData["SEA_Created"])
        self.SEA_Changed = vDate(wsData["SEA_Changed"])
        self.SEA_SER = vString(wsData["SEA_SER"])
        self.SEA_Name_German = vString(wsData["SEA_Name_German"])
        self.SEA_Name_English = vString(wsData["SEA_Name_English"])
        self.SEA_Number = vInt(wsData["SEA_Number"])
        self.SEA_OrderNumber = vInt(wsData["SEA_OrderNumber"])
        self.SEA_EpisodesCount = vInt(wsData["SEA_EpisodesCount"])
        self.SEA_Description_German = vString(wsData["SEA_Description_German"])
        self.SEA_Description_English = vString(wsData["SEA_Description_English"])
        self.SEA_NumberText = vString(wsData["SEA_NumberText"])
        
    }


}
