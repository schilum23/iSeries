//
//  Main.swift
//  iSeries
//
//  Created by Oliver Rosner on 26.07.15.
//  Copyright © 2015 Oliver Rosner. All rights reserved.
//

import UIKit

let ip = "http://217.160.178.136:8023/Service.asmx"
let linkSeries = "/getSeries"
let linkSeriesData = "/getSeriesData"
let linkSeasons = "/getSeasons"
let linkEpisodes = "/getEpisodes"



class Main: NSObject {

    var oSERs = [Series]()
    var oSER = Series()
    var oSEAs = [Seasons]()
    var oEPIs = [Episodes]()
    
    func getSeries() {
        
        let dic = getDictionary(ip + linkSeries, paramter: "")
        
        for dic in dic {
            let newItem: Series = Series(wsData: dic)
            oSERs.append(newItem)
        }
    }
    
    func getSeriesData(SER_ID: String) {
        
        let dic = getDictionary(ip + linkSeriesData, paramter: "?SER_ID=\(SER_ID)")
        
        for dic in dic {
            let newItem: Series = Series(wsData: dic)
            oSER = newItem
        }
    }
    
    func getSeasons(SER_ID: String) {
        
        let dic = getDictionary(ip + linkSeasons, paramter: "?SER_ID=\(SER_ID)")
   
        for dic in dic {
            let newItem: Seasons = Seasons(wsData: dic)
            oSEAs.append(newItem)
        }
    }
    
    func getEpisodes(SER_ID: String, SEA_ID: String) {
        
        let dic = getDictionary(ip + linkEpisodes, paramter: "?SER_ID=\(SER_ID)&SEA_ID=\(SEA_ID)")
        
        for dic in dic {
            let newItem: Episodes = Episodes(wsData: dic)
            oEPIs.append(newItem)
        }
    }
    
}
