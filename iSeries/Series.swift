//
//  Series.swift
//  iSeries
//
//  Created by Oliver Rosner on 17.07.15.
//  Copyright © 2015 Oliver Rosner. All rights reserved.
//

import UIKit


class Series: NSObject {
    
    var SER_ID: String = ""
    var SER_Created: NSDate?
    var SER_Changed: NSDate?
    var SER_theTVDB_ID: String = ""
    var SER_Name_German: String = ""
    var SER_Name_English: String = ""
    var SER_DescriptionShort_German: String = ""
    var SER_DescriptionShort_English: String = ""
    var SER_Description_German: String = ""
    var SER_Description_English: String = ""
    var SER_FirstAired_German: NSDate?
    var SER_FirstAired_English: NSDate?
    var SER_Rate: Double = 0
    var SER_RateCount: Int = 0
    var SER_imdb_Rate: Double = 0
    var SER_imdb_RateCount: Int = 0
    var SER_RunTime: Int = 0
    var SER_State: String = ""
    var SER_Soundtrack: String = ""
    var SER_Trailer: String = ""
    var SER_ProductionDateFrom: NSDate?
    var SER_ProductionDateTo: NSDate?
    var SER_Country: String = ""
    var SER_Languages: String = ""
    var SER_Awards: String = ""
    var SER_Website: String = ""
    var SER_Facebook: String = ""
    var SER_Twitter: String = ""
    var SER_ImageLink: String = ""
    var SER_SeasonCount: Int = 0
    var SER_EpisodesCount: Int = 0
    var SER_FavouritesCount: Int = 0
    var SER_DIR: String = ""
    
    var SER_Image: UIImage?
    var SER_Image_Wide: UIImage?

    
    // MARK: - Init / Coder
    override init() {
        super.init()
    }
    
    init(wsData: [String:NSObject]) {
        super.init()
        
        self.SER_ID = vString(wsData["SER_ID"])
        self.SER_Created = vDate(wsData["SER_Created"])
        self.SER_Changed = vDate(wsData["SER_Changed"])
        self.SER_theTVDB_ID = vString(wsData["SER_theTVDB_ID"])
        self.SER_Name_German = vString(wsData["SER_Name_German"])
        self.SER_Name_English = vString(wsData["SER_Name_English"])
        self.SER_DescriptionShort_German = vString(wsData["SER_DescriptionShort_German"])
        self.SER_DescriptionShort_English = vString(wsData["SER_DescriptionShort_English"])
        self.SER_Description_German = vString(wsData["SER_Description_German"])
        self.SER_Description_English = vString(wsData["SER_Description_English"])
        self.SER_FirstAired_German = vDate(wsData["SER_FirstAired_German"])
        self.SER_FirstAired_English = vDate(wsData["SER_FirstAired_English"])
        self.SER_Rate = vDouble(wsData["SER_Rate"])
        self.SER_RateCount = vInt(wsData["SER_RateCount"])
        self.SER_imdb_Rate = vDouble(wsData["SER_imdb_Rate"])
        self.SER_imdb_RateCount = vInt(wsData["SER_imdb_RateCount"])
        self.SER_RunTime = vInt(wsData["SER_RunTime"])
        self.SER_State = vString(wsData["SER_State"])
        self.SER_Soundtrack = vString(wsData["SER_Soundtrack"])
        self.SER_Trailer = vString(wsData["SER_Trailer"])
        self.SER_ProductionDateFrom = vDate(wsData["SER_ProductionDateFrom"])
        self.SER_ProductionDateTo = vDate(wsData["SER_ProductionDateTo"])
        self.SER_Country = vString(wsData["SER_Country"])
        self.SER_Languages = vString(wsData["SER_Languages"])
        self.SER_Awards = vString(wsData["SER_Awards"])
        self.SER_Website = vString(wsData["SER_Website"])
        self.SER_Facebook = vString(wsData["SER_Facebook"])
        self.SER_Twitter = vString(wsData["SER_Twitter"])
        self.SER_ImageLink = vString(wsData["SER_ImageLink"])
        self.SER_SeasonCount = vInt(wsData["SER_SeasonCount"])
        self.SER_EpisodesCount = vInt(wsData["SER_EpisodesCount"])
        self.SER_FavouritesCount = vInt(wsData["SER_FavouritesCount"])
        self.SER_DIR = vString(wsData["SER_DIR"])
        self.SER_Image = getImage(vString(self.SER_theTVDB_ID))
        self.SER_Image_Wide = getImage(vString(self.SER_theTVDB_ID) + "_SERF")

        
    }


}
