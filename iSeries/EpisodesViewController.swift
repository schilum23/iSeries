//
//  EpisodesViewController.swift
//  iSeries
//
//  Created by Oliver Rosner on 18.07.15.
//  Copyright © 2015 Oliver Rosner. All rights reserved.
//

import UIKit

class EpisodesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // Controls
    var tableView: UITableView!
    
    // Variables
    var oSEA = Seasons()
    var oSER = Series()
    var oEPIs = [Episodes]()

    let main = Main()

    override func viewDidLoad() {
        super.viewDidLoad()

        main.getEpisodes(oSER.SER_ID, SEA_ID: oSEA.SEA_ID)
        oEPIs = main.oEPIs
        
        setupViews()
    }
    
    // MARK: - Help Functions
    func setupViews() {
        
        self.view.backgroundColor = UIColor.whiteColor()
        // Navigationbar
        let navBar = UINavigationBar()
        let title = "Staffel \(oSEA.SEA_Number)"
        navBar.defaultNavigationBar(title, viewController: self, lBTitle: "back", lBFunc: "backButtonAction:")
        
        self.view.addSubview(navBar)
        
        // TableView Folgen
        tableView = UITableView(frame: CGRectMake(0, CGRectGetMaxY(navBar.frame), self.view.frame.width, self.view.frame.height - CGRectGetMaxY(navBar.frame)))
        tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        self.view.addSubview(tableView)
        
    }
    
    // MARK: - TableView
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let episodeView = EpisodeViewController()
        episodeView.oEPI = oEPIs[indexPath.row]
      //  self.presentViewController(episodeView, animated: true, completion: nil)
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return oEPIs.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell?
        let oEPI = oEPIs[indexPath.row] as Episodes
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
            cell?.selectionStyle = UITableViewCellSelectionStyle.None

            
            let label = UILabel(frame: CGRectMake(10, 0, cell!.frame.width - 5, cell!.frame.height))
            cell!.addSubview(label)
            label.tag = 1
            
            // Switch Seen
//            let switchSeen = UISwitch(frame: CGRectMake(CGRectGetMaxX(label.frame) + 10, (cell!.frame.height - 31) / 2, 51, 31))
//            switchSeen.addTarget(self, action: "switchedSeen:", forControlEvents: UIControlEvents.ValueChanged)
//            switchSeen.onImage = UIImage(named: "fav1")

           // switchSeen.tag = 2
            
           // cell!.addSubview(switchSeen)

            
            let button = UIButton(frame: CGRectMake(CGRectGetMaxX(label.frame) + 10, (cell!.frame.height - 31) / 2, 30, 30))
            button.addTarget(self, action: "setSeen:", forControlEvents: UIControlEvents.TouchUpInside)
            button.setImage(UIImage(named: "off"), forState: UIControlState.Normal)
            button.setImage(UIImage(named: "on"), forState: UIControlState.Selected)

            button.tag = 2
            cell?.addSubview(button)
        }
        
        (cell!.viewWithTag(1) as! UILabel).text = "\(oEPI.EPI_NumberOfSeason) - \(oEPI.EPI_Name_German)"
       // (cell!.viewWithTag(2) as! UISwitch).on = vBool(NSUserDefaults.standardUserDefaults().valueForKey(oEPI.EPI_ID))
       // (cell!.viewWithTag(2) as! UISwitch).tag = indexPath.row
        (cell!.viewWithTag(2) as! UIButton).selected = vBool(NSUserDefaults.standardUserDefaults().valueForKey(oEPI.EPI_ID))

        (cell!.viewWithTag(2) as! UIButton).tag = indexPath.row



        
        return cell!

    }
    
    // MARK - Switch
    func setSeen(sender: UIButton) {
        
        let oEPI = oEPIs[sender.tag]
        
        let isSeen = vBool(NSUserDefaults.standardUserDefaults().valueForKey(oEPI.EPI_ID))
        NSUserDefaults.standardUserDefaults().setValue(!isSeen, forKey: oEPI.EPI_ID)
        sender.selected = !sender.selected


    }
    
    // MARK: - BarButton Events
    // Zurück
    func backButtonAction(button: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }


}
