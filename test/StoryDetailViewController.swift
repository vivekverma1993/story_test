//
//  StoryDetailViewController.swift
//  test
//
//  Created by vivek verma on 22/07/16.
//  Copyright © 2016 roposo. All rights reserved.
//

import UIKit
import SDWebImage

class StoryDetailViewController: UITableViewController {
    
    var story : Story!
    var user : User!
    var headerView: ParallaxHeaderView!
    
    
//    override func viewWillAppear(animated: Bool) {
//        self.navigationController?.navigationBar.hidden = true
//        UIApplication.sharedApplication().statusBarStyle = .LightContent
//    }
//    
//    override func viewWillDisappear(animated: Bool) {
//        self.navigationController?.navigationBar.hidden = false
//        UIApplication.sharedApplication().statusBarStyle = .Default
//    }

//    var sudoNavbar : UIView = {
//        var view = UIView()
//        view.backgroundColor = UIColor.redColor()
//        return view
//    }()
//    
//    var backButton : UIButton = {
//        var button = UIButton()
//        button.setImage(UIImage(named: "back"), forState: .Normal)
//        return button
//    }()
    
    var userDetailView : UIView = {
        var view = UIView()
        return view
    }()
    
    var profileImageView : UIImageView = {
        var imageView = UIImageView()
        
        return imageView
    }()
    
    let nameLabel : UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 2
        
        return label
    }()
    
    let followButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.whiteColor()
        button.setTitle("FOLLOW", forState: .Normal)
        button.setTitleColor(UIColor.redColor(), forState: .Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(11)
        button.layer.cornerRadius = 12.5
        return button
    }()
    
    let roposoStory : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.whiteColor()
        button.setTitle("View this on Roposo", forState: .Normal)
        button.setTitleColor(UIColor.redColor(), forState: .Normal)
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(14)
        return button
    }()
    
    
    let titleLabel : UILabel = {
        let label = UILabel()
        
        label.font = UIFont.boldSystemFontOfSize(14)
        return label
    }()
    
    let descriptionLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFontOfSize(14)
        return label
    }()
    
    let likeCommentLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(14)
        return label
    }()
    
    func setupTableView(){
        tableView?.backgroundColor = UIColor(white: 0.9, alpha: 1)
        tableView?.alwaysBounceVertical = true
        
        tableView?.registerClass(UITableViewCell.classForKeyedArchiver(), forCellReuseIdentifier: "storydetail")
        tableView?.tableFooterView = UIView(frame: CGRectZero)
        
        
        
        let imgUrl : NSURL = NSURL(string:story.si)!
        let imageManager : SDWebImageManager  = SDWebImageManager ()
        
        if(imgUrl != ""){
            imageManager.downloadImageWithURL(imgUrl,
                                              options: SDWebImageOptions.LowPriority,
                                              progress: nil) { (image, error, SDImageCacheTypeMemory, finished, url) -> Void in
                                                if(image != nil){
                                                    self.headerView = ParallaxHeaderView.parallaxHeaderViewWithImage(image, forSize: CGSizeMake(self.tableView.frame.size.width, 300)) as! ParallaxHeaderView
                                                    
                                                    
                                                    
                                                    self.tableView?.tableHeaderView = self.headerView
                                                }
            }
        }
        
        
    }
    
    override func  scrollViewDidScroll(scrollView: UIScrollView) {
        if(scrollView ==  self.tableView){
            let header: ParallaxHeaderView = self.tableView.tableHeaderView as! ParallaxHeaderView
            header.layoutHeaderViewForScrollViewOffset(scrollView.contentOffset)
            self.tableView.tableHeaderView = header
        }
    }
    
    func followClicked(sender : UIButton!){
        let user_id = story.db
        var is_following = ""
        var u_index = -1
        for (index,user) in DataModel.sharedInstance.users.enumerate(){
            if(user.id == user_id){
                is_following = user.is_following
                u_index = index
                break
            }
        }
        
        if(is_following == "0"){
            DataModel.sharedInstance.users[u_index].is_following = "1"
            sender.setTitle("FOLLOWING", forState: .Normal)
            sender.backgroundColor = UIColor.redColor()
            sender.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        }
        else{
            DataModel.sharedInstance.users[u_index].is_following = "0"
            sender.setTitle("FOLLOW", forState: .Normal)
            sender.backgroundColor = UIColor.whiteColor()
            sender.setTitleColor(UIColor.redColor(), forState: .Normal)
        }
        
        UIView.animateWithDuration(0.1 ,
                                   animations: {
                                    sender.transform = CGAffineTransformMakeScale(1.2, 1.2)
            },
                                   completion: { finish in
                                    UIView.animateWithDuration(0.1,
                                        animations: {
                                            sender.transform = CGAffineTransformIdentity
                                        },
                                        completion: { finish in
                                    })
        })
        
    }
    
    func roposo_story(){
        UIApplication.sharedApplication().openURL(NSURL(string:self.story.url)!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.yellowColor()
//        view.insertSubview(sudoNavbar, aboveSubview: tableView)
//        sudoNavbar.addSubview(backButton)
        setupTableView()
        
        
        
        self.profileImageView.sd_setImageWithURL(NSURL(string: user!.image))
        
        let is_following = user?.is_following
        
        
        if(is_following == "1"){
            followButton.setTitle("FOLLOWING", forState: .Normal)
            followButton.backgroundColor = UIColor.redColor()
            followButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        }
        else{
            followButton.setTitle("FOLLOW", forState: .Normal)
            followButton.backgroundColor = UIColor.whiteColor()
            followButton.setTitleColor(UIColor.redColor(), forState: .Normal)
        }
        
        followButton.addTarget(self, action:#selector(StoryDetailViewController.followClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        roposoStory.addTarget(self, action:#selector(StoryDetailViewController.roposo_story), forControlEvents: UIControlEvents.TouchUpInside)
        
        if let username = user?.username{
            let attributedText = NSMutableAttributedString(string: username, attributes: [NSFontAttributeName:UIFont.boldSystemFontOfSize(14),NSForegroundColorAttributeName:UIColor.whiteColor()])
            
            attributedText.appendAttributedString(NSAttributedString(string: "\n\((user?.handle)! as String)", attributes: [NSFontAttributeName:UIFont.systemFontOfSize(12),NSForegroundColorAttributeName:UIColor.whiteColor()]))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4
            
            attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range:NSMakeRange(0,attributedText.string.characters.count))
            
            nameLabel.attributedText = attributedText
            
            profileImageView.sd_setImageWithURL(NSURL(string: user!.image))
        }

        
        userDetailView.addSubview(self.profileImageView)
        userDetailView.addSubview(self.nameLabel)
        userDetailView.addSubview(self.followButton)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRectMake(0, 0, self.view.frame.size.width, 60)
        let color1 = UIColor.blackColor().colorWithAlphaComponent(0.0).CGColor as CGColorRef
        let color2 = UIColor.blackColor().colorWithAlphaComponent(0.2).CGColor as CGColorRef
        let color3 = UIColor.blackColor().colorWithAlphaComponent(0.4).CGColor as CGColorRef
        let color4 = UIColor.blackColor().colorWithAlphaComponent(0.8).CGColor as CGColorRef
        gradientLayer.colors = [color1,color2,color3,color4]
        gradientLayer.locations = [0.0, 0.25, 0.7, 1.0]
        userDetailView.layer.insertSublayer(gradientLayer, atIndex: 0)
        
        self.headerView.addSubview(userDetailView)
        
        
//        view.addContraintsWithFormat("H:|[v0]|", views: sudoNavbar)
//        view.addContraintsWithFormat("V:|[v0(64)]", views: sudoNavbar)
        
        self.headerView.addContraintsWithFormat("H:|[v0]|", views: userDetailView)
        self.headerView.addContraintsWithFormat("V:[v0(60)]|", views: userDetailView)
        
        
        userDetailView.addContraintsWithFormat("H:|-8-[v0(44)]-8-[v1]-4-[v2(80)]-10-|", views: profileImageView,nameLabel, followButton)
        userDetailView.addContraintsWithFormat("V:|-8-[v0(44)]", views: profileImageView)
        userDetailView.addContraintsWithFormat("V:|-12-[v0]", views: nameLabel)
        userDetailView.addContraintsWithFormat("V:|-17.5-[v0(25)]", views: followButton)
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("storydetail", forIndexPath: indexPath) as UITableViewCell
        
        
        if(indexPath.row == 0){
            
            titleLabel.frame = CGRectMake(10, 4, self.view.frame.size.width-20, 0)
            
            titleLabel.text = self.story.title
            descriptionLabel.text =  self.story.sdescription
            
            titleLabel.lineBreakMode = .ByWordWrapping
            titleLabel.numberOfLines = 0
            titleLabel.sizeToFit()
            
            descriptionLabel.frame = CGRectMake(10, self.titleLabel.bounds.height + 8, self.view.frame.size.width-20, 0)
            
            descriptionLabel.lineBreakMode = .ByWordWrapping
            descriptionLabel.numberOfLines = 0
            descriptionLabel.sizeToFit()
            
            
            
            likeCommentLabel.frame = CGRectMake(10, self.titleLabel.bounds.height + self.descriptionLabel.bounds.height + 12, self.view.frame.size.width-20 , 30)
            
            
            
            
            let attributedText : NSMutableAttributedString = NSMutableAttributedString()
            
            if let likes = story?.likes_count{
                attributedText.appendAttributedString(NSAttributedString(string: "\(likes) Likes", attributes: [NSFontAttributeName:UIFont.systemFontOfSize(12),NSForegroundColorAttributeName:UIColor.lightGrayColor()]))
            }
            
            if let comments = story?.comment_count{
                attributedText.appendAttributedString(NSAttributedString(string: "  \(comments) Comments", attributes: [NSFontAttributeName:UIFont.systemFontOfSize(12),NSForegroundColorAttributeName:UIColor.lightGrayColor()]))
            }
            
            self.likeCommentLabel.attributedText = attributedText
            
            
            self.roposoStory.frame = CGRectMake(20, self.titleLabel.bounds.height + self.descriptionLabel.bounds.height + 46 , self.view.frame.size.width-40, 30)
            
            cell.addSubview(titleLabel)
            cell.addSubview(descriptionLabel)
            cell.addSubview(self.likeCommentLabel)
            cell.addSubview(self.roposoStory)
            
            
            
        }
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.titleLabel.bounds.height + self.descriptionLabel.bounds.height + 92
    }
    
}



