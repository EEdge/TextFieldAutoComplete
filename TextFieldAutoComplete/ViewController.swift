//
//  ViewController.swift
//  TextFieldAutoComplete
//
//  Created by Evan Edge on 6/6/16.
//  Copyright © 2016 eedge. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var tf: TextFieldAutoComplete!

    @IBOutlet weak var regularTextField: UITextField!
    var unsortedStrings: Array<String> = ["pickle", "apple", "avocado", "banana", "cherry"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tf.assignDataSource(unsortedStrings)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

