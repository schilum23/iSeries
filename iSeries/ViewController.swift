//
//  ViewController.swift
//  iSeries
//
//  Created by Oliver Rosner on 14.07.15.
//  Copyright © 2015 Oliver Rosner. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    // Controls
    var scrollView: UIScrollView!
    var selectionBar: UIView!
    var toolBar: UIToolbar!
    var picker: UIPickerView!
    var navItem = UINavigationItem()

    // Variables
    var currentPageIndex = 0
    var lastY: CGFloat = 0
    var tabCount = 2
    var oSERs = [[Series]]()
    //var oSERs_Favs = [Series]()
    
    let main = Main()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupViews()
        
        main.getSeries()
        oSERs.removeAll()
        oSERs.append(main.oSERs)
        oSERs.append([Series]())
        getFavs()
    }
    
    func getFavs() {
        oSERs[1].removeAll()
        for oSER in oSERs[0] {
            if vBool(NSUserDefaults.standardUserDefaults().valueForKey(oSER.SER_ID)) {
                oSERs[1].append(oSER)
            }
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        getFavs()

        for view in scrollView.subviews {
            if view.isKindOfClass(UITableView) {
                (view as? UITableView)?.reloadData()
            }
        }
    }
    
    
    // MARK: - Help Functions
    func setupViews() {
        
        self.view.removeSubViews()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        // NavigationBar
        let navBar = UINavigationBar(frame: CGRectMake(0, 20, self.view.frame.width, 44))
        navBar.items = [navItem]
        
        self.view.addSubview(navBar)
        setUpSearchBar(true)
        
        // ToolBar
        toolBar = UIToolbar(frame: CGRectMake(0, CGRectGetMaxY(navBar.frame), self.view.frame.width, 44))
        self.view.addSubview(toolBar)
        setupButtons()
        
        // ScrollView
        let maxY = CGRectGetMaxY(toolBar.frame)
        scrollView = UIScrollView(frame: CGRect(x: 0.0, y: maxY, width: self.view.frame.width, height: self.view.frame.height - maxY))
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: scrollView.frame.width * CGFloat(tabCount), height: scrollView.frame.height)
        scrollView.bounces = false
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        for i in 0..<tabCount {
            
            let frame = CGRect(x: 0.0, y: 0.0, width: scrollView.frame.width, height: scrollView.frame.height)
            
            
            // TableView
            let tableView = UITableView(frame: frame)
            tableView.tag = i
            tableView.dataSource = self
            tableView.delegate = self
            tableView.pagingEnabled = true
            tableView.separatorStyle = UITableViewCellSeparatorStyle.None
            tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
            tableView.frame.origin.x += CGFloat(i) * self.view.frame.width
            

            scrollView.addSubview(tableView)
            
        }
        
        self.view.addSubview(scrollView)
        
        var scrollToFrame = scrollView.frame
        scrollToFrame.origin = CGPointMake(scrollToFrame.width * CGFloat(currentPageIndex), 0)
        scrollView.scrollRectToVisible(scrollToFrame, animated: true)
    }
    
    // MARK: - Searchbar
    func setUpSearchBar(removeSearchachBar: Bool) {
        
        var title = ""
        let searchBar:UISearchBar = UISearchBar(frame: CGRectMake(0, 0, view.frame.size.width - 80, 20))
        searchBar.delegate = self
        searchBar.placeholder = "Suchtext"
        searchBar.becomeFirstResponder()
        searchBar.showsCancelButton = true
        
       // let settingsButton = UIBarButtonItem(title: "Menü", style: UIBarButtonItemStyle.Plain, target: self, action: "settingsButtonAction:")
        let searchButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: "setUpSearchBar:")
        
        var rightNavBarButton = UIBarButtonItem(customView:searchBar)
        
        if removeSearchachBar {
            rightNavBarButton = searchButton
            title = "Serien"
        } else {
            title = ""
        }
        
        navItem.rightBarButtonItem = rightNavBarButton
      //  navItem.leftBarButtonItem = settingsButton
        navItem.title = title
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.oSERs[0] = self.main.oSERs
        getFavs()
        setUpSearchBar(true)
        for view in scrollView.subviews {
            if view.isKindOfClass(UITableView) {
                (view as? UITableView)?.reloadData()
            }
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        setUpSearchBar(true)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        //var predicateString = searchText != "" ? "ser_Name contains[cd] '\(searchText)'" : ""
        
        self.oSERs[0] = self.main.oSERs.filter( { $0.SER_Name_German.lowercaseString.rangeOfString(searchText.lowercaseString) != nil } )
        getFavs()
        for view in scrollView.subviews {
            if view.isKindOfClass(UITableView) {
                (view as? UITableView)?.reloadData()
            }
        }

    }

    
    func setupButtons() {
        
        var buttonText = ["Serien", "Favoriten", "Top", "New"]
        
        for i in 0..<tabCount {
            
            let button = UIButton(frame: CGRectMake(CGFloat(i) * (toolBar.frame.width / CGFloat(tabCount)), 10, (toolBar.frame.width / CGFloat(tabCount)), 34))
            
            button.tag = i
            button.addTarget(self, action: "tapSegmentButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
            button.setTitleColor(UIColor.blackColor(), forState: .Normal)
            button.setTitle(buttonText[i], forState:UIControlState.Normal)
            
            toolBar.addSubview(button)
            
        }
        self.setupSelector()
    }
    
    // Switch Button Action
    func tapSegmentButtonAction(button:UIButton) {
        let tempIndex = currentPageIndex
        if button.tag > tempIndex {
            for var i = tempIndex+1; i <= button.tag ; i++ {
                scrollView.scrollRectToVisible(CGRectMake(scrollView.frame.width*CGFloat(i), 0, scrollView.frame.width, scrollView.frame.height), animated: true)
            }
        }
        else if button.tag < tempIndex {
            for var i = tempIndex-1; i >= button.tag ; i-- {
                scrollView.scrollRectToVisible(CGRectMake(scrollView.frame.width*CGFloat(i), 0, scrollView.frame.width, scrollView.frame.height), animated: true)
            }
        }
    }
    
    
    // Switch Selector
    func setupSelector() {
        selectionBar = UIView(frame: CGRectMake(0, 40, (toolBar.frame.width / CGFloat(tabCount)), 4))
        selectionBar.backgroundColor =  UIColorFromHex(0x3498db, alpha: 1)
        toolBar.addSubview(selectionBar)
        
    }
    
    // MARK: - TableView
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        if oSERs[tableView.tag].count != 0 {
            tableView.backgroundView = UIView()
            return 1
        }
        
        // Display a message when the table is empty
        let label = UILabel(frame: CGRectMake(tableView.frame.origin.x, tableView.frame.origin.y, tableView.frame.width, tableView.frame.height))
        var labelText = ""
        
        switch tableView.tag {
            case 0:
                labelText = "Keine Serien vorhanden!"
            case 1:
                labelText = "Keine Favoriten vorhanden!"
            default:
                labelText = "Keine Serien vorhanden!"
        }
        label.text = labelText
        label.textColor = UIColor.blackColor()
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont(name: label.font.fontName, size: 20)
        label.sizeToFit()
        
        tableView.backgroundView = label
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        return 0

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return oSERs[tableView.tag].count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var height: CGFloat = 0
        
//        switch 0 {
//        case 0:
            height = tableView.frame.height
//        case 1:
//            height = 90
//        case 2:
//            height = 44
//        default:
//            height = tableView.frame.height
//        }
        
        return height
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell?
        let oSER = oSERs[tableView.tag][indexPath.row]
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
            
            let imageView = UIImageView(frame: tableView.frame)
            imageView.center = CGPointMake(tableView.frame.width/2, tableView.frame.height/2)
            imageView.tag = 1
            cell!.addSubview(imageView)
            cell!.backgroundColor = UIColor.blackColor()
        }
        
        (cell!.viewWithTag(1) as! UIImageView).image = oSER.SER_Image

        
        return cell!
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let seasonsView = SeasonsViewController()
        seasonsView.oSER = oSERs[tableView.tag][indexPath.row]
        self.presentViewController(seasonsView, animated: true, completion: nil)
        tableView.deselectRowAtIndexPath(indexPath, animated: false)

    }
    
    
    // MARK: - ScrollView
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y != 0 {
            lastY = scrollView.contentOffset.y
        }
        
        if scrollView.contentOffset.y != 0 || (scrollView.contentOffset.y == 0 && scrollView.contentOffset.x == 0) {
            return
        }
        
        let xFromCenter:CGFloat = (self.view.frame.size.width - scrollView.contentOffset.x) / CGFloat(tabCount)
        let xCoor:CGFloat = selectionBar.frame.size.width
        
        selectionBar.frame = CGRectMake(xCoor - xFromCenter, selectionBar.frame.origin.y, selectionBar.frame.size.width, selectionBar.frame.size.height)
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        if lastY == 0 {
            currentPageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        } else {
            lastY = 0
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if lastY == 0 {
            currentPageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        } else {
            lastY = 0
        }
    }
    
    
}







