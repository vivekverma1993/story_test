//
//  StoryViewController.swift
//  test
//
//  Created by vivek verma on 22/07/16.
//  Copyright © 2016 roposo. All rights reserved.
//

import UIKit

class StoryViewController: UIViewController {
    
    
    var tableView : UITableView = UITableView()
    
    // Mark: - TableView Initializers
    
    func setupTableView(){
        self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)
        self.tableView.backgroundColor = UIColor.redColor()
        self.tableView.delegate =  self
        self.tableView.dataSource =  self
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        self.tableView.backgroundColor = UIColor.clearColor()
//        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.view.addSubview(self.tableView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.blueColor()
        setupTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation
 

}

extension StoryViewController : UITableViewDelegate{
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let destViewController : StoryDetailViewController = StoryDetailViewController()
        destViewController.sid = "1"
        self.navigationController?.pushViewController(destViewController, animated: true)
    }
}

extension StoryViewController : UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
//        let sizeOfScreen : CGSize = UIScreen.mainScreen().bounds.size
//        let width = sizeOfScreen.width
//        let height = 200 as CGFloat
        
        var cell : UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("flight")
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "flight")
            
//            cell?.backgroundColor = UIColor.clearColor()
            cell?.selectionStyle = UITableViewCellSelectionStyle.None
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
}
