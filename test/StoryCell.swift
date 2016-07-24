//
//  StoryCell.swift
//  test
//
//  Created by vivek verma on 23/07/16.
//  Copyright © 2016 roposo. All rights reserved.
//

import UIKit
import SDWebImage


class StoryCell: UICollectionViewCell  {
    
    var activityIndicator : UIActivityIndicatorView!
    

    
    
    var user : User? {
        didSet{
            
            if let username = user?.username{
                let attributedText = NSMutableAttributedString(string: username, attributes: [NSFontAttributeName:UIFont.boldSystemFontOfSize(14)])
                
                attributedText.appendAttributedString(NSAttributedString(string: "\n\((user?.handle)! as String)", attributes: [NSFontAttributeName:UIFont.systemFontOfSize(12),NSForegroundColorAttributeName:UIColor.blueColor()]))
                
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = 4
                
                attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range:NSMakeRange(0,attributedText.string.characters.count))
                
                nameLabel.attributedText = attributedText
                
                profileImageView.sd_setImageWithURL(NSURL(string: user!.image))
            }
            
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
            
        }
    }
    var story : Story? {
        didSet{
            descriptionLabel.text = story?.sdescription
            
            let img_url = NSURL(string: (story?.si)!)
            
            
            
            self.activityIndicator.startAnimating()
            
            self.storyImageView.sd_setImageWithURL(img_url) { (image, error, SDImageCacheTypeMemory, img_url) in
                self.storyImageView.contentMode = .ScaleAspectFill
                self.storyImageView.layer.masksToBounds = true
                self.activityIndicator.stopAnimating()

            }
            
            let attributedText : NSMutableAttributedString = NSMutableAttributedString()
            
            if let likes = story?.likes_count{
                attributedText.appendAttributedString(NSAttributedString(string: "\(likes) Likes", attributes: [NSFontAttributeName:UIFont.systemFontOfSize(12),NSForegroundColorAttributeName:UIColor.lightGrayColor()]))
            }
            
            if let comments = story?.comment_count{
                attributedText.appendAttributedString(NSAttributedString(string: "  \(comments) Comments", attributes: [NSFontAttributeName:UIFont.systemFontOfSize(12),NSForegroundColorAttributeName:UIColor.lightGrayColor()]))
            }
            
            self.likeCommentLabel.attributedText = attributedText
            
            
        }
    }
    
    var follow_tag : Int?{
        didSet{
            followButton.tag = follow_tag!
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel : UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 2
       
        
        
        return label
    }()
    
    
    
    let profileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .ScaleAspectFit
        

        return imageView
    }()
    
    
    let followButton : UIButton = {
        let button = UIButton()
        button.setTitle("FOLLOW", forState: .Normal)
        button.setTitleColor(UIColor.redColor(), forState: .Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(11)
        button.layer.cornerRadius = 12.5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.redColor().CGColor
        return button
    }()
    
    let descriptionLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Celebrating Black Friday in this lovely black cut out romper and floral accessories. I love black and i think it is the easiest thing to wear when i am in doubt. So a black romper solves my dilemma of what to wear when i am short of time to decide and outfit. When you wear black add some fun accessories to keep the outfit fun and lively."
        label.font = UIFont.systemFontOfSize(14)
        return label
    }()
    
    let storyImageView : UIImageView = {
        let imageView = UIImageView()
       
        
        
       

        
        return imageView
    }()
    
    let likeCommentLabel : UILabel = {
        let label = UILabel()
        label.text = "20 Likes   10 Comments"
        label.font = UIFont.systemFontOfSize(12)
        return label
    }()
    
    
    
    
    func setUpViews(){
        backgroundColor = UIColor.whiteColor()
       
        
        
        
        addSubview(nameLabel)
        addSubview(profileImageView)
        addSubview(followButton)
        addSubview(descriptionLabel)
        addSubview(storyImageView)
        addSubview(likeCommentLabel)
        
        self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        self.activityIndicator.frame = CGRectMake(0,0, 30, 30)
        
        storyImageView.addSubview(self.activityIndicator)
        
        
        addContraintsWithFormat("H:|-8-[v0(44)]-8-[v1]-4-[v2(80)]-10-|", views: profileImageView,nameLabel, followButton)
        
        addContraintsWithFormat("H:|-4-[v0]-4-|", views: descriptionLabel)
        
        addContraintsWithFormat("H:|[v0]|", views: storyImageView)
        
        addContraintsWithFormat("H:|-12-[v0]|", views: likeCommentLabel)
        
        addContraintsWithFormat("H:|[v0]|", views: self.activityIndicator)
        
        
        addContraintsWithFormat("V:|-12-[v0]", views: nameLabel)
        
        addContraintsWithFormat("V:|-12-[v0(25)]", views: followButton)
        
        addContraintsWithFormat("V:|[v0]|", views: self.activityIndicator)
        
        
        
        
        
        
        addContraintsWithFormat("V:|-8-[v0(44)]-4-[v1]-4-[v2(300)]-8-[v3(24)]-8-|", views: profileImageView,descriptionLabel,storyImageView,likeCommentLabel)
 
        
        
    }
  
}


extension UIView{
    func addContraintsWithFormat(format: String, views: UIView...){
        var viewDictionary = [String: UIView]()
        for (index,view) in views.enumerate(){
            let key = "v\(index)"
            viewDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(format, options: NSLayoutFormatOptions(), metrics: nil, views: viewDictionary))
    }
}
