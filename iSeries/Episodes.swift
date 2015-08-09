//
//  Episodes.swift
//  iSeries
//
//  Created by Oliver Rosner on 18.07.15.
//  Copyright © 2015 Oliver Rosner. All rights reserved.
//

import UIKit

class Episodes: NSObject {

    var EPI_ID: String = ""
    var EPI_Created: NSDate = NSDate()
    var EPI_Changed: NSDate = NSDate()
    var EPI_SEA: String = ""
    var EPI_Name_German: String = ""
    var EPI_Name_English: String = ""
    var EPI_DescriptionShort_German: String = ""
    var EPI_DescriptionShort_English: String = ""
    var EPI_Description_German: String = ""
    var EPI_Description_English: String = ""
    var EPI_FirstAired_German: NSDate = NSDate()
    var EPI_FirstAired_English: NSDate = NSDate()
    var EPI_Rate: Double = 0
    var EPI_RateCount: Int = 0
    var EPI_imdb_Rate: Double = 0
    var EPI_imdb_RateCount: Int = 0
    var EPI_WatchedCount: Int = 0
    var EPI_Number: Int = 0
    var EPI_NumberOfSeason: Int = 0
    var EPI_NumberText: String = ""
    var EPI_Languages: String = ""

    // MARK: - Init / Coder
    override init() {
        super.init()
    }
    
    init(wsData: [String:NSObject]) {
        super.init()
        
        self.EPI_ID = vString(wsData["EPI_ID"])
        self.EPI_Created = vDate(wsData["EPI_Created"])
        self.EPI_Changed = vDate(wsData["EPI_Changed"])
        self.EPI_SEA = vString(wsData["EPI_SEA"])
        self.EPI_Name_German = vString(wsData["EPI_Name_German"])
        self.EPI_Name_English = vString(wsData["EPI_Name_English"])
        self.EPI_DescriptionShort_German = vString(wsData["EPI_DescriptionShort_German"])
        self.EPI_DescriptionShort_English = vString(wsData["EPI_DescriptionShort_English"])
        self.EPI_Description_German = vString(wsData["EPI_Description_German"])
        self.EPI_Description_English = vString(wsData["EPI_Description_English"])
        self.EPI_FirstAired_German = vDate(wsData["EPI_FirstAired_German"])
        self.EPI_FirstAired_English = vDate(wsData["EPI_FirstAired_English"])
        self.EPI_Rate = vDouble(wsData["EPI_Rate"])
        self.EPI_RateCount = vInt(wsData["EPI_RateCount"])
        self.EPI_imdb_Rate = vDouble(wsData["EPI_imdb_Rate"])
        self.EPI_imdb_RateCount = vInt(wsData["EPI_imdb_RateCount"])
        self.EPI_WatchedCount = vInt(wsData["EPI_WatchedCount"])
        self.EPI_Number = vInt(wsData["EPI_Number"])
        self.EPI_NumberOfSeason = vInt(wsData["EPI_NumberOfSeason"])
        self.EPI_NumberText = vString(wsData["EPI_NumberText"])
        self.EPI_Languages = vString(wsData["EPI_Languages"])
        
    }

}
