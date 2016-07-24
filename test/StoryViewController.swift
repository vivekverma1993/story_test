//
//  StoryViewController.swift
//  test
//
//  Created by vivek verma on 22/07/16.
//  Copyright © 2016 roposo. All rights reserved.
//

import UIKit
import SDWebImage

class StoryViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    
    
    // Mark: - Data Setup
    
    func datasetup(){
        DataModel.sharedInstance.users = [User]()
        DataModel.sharedInstance.stories = [Story]()
        DataModel.sharedInstance.cellHeights = [CGFloat]()
    }
    
    // Mark: - TableView Initializers
    
    func setupCollectionView(){
        collectionView?.backgroundColor = UIColor(white: 0.9, alpha: 1)
        collectionView?.alwaysBounceVertical = true 
        collectionView?.registerClass(StoryCell.self, forCellWithReuseIdentifier: "story")
    }
    
    
    func loadDataFromFile(){
        if let data = Globals.loadJson("data"){
            let filteredData = data as Array
            for i in 0..<2{
                let user_object : User = User(about: Globals.checkKeyExists(filteredData[i] as! NSDictionary , key: "about"),
                                              id: Globals.checkKeyExists(filteredData[i] as! NSDictionary , key: "id"),
                                              username: Globals.checkKeyExists(filteredData[i] as! NSDictionary , key: "username"),
                                              followers: Globals.checkKeyExists(filteredData[i] as! NSDictionary , key: "followers"),
                                              following: Globals.checkKeyExists(filteredData[i] as! NSDictionary , key: "following"),
                                              image: Globals.checkKeyExists(filteredData[i] as! NSDictionary , key: "image"),
                                              url: Globals.checkKeyExists(filteredData[i] as! NSDictionary , key: "url"),
                                              handle: Globals.checkKeyExists(filteredData[i] as! NSDictionary , key: "handle"),
                                              is_following: Globals.checkKeyExists(filteredData[i] as! NSDictionary , key: "is_following"),
                                              createdOn: Globals.checkKeyExists(filteredData[i] as! NSDictionary , key: "createdOn"))
                
                DataModel.sharedInstance.users.append(user_object)
            }
            
            for j in 2..<filteredData.count{
                let story_object : Story = Story(sdescription: Globals.checkKeyExists(filteredData[j] as! NSDictionary , key: "description"),
                                                 id: Globals.checkKeyExists(filteredData[j] as! NSDictionary , key: "id"),
                                                 verb: Globals.checkKeyExists(filteredData[j] as! NSDictionary , key: "verb"),
                                                 db: Globals.checkKeyExists(filteredData[j] as! NSDictionary , key: "db"),
                                                 url: Globals.checkKeyExists(filteredData[j] as! NSDictionary , key: "url"),
                                                 si: Globals.checkKeyExists(filteredData[j] as! NSDictionary , key: "si"),
                                                 type: Globals.checkKeyExists(filteredData[j] as! NSDictionary , key: "type"),
                                                 title: Globals.checkKeyExists(filteredData[j] as! NSDictionary , key: "title"),
                                                 like_flag: Globals.checkKeyExists(filteredData[j] as! NSDictionary , key: "like_flag"),
                                                 likes_count: Globals.checkKeyExists(filteredData[j] as! NSDictionary , key: "likes_count"),
                                                 comment_count: Globals.checkKeyExists(filteredData[j] as! NSDictionary , key: "comment_count"))
                
                DataModel.sharedInstance.stories.append(story_object)
            }
            
            
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.blueColor()
        datasetup()
        loadDataFromFile()
        setupCollectionView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        if let sdescription = DataModel.sharedInstance.stories[indexPath.item].sdescription {
            let rect = NSString(string: sdescription).boundingRectWithSize(CGSizeMake(view.frame.width, 1000), options: NSStringDrawingOptions.UsesFontLeading.union(NSStringDrawingOptions.UsesLineFragmentOrigin), attributes: [NSFontAttributeName: UIFont.systemFontOfSize(14)], context: nil)
            
            
            let knwonHeight =  (8 + 44 + 4 + 4 + 300 + 8 + 24 + 24) as CGFloat
            
            return CGSizeMake(view.frame.width, rect.size.height + knwonHeight)
        }
        
        return CGSizeMake(view.frame.width, 600)
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataModel.sharedInstance.stories.count
    }
    
    
    func followClicked(sender : UIButton!){
        let user_id = DataModel.sharedInstance.stories[sender.tag].db
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
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let storyCell = collectionView.dequeueReusableCellWithReuseIdentifier("story", forIndexPath: indexPath) as! StoryCell
        
        let user_id = DataModel.sharedInstance.stories[indexPath.row].db
        var objectuser : User!
        for user in DataModel.sharedInstance.users{
            if(user.id == user_id){
                objectuser = user
                break
            }
        }
        
        storyCell.user = objectuser
        storyCell.story = DataModel.sharedInstance.stories[indexPath.row]
        storyCell.followButton.tag = indexPath.row
        
        print(indexPath.row)
        
        storyCell.followButton.addTarget(self, action:#selector(StoryViewController.followClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)

        return storyCell
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    

 

}


