//
//  StoryDetailViewController.swift
//  test
//
//  Created by vivek verma on 22/07/16.
//  Copyright © 2016 roposo. All rights reserved.
//

import UIKit

class StoryDetailViewController: UIViewController {
    
    var sid : String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.yellowColor()
        print(sid)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
