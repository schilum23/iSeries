//
//  SeasonsViewController.swift
//  iSeries
//
//  Created by Oliver Rosner on 18.07.15.
//  Copyright © 2015 Oliver Rosner. All rights reserved.
//

import UIKit

class SeasonsViewController: UIViewController, UIScrollViewDelegate {
    
    // Controls
    var scrollViewSeasons = UIScrollView()
    var textViewDescription = UITextView()
    let navBar = UINavigationBar()

    // Variables
    var oSER = Series()
    var oSEAs = [Seasons]()
    let main = Main()
  
    override func viewDidLoad() {
        super.viewDidLoad()

        
        main.getSeriesData(oSER.SER_ID)
        oSER = main.oSER
        
        main.getSeasons(oSER.SER_ID)
        oSEAs = main.oSEAs
        
        setupViews()
        reloadData()
    }

    // MARK: - Help Functions
    func setupViews() {
        
        self.view.removeSubViews()
        self.view.backgroundColor = UIColor.whiteColor()
        
        // Navigationbar
        let title = oSER.SER_Name_German
        let favorite: NSNumber = (vBool(NSUserDefaults.standardUserDefaults().valueForKey(oSER.SER_ID))) ? 0 : 1
        navBar.defaultNavigationBar(title, viewController: self, lBTitle: "back", lBFunc: "backButtonAction:", rBTitle: "fav\(favorite)", rBFunc: "setFavorite")
        
        self.view.addSubview(navBar)
        
        // Image
        let factor = (((self.view.frame.width) - 20.00) / oSER.SER_Image_Wide!.size.width) * 1.00
        let image = imageResize(oSER.SER_Image_Wide!, factor: factor)
        let imageViewSerie = UIImageView(image: image)
        imageViewSerie.frame.origin = CGPointMake(10.00, CGRectGetMaxY(navBar.frame) + 10.00)
        
        self.view.addSubview(imageViewSerie)
        
        // Label Name
        let labelName = UILabel(frame: CGRectMake(10, CGRectGetMaxY(imageViewSerie.frame) + 10, self.view.frame.width - 20, 21))
        labelName.numberOfLines = 0
        labelName.lineBreakMode = NSLineBreakMode.ByWordWrapping
        labelName.text = ""
        labelName.textAlignment = NSTextAlignment.Center
        
        self.view.addSubview(labelName)
        
        // ScrollView Seasons
        scrollViewSeasons = UIScrollView(frame: CGRectMake(0, CGRectGetMaxY(labelName.frame) + 10, self.view.frame.width, 131))
        scrollViewSeasons.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(scrollViewSeasons)
        
        // Label Description
        textViewDescription = UITextView(frame: CGRectMake(0, CGRectGetMaxY(scrollViewSeasons.frame) + 10, self.view.frame.width, CGRectGetMaxY(scrollViewSeasons.frame) - self.view.frame.height))
        textViewDescription.textAlignment = NSTextAlignment.Justified
        textViewDescription.text = "\(oSER.SER_Description_German)"
        textViewDescription.textContainerInset = UIEdgeInsetsMake(0, 10, 0, 10);

        self.view.addSubview(textViewDescription)


    }
    
    // MARK: - BarButton Events
    // Zurück
    func backButtonAction(button: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // MARK: - Help Functions
    func reloadData () {
        
        var maxY: CGFloat = 0
        
        // ScrollView
        scrollViewSeasons.delegate = self
        scrollViewSeasons.bounces = false
        scrollViewSeasons.showsHorizontalScrollIndicator = true
        
        for i in 0..<oSEAs.count {
            
            // Staffel Bild
            var counter = 0
            var image = UIImage(named: "\(oSER.SER_theTVDB_ID)-\(oSEAs[i].SEA_Number).jpg") as UIImage!
            
            while image == nil && counter < 10 {
                image = UIImage(named: "\(oSER.SER_theTVDB_ID)-\(oSEAs[i].SEA_Number)-\(counter).jpg") as UIImage!
                counter++
            }
            
            if image == nil {
                image = UIImage(named: oSER.SER_theTVDB_ID + ".jpg") as UIImage!
            }
            
            let factor = (80 / image.size.width) * 1.00
            
            image = imageResize(image, factor: factor)
            
            // Season Views
            let viewSeason = UIButton(frame: CGRect(x: 10, y: 10, width: image.size.width, height: image.size.height))
            viewSeason.setImage(image, forState: UIControlState.Normal)
            viewSeason.tag = i
            viewSeason.addTarget(self, action: "gotoEpisodes:", forControlEvents: UIControlEvents.TouchUpInside)
            viewSeason.frame.origin.x += CGFloat(i) * 100
            
            scrollViewSeasons.addSubview(viewSeason)
            
            // Season Label
            let label = UILabel(frame: CGRectMake(10, CGRectGetMaxY(viewSeason.frame) + 10, 80, 21))
            label.text = "Staffel \(oSEAs[i].SEA_Number)"
            label.textAlignment = NSTextAlignment.Center
            label.font = UIFont(name: label.font.fontName, size: 12)
            label.frame.origin.x += CGFloat(i) * 100
            
            scrollViewSeasons.addSubview(label)
            if CGRectGetMaxY(label.frame) > maxY {
                maxY = CGRectGetMaxY(label.frame)
            }
            
        }
        
        scrollViewSeasons.frame.size.height = maxY + 10
        textViewDescription.frame.origin.y = CGRectGetMaxY(scrollViewSeasons.frame) + 10
        
        scrollViewSeasons.contentSize = CGSize(width: 100 * CGFloat(oSEAs.count), height: scrollViewSeasons.frame.height)
    }
    
    // Folgen öffnen
    func gotoEpisodes(sender: UIButton) {
        
        let episodesView = EpisodesViewController()
        episodesView.oSEA = oSEAs[sender.tag]
        episodesView.oSER = oSER
        self.presentViewController(episodesView, animated: true, completion: nil)
        
    }
    
    // Serie zu Favoriten hinzufügen/von Favoriten entfernen
    func setFavorite() {

        let isFav = vBool(NSUserDefaults.standardUserDefaults().valueForKey(oSER.SER_ID))
        let favorite: NSNumber = (isFav) ? 1 : 0
        navBar.items![0].rightBarButtonItem!.image = UIImage(named: "fav\(favorite)")
        NSUserDefaults.standardUserDefaults().setValue(!isFav, forKey: oSER.SER_ID)
    }
    
}
