//
//  EpisodeViewController.swift
//  iSeries
//
//  Created by Oliver Rosner on 03.08.15.
//  Copyright © 2015 Oliver Rosner. All rights reserved.
//

import UIKit

class EpisodeViewController: UIViewController {

    // Controls
    
    // Variables
    var oEPI = Episodes()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    // MARK: - Help Functions
    func setupViews() {
        
        self.view.backgroundColor = UIColor.whiteColor()
        // Navigationbar
        let navBar = UINavigationBar()
        let title = "Folge \(oEPI.EPI_NumberOfSeason)"
        navBar.defaultNavigationBar(title, viewController: self, lBTitle: "back", lBFunc: "backButtonAction:")
        
        self.view.addSubview(navBar)
        
    }
    
    // MARK: - BarButton Events
    // Zurück
    func backButtonAction(button: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
