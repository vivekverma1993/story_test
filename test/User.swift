//
//  User.swift
//  test
//
//  Created by vivek verma on 22/07/16.
//  Copyright © 2016 roposo. All rights reserved.
//

import UIKit

class User: NSObject {
    var about : String!
    var id : String!
    var username : String!
    var followers : String!
    var following : String!
    var image : String!
    var url : String!
    var handle : String!
    var is_following : String!
    var createdOn : String!
    
    init(about : String!,
         id : String!,
         username : String!,
         followers : String!,
         following : String!,
         image : String!,
         url : String!,
         handle : String!,
         is_following : String!,
         createdOn : String!) {
        super.init()
        self.about = about
        self.id = id
        self.username = username
        self.followers = followers
        self.following = following
        self.image = image
        self.url = url
        self.handle = handle
        self.is_following = is_following
        self.createdOn = createdOn
    }
}
