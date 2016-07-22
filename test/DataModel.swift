//
//  DataModel.swift
//  test
//
//  Created by vivek verma on 22/07/16.
//  Copyright © 2016 roposo. All rights reserved.
//

import UIKit

class DataModel: NSObject {
    
    var users : [User]!
    var stories : [Story]!
    
    
    static let sharedInstance = DataModel()
    
    override init() {
        super.init()
    }

}
