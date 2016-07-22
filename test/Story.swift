//
//  Story.swift
//  test
//
//  Created by vivek verma on 22/07/16.
//  Copyright © 2016 roposo. All rights reserved.
//

import UIKit

class Story: NSObject {
    // description doesnt work so have to choose different name
    var sdescription : String!
    var id : String!
    var verb : String!
    var db : String!
    var url : String!
    var si : String!
    var type : String!
    var title : String!
    var like_flag : String!
    var likes_count : String!
    var comment_count : String!
    
    init(sdescription : String!,
         id : String!,
         verb : String!,
         db : String!,
         url : String!,
         si : String!,
         type : String!,
         title : String!,
         like_flag : String!,
         likes_count : String!,
         comment_count : String!) {
        super.init()
        self.sdescription = sdescription
        self.id = id
        self.verb = verb
        self.db = db
        self.url = url
        self.si = si
        self.type = type
        self.title = title
        self.like_flag = like_flag
        self.likes_count = likes_count
        self.comment_count = comment_count
    }
}
